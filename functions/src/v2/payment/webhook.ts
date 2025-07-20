import Stripe from 'stripe'
import {
  getStripe,
  stripeOptions,
  stripeErrors,
  APPLICATION_FEE_PERCENT,
} from './utils'
import { onRequest } from '../../utils/base_function'
import { logger, V2Logger } from '../../utils/logger'

import { createTicketDocument } from '../business/services/ticket.service'
import {
  createWebhookEventDocument,
  getUidFromStripeCustomerId,
  updateOderDocument,
  updatePaymentDocument,
} from './utils/stripe_firestore'
import { updateAccountStatus } from '../business/services/account.service'

import { checkDocumentExistsByQuery } from '../firestore/utils/idempotency'

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

const handlePaymentIntentSucceeded = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  const methodName = 'handlePaymentIntentSucceeded'

  try {
    V2Logger.start(methodName, { paymentIntentId: paymentIntent.id })

    // 最新のPaymentIntent情報を再取得
    const latestPaymentIntent = await V2Logger.measure(
      'Stripe PaymentIntent Retrieve',
      async () => {
        return await getStripe()
          .paymentIntents.retrieve(paymentIntent.id, {
            expand: ['customer', 'payment_method'],
          })
          .then(
            (result: Stripe.Response<Stripe.PaymentIntent>) => result,
            (error: any) => {
              stripeErrors(error)
              throw new Error('Failed to retrieve payment intent')
            },
          )
      },
      { paymentIntentId: paymentIntent.id },
    )

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
      currency: 'jpy',
      destination: latestPaymentIntent.metadata.account_id,
      transfer_group: latestPaymentIntent.metadata.orderId,
    }

    stripeOptions.idempotencyKey = `create_transfer_${uid}`

    await V2Logger.measure(
      'Stripe Transfer Create',
      async () => {
        return await getStripe()
          .transfers.create(params, stripeOptions)
          .then(
            (result: Stripe.Response<Stripe.Transfer>) => result,
            (error: any) => {
              stripeErrors(error)
              throw new Error('transfer failed')
            },
          )
      },
      { params },
    )

    await createTicketDocument(latestPaymentIntent.metadata.orderId)

    V2Logger.success(methodName, { received: true })
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    V2Logger.error(methodName, error, { paymentIntentId: paymentIntent.id })
    handleError(error, response)
  }
}

const handlePaymentIntentFailed = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  const methodName = 'handlePaymentIntentFailed'

  try {
    V2Logger.start(methodName, { paymentIntentId: paymentIntent.id })

    // 最新のPaymentIntent情報を再取得
    const latestPaymentIntent = await V2Logger.measure(
      'Stripe PaymentIntent Retrieve',
      async () => {
        return await getStripe()
          .paymentIntents.retrieve(paymentIntent.id, {
            expand: ['customer', 'last_payment_error'],
          })
          .then(
            (result: Stripe.Response<Stripe.PaymentIntent>) => result,
            (error: any) => {
              stripeErrors(error)
              throw new Error('Failed to retrieve payment intent')
            },
          )
      },
      { paymentIntentId: paymentIntent.id },
    )

    // 失敗の詳細情報をログに記録
    logger.info('Payment intent failed', {
      paymentIntentId: latestPaymentIntent.id,
      status: latestPaymentIntent.status,
      lastPaymentError: latestPaymentIntent.last_payment_error,
    })

    V2Logger.success(methodName, { received: true })
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    V2Logger.error(methodName, error, { paymentIntentId: paymentIntent.id })
    handleError(error, response)
  }
}

