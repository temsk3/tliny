// // import * as firebaseAdmin from 'firebase-admin'
// // import * as functions from 'firebase-functions'
// import { Stripe } from 'stripe'
// import { v4 as uuidv4 } from 'uuid'
// import { onRequest } from '../../utils/base_function'
// import { exportFunction } from '../../utils/deploy'
// import * as P from '../../utils/function_paths'
// import { createTicketDocument } from '../method/ticket'
// import * as logs from './utils/logs'
// import {
//   stripe,
//   stripeOptions,
//   stripeWebhookEndpointSecret,
// } from './utils/stripe_config'
// import stripeErrors from './utils/stripe_error'
// import {
//   createTransferDocument,
//   createWebhookEventDocument,
//   getUidFromStripeCustomerId,
//   updateOderDocument,
//   updatePaymentDocument,
// } from './utils/stripe_firestore'
// import { cancelOrder } from '../method/order'
// import { updateAccountStatus } from '../method/stripeAccount'

// const _exportFunction = (name: string, f: () => unknown) =>
//   exportFunction([P.v1, P.stripe, 'webhook', name], exports, f)

// // const db = firebaseAdmin.firestore()

// // /
// // / WebHook
// // /

// // MARK: -
// _exportFunction('handleWebhookEvents', () =>
//   onRequest(async (request, response) => {
//     console.log('stripe_webhook ==========')

//     // const event = request.body
//     const relevantEvents = new Set([
//       'account.updated',
//       //
//       'payment_intent.succeeded',
//       'payment_intent.canceled',
//       //
//       'payment_method.attached',
//       //
//       'checkout.session.completed',
//       'checkout.session.async_payment_succeeded',
//       'checkout.session.async_payment_failed',
//       'checkout.session.expired',
//     ])
//     let event: Stripe.Event

//     const signature = request.headers['stripe-signature']
//       ? (request.headers['stripe-signature'] as string)
//       : null
//     if (!signature) {
//       console.error('️[Error]: Webhook signature verification failed.')
//       response.status(401).send('Webhook Error: Invalid Secret')
//       return
//     }

//     try {
//       // ボディのrawデータ、署名ヘッダー、署名シークレットを指定しイベントを初期化
//       event = stripe.webhooks.constructEvent(
//         request.rawBody,
//         signature,
//         stripeWebhookEndpointSecret
//       )
//     } catch (error: any) {
//       // 不正なリクエストの場合
//       // return response.status(400).send(`Webhook Error: ${err.message}`)
//       logs.badWebhookSecret(error)
//       response.status(401).send('Webhook Error: Invalid Secret')
//       return
//     }
//     // stripe_eventsコレクションにドキュメントを追加
//     createWebhookEventDocument(event)

//     // イベントのタイプに応じて処理を行う
//     if (relevantEvents.has(event.type)) {
//       logs.startWebhookEventProcessing(event.id, event.type)
//       try {
//         switch (
//           event.type // イベントのタイプに応じて処理を行う
//         ) {
//           // Account_update
//           case 'account.updated': {
//             const accountData = event.data.object as Stripe.Account
//             console.log('Checkout Session Completed', accountData)
//             try {
//               let stripeStatus = 'unverified'
//               if (accountData.individual !== undefined) {
//                 if (accountData.individual.verification !== undefined) {
//                   stripeStatus = accountData.individual.verification.status
//                 }
//               }
//               let uid = undefined
//               if (accountData.metadata) {
//                 uid = accountData.metadata.uid
//               }
//               const chargesEnabled = accountData.charges_enabled
//               updateAccountStatus(
//                 uid,
//                 accountData.id,
//                 stripeStatus,
//                 chargesEnabled
//               )
//             } catch (e) {
//               console.log(
//                 '========== WEB HOOK Account情報のUpdateに失敗==============='
//               )
//               console.log(e)
//               console.log('=========================')
//             }
//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           // payment_intent
//           case 'payment_intent.succeeded': {
//             // PaymentIntentによる決済成功時
//             // PaymentIntentのインスタンスを取得
//             const paymentIntent = event.data.object as Stripe.PaymentIntent
//             console.log('Payment Intent Succeeded', paymentIntent)
//             const customer = paymentIntent.customer
//             if (!customer) {
//               throw new Error('customer is null')
//             }
//             const uid = await getUidFromStripeCustomerId(customer as string)
//             if (!uid) {
//               throw new Error('uid not found')
//             }

