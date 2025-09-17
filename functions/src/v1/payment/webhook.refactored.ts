import * as functions from 'firebase-functions'
import Stripe from 'stripe'
import { SecretManagerServiceClient } from '@google-cloud/secret-manager'
import { db } from '../../utils/firebase_utils'
import { logger } from '../../utils/logger'
import { ErrorHandler } from '../../utils/error_handler'
import * as admin from 'firebase-admin'

// 定数
const APPLICATION_FEE_PERCENT = 1.3
const currency = 'jpy'

// Stripe設定
let stripe: Stripe | null = null
const getStripe = async (): Promise<Stripe> => {
  if (!stripe) {
    let key = process.env.STRIPE_SECRET || process.env.STRIPE_SECRET_KEY
    if (!key) {
      try {
        const client = new SecretManagerServiceClient()
        const [version] = await client.accessSecretVersion({
          name: 'projects/tliny-c9630/secrets/STRIPE_SECRET/versions/latest',
        })
        key = (version.payload?.data?.toString() || '').trim()
        console.log('Stripe secret retrieved from Secret Manager')
      } catch (error) {
        console.error(
          'Failed to retrieve Stripe secret from Secret Manager:',
          error,
        )
      }
    }
    if (!key) throw new Error('STRIPE_SECRET not configured')
    stripe = new Stripe(key, { apiVersion: '2025-06-30.basil' })
  }
  return stripe
}

const stripeOptions: Stripe.StripeConfig & {
  idempotencyKey?: string
  stripeAccount?: string
} = {
  apiVersion: '2025-06-30.basil',
}

const handleError = (
  error: any,
  response: any,
  status = 500,
  message = 'Webhook handler failed.',
) => {
  logger.error(`Webhookエラーハンドラ: ${message}（HTTP ${status}）`, {
    error: error.message,
    status,
    stack: error.stack,
    eventId: error?.eventId,
    orderId: error?.orderId,
    paymentIntentId: error?.paymentIntentId,
    userId: error?.userId,
  })
  setImmediate(() => {
    response.status(status).send(message)
  })
}