const handleCheckoutSessionCompleted = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  const methodName = 'handleCheckoutSessionCompleted'

  // 関数呼び出し直後に強制DEBUG出力
  logger.error('!!! FORCE DEBUG: handleCheckoutSessionCompleted called', {
    checkoutSession,
  })

  try {
    V2Logger.start(methodName, { checkoutSessionId: checkoutSession.id })

    // 最新のCheckoutSession情報を再取得
    const latestCheckoutSession = await V2Logger.measure(
      'Stripe CheckoutSession Retrieve',
      async () => {
        // accountIdはmetadataから取得
        const accountId = checkoutSession.metadata?.accountId
        logger.info('!!! DEBUG: Stripe CheckoutSession Retrieve params', {
          checkoutSessionId: checkoutSession.id,
          stripeAccount: accountId || undefined,
          stripeApiKey:
            process.env.STRIPE_KEY ||
            process.env.STRIPE_SECRET_KEY ||
            'not_set',
        })
        return await getStripe()
          .checkout.sessions.retrieve(
            checkoutSession.id,
            { expand: ['customer', 'payment_intent', 'line_items'] },
            accountId ? { stripeAccount: accountId } : undefined,
          )
          .then(
            (result: Stripe.Response<Stripe.Checkout.Session>) => result,
            (error: any) => {
              // Stripe APIエラー詳細も出力
              logger.error('!!! DEBUG: Stripe API Error', {
                code: error?.code,
                type: error?.type,
                raw: error?.raw,
                message: error?.message,
                stack: error?.stack,
              })
              stripeErrors(error)
              throw new Error('Failed to retrieve checkout session')
            },
          )
      },
      { checkoutSessionId: checkoutSession.id },
    )

    // --- ここからデバッグ用ログと型ガード追加 ---
    const metadata = latestCheckoutSession.metadata
    logger.info('!!! FORCE DEBUG: checkoutSession.metadata', {
      metadata,
      type: typeof metadata,
    })

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
    // --- ここまで追加 ---

    if (!orderId) {
      throw new Error('orderId not found in checkout session metadata')
    }

    // デバッグログ: line_itemsの詳細を出力
    logger.info('!!! FORCE DEBUG: checkout session line items', {
      checkoutSessionId: latestCheckoutSession.id,
      lineItems: latestCheckoutSession.line_items?.data,
      lineItemsImages: latestCheckoutSession.line_items?.data?.map(
        (item: any) => ({
          name: item.description,
          images: item.price?.product?.images,
        }),
      ),
    })

    logger.info('Processing checkout session completion', {
      checkoutSessionId: latestCheckoutSession.id,
      orderId,
      paymentStatus: latestCheckoutSession.payment_status,
      customerId: latestCheckoutSession.customer,
    })

    // チケット作成処理
    await createTicketDocument(orderId)

    V2Logger.success(methodName, {
      checkoutSessionId: latestCheckoutSession.id,
      orderId,
      received: true,
    })
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    // まずconsole.errorで生のerrorを出す
    console.error('!!! RAW ERROR:', error)
    logger.error('!!! FORCE DEBUG: CATCH', {
      error,
      errorType: typeof error,
      errorString: JSON.stringify(error),
      errorMessage: error?.message,
      errorStack: error?.stack,
      checkoutSession,
    })
    V2Logger.error(methodName, error, { checkoutSessionId: checkoutSession.id })
    handleError(error, response)
  }
}

const handleAccountUpdated = async (account: Stripe.Account, response: any) => {
  const methodName = 'handleAccountUpdated'

  try {
    V2Logger.start(methodName, { accountId: account.id })

    // 最新のAccount情報を再取得
    const latestAccount = await V2Logger.measure(
      'Stripe Account Retrieve',
      async () => {
        return await getStripe()
          .accounts.retrieve(account.id)
          .then(
            (result: Stripe.Response<Stripe.Account>) => result,
            (error: any) => {
              stripeErrors(error)
              throw new Error('Failed to retrieve account')
            },
          )
      },
      { accountId: account.id },
    )

    let status = 'unverified'

    // デバッグ用ログを追加
    logger.info('Account structure debug:', {
      accountId: latestAccount.id,
      hasIndividual: !!latestAccount.individual,
      individualKeys: latestAccount.individual
        ? Object.keys(latestAccount.individual)
        : [],
      accountKeys: Object.keys(latestAccount),
    })

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

    V2Logger.success(methodName, { received: true })
    setImmediate(() => {
      response.json({ received: true })
    })
  } catch (error: any) {
    V2Logger.error(methodName, error, { accountId: account.id })
    handleError(error, response)
  }
}