//             await updatePaymentDocument({
//               uid,
//               paymentIntentId: paymentIntent.id,
//               status: paymentIntent.status,
//             })

//             await updateOderDocument({
//               orderId: paymentIntent.metadata.orderId,
//               status: paymentIntent.status,
//             })
//             const fee = Math.floor(paymentIntent.amount * 0.05)
//             const amount = paymentIntent.amount - fee
//             const params: Stripe.TransferCreateParams = {
//               amount: amount,
//               currency: 'jpy',
//               // source_transaction: paymentIntent.latest_charge as string,
//               destination: paymentIntent.metadata.account_id,
//               transfer_group: paymentIntent.metadata.orderId,
//             }
//             stripeOptions.idempotencyKey = uuidv4()
//             const transfer = await stripe.transfers
//               .create(params, stripeOptions)
//               .then(
//                 (result: Stripe.Response<Stripe.Transfer>) => result,
//                 (error: any) => {
//                   stripeErrors(error)
//                   throw new Error('transfer failed')
//                 }
//               )
//             await createTransferDocument(transfer.id)

//             await createTicketDocument(paymentIntent.metadata.orderId)

//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           case 'payment_intent.canceled': {
//             const paymentIntent = event.data.object as Stripe.PaymentIntent
//             console.log('Payment Intent Cancelled', paymentIntent)
//             response.json({ received: true }) // ステータス200でレスポンスを返却

//             break
//           }
//           case 'payment_intent.payment_failed': {
//             const paymentIntent = event.data.object as Stripe.PaymentIntent
//             console.log('Payment Intent Failed', paymentIntent)
//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           // checkout_session
//           case 'checkout.session.completed': {
//             const checkoutSession = event.data.object as Stripe.Checkout.Session
//             console.log('Checkout Session Completed', checkoutSession)
//             try {
//               if (checkoutSession.payment_status === 'paid') {
//                 if (checkoutSession.metadata === null) {
//                   new Error('not orderId')
//                   break
//                 }
//                 const orderId = checkoutSession.metadata.orderId
//                 console.log(orderId)
//                 // order
//                 // 発券処理
//                 await createTicketDocument(orderId)
//               }
//             } catch (e) {
//               console.log(
//                 '========== WEB HOOK 決裁情報の取得に失敗==============='
//               )
//               console.log(e)
//               console.log('=========================')
//             }
//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           case 'checkout.session.async_payment_succeeded': {
//             const checkoutSession = event.data.object as Stripe.Checkout.Session
//             console.log('Checkout Session Succeeded', checkoutSession)
//             if (checkoutSession.payment_status === 'paid') {
//               if (checkoutSession.metadata === null) {
//                 new Error('not orderId')
//                 break
//               }
//               const orderId = checkoutSession.metadata.orderId
//               console.log('orderId : ' + orderId)
//               // order
//               // 発券処理
//               await createTicketDocument(orderId)
//             }
//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           case 'checkout.session.async_payment_failed': {
//             const checkoutSession = event.data.object as Stripe.Checkout.Session
//             console.log('Checkout Session Failed', checkoutSession)
//             try {
//               if (checkoutSession.metadata === null) {
//                 new Error('not orderId')
//                 break
//               }
//               const orderId = checkoutSession.metadata.orderId
//               console.log('orderId : ' + orderId)
//               // cancel
//               // 在庫を戻す
//               // カートに商品を戻す
//               await cancelOrder(orderId)
//             } catch (e) {
//               console.log(
//                 '========== WEB HOOK 決裁情報の取得に失敗==============='
//               )
//               console.log(e)
//               console.log('=========================')
//             }
//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           case 'checkout.session.expired': {
//             const checkoutSession = event.data.object as Stripe.Checkout.Session
//             console.log('Checkout Session Expired', checkoutSession)
//             try {
//               if (checkoutSession.metadata === null) {
//                 new Error('not orderId')
//                 break
//               }
//               const orderId = checkoutSession.metadata.orderId
//               console.log('orderId : ' + orderId)
//               // cancel
//               // 在庫を戻す
//               // カートに商品を戻す
//               cancelOrder(orderId)
//             } catch (e) {
//               console.log(
//                 '========== WEB HOOK 決裁情報の取得に失敗==============='
//               )
//               console.log(e)
//               console.log('=========================')
//             }
//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           // payment_method
//           case 'payment_method.attached': {
//             // PaymentMethodがカスタマーに紐づけられた時
//             const paymentMethod = event.data.object // PaymentMethodのインスタンスを取得
//             console.log(paymentMethod)
//             response.json({ received: true }) // ステータス200でレスポンスを返却
//             break
//           }
//           default: {
//             // 想定していないイベントが通知された場合
//             console.log('====WEB HOOK ERROR====')
//             console.log('Stripe Web hook 想定していないイベントを受領 ========')

