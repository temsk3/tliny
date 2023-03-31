import * as functions from 'firebase-functions'
import { v4 as uuidv4 } from 'uuid'

import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

import Stripe from 'stripe'
import { getRequestingUserId, getUserEmail } from '../../utils/firebase_utils'
import { currency, stripe, stripeOptions } from './utils/stripe_config'
import stripeErrors from './utils/stripe_error'
import { getStripeCustomerId } from './utils/stripe_utils'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'paymentIntent', name], exports, f)

// Create a PaymentIntent
_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    const params: Stripe.PaymentIntentCreateParams = data.params
    // const params: Stripe.PaymentIntentCreateParams = {
    //   customer: customerId,
    //   setup_future_usage: 'off_session',
    //   amount: data.amount,
    //   currency: currency,
    //   payment_method_types: data.paymentMethodTypes, // ["card"]
    // }
    params.customer = customerId

    stripeOptions.idempotencyKey = uuidv4()

    console.log(stripeOptions)
    return await stripe.paymentIntents.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.PaymentIntent>) => {
        // const clientSecret = result.client_secret
        return result
        // const paymentIntentId = result.id
        // return { paymentIntentId: paymentIntentId }
      },
      (error: any) => {
        stripeErrors(error)
      }
    )
  })
)

// Capture a PaymentIntent
_exportFunction('onCapture', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const paymentIntentId: string = data.paymentIntentId

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.paymentIntents
      .capture(paymentIntentId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          // const status = result.status // 'succeeded'
          return result
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)

// Confirm a PaymentIntent
_exportFunction('onConfirm', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const paymentId = data.paymentId
    const params: Stripe.PaymentIntentConfirmParams = {
      payment_method: data.paymentMethod,
    }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.paymentIntents
      .confirm(paymentId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)

// Update a PaymentIntent
_exportFunction('onUpdate', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const clientSecret = data.clientSecret
    const params: Stripe.PaymentIntentUpdateParams = data.params

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.paymentIntents
      .update(clientSecret, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)

// Create a AutomaticPaymentIntent
_exportFunction('onCreateAutomatic', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    // if (!context.auth || !context.auth.uid) {
    //   throw new functions.https.HttpsError(
    //     'unauthenticated',
    //     'User is not authenticated.'
    //   )
    // }
    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    const params: Stripe.PaymentIntentCreateParams = {
      customer: customerId,
      amount: 50,
      currency: currency,
    }
    if (data.amount) params.amount = data.amount
    if (data.returnUrl) params.return_url = data.returnUrl

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.paymentIntents.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.PaymentIntent>) => {
        // console.log('AutomaticPaymentIntent', result)
        return result
      },
      (error: any) => {
        stripeErrors(error)
      }
    )
    // }
  })
)
// Create a ManualPaymentIntent
_exportFunction('onCreateManual', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    // if (!context.auth || !context.auth.uid) {
    //   throw new functions.https.HttpsError(
    //     'unauthenticated',
    //     'User is not authenticated.'
    //   )
    // }
    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    const params: Stripe.PaymentIntentCreateParams = {
      customer: customerId,
      payment_method: data.paymentMethod,
      confirmation_method: 'manual',
      amount: data.amount,
      return_url: data.returnUrl,
      confirm: true,
      currency: currency,
      setup_future_usage: 'on_session',
    }
    const userEmail = await getUserEmail(getRequestingUserId(context))
    if (userEmail !== undefined) {
      params.receipt_email = userEmail
    }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.paymentIntents.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.PaymentIntent>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      }
    )
    // }
  })
)