// Webhook endpoint for Stripe events
const onStripeWebhook = onRequest(async (req, res) => {
  const methodName = 'onStripeWebhook'

  try {
    V2Logger.start(methodName, {
      method: req.method,
      eventType: req.headers['stripe-signature'] ? 'stripe-webhook' : 'unknown',
    })

    if (req.method !== 'POST') {
      res.status(405).send('Method Not Allowed')
      return
    }
    const sig = req.headers['stripe-signature']
    const endpointSecret = process.env.STRIPE_DEV_EP
    if (!sig || !endpointSecret) {
      res.status(400).send('Webhook signature verification failed')
      return
    }

    let rawBody = (req as any).rawBody
    if (!(rawBody instanceof Buffer)) {
      rawBody = Buffer.from(rawBody)
    }
    const event = getStripe().webhooks.constructEvent(
      rawBody,
      sig as string,
      endpointSecret,
    )

    // 冪等性保証: 同じWebhookイベントが既に処理済みかチェック
    const eventExists = await checkDocumentExistsByQuery(
      'v/1/platform/spel1/stripe_events',
      'stripe_event_id',
      event.id,
    )
    if (eventExists) {
      V2Logger.warn(methodName, 'Webhook event already processed, skipping', {
        eventId: event.id,
        eventType: event.type,
      })
      res.status(200).send('Event already processed')
      return
    }

    // Webhookイベントドキュメントを作成（本番と同じタイミング）
    await V2Logger.measure(
      'createWebhookEventDocument',
      async () => {
        return await createWebhookEventDocument(event)
      },
      { eventId: event.id, eventType: event.type },
    )

    logger.info('Processing webhook event', {
      eventId: event.id,
      eventType: event.type,
    })
    try {
      switch (event.type) {
        case 'payment_intent.succeeded':
          logger.info('Processing payment_intent.succeeded event', {
            eventId: event.id,
            paymentIntentId: (event.data.object as Stripe.PaymentIntent).id,
          })
          await handlePaymentIntentSucceeded(
            event.data.object as Stripe.PaymentIntent,
            res,
          )
          break
        case 'payment_intent.payment_failed':
          logger.info('Processing payment_intent.payment_failed event', {
            eventId: event.id,
            paymentIntentId: (event.data.object as Stripe.PaymentIntent).id,
          })
          await handlePaymentIntentFailed(
            event.data.object as Stripe.PaymentIntent,
            res,
          )
          break
        case 'checkout.session.completed':
          logger.info('Processing checkout.session.completed event', {
            eventId: event.id,
            checkoutSessionId: (event.data.object as Stripe.Checkout.Session)
              .id,
          })
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
          V2Logger.success(methodName, { eventType: 'charge.succeeded' })
          res.status(200).send('OK: charge.succeeded')
          return
        default:
          V2Logger.warn(methodName, 'Unhandled event type', {
            eventType: event.type,
          })
          setImmediate(() => {
            res.status(200).send('Event type not handled')
          })
          return
      }
    } catch (error: any) {
      V2Logger.error(methodName, error, {
        eventId: event.id,
        eventType: event.type,
      })
      setImmediate(() => {
        res.status(500).send('Webhook processing failed')
      })
      return
    }
  } catch (err: any) {
    V2Logger.error(methodName, err, {
      errorType: 'webhook_construction',
    })
    res.status(400).send(`Webhook Error: ${err.message}`)
    return
  }
})

export { onStripeWebhook as 'v2_payment_webhook_onStripeWebhook' }