//             logs.webhookHandlerError(
//               new Error('Unhandled relevant event!'),
//               event.id,
//               event.type
//             )
//             // console.log(event.type)
//             console.log('========')
//             // return response.status(400).end() // ステータス400でレスポンスを返却
//             response.status(400).end()
//             // new Error('Unhandled relevant event!')
//           }
//         }
//         logs.webhookHandlerSucceeded(event.id, event.type)
//         return
//       } catch (error: any) {
//         logs.webhookHandlerError(error, event.id, event.type)
//         response.status(500).json({
//           error: 'Webhook handler failed. View function logs in Firebase.',
//         })
//         return
//       }
//     }

//     response.json({ received: true }) // 何かしらレスポンスは必須
//   })
// )

import { Stripe } from 'stripe'
import { v4 as uuidv4 } from 'uuid'
import { onRequest } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'
import { createTicketDocument } from '../method/ticket'
import * as logs from './utils/logs'
import {
  stripe,
  stripeOptions,
  stripeWebhookEndpointSecret,
  APPLICATION_FEE_PERCENT,
  currency,
} from './utils/stripe_config'
import {
  createTransferDocument,
  createWebhookEventDocument,
  getUidFromStripeCustomerId,
  updateOderDocument,
  updatePaymentDocument,
} from './utils/stripe_firestore'
import { cancelOrder } from '../method/order'
import { updateAccountStatus } from '../method/stripeAccount'

// エクスポート用の関数を定義するヘルパー関数
const _exportFunction = (name: string, f: () => unknown) =>
  exportFunction([P.v1, P.stripe, 'webhook', name], exports, f)

// 処理対象のStripeイベントを定義
const RELEVANT_EVENTS = [
  'account.updated',
  'payment_intent.succeeded',
  'payment_intent.canceled',
  'payment_intent.payment_failed',
  'payment_method.attached',
  'checkout.session.completed',
  'checkout.session.async_payment_succeeded',
  'checkout.session.async_payment_failed',
  'checkout.session.expired',
] as const
// 処理対象のイベントタイプの型エイリアス
type RelevantEventType = (typeof RELEVANT_EVENTS)[number]

// エラー処理とレスポンス送信を行うヘルパー関数
const handleError = (
  error: any,
  response: any,
  status = 500,
  message = 'Webhook handler failed.',
) => {
  console.error(error)
  response.status(status).json({ error: message })
}

