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

function getProjectId() {
  return (
    process.env.GCLOUD_PROJECT ||
    process.env.GCP_PROJECT ||
    process.env.FUNCTIONS_EMULATOR_PROJECT_ID ||
    (process.env.FIREBASE_CONFIG &&
      (() => {
        try {
          return JSON.parse(process.env.FIREBASE_CONFIG).projectId
        } catch {
          return undefined
        }
      })()) ||
    undefined
  )
}

const getStripeSecretKey = () => {
  const projectId = getProjectId()
  if (projectId === 'tliny-c9630') {
    return process.env.STRIPE_SECRET || process.env.STRIPE_SECRET_KEY
  } else {
    // tliny-sample またはデフォルト
    return process.env.STRIPE_DEV_SK
  }
}

const getStripeEpKey = () => {
  const projectId = getProjectId()
  if (projectId === 'tliny-c9630') {
    return process.env.STRIPE_EP
  } else {
    // tliny-sample またはデフォルト
    return process.env.STRIPE_DEV_EP
  }
}

const getSecretManagerSecret = async (secretName: string) => {
  try {
    const client = new SecretManagerServiceClient()
    const projectId = getProjectId()
    let project = 'tliny-c9630'
    if (projectId && projectId !== 'tliny-c9630') {
      project = 'tliny-sample'
    }
    const [version] = await client.accessSecretVersion({
      name: `projects/${project}/secrets/${secretName}/versions/latest`,
    })
    return (version.payload?.data?.toString() || '').trim()
  } catch (error) {
    console.error(
      `Failed to retrieve ${secretName} from Secret Manager:`,
      error,
    )
    return undefined
  }
}