const createWebhookEventDocument = async (event: Stripe.Event) => {
  try {
    await db.collection('stripe_events').doc(event.id).set({
      event_id: event.id,
      event_type: event.type,
      created: new Date(),
      data: event.data,
    })
    logger.info(
      `Webhookイベントドキュメント作成完了: eventId=${event.id}, type=${event.type}`,
    )
  } catch (error: any) {
    logger.error('Webhookイベントドキュメント作成中にエラー', {
      eventId: event.id,
      error: error.message,
      stack: error.stack,
    })
    ErrorHandler.logError(error, error.stack, 'webhook.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'webhook.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

const getUidFromStripeCustomerId = async (
  customerId: string,
): Promise<string | null> => {
  try {
    const snapshot = await db
      .collection('v/1/stripe_customers')
      .where('customer_id', '==', customerId)
      .limit(1)
      .get()
    if (!snapshot.empty) {
      return snapshot.docs[0].id
    }
    return null
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'webhook.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'webhook.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

const updatePaymentDocument = async (data: {
  uid: string
  paymentIntentId: string
  status: string
}): Promise<void> => {
  try {
    await db
      .collection('v/1/users')
      .doc(data.uid)
      .collection('payments')
      .doc(data.paymentIntentId)
      .set(
        {
          payment_intent_id: data.paymentIntentId,
          status: data.status,
          updated: new Date(),
        },
        { merge: true },
      )
    logger.info('Payment document updated', {
      paymentIntentId: data.paymentIntentId,
    })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'webhook.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'webhook.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

const createTicketDocument = async (orderId: string): Promise<void> => {
  try {
    logger.info(`チケット発券処理開始: orderId=${orderId}`)
    const existingTicketsQuery = await db
      .collection('v/1/tickets')
      .where('orderId', '==', orderId)
      .limit(1)
      .get()
    if (!existingTicketsQuery.empty) {
      logger.warn(
        `既にチケットが存在するため発券スキップ: orderId=${orderId}, 件数=${existingTicketsQuery.size}`,
      )
      return
    }
    const orderDoc = await db.collection('v/1/orders').doc(orderId).get()
    if (!orderDoc.exists) {
      logger.error(`注文ドキュメントが見つかりません: orderId=${orderId}`)
      throw new Error(`Order not found: ${orderId}`)
    }
    const orderData = orderDoc.data()
    if (!orderData) {
      logger.error(`注文データが見つかりません: orderId=${orderId}`)
      throw new Error(`Order data not found: ${orderId}`)
    }
    if (orderData.status !== 'pre') {
      logger.warn(
        `注文ステータスがpre以外のためチケット発券スキップ: orderId=${orderId}, status=${orderData.status}`,
      )
      return
    }
    const shouldUpdateStatus = orderData.status === 'pre'
    if (shouldUpdateStatus) {
      await orderDoc.ref.set({ status: 'order' }, { merge: true })
      logger.info(`注文ステータスをorderに更新: orderId=${orderId}`)
    }
    if (orderData.paymentIntentId) {
      await orderDoc.ref.set({ status: 'paid' }, { merge: true })
      logger.info(
        `注文ステータスをpaidに更新: orderId=${orderId}, paymentIntentId=${orderData.paymentIntentId}`,
      )
    }
    const userId = orderData.userId
    const userDoc = await db.collection('v/1/users').doc(userId).get()
    if (userDoc.exists) {
      await userDoc.ref
        .collection('orders')
        .doc(orderId)
        .set({ orderDocRef: orderDoc.ref.path }, { merge: true })
      logger.info(
        `ユーザー購入履歴を更新: userId=${userId}, orderId=${orderId}`,
      )
    }
    const eventId = orderData.eventId
    const eventDocRef = db.collection('v/1/events').doc(eventId)
    await eventDocRef
      .collection('orders')
      .doc(orderId)
      .set({ orderDocRef: orderDoc.ref.path }, { merge: true })
    logger.info(
      `イベント販売履歴を更新: eventId=${eventId}, orderId=${orderId}`,
    )
    const products = orderData.snapshotProducts
    await db.runTransaction(async (transaction) => {
      const ticketChecks: Promise<admin.firestore.DocumentSnapshot>[] = []
      const ticketParams: any[] = []
      for (const product of products) {
        for (let index = 0; index < product.quantity; index++) {
          const ticketId = `ticket_${orderId}_${product.productId}_${index}`
          const params = {
            paidUserId: product.userId,
            paidUserName: product.userName,
            purchaseTime: orderData.purchaseTime,
            ownerId: product.userId,
            ownerName: product.userName,
            assignment: [
              {
                from: product.organizerId,
                to: product.userId,
                assignmentDate: orderData.purchaseTime,
              },
            ],
            isPrinting: false,
            isUsed: false,
            uuid: null,
            pdfUuid: null,
            productDocRef: db.collection('v/1/products').doc(product.productId),
            productId: product.productId,
            code: product.code,
            name: product.name,
            desc: product.desc,
            price: product.price,
            pictureURL: product.pictureURL,
            expirationFrom: product.expirationFrom,
            expirationTo: product.expirationTo,
            organizerDocRef: product.organizerDocRef,
            organizerId: product.organizerId,
            eventDocRef: eventDocRef,
            eventId: product.eventId,
            eventName: product.eventName,
            orderId: orderId,
          }
          const ticketRef = db.collection('v/1/tickets').doc(ticketId)
          ticketChecks.push(transaction.get(ticketRef))
          ticketParams.push({ ticketId, params })
          logger.info(
            `チケット作成準備: ticketId=${ticketId}, orderId=${orderId}, productId=${product.productId}, userId=${product.userId}`,
          )
        }
      }
      const ticketSnapshots = await Promise.all(ticketChecks)
      for (let i = 0; i < ticketSnapshots.length; i++) {
        const snapshot = ticketSnapshots[i]
        const { ticketId, params } = ticketParams[i]
        if (!snapshot.exists) {
          transaction.set(db.collection('v/1/tickets').doc(ticketId), params)
          logger.info(
            `チケット作成（トランザクション内）: ticketId=${ticketId}, orderId=${orderId}, userId=${params.ownerId}`,
          )
        } else {
          logger.warn(
            `既にチケットが存在（トランザクション内）: ticketId=${ticketId}, orderId=${orderId}`,
          )
        }
      }
    })
    logger.info(`チケット発券処理完了: orderId=${orderId}`)
  } catch (error: any) {
    logger.error(
      `チケット発券処理中にエラー: orderId=${orderId}, error=${error.message}`,
    )
    ErrorHandler.logError(error, error.stack, 'webhook.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'webhook.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

const updateAccountStatus = async (
  uid: string | undefined,
  accountId: string,
  status: string,
  chargesEnabled: boolean,
): Promise<void> => {
  try {
    if (!uid) {
      logger.warn('UID not provided for account status update', { accountId })
      return
    }
    await db.collection('v/1/stripe_connect_accounts').doc(uid).update({
      status: status,
      chargesEnabled: chargesEnabled,
      updatedAt: new Date(),
    })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'webhook.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'webhook.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

const checkDocumentExistsByQuery = async (
  collectionPath: string,
  field: string,
  value: string,
): Promise<boolean> => {
  try {
    const query = await db
      .collection(collectionPath)
      .where(field, '==', value)
      .limit(1)
      .get()
    return !query.empty
  } catch (error) {
    logger.error('Error checking document existence by query', {
      collectionPath,
      field,
      value,
      error: error instanceof Error ? error.message : String(error),
    })
    throw error
  }
}

const handlePaymentIntentSucceeded = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  try {
    logger.info(
      `payment_intent.succeeded処理開始: paymentIntentId=${paymentIntent.id}, orderId=${paymentIntent.metadata?.orderId}, customerId=${paymentIntent.customer}, amount=${paymentIntent.amount}, status=${paymentIntent.status}`,
    )
    const latestPaymentIntent = await (
      await getStripe()
    ).paymentIntents.retrieve(paymentIntent.id, {
      expand: ['customer', 'payment_method'],
    })
    const customer = latestPaymentIntent.customer
    if (!customer) throw new Error('customer is null')
    const uid = await getUidFromStripeCustomerId(customer as string)
    if (!uid) throw new Error('uid not found')
    await updatePaymentDocument({
      uid,
      paymentIntentId: latestPaymentIntent.id,
      status: latestPaymentIntent.status,
    })
    logger.info(
      `注文ステータス更新はcheckout.session.completedで実施: orderId=${latestPaymentIntent.metadata.orderId}, status=${latestPaymentIntent.status}, paymentIntentId=${latestPaymentIntent.id}, customerId=${latestPaymentIntent.customer}`,
    )
    const fee = Math.floor(
      latestPaymentIntent.amount * (APPLICATION_FEE_PERCENT / 100),
    )
    const amount = latestPaymentIntent.amount - fee
    const params: Stripe.TransferCreateParams = {
      amount: amount,
      currency: currency,
      destination: latestPaymentIntent.metadata.account_id,
      transfer_group: latestPaymentIntent.metadata.orderId,
    }
    stripeOptions.idempotencyKey = `create_transfer_${uid}`
    await (await getStripe()).transfers.create(params, stripeOptions)
    logger.info(
      `チケット作成はcheckout.session.completedで実施: orderId=${latestPaymentIntent.metadata.orderId}, paymentIntentId=${latestPaymentIntent.id}`,
    )
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    logger.error(
      `payment_intent.succeededハンドラでエラー: paymentIntentId=${paymentIntent.id}, error=${error.message}`,
    )
    handleError(error, response)
  }
}

const handlePaymentIntentFailed = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  try {
    logger.info(
      `payment_intent.payment_failed処理開始: paymentIntentId=${paymentIntent.id}, orderId=${paymentIntent.metadata?.orderId}, customerId=${paymentIntent.customer}, amount=${paymentIntent.amount}, status=${paymentIntent.status}`,
    )
    const latestPaymentIntent = await (
      await getStripe()
    ).paymentIntents.retrieve(paymentIntent.id, {
      expand: ['customer', 'last_payment_error'],
    })
    logger.info(
      `決済失敗詳細: paymentIntentId=${latestPaymentIntent.id}, status=${latestPaymentIntent.status}, lastPaymentError=${latestPaymentIntent.last_payment_error}, orderId=${latestPaymentIntent.metadata?.orderId}, customerId=${latestPaymentIntent.customer}`,
    )
    const orderId = latestPaymentIntent.metadata?.orderId
    if (orderId) {
      try {
        await cancelOrder(orderId)
        logger.info(`注文キャンセル処理完了: orderId=${orderId}`)
      } catch (e: any) {
        logger.error(
          `注文キャンセル処理失敗: orderId=${orderId}, error=${e.message}`,
        )
      }
    }
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    logger.error(
      `payment_intent.payment_failedハンドラでエラー: paymentIntentId=${paymentIntent.id}, error=${error.message}`,
    )
    handleError(error, response)
  }
}

const handleCheckoutSessionCompleted = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  try {
    logger.info(
      `checkout.session.completed処理開始: checkoutSessionId=${checkoutSession.id}, orderId=${checkoutSession.metadata?.orderId}, customerId=${checkoutSession.customer}, paymentStatus=${checkoutSession.payment_status}`,
    )
    const accountId = checkoutSession.metadata?.accountId
    const latestCheckoutSession = await (
      await getStripe()
    ).checkout.sessions.retrieve(
      checkoutSession.id,
      { expand: ['customer', 'payment_intent', 'line_items'] },
      accountId ? { stripeAccount: accountId } : undefined,
    )
    const metadata = latestCheckoutSession.metadata
    let orderId: string | undefined
    if (typeof metadata === 'object' && metadata !== null) {
      orderId = (metadata as any).orderId
    } else if (typeof metadata === 'string') {
      try {
        const parsed = JSON.parse(metadata)
        orderId = parsed.orderId
      } catch (_e) {
        orderId = undefined
      }
    }
    if (!orderId)
      throw new Error('orderId not found in checkout session metadata')
    logger.info(
      `checkout.session.completed詳細: checkoutSessionId=${latestCheckoutSession.id}, orderId=${orderId}, paymentStatus=${latestCheckoutSession.payment_status}, customerId=${latestCheckoutSession.customer}, lineItems=${JSON.stringify(latestCheckoutSession.line_items)}`,
    )
    await createTicketDocument(orderId)
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    logger.error(
      `checkout.session.completedハンドラでエラー: checkoutSessionId=${checkoutSession.id}, error=${error.message}`,
    )
    handleError(error, response)
  }
}

const handleAccountUpdated = async (account: Stripe.Account, response: any) => {
  try {
    logger.info('Processing account.updated', { accountId: account.id })
    const latestAccount = await (
      await getStripe()
    ).accounts.retrieve(account.id)
    let status = 'unverified'
    if (latestAccount.individual?.verification?.status) {
      status = latestAccount.individual.verification.status
    } else if ((latestAccount as any).verification?.status) {
      status = (latestAccount as any).verification.status
    } else if (
      latestAccount.requirements?.currently_due?.length === 0 &&
      latestAccount.requirements?.eventually_due?.length === 0
    ) {
      status = 'verified'
    } else if (
      latestAccount.charges_enabled &&
      latestAccount.details_submitted
    ) {
      status = 'verified'
    }
    const uid = latestAccount.metadata?.uid
    const chargesEnabled = latestAccount.charges_enabled
    if (!uid) throw new Error('uid not found in account metadata')
    await updateAccountStatus(uid, latestAccount.id, status, chargesEnabled)
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    logger.error('Account updated handler error', {
      accountId: account.id,
      error: error.message,
    })
    handleError(error, response)
  }
}

export const handleWebhookEvents = functions.https.onRequest(
  async (req, res) => {
    console.log('=== V1 Webhook Handler Started ===')
    try {
      if (req.method !== 'POST') {
        res.status(405).send('Method Not Allowed')
        return
      }
      const sig = req.headers['stripe-signature']
      let endpointSecret = process.env.STRIPE_EP
      if (!endpointSecret) {
        try {
          const client = new SecretManagerServiceClient()
          const [version] = await client.accessSecretVersion({
            name: 'projects/tliny-c9630/secrets/STRIPE_EP/versions/latest',
          })
          endpointSecret = (version.payload?.data?.toString() || '').trim()
          console.log('Webhook endpoint secret retrieved from Secret Manager')
        } catch (error) {
          console.error(
            'Failed to retrieve webhook endpoint secret from Secret Manager:',
            error,
          )
        }
      }
      if (!sig || !endpointSecret || !req.rawBody) {
        res.status(400).send('Webhook signature verification failed')
        return
      }
      const event = (await getStripe()).webhooks.constructEvent(
        req.rawBody,
        sig,
        endpointSecret,
      )
      const eventExists = await checkDocumentExistsByQuery(
        'stripe_events',
        'event_id',
        event.id,
      )
      if (eventExists) {
        res.status(200).send('Event already processed')
        return
      }
      await createWebhookEventDocument(event)
      logger.info('Processing webhook event', {
        eventId: event.id,
        eventType: event.type,
      })
      switch (event.type) {
        case 'payment_intent.succeeded':
          logger.info('Processing payment_intent.succeeded event')
          await handlePaymentIntentSucceeded(
            event.data.object as Stripe.PaymentIntent,
            res,
          )
          break
        case 'payment_intent.payment_failed':
          logger.info('Processing payment_intent.payment_failed event')
          await handlePaymentIntentFailed(
            event.data.object as Stripe.PaymentIntent,
            res,
          )
          break
        case 'checkout.session.completed':
          logger.info('Processing checkout.session.completed event')
          await handleCheckoutSessionCompleted(
            event.data.object as Stripe.Checkout.Session,
            res,
          )
          break
        case 'account.updated':
          logger.info('Processing account.updated event', {
            eventId: event.id,
            accountId: (event.data.object as Stripe.Account).id,
          })
          await handleAccountUpdated(event.data.object as Stripe.Account, res)
          break
        case 'charge.succeeded':
          logger.info('Processing charge.succeeded event')
          res.status(200).send('OK: charge.succeeded')
          return
        case 'payment_intent.created':
          logger.info('Processing payment_intent.created event')
          res
            .status(200)
            .json({ received: true, eventType: 'payment_intent.created' })
          break
        default:
          logger.warn('Unhandled event type:', event.type)
          res.status(200).json({ received: true, eventType: event.type })
      }
    } catch (error: any) {
      console.error('Webhook handler error:', {
        error: error?.message || 'Unknown error',
        stack: error?.stack,
      })
      res.status(400).send('Webhook handler failed')
    }
  },
)

export { createTicketDocument }

export const manualTicketCreation = functions.https.onRequest(
  async (req, res) => {
    try {
      const apiKey = req.headers['x-api-key']
      const expectedApiKey =
        process.env.MANUAL_TICKET_API_KEY || 'test-secret-key-123'
      if (apiKey !== expectedApiKey) {
        res.status(401).json({ error: 'Unauthorized' })
        return
      }
      const { orderId } = req.query
      if (!orderId || typeof orderId !== 'string') {
        res.status(400).json({ error: 'orderId is required' })
        return
      }
      console.log(`Manual ticket creation requested for order: ${orderId}`)
      await createTicketDocument(orderId)
      res.status(200).json({
        success: true,
        message: `Tickets created for order: ${orderId}`,
      })
    } catch (error) {
      console.error('Manual ticket creation failed:', error)
      res.status(500).json({
        error: 'Failed to create tickets',
        details: error instanceof Error ? error.message : 'Unknown error',
      })
    }
  },
)

const sendBackCartItem = async (userId: string, orderItems: any[]) => {
  try {
    for (const orderItem of orderItems) {
      const cartItemId = `${userId}_${orderItem.productId}_${orderItem.eventId}`
      const cartRef = db
        .collection(`v/1/users/${userId}/cart_items`)
        .doc(cartItemId)
      const cartSnap = await cartRef.get()
      if (!cartSnap.exists) {
        await cartRef.set({
          productDocRef: orderItem.productDocRef,
          quantity: orderItem.quantity,
          programId: orderItem.eventId,
          productId: orderItem.productId,
        })
      }
    }
  } catch (error: any) {
    logger.error('sendBackCartItem error', { error: error.message })
    throw error
  }
}

const cancelOrder = async (orderId: string): Promise<string> => {
  const orderDoc = await db.collection('v/1/orders').doc(orderId).get()
  if (!orderDoc.exists) {
    throw new Error('Order not found')
  }
  const orderData = orderDoc.data()
  if (!orderData) {
    throw new Error('Order data not found')
  }
  if (orderData.status === 'order' || orderData.status === 'paid') {
    throw new Error('Order is already confirmed or paid and cannot be canceled')
  }
  if (orderData.status === 'cancel') {
    return 'already_canceled'
  }
  await orderDoc.ref.set(
    { status: 'cancel', cancelAt: new Date() },
    { merge: true },
  )
  const orderItems = orderData.snapshotProducts || []
  await db.runTransaction(async (transaction) => {
    for (const orderItem of orderItems) {
      const productRef =
        orderItem.productDocRef as admin.firestore.DocumentReference
      const productDoc = await transaction.get(productRef)
      if (!productDoc.exists) throw new Error('Product not found')
      const productData = productDoc.data()
      transaction.update(productRef, {
        stock: (productData?.stock || 0) + orderItem.quantity,
      })
    }
  })
  if (orderData.userId) {
    await sendBackCartItem(orderData.userId, orderItems)
  }
  return 'canceled'
}

export const manualOrderCancel = functions.https.onRequest(async (req, res) => {
  try {
    const apiKey = req.headers['x-api-key']
    const expectedApiKey =
      process.env.MANUAL_TICKET_API_KEY || 'test-secret-key-123'
    if (apiKey !== expectedApiKey) {
      res.status(401).json({ error: 'Unauthorized' })
      return
    }
    const { orderId } = req.query
    if (!orderId || typeof orderId !== 'string') {
      res.status(400).json({ error: 'orderId is required' })
      return
    }
    let result
    try {
      result = await cancelOrder(orderId)
    } catch (e: any) {
      if (
        e.message === 'Order not found' ||
        e.message === 'Order data not found'
      ) {
        res.status(404).json({ error: e.message })
        return
      }
      if (
        e.message ===
        'Order is already confirmed or paid and cannot be canceled'
      ) {
        res.status(400).json({ error: e.message })
        return
      }
      throw e
    }
    if (result === 'already_canceled') {
      res.status(200).json({ success: true, message: 'Order already canceled' })
      return
    }
    res
      .status(200)
      .json({ success: true, message: `Order ${orderId} canceled` })
  } catch (error: any) {
    res.status(500).json({
      error: 'Failed to cancel order',
      details: error instanceof Error ? error.message : 'Unknown error',
    })
  }
})
