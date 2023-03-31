import * as functions from 'firebase-functions'
import Stripe from 'stripe'
import { v4 as uuidv4 } from 'uuid'
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import {
  checkAuth,
  getRequestingUserId,
  getStripeConnectAccountId,
} from '../../utils/firebase_utils'
import * as P from '../../utils/function_paths'

import { stripe, stripeOptions } from './utils/stripe_config'
import stripeErrors from './utils/stripe_error'
import { getStripeCustomerId } from './utils/stripe_utils'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'checkout', name], exports, f)

// MARK: - Checkout.Sessionのurlを返す
_exportFunction('onPayment', () =>
  onCall(async (data, context) => {
    try {
      console.log(data)
      const organizerId = data.organizerId
      const orderId = data.orderId
      const lineItems: Stripe.Checkout.SessionCreateParams.LineItem[] =
        data.lineItems
      const successUrl = data.successUrl
      const cancelUrl = data.cancelUrl
      // 認証済みユーザーかどうかチェックする
      checkAuth(context)
      const uid = getRequestingUserId(context)
      console.log(uid)
      const customerId = await getStripeCustomerId(uid)
      if (customerId === null) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
        )
      }
      console.log(customerId)
      const accountId = await getStripeConnectAccountId(organizerId)
      if (accountId === null) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe Account ID'
        )
      }
      console.log(accountId)
      // 顧客の複製
      // const cloneCustomerId = await cloneCustomer(uid, customerId, accountId)

      // 有効なCheckout URLを複数発行しないための施策【二重決済対策】
      // 1. 生成したCheckout URLを一覧で取得
      const { data: sessionList } = await stripe.checkout.sessions.list({
        customer: customerId,
        // customer: cloneCustomerId,
      })
      // 2. 現在有効中のURLをフィルターする
      const openSessionList = sessionList.filter(
        (sessionItem) => sessionItem.status === 'open'
      )
      // 3. 有効中のURLを無効化する
      await Promise.all(
        openSessionList.map((openSessionItem) =>
          stripe.checkout.sessions.expire(openSessionItem.id)
        )
      )

      // 決済URLを発行
      const paymentIntentData: Stripe.Checkout.SessionCreateParams.PaymentIntentData =
        {
          transfer_group: orderId,
          setup_future_usage: 'off_session',
        }
      const params: Stripe.Checkout.SessionCreateParams = {
        mode: 'payment',
        customer: customerId,
        // customer: cloneCustomerId,
        line_items: lineItems,
        success_url: successUrl,
        cancel_url: cancelUrl,
        metadata: { orderId: orderId },
        payment_intent_data: paymentIntentData,
        expires_at: Math.floor(Date.now() / 1000) + 3600 * 2,
      }

      stripeOptions.idempotencyKey = uuidv4()
      // stripeOptions.stripeAccount = accountId

      return await stripe.checkout.sessions.create(params, stripeOptions).then(
        (result: Stripe.Response<Stripe.Checkout.Session>) => {
          const checkoutSessionId = result.id
          const url = result.url
          return { checkoutSessionId: checkoutSessionId, url: url }
        },
        (error: any) => {
          stripeErrors(error)
          console.log('Stripe Checkout Create Error')
          throw new Error(error.message)
        }
      )
    } catch (error: any) {
      console.log(error)
      throw new Error(error)
    }
  })
)

// MARK: - Checkout.Sessionのsetup urlを返す
_exportFunction('onSetup', () =>
  onCall(async (data, context) => {
    const successUrl = data.successUrl
    const cancelUrl = data.cancelUrl
    // const connectAccountId = data.connectAccountId
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    const params: Stripe.Checkout.SessionCreateParams = {
      payment_method_types: ['card'],
      mode: 'setup',
      customer: customerId,
      customer_update: { name: 'auto' },
      success_url: successUrl,
      cancel_url: cancelUrl,
    }
    // if (data.connectAccountId) {
    //   const paymentIntentData: Stripe.Checkout.SessionCreateParams.PaymentIntentData =
    //     {
    //       on_behalf_of: connectAccountId,
    //     }
    //   params.payment_intent_data = paymentIntentData
    // }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.checkout.sessions.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.Checkout.Session>) => {
        const checkoutSessionId = result.id
        const url = result.url
        return { checkoutSessionId: checkoutSessionId, url: url }
      },
      (error: any) => {
        stripeErrors(error)
        console.log('Stripe Checkout Create Error')
        throw new Error(error.message)
      }
    )
  })
)

// MARK: - Checkout.Sessionのsubscription urlを返す
_exportFunction('onSubscription', () =>
  onCall(async (data, context) => {
    const orderId = data.orderId
    const lineItems = data.lineItems
    const successUrl = data.successUrl
    const cancelUrl = data.cancelUrl
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    const params: Stripe.Checkout.SessionCreateParams = {
      mode: 'subscription',
      customer: customerId,
      line_items: lineItems,
      success_url: successUrl,
      cancel_url: cancelUrl,
      metadata: { orderId: orderId },
    }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.checkout.sessions.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.Checkout.Session>) => {
        const checkoutSessionId = result.id
        const url = result.url
        return { checkoutSessionId: checkoutSessionId, url: url }
      },
      (error: any) => {
        stripeErrors(error)
        console.log('Stripe Checkout Create Error')
        throw new Error(error.message)
      }
    )
  })
)

// MARK: - を返す
_exportFunction('onExpire', () =>
  onCall(async (data, context) => {
    const checkoutSessionId = data.checkoutSessionId
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.checkout.sessions
      .expire(checkoutSessionId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Checkout.Session>) => {
          const checkoutSessionId = result.id
          return { checkoutSessionId: checkoutSessionId }
        },
        (error: any) => {
          stripeErrors(error)
          console.log('Stripe Checkout Create Error')
          throw new Error(error.message)
        }
      )
  })
)

// MARK: - を返す
_exportFunction('onRetrieve', () =>
  onCall(async (data, context) => {
    const checkoutSessionId = data.checkoutSessionId
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    return await stripe.checkout.sessions
      .retrieve(checkoutSessionId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Checkout.Session>) => {
          const checkoutSessionId = result.id
          return { checkoutSessionId: checkoutSessionId }
        },
        (error: any) => {
          stripeErrors(error)
          console.log('Stripe Checkout Create Error')
          throw new Error(error.message)
        }
      )
  })
)