const getStripe = async (): Promise<Stripe> => {
  if (!stripe) {
    let key = getStripeSecretKey()
    if (!key) {
      // プロジェクトごとにSecret Managerから取得
      key = await getSecretManagerSecret(
        getProjectId() === 'tliny-c9630' ? 'STRIPE_SECRET' : 'STRIPE_DEV_SK',
      )
      console.log('Stripe secret retrieved from Secret Manager')
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

// Stripe Firestore utilities
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

// チケット作成サービス
const createTicketDocument = async (orderId: string): Promise<void> => {
  try {
    logger.info(`チケット発券処理開始: orderId=${orderId}`)

    // 既存のチケットをチェック
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

    // 注文情報を取得
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

    // 注文ステータスの確認（preの場合のみチケット作成を実行）
    if (orderData.status !== 'pre') {
      logger.warn(
        `注文ステータスがpre以外のためチケット発券スキップ: orderId=${orderId}, status=${orderData.status}`,
      )
      return
    }

    // 注文の確定（preステータスの場合のみorderに更新）
    const shouldUpdateStatus = orderData.status === 'pre'

    // 注文の確定（preステータスの場合のみorderに更新）
    if (shouldUpdateStatus) {
      await orderDoc.ref.set({ status: 'order' }, { merge: true })
      logger.info(`注文ステータスをorderに更新: orderId=${orderId}`)
    }

    // 決済完了の確認（paymentIntentIdが存在する場合はpaidステータスに更新）
    if (orderData.paymentIntentId) {
      await orderDoc.ref.set({ status: 'paid' }, { merge: true })
      logger.info(
        `注文ステータスをpaidに更新: orderId=${orderId}, paymentIntentId=${orderData.paymentIntentId}`,
      )
    }

    // ユーザー購入履歴の更新
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

    // イベント販売履歴の更新
    const eventId = orderData.eventId
    const eventDocRef = db.collection('v/1/events').doc(eventId)
    await eventDocRef
      .collection('orders')
      .doc(orderId)
      .set({ orderDocRef: orderDoc.ref.path }, { merge: true })
    logger.info(
      `イベント販売履歴を更新: eventId=${eventId}, orderId=${orderId}`,
    )

    // チケット発券
    const products = orderData.snapshotProducts

    // トランザクション内でチケット作成
    await db.runTransaction(async (transaction) => {
      // 最初にすべてのチケットの存在チェックを実行
      const ticketChecks: Promise<admin.firestore.DocumentSnapshot>[] = []
      const ticketParams: any[] = []

      for (const product of products) {
        for (let index = 0; index < product.quantity; index++) {
          const ticketId = `ticket_${orderId}_${product.productId}_${index}`

          const params = {
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

          // チケットの存在チェックを追加
          const ticketRef = db.collection('v/1/tickets').doc(ticketId)
          ticketChecks.push(transaction.get(ticketRef))
          ticketParams.push({ ticketId, params })
          logger.info(
            `チケット作成準備: ticketId=${ticketId}, orderId=${orderId}, productId=${product.productId}, userId=${product.userId}`,
          )
        }
      }

      // すべての読み取り操作を実行
      const ticketSnapshots = await Promise.all(ticketChecks)

      // 存在しないチケットのみ作成
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
    logger.info(
      `payment_intent.succeeded処理開始: paymentIntentId=${paymentIntent.id}, orderId=${paymentIntent.metadata?.orderId}, customerId=${paymentIntent.customer}, amount=${paymentIntent.amount}, status=${paymentIntent.status}`,
    )

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

    // 注文ステータス更新はチケット作成後に実行するため、ここではスキップ
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

    // チケット作成はcheckout.session.completedで実行するため、ここではスキップ
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

    // 最新のPaymentIntent情報を再取得
    const latestPaymentIntent = await (
      await getStripe()
    ).paymentIntents.retrieve(paymentIntent.id, {
      expand: ['customer', 'last_payment_error'],
    })

    // 失敗の詳細情報をログに記録
    logger.info(
      `決済失敗詳細: paymentIntentId=${latestPaymentIntent.id}, status=${latestPaymentIntent.status}, lastPaymentError=${latestPaymentIntent.last_payment_error}, orderId=${latestPaymentIntent.metadata?.orderId}, customerId=${latestPaymentIntent.customer}`,
    )

    // 注文キャンセル処理（V2同等）
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

    logger.info(
      `checkout.session.completed詳細: checkoutSessionId=${latestCheckoutSession.id}, orderId=${orderId}, paymentStatus=${latestCheckoutSession.payment_status}, customerId=${latestCheckoutSession.customer}, lineItems=${JSON.stringify(latestCheckoutSession.line_items)}`,
    )

    // チケット作成処理
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
      let endpointSecret = getStripeEpKey()
      if (!endpointSecret) {
        endpointSecret = await getSecretManagerSecret(
          getProjectId() === 'tliny-c9630' ? 'STRIPE_EP' : 'STRIPE_DEV_EP',
        )
        console.log('Webhook endpoint secret retrieved from Secret Manager')
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
        'stripe_events',
        'event_id',
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

// 手動チケット作成用にエクスポート
export { createTicketDocument }

// 手動チケット作成用のHTTPエンドポイント
export const manualTicketCreation = functions.https.onRequest(
  async (req, res) => {
    try {
      // APIキー認証
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

      // 直接createTicketDocument関数を呼び出し
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

// カートに商品を戻す
const sendBackCartItem = async (userId: string, orderItems: any[]) => {
  try {
    for (const orderItem of orderItems) {
      const cartItemId = `${userId}_${orderItem.productId}_${orderItem.eventId}`
      const cartRef = db
        .collection(`v/1/users/${userId}/cart_items`)
        .doc(cartItemId)
      const cartSnap = (await cartRef.get()) as any
      const exists = cartSnap.exists
      if (!exists) {
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

// V2同等の注文キャンセル処理
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
  // ステータス更新
  await orderDoc.ref.set(
    { status: 'cancel', cancelAt: new Date() },
    { merge: true },
  )
  // 在庫差し戻し
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
  // カート返却
  if (orderData.userId) {
    await sendBackCartItem(orderData.userId, orderItems)
  }
  return 'canceled'
}

// manualOrderCancelエンドポイントでV2同等のキャンセル処理を利用
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
