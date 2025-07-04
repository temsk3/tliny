import Stripe from 'stripe'
import {
  getStripe,
  stripeOptions,
  stripeErrors,
  getStripeCustomerId,
  generateIdempotencyKey,
} from './utils'
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { getRequestingUserId, checkAuth } from '../../utils/firebase_utils'
import { HttpsError } from 'firebase-functions/v2/https'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'payment', 'payment_method', name], exports, f)

// Create a PaymentMethod
// クライアント側で実装
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(request)

    const type = request.data.type
    const card = request.data.card
    const billingDetails = request.data.billing_details
    const metadata = request.data.metadata

    const params: Stripe.PaymentMethodCreateParams = {
      type: type,
      card: card,
      billing_details: billingDetails,
      metadata: metadata,
    }

    // 主要パラメータを含めたidempotencyKeyを生成
    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'create_payment_method',
      getRequestingUserId(request),
      type,
      card?.token,
      billingDetails?.email,
      billingDetails?.name,
    )

    return await getStripe()
      .paymentMethods.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentMethod>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Attach a PaymentMethod to a Customer
_exportFunction('onAttach', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(request)

    const paymentMethodId = request.data.paymentMethodId
    const customerId = await getStripeCustomerId(getRequestingUserId(request))
    if (customerId === null) {
      throw new HttpsError('failed-precondition', 'User has no Stripe ID')
    }

    const params: Stripe.PaymentMethodAttachParams = { customer: customerId }

    // 主要パラメータを含めたidempotencyKeyを生成
    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'attach_payment_method',
      getRequestingUserId(request),
      paymentMethodId,
      customerId,
    )

    return await getStripe()
      .paymentMethods.attach(paymentMethodId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentMethod>) => {
          const paymentIntentId = result.id
          return { paymentMethodId: paymentIntentId }
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Retrieve a PaymentMethod
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    checkAuth(request)
    const paymentMethodId: string = request.data.paymentMethodId

    // 取得系はidempotencyKey不要
    return await getStripe()
      .paymentMethods.retrieve(paymentMethodId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentMethod>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Update a PaymentMethod
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(request)

    const paymentMethodId = request.data.paymentMethodId
    const billingDetails = request.data.billing_details
    const card = request.data.card
    const metadata = request.data.metadata

    const params: Stripe.PaymentMethodUpdateParams = {
      billing_details: billingDetails,
      card: card,
      metadata: metadata,
    }

    // 主要パラメータを含めたidempotencyKeyを生成
    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'update_payment_method',
      getRequestingUserId(request),
      paymentMethodId,
      billingDetails?.email,
      billingDetails?.name,
      metadata?.orderId,
    )

    return await getStripe()
      .paymentMethods.update(paymentMethodId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentMethod>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Detach a PaymentMethod from a Customer
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(request)

    const paymentMethodId = request.data.paymentMethodId

    // 主要パラメータを含めたidempotencyKeyを生成
    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'detach_payment_method',
      getRequestingUserId(request),
      paymentMethodId,
    )

    return await getStripe()
      .paymentMethods.detach(paymentMethodId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentMethod>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)
