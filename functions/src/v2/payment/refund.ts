import { onCall } from '../../utils/base_function'
import { getStripe, stripeOptions, stripeErrors } from './utils'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'
import Stripe from 'stripe'

// Create a Refund
const refundOnCreate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const paymentIntentId: string = (request.data as any).paymentIntentId
  const amount = (request.data as any).amount
  const currency = (request.data as any).currency
  const reason = (request.data as any).reason
  const metadata = (request.data as any).metadata

  const params: Stripe.RefundCreateParams = {
    payment_intent: paymentIntentId,
    amount: amount,
    currency: currency,
    reason: reason,
    metadata: metadata,
  }

  stripeOptions.idempotencyKey = `create_refund_${uid}_${paymentIntentId}`

  return await getStripe()
    .refunds.create(params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Refund>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Retrieve a Refund
const refundOnRetrieve = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const refundId: string = (request.data as any).refundId
  const expand = (request.data as any).expand

  const params: Stripe.RefundRetrieveParams = {
    expand: expand,
  }

  stripeOptions.idempotencyKey = `retrieve_refund_${uid}_${refundId}`

  return await getStripe()
    .refunds.retrieve(refundId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Refund>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Update a Refund
const refundOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const refundId: string = (request.data as any).refundId
  const metadata = (request.data as any).metadata

  const params: Stripe.RefundUpdateParams = {
    metadata: metadata,
  }

  stripeOptions.idempotencyKey = `update_refund_${uid}_${refundId}`

  return await getStripe()
    .refunds.update(refundId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Refund>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// List all Refunds
const refundOnList = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const limit = (request.data as any).limit
  const startingAfter = (request.data as any).starting_after
  const endingBefore = (request.data as any).ending_before

  const params: Stripe.RefundListParams = {
    limit: limit,
    starting_after: startingAfter,
    ending_before: endingBefore,
  }

  stripeOptions.idempotencyKey = `list_refunds_${uid}`

  return await getStripe()
    .refunds.list(params, stripeOptions)
    .then(
      (result: Stripe.ApiList<Stripe.Refund>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Cancel a Refund
const refundOnCancel = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const refundId: string = (request.data as any).refundId

  stripeOptions.idempotencyKey = `cancel_refund_${uid}_${refundId}`

  return await getStripe()
    .refunds.cancel(refundId, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Refund>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

export {
  refundOnCreate as 'v2_payment_refund_onCreate',
  refundOnRetrieve as 'v2_payment_refund_onRetrieve',
  refundOnUpdate as 'v2_payment_refund_onUpdate',
  refundOnList as 'v2_payment_refund_onList',
  refundOnCancel as 'v2_payment_refund_onCancel',
}
