// import * as firebaseAdmin from 'firebase-admin'
// import * as functions from 'firebase-functions'
import { Stripe } from 'stripe'
import { v4 as uuidv4 } from 'uuid'
import { onRequest } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'
import { createTicketDocument } from '../firestore/ticket'
import * as logs from './utils/logs'
import {
  stripe,
  stripeOptions,
  stripeWebhookEndpointSecret,
} from './utils/stripe_config'
import stripeErrors from './utils/stripe_error'
import {
  createTransferDocument,
  createWebhookEventDocument,
  getUidFromStripeCustomerId,
  updateOderDocument,
  updatePaymentDocument,
} from './utils/stripe_firestore'
import { cancelOrder } from '../method/order'

const _exportFunction = (name: string, f: () => unknown) =>
  exportFunction([P.v1, P.stripe, 'webhook', name], exports, f)

// const db = firebaseAdmin.firestore()

// /
// / WebHook
// /

// MARK: -
_exportFunction('handleWebhookEvents', () =>
  onRequest(async (request, response) => {
    console.log('stripe_webhook ==========')

    // const event = request.body
    const relevantEvents = new Set([
      'payment_intent.succeeded',
      'payment_intent.canceled',
      //
      'payment_method.attached',
      //
      'checkout.session.completed',
      'checkout.session.async_payment_succeeded',
      'checkout.session.async_payment_failed',
      'checkout.session.expired',
    ])
    let event: Stripe.Event

    const signature = request.headers['stripe-signature']
      ? (request.headers['stripe-signature'] as string)
      : null
    if (!signature) {
      console.error('️[Error]: Webhook signature verification failed.')
      response.status(401).send('Webhook Error: Invalid Secret')
      return
    }

    try {
      // ボディのrawデータ、署名ヘッダー、署名シークレットを指定しイベントを初期化
      event = stripe.webhooks.constructEvent(
        request.rawBody,
        signature,
        stripeWebhookEndpointSecret
      )
    } catch (error: any) {
      // 不正なリクエストの場合
      // return response.status(400).send(`Webhook Error: ${err.message}`)
      logs.badWebhookSecret(error)
      response.status(401).send('Webhook Error: Invalid Secret')
      return
    }
    // stripe_eventsコレクションにドキュメントを追加
    createWebhookEventDocument(event)

    // イベントのタイプに応じて処理を行う
    if (relevantEvents.has(event.type)) {
      logs.startWebhookEventProcessing(event.id, event.type)
      try {
        switch (
          event.type // イベントのタイプに応じて処理を行う
        ) {
          // payment_intent
          case 'payment_intent.succeeded': {
            // PaymentIntentによる決済成功時
            const paymentIntent = event.data.object as Stripe.PaymentIntent // PaymentIntentのインスタンスを取得
            console.log('Payment Intent Succeeded', paymentIntent)
            const customer = paymentIntent.customer
            if (!customer) {
              throw new Error('customer is null')
            }
            const uid = await getUidFromStripeCustomerId(customer as string)
            if (!uid) {
              throw new Error('uid not found')
            }

            await updatePaymentDocument({
              uid,
              paymentIntentId: paymentIntent.id,
              status: paymentIntent.status,
            })

            await updateOderDocument({
              orderId: paymentIntent.metadata.order_id,
              status: paymentIntent.status,
            })
            const fee = Math.floor(paymentIntent.amount * 0.05)
            const amount = paymentIntent.amount - fee
            const params: Stripe.TransferCreateParams = {
              amount: amount,
              currency: 'jpy',
              // source_transaction: paymentIntent.latest_charge as string,
              destination: paymentIntent.metadata.account_id,
              transfer_group: paymentIntent.metadata.order_id,
            }
            stripeOptions.idempotencyKey = uuidv4()
            const transfer = await stripe.transfers
              .create(params, stripeOptions)
              .then(
                (result: Stripe.Response<Stripe.Transfer>) => result,
                (error: any) => {
                  stripeErrors(error)
                  throw new Error('transfer failed')
                }
              )
            await createTransferDocument(transfer.id)

            await createTicketDocument(paymentIntent.metadata.order_id)

            response.json({ received: true }) // ステータス200でレスポンスを返却
            break
          }
          case 'payment_intent.canceled': {
            const paymentIntent = event.data.object as Stripe.PaymentIntent
            console.log('Payment Intent Cancelled', paymentIntent)
            response.json({ received: true }) // ステータス200でレスポンスを返却

            break
          }
          case 'payment_intent.payment_failed': {
            const paymentIntent = event.data.object as Stripe.PaymentIntent
            console.log('Payment Intent Failed', paymentIntent)
            response.json({ received: true }) // ステータス200でレスポンスを返却
            break
          }
          // checkout_session
          case 'checkout.session.completed': {
            const checkoutSession = event.data.object as Stripe.Checkout.Session
            console.log('Checkout Session Completed', checkoutSession)
            try {
              if (checkoutSession.payment_status === 'paid') {
                if (checkoutSession.metadata === null) {
                  new Error('not orderId')
                  break
                }
                const orderId = checkoutSession.metadata.order_id
                console.log(orderId)
                // order
                // 発券処理
                await createTicketDocument(orderId)
              }
            } catch (e) {
              console.log(
                '========== WEB HOOK 決裁情報の取得に失敗==============='
              )
              console.log(e)
              console.log('=========================')
            }
            response.json({ received: true }) // ステータス200でレスポンスを返却
            break
          }
          case 'checkout.session.async_payment_succeeded': {
            const checkoutSession = event.data.object as Stripe.Checkout.Session
            console.log('Checkout Session Succeeded', checkoutSession)
            if (checkoutSession.payment_status === 'paid') {
              if (checkoutSession.metadata === null) {
                new Error('not orderId')
                break
              }
              const orderId = checkoutSession.metadata.order_id
              console.log('order_id : ' + orderId)
              // order
              // 発券処理
              await createTicketDocument(orderId)
            }
            response.json({ received: true }) // ステータス200でレスポンスを返却
            break
          }
          case 'checkout.session.async_payment_failed': {
            const checkoutSession = event.data.object as Stripe.Checkout.Session
            console.log('Checkout Session Failed', checkoutSession)
            try {
              if (checkoutSession.metadata === null) {
                new Error('not orderId')
                break
              }
              const orderId = checkoutSession.metadata.order_id
              console.log('order_id : ' + orderId)
              // cancel
              // 在庫を戻す
              // カートに商品を戻す
              await cancelOrder(orderId)
            } catch (e) {
              console.log(
                '========== WEB HOOK 決裁情報の取得に失敗==============='
              )
              console.log(e)
              console.log('=========================')
            }
            response.json({ received: true }) // ステータス200でレスポンスを返却
            break
          }
          case 'checkout.session.expired': {
            const checkoutSession = event.data.object as Stripe.Checkout.Session
            console.log('Checkout Session Expired', checkoutSession)
            try {
              if (checkoutSession.metadata === null) {
                new Error('not orderId')
                break
              }
              const orderId = checkoutSession.metadata.orderId
              console.log('order_id : ' + orderId)
              // cancel
              // 在庫を戻す
              // カートに商品を戻す
              cancelOrder(orderId)
            } catch (e) {
              console.log(
                '========== WEB HOOK 決裁情報の取得に失敗==============='
              )
              console.log(e)
              console.log('=========================')
            }
            response.json({ received: true }) // ステータス200でレスポンスを返却
            break
          }
          // payment_method
          case 'payment_method.attached': {
            // PaymentMethodがカスタマーに紐づけられた時
            const paymentMethod = event.data.object // PaymentMethodのインスタンスを取得
            console.log(paymentMethod)
            response.json({ received: true }) // ステータス200でレスポンスを返却
            break
          }
          default: {
            // 想定していないイベントが通知された場合
            console.log('====WEBHOC ERROR====')
            console.log('Stripe Webhoc 想定していないイベントを受領 ========')

            logs.webhookHandlerError(
              new Error('Unhandled relevant event!'),
              event.id,
              event.type
            )
            // console.log(event.type)
            console.log('========')
            // return response.status(400).end() // ステータス400でレスポンスを返却
            response.status(400).end()
            // new Error('Unhandled relevant event!')
          }
        }
        logs.webhookHandlerSucceeded(event.id, event.type)
      } catch (error: any) {
        logs.webhookHandlerError(error, event.id, event.type)
        response.status(500).json({
          error: 'Webhook handler failed. View function logs in Firebase.',
        })
        return
      }
    }

    response.json({ received: true }) // 何かしらレスポンスは必須
  })
)