/**
 * Stripeアカウントが更新された際の処理
 * @param {Stripe.Account} accountUpdatedEvent - Stripe.Account オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handleAccountUpdated = async (
  accountUpdatedEvent: Stripe.Account,
  response: any,
) => {
  console.log('Account Updated', accountUpdatedEvent)
  try {
    // StripeアカウントのIDを取得
    const accountId = accountUpdatedEvent.id
    // Stripeからアカウント情報を取得
    const accountData = await stripe.accounts.retrieve(accountId)
    // charges_enabledとpayouts_enabledからStripeの状態を判定
    let stripeStatus: 'unverified' | 'pending' | 'verified' = 'unverified'
    if (accountData.charges_enabled && accountData.payouts_enabled) {
      stripeStatus = 'verified'
    } else if (accountData.charges_enabled || accountData.payouts_enabled) {
      stripeStatus = 'pending'
    } else {
      stripeStatus = 'unverified'
    }

    // アカウントのメタデータからuidを取得
    const uid = accountData.metadata?.uid
    // charges_enabledとpayouts_enabledを取得
    const chargesEnabled = accountData.charges_enabled
    const payoutsEnabled = accountData.payouts_enabled
    // Firestoreのaccount情報を更新
    await updateAccountStatus(
      uid,
      accountData.id,
      stripeStatus,
      chargesEnabled,
      payoutsEnabled,
    )
    // 成功レスポンスを送信
    response.json({ received: true })
  } catch (e) {
    // エラーが発生した場合
    console.error(
      '========== WEB HOOK Account情報のUpdateに失敗===============',
    )
    console.error(e)
    console.error('=========================')
    handleError(e, response, 500, 'Account Update failed')
  }
}

/**
 * PaymentIntentが成功した際の処理
 * @param {Stripe.PaymentIntent} paymentIntent - Stripe.PaymentIntent オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handlePaymentIntentSucceeded = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  console.log('Payment Intent Succeeded', paymentIntent)
  try {
    // customerがnullの場合はエラー
    if (!paymentIntent.customer) {
      throw new Error('customer is null')
    }
    // StripeのcustomerIdからuidを取得
    const uid = await getUidFromStripeCustomerId(
      paymentIntent.customer as string,
    )
    // uidが取得できなかった場合はエラー
    if (!uid) {
      throw new Error('uid not found')
    }

    // Firestoreのpayment情報を更新
    await updatePaymentDocument({
      uid,
      paymentIntentId: paymentIntent.id,
      status: paymentIntent.status,
    })
    // Firestoreのorder情報を更新
    await updateOderDocument({
      orderId: paymentIntent.metadata.orderId,
      status: paymentIntent.status,
    })
    // 手数料を計算（ここでは5%）
    const fee = Math.floor(
      (paymentIntent.amount * APPLICATION_FEE_PERCENT) / 100,
    )
    // 振込金額を計算
    const amount = paymentIntent.amount - fee
    // 振込パラメータを生成
    const params: Stripe.TransferCreateParams = {
      amount: amount,
      currency: currency,
      // source_transaction: paymentIntent.latest_charge as string,
      destination: paymentIntent.metadata.account_id,
      transfer_group: paymentIntent.metadata.orderId,
    }
    // 冪等性キーを生成
    stripeOptions.idempotencyKey = uuidv4()
    // 振込処理を実行
    const transfer = await stripe.transfers
      .create(params, stripeOptions)
      .catch((error: any) => {
        throw error
      })
    // Firestoreに振込情報を登録
    await createTransferDocument(transfer.id)
    // チケットドキュメントを生成
    await createTicketDocument(paymentIntent.metadata.orderId)

    // 成功レスポンスを送信
    response.json({ received: true })
  } catch (error: any) {
    handleError(error, response, 500, 'Payment Intent Success failed')
  }
}

/**
 * PaymentIntentがキャンセルされた際の処理
 * @param {Stripe.PaymentIntent} paymentIntent - Stripe.PaymentIntent オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handlePaymentIntentCanceled = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  console.log('Payment Intent Cancelled', paymentIntent)
  response.json({ received: true })
}

/**
 * PaymentIntentが失敗した際の処理
 * @param {Stripe.PaymentIntent} paymentIntent - Stripe.PaymentIntent オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handlePaymentIntentFailed = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  console.log('Payment Intent Failed', paymentIntent)
  response.json({ received: true })
}

/**
 * Checkoutセッションが完了した際の処理
 * @param {Stripe.Checkout.Session} checkoutSession - Stripe.Checkout.Session オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handleCheckoutSessionCompleted = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  console.log('Checkout Session Completed', checkoutSession)
  try {
    // payment_statusがpaidかつorderIdが存在する場合
    if (
      checkoutSession.payment_status === 'paid' &&
      checkoutSession.metadata?.orderId
    ) {
      // orderIdを取得
      const orderId = checkoutSession.metadata.orderId
      console.log(orderId)
      // チケットドキュメントを生成
      await createTicketDocument(orderId)
      // 成功レスポンスを送信
      response.json({ received: true })
    } else {
      throw new Error('Payment status is not paid or orderId not found.')
    }
  } catch (e) {
    console.error('========== WEB HOOK 決裁情報の取得に失敗===============')
    console.error(e)
    console.error('=========================')
    handleError(e, response, 500, 'Checkout Session Completed failed')
  }
}

/**
 * Checkoutセッションが非同期で成功した際の処理
 * @param {Stripe.Checkout.Session} checkoutSession - Stripe.Checkout.Session オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handleCheckoutSessionSucceeded = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  console.log('Checkout Session Succeeded', checkoutSession)
  try {
    // payment_statusがpaidかつorderIdが存在する場合
    if (
      checkoutSession.payment_status === 'paid' &&
      checkoutSession.metadata?.orderId
    ) {
      // orderIdを取得
      const orderId = checkoutSession.metadata.orderId
      console.log('orderId : ' + orderId)
      // チケットドキュメントを生成
      await createTicketDocument(orderId)
    } else {
      throw new Error('Payment status is not paid or orderId not found.')
    }
    // 成功レスポンスを送信
    response.json({ received: true })
  } catch (e) {
    handleError(e, response, 500, 'Checkout session Succeeded failed')
  }
}

/**
 * Checkoutセッションが非同期で失敗した際の処理
 * @param {Stripe.Checkout.Session} checkoutSession - Stripe.Checkout.Session オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handleCheckoutSessionFailed = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  console.log('Checkout Session Failed', checkoutSession)
  try {
    // orderIdが存在する場合
    if (checkoutSession.metadata?.orderId) {
      // orderIdを取得
      const orderId = checkoutSession.metadata.orderId
      console.log('orderId : ' + orderId)
      // 注文をキャンセル
      await cancelOrder(orderId)
    } else {
      throw new Error('orderId not found.')
    }
    // 成功レスポンスを送信
    response.json({ received: true })
  } catch (e) {
    console.error('========== WEB HOOK 決裁情報の取得に失敗===============')
    console.error(e)
    console.error('=========================')
    handleError(e, response, 500, 'Checkout Session Failed failed')
  }
}

/**
 * Checkoutセッションが期限切れになった際の処理
 * @param {Stripe.Checkout.Session} checkoutSession - Stripe.Checkout.Session オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handleCheckoutSessionExpired = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  console.log('Checkout Session Expired', checkoutSession)
  try {
    // orderIdが存在する場合
    if (checkoutSession.metadata?.orderId) {
      // orderIdを取得
      const orderId = checkoutSession.metadata.orderId
      console.log('orderId : ' + orderId)
      // 注文をキャンセル
      await cancelOrder(orderId)
    } else {
      throw new Error('orderId not found.')
    }
    // 成功レスポンスを送信
    response.json({ received: true })
  } catch (e) {
    console.error('========== WEB HOOK 決裁情報の取得に失敗===============')
    console.error(e)
    console.error('=========================')
    handleError(e, response, 500, 'Checkout Session Expired failed')
  }
}

/**
 * PaymentMethodがアタッチされた際の処理
 * @param {any}paymentMethod - Stripe.PaymentMethod オブジェクト
 * @param {any} response - レスポンスオブジェクト
 */
