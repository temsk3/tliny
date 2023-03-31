import * as functions from 'firebase-functions'
import { v4 as uuidv4 } from 'uuid'

import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

import { stripe, stripeOptions } from './utils/stripe_config'
import stripeErrors from './utils/stripe_error'
import { getStripeCustomerId } from './utils/stripe_utils'
import { getRequestingUserId } from '../../utils/firebase_utils'
import Stripe from 'stripe'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'paymentMethod', name], exports, f)

// Create a PaymentMethod
// クライアント側で実装
_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const type = data.paymentMethodTypes // "card" etc.
    const number = data.number
    const expMonth = data.expMonth
    const expYear = data.expYear
    const cvc = data.expMonth

    const params: Stripe.PaymentMethodCreateParams = {
      type: type,
      card: {
        number: number,
        exp_month: expMonth,
        exp_year: expYear,
        cvc: cvc,
      },
    }

    stripeOptions.idempotencyKey = uuidv4()

    await stripe.paymentMethods
      .create(
        //   {
        //   type: type,
        //   card: {
        //     number: number,
        //     exp_month: expMonth,
        //     exp_year: expYear,
        //     cvc: cvc,
        //   },
        // }
        params,
        stripeOptions
      )
      .then(
        (result: any) => {
          const paymentMethodId = result.id
          return { paymentMethodId: paymentMethodId }
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)

// Attach a PaymentMethod to a Customer
_exportFunction('onAttach', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    if (!context.auth || !context.auth.uid) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'User is not authenticated.'
      )
    }
    const paymentMethodId = data.paymentMethodId
    const customerId = await getStripeCustomerId(getRequestingUserId(context))
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }

    const params: Stripe.PaymentMethodAttachParams = { customer: customerId }

    stripeOptions.idempotencyKey = uuidv4()

    await stripe.paymentMethods
      .attach(paymentMethodId, params, stripeOptions)
      .then(
        (result: any) => {
          const paymentIntentId = result.id
          return { paymentMethodId: paymentIntentId }
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)
