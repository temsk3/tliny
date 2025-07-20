import * as functions from 'firebase-functions'
import Stripe from 'stripe'
import { SecretManagerServiceClient } from '@google-cloud/secret-manager'
import { db } from '../../utils/firebase_utils'
import { logger } from '../../utils/logger'
import { ErrorHandler } from '../../utils/error_handler'

// 定数
const APPLICATION_FEE_PERCENT = 1.3
const currency = 'jpy'

// Stripe設定
let stripe: Stripe | null = null

const getStripe = async (): Promise<Stripe> => {
  if (!stripe) {
    let key = process.env.STRIPE_SECRET || process.env.STRIPE_SECRET_KEY

    // 環境変数にない場合はSecret Managerから取得
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

// エラーハンドリング
const handleError = (
  error: any,
  response: any,
  status = 500,
  message = 'Webhook handler failed.',
) => {
  logger.error(message, { error: error.message, status })
  setImmediate(() => {
    response.status(status).send(message)
  })
}

// Stripe Firestore utilities
const createWebhookEventDocument = async (event: Stripe.Event) => {
  try {
    await db.collection('stripe_events').doc(event.id).set({
      event_id: event.id,
      event_type: event.type,
      created: new Date(),
      data: event.data,
    })
    logger.info('Webhook event document created', { eventId: event.id })
  } catch (error: any) {
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

const updateOderDocument = async (data: {
  orderId: string
  status: string
}): Promise<void> => {
  try {
    await db.collection('v/1/orders').doc(data.orderId).set(
      {
        status: data.status,
        updated: new Date(),
      },
      { merge: true },
    )
    logger.info('Order document updated', { orderId: data.orderId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'webhook.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'webhook.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

// チケット作成サービス
const createTicketDocument = async (orderId: string): Promise<void> => {
  try {
    logger.info('Creating ticket document', { orderId })

    // 既存のチケットをチェック
    const existingTicketsQuery = await db
      .collection('v/1/tickets')
      .where('orderId', '==', orderId)
      .limit(1)
      .get()

    if (!existingTicketsQuery.empty) {
      logger.warn('Tickets already exist for order, skipping creation', {
        orderId,
        existingTicketsCount: existingTicketsQuery.size,
      })
      return
    }

    // 注文情報を取得
    const orderDoc = await db.collection('v/1/orders').doc(orderId).get()
    if (!orderDoc.exists) {
      throw new Error(`Order not found: ${orderId}`)
    }

    const orderData = orderDoc.data()
    if (!orderData) {
      throw new Error(`Order data not found: ${orderId}`)
    }

    // 注文ステータスの確認
    if (orderData.status !== 'pre') {
      logger.warn('Order status is not pre, skipping ticket creation', {
        orderId,
        status: orderData.status,
      })
      return
    }

    // 注文の確定
    await orderDoc.ref.set({ status: 'order' }, { merge: true })

    // ユーザー購入履歴の更新
    const userId = orderData.userId
    const userDoc = await db.collection('v/1/users').doc(userId).get()
    if (userDoc.exists) {
      await userDoc.ref
        .collection('orders')
        .doc(orderId)
        .set({ orderDocRef: orderDoc.ref.path }, { merge: true })
    }

    // イベント販売履歴の更新
    const eventId = orderData.eventId
    const eventDocRef = db.collection('v/1/events').doc(eventId)
    await eventDocRef
      .collection('orders')
      .doc(orderId)
      .set({ orderDocRef: orderDoc.ref.path }, { merge: true })

    // チケット発券
    const products = orderData.snapshotProducts

    // トランザクション内でチケット作成
    await db.runTransaction(async (transaction) => {
      for (const product of products) {
        for (let index = 0; index < product.quantity; index++) {
          const ticketId = `ticket_${orderId}_${product.productId}_${index}`

          const ticketParams = {
            // 購入者
            paidUserId: product.userId,
            paidUserName: product.userName,
            purchaseTime: orderData.purchaseTime,
            // 所有者
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
            // 商品情報
            productDocRef: db.collection('v/1/products').doc(product.productId),
            productId: product.productId,
            code: product.code,
            name: product.name,
            desc: product.desc,
            price: product.price,
            pictureURL: product.pictureURL,
            expirationFrom: product.expirationFrom,
            expirationTo: product.expirationTo,
            // 開催者
            organizerDocRef: product.organizerDocRef,
            organizerId: product.organizerId,
            // イベント情報
            eventDocRef: eventDocRef,
            eventId: product.eventId,
            eventName: product.eventName,
            // 注文情報
            orderId: orderId,
          }

          // トランザクション内でチケット作成
          const ticketRef = db.collection('v/1/tickets').doc(ticketId)
          const ticketDoc = await transaction.get(ticketRef)
          if (!ticketDoc.exists) {
            transaction.set(ticketRef, ticketParams)
          }
        }
      }
    })

    logger.info('Ticket document created successfully', { orderId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'webhook.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'webhook.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

// アカウント更新サービス
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

// 冪等性チェック
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

// イベントハンドラー
const handlePaymentIntentSucceeded = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  try {
    logger.info('Processing payment_intent.succeeded', {
      paymentIntentId: paymentIntent.id,
    })

    // 最新のPaymentIntent情報を再取得
    const latestPaymentIntent = await (
      await getStripe()
    ).paymentIntents.retrieve(paymentIntent.id, {
      expand: ['customer', 'payment_method'],
    })

    const customer = latestPaymentIntent.customer
    if (!customer) {
      throw new Error('customer is null')
    }

    const uid = await getUidFromStripeCustomerId(customer as string)
    if (!uid) {
      throw new Error('uid not found')
    }

    await updatePaymentDocument({
      uid,
      paymentIntentId: latestPaymentIntent.id,
      status: latestPaymentIntent.status,
    })

    await updateOderDocument({
      orderId: latestPaymentIntent.metadata.orderId,
      status: latestPaymentIntent.status,
    })

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

    await createTicketDocument(latestPaymentIntent.metadata.orderId)

    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    logger.error('Payment intent succeeded handler error', {
      paymentIntentId: paymentIntent.id,
      error: error.message,
    })
    handleError(error, response)
  }
}

const handlePaymentIntentFailed = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  try {
    logger.info('Processing payment_intent.payment_failed', {
      paymentIntentId: paymentIntent.id,
    })

    // 最新のPaymentIntent情報を再取得
    const latestPaymentIntent = await (
      await getStripe()
    ).paymentIntents.retrieve(paymentIntent.id, {
      expand: ['customer', 'last_payment_error'],
    })

    // 失敗の詳細情報をログに記録
    logger.info('Payment intent failed', {
      paymentIntentId: latestPaymentIntent.id,
      status: latestPaymentIntent.status,
      lastPaymentError: latestPaymentIntent.last_payment_error,
    })

    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    logger.error('Payment intent failed handler error', {
      paymentIntentId: paymentIntent.id,
      error: error.message,
    })
    handleError(error, response)
  }
}

const handleCheckoutSessionCompleted = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  try {
    logger.info('Processing checkout.session.completed', {
      checkoutSessionId: checkoutSession.id,
    })

    // 最新のCheckoutSession情報を再取得
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
      } catch (e) {
        orderId = undefined
      }
    }

    if (!orderId) {
      throw new Error('orderId not found in checkout session metadata')
    }

    logger.info('Processing checkout session completion', {
      checkoutSessionId: latestCheckoutSession.id,
      orderId,
      paymentStatus: latestCheckoutSession.payment_status,
      customerId: latestCheckoutSession.customer,
    })

    // チケット作成処理
    await createTicketDocument(orderId)

    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    logger.error('Checkout session completed handler error', {
      checkoutSessionId: checkoutSession.id,
      error: error.message,
    })
    handleError(error, response)
  }
}

const handleAccountUpdated = async (account: Stripe.Account, response: any) => {
  try {
    logger.info('Processing account.updated', { accountId: account.id })

    // 最新のAccount情報を再取得
    const latestAccount = await (
      await getStripe()
    ).accounts.retrieve(account.id)

    let status = 'unverified'

    // 複数の方法でstatusを取得
    if (latestAccount.individual?.verification?.status) {
      status = latestAccount.individual.verification.status
    } else if ((latestAccount as any).verification?.status) {
      status = (latestAccount as any).verification.status
    } else if (
      latestAccount.requirements?.currently_due?.length === 0 &&
      latestAccount.requirements?.eventually_due?.length === 0
    ) {
      // 要件が満たされている場合はverifiedとみなす
      status = 'verified'
    } else if (
      latestAccount.charges_enabled &&
      latestAccount.details_submitted
    ) {
      // 決済有効で詳細提出済みの場合はverifiedとみなす
      status = 'verified'
    }

    const uid = latestAccount.metadata?.uid
    const chargesEnabled = latestAccount.charges_enabled

    if (!uid) {
      throw new Error('uid not found in account metadata')
    }

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

// Firebase Functions v1でのwebhook endpoint
export const handleWebhookEvents = functions.https.onRequest(
  async (req, res) => {
    console.log('=== V1 Webhook Handler Started ===')

    try {
      console.log('Request method:', req.method)
      console.log('Has stripe-signature:', !!req.headers['stripe-signature'])
      console.log('Has rawBody:', !!req.rawBody)
      console.log('Raw body length:', req.rawBody ? req.rawBody.length : 0)

      if (req.method !== 'POST') {
        console.log('Method not allowed:', req.method)
        res.status(405).send('Method Not Allowed')
        return
      }

      // 署名検証を実行（v1ではrawBodyが利用可能）
      const sig = req.headers['stripe-signature']
      let endpointSecret = process.env.STRIPE_EP

      // 環境変数にない場合はSecret Managerから取得
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

      console.log('Signature verification debug:', {
        hasSignature: !!sig,
        hasEndpointSecret: !!endpointSecret,
        endpointSecretLength: endpointSecret ? endpointSecret.length : 0,
        endpointSecretPrefix: endpointSecret
          ? endpointSecret.substring(0, 10) + '...'
          : 'undefined',
        hasRawBody: !!req.rawBody,
        rawBodyLength: req.rawBody ? req.rawBody.length : 0,
        rawBodyPrefix: req.rawBody
          ? req.rawBody.toString().substring(0, 100) + '...'
          : 'undefined',
      })

      if (!sig || !endpointSecret || !req.rawBody) {
        console.error('Webhook signature verification failed:', {
          hasSignature: !!sig,
          hasEndpointSecret: !!endpointSecret,
          hasRawBody: !!req.rawBody,
        })
        res.status(400).send('Webhook signature verification failed')
        return
      }

      // Stripeの署名検証を実行（v1ではrawBodyを使用）
      const event = (await getStripe()).webhooks.constructEvent(
        req.rawBody,
        sig,
        endpointSecret,
      )

      console.log('Webhook signature verification successful:', {
        eventId: event.id,
        eventType: event.type,
      })

      // 冪等性保証: 同じWebhookイベントが既に処理済みかチェック
      const eventExists = await checkDocumentExistsByQuery(
        'v/1/platform/spel1/stripe_events',
        'stripe_event_id',
        event.id,
      )
      if (eventExists) {
        console.log('Webhook event already processed, skipping', {
          eventId: event.id,
          eventType: event.type,
        })
        res.status(200).send('Event already processed')
        return
      }

      // Webhookイベントドキュメントを作成
      await createWebhookEventDocument(event)

      logger.info('Processing webhook event', {
        eventId: event.id,
        eventType: event.type,
      })

      // イベントタイプに応じて処理
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