const handlePaymentMethodAttached = async (
  paymentMethod: any,
  response: any,
) => {
  console.log('PaymentMethod Attached', paymentMethod)
  response.json({ received: true })
}
/**
 * Webhookイベントを処理するメイン関数
 */
_exportFunction('handleWebhookEvents', () =>
  onRequest(async (request, response) => {
    console.log('stripe_webhook ==========')

    // リクエストヘッダーからStripeの署名を取得
    const signature = request.headers['stripe-signature'] as string | null
    // 署名がない場合はエラー
    if (!signature) {
      console.error('️[Error]: Webhook signature verification failed.')
      return response.status(401).send('Webhook Error: Invalid Secret')
    }

    let event: Stripe.Event
    try {
      // StripeのWebhookイベントを検証
      event = stripe.webhooks.constructEvent(
        request.rawBody,
        signature,
        stripeWebhookEndpointSecret,
      )
    } catch (error: any) {
      // 検証に失敗した場合はエラーログを出力
      logs.badWebhookSecret(error)
      return response.status(401).send('Webhook Error: Invalid Secret')
    }

    // FirestoreにWebhookイベント情報を登録
    await createWebhookEventDocument(event)

    // 処理対象外のイベントの場合は処理をスキップ
    if (!RELEVANT_EVENTS.includes(event.type as RelevantEventType)) {
      return response.json({ received: true })
    }

    // イベント処理開始ログを出力
    logs.startWebhookEventProcessing(event.id, event.type)
    try {
      // イベントタイプに応じて処理を分岐
      switch (event.type) {
        case 'account.updated':
          await handleAccountUpdated(
            event.data.object as Stripe.Account,
            response,
          )
          return
        case 'payment_intent.succeeded':
          await handlePaymentIntentSucceeded(
            event.data.object as Stripe.PaymentIntent,
            response,
          )
          return
        case 'payment_intent.canceled':
          await handlePaymentIntentCanceled(
            event.data.object as Stripe.PaymentIntent,
            response,
          )
          return
        case 'payment_intent.payment_failed':
          await handlePaymentIntentFailed(
            event.data.object as Stripe.PaymentIntent,
            response,
          )
          return
        case 'checkout.session.completed':
          await handleCheckoutSessionCompleted(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          return
        case 'checkout.session.async_payment_succeeded':
          await handleCheckoutSessionSucceeded(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          return
        case 'checkout.session.async_payment_failed':
          await handleCheckoutSessionFailed(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          return
        case 'checkout.session.expired':
          await handleCheckoutSessionExpired(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          return
        case 'payment_method.attached':
          await handlePaymentMethodAttached(event.data.object, response)
          return
        default:
          // 想定外のイベントタイプの場合はエラー
          console.error('====WEB HOOK ERROR====')
          console.error('Stripe Web hook 想定していないイベントを受領 ========')
          logs.webhookHandlerError(
            new Error('Unhandled relevant event!'),
            event.id,
            event.type,
          )
          return response.status(400).end()
      }
    } catch (error: any) {
      // エラーが発生した場合
      logs.webhookHandlerError(error, event.id, event.type)
      handleError(
        error,
        response,
        500,
        'Webhook handler failed. View function logs in Firebase.',
      )
      return
    }

    // デフォルトのレスポンス（何も送信されていない場合のフォールバック）
    if (!response.headersSent) {
      response.json({ received: true })
    }
  }),
)
