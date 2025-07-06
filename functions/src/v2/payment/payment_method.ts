import Stripe from 'stripe'
import {
  getStripe,
  stripeOptions,
  stripeErrors,
  getStripeCustomerId,
  generateIdempotencyKey,
} from './utils'
import { onCall } from '../../utils/base_function'
import { getRequestingUserId, checkAuth } from '../../utils/firebase_utils'
import { HttpsError } from 'firebase-functions/v2/https'

// Create a PaymentMethod
const paymentMethodOnCreate = onCall(async (request) => {
  checkAuth(request)
  const type = (request.data as any).type
  const card = (request.data as any).card
  const billingDetails = (request.data as any).billing_details
  const metadata = (request.data as any).metadata

  const params: Stripe.PaymentMethodCreateParams = {
    type: type,
    card: card,
    billing_details: billingDetails,
    metadata: metadata,
  }

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
})

// Attach a PaymentMethod to a Customer
const paymentMethodOnAttach = onCall(async (request) => {
  checkAuth(request)
  const paymentMethodId = (request.data as any).paymentMethodId
  const customerId = await getStripeCustomerId(getRequestingUserId(request))
  if (customerId === null) {
    throw new HttpsError('failed-precondition', 'User has no Stripe ID')
  }

  const params: Stripe.PaymentMethodAttachParams = { customer: customerId }

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
})

// Retrieve a PaymentMethod
const paymentMethodOnRetrieve = onCall(async (request) => {
  checkAuth(request)
  const paymentMethodId: string = (request.data as any).paymentMethodId

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
})

// Update a PaymentMethod
const paymentMethodOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const paymentMethodId = (request.data as any).paymentMethodId
  const billingDetails = (request.data as any).billing_details
  const card = (request.data as any).card
  const metadata = (request.data as any).metadata

  const params: Stripe.PaymentMethodUpdateParams = {
    billing_details: billingDetails,
    card: card,
    metadata: metadata,
  }

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
})

// Detach a PaymentMethod from a Customer
const paymentMethodOnDelete = onCall(async (request) => {
  checkAuth(request)
  const paymentMethodId = (request.data as any).paymentMethodId

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
})

export {
  paymentMethodOnCreate as 'v2_payment_payment_method_onCreate',
  paymentMethodOnAttach as 'v2_payment_payment_method_onAttach',
  paymentMethodOnRetrieve as 'v2_payment_payment_method_onRetrieve',
  paymentMethodOnUpdate as 'v2_payment_payment_method_onUpdate',
  paymentMethodOnDelete as 'v2_payment_payment_method_onDelete',
}
