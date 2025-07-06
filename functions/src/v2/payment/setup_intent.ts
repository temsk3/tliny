import Stripe from 'stripe'
import {
  getStripe,
  stripeOptions,
  stripeErrors,
  generateIdempotencyKey,
} from './utils'
import { onCall } from '../../utils/base_function'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'

// Create a SetupIntent
const setupIntentOnCreate = onCall(async (request) => {
  const uid = getRequestingUserId(request)
  const customer = (request.data as any).customer
  const paymentMethodTypes = (request.data as any).payment_method_types || [
    'card',
  ]
  const description = (request.data as any).description
  const metadata = (request.data as any).metadata
  const usage = (request.data as any).usage
  const mandateData = (request.data as any).mandate_data
  const onBehalfOf = (request.data as any).on_behalf_of
  const paymentMethodOptions = (request.data as any).payment_method_options
  const paymentMethod = (request.data as any).payment_method
  const returnUrl = (request.data as any).return_url
  const singleUse = (request.data as any).single_use
  const confirm = (request.data as any).confirm
  const paymentMethodData = (request.data as any).payment_method_data
  const useStripeSdk = (request.data as any).use_stripe_sdk

  const params: Stripe.SetupIntentCreateParams = {
    customer: customer,
    payment_method_types: paymentMethodTypes,
    description: description,
    metadata: metadata,
    usage: usage,
    mandate_data: mandateData,
    on_behalf_of: onBehalfOf,
    payment_method_options: paymentMethodOptions,
    payment_method: paymentMethod,
    return_url: returnUrl,
    single_use: singleUse,
    confirm: confirm,
    payment_method_data: paymentMethodData,
    use_stripe_sdk: useStripeSdk,
  }

  stripeOptions.idempotencyKey = generateIdempotencyKey(
    'create_setup_intent',
    uid,
    customer,
    paymentMethodTypes.join(','),
    description,
    metadata?.orderId,
    usage,
  )

  return await getStripe()
    .setupIntents.create(params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.SetupIntent>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Retrieve a SetupIntent
const setupIntentOnRetrieve = onCall(async (request) => {
  checkAuth(request)
  const setupIntentId: string = (request.data as any).setupIntentId
  const params: Stripe.SetupIntentRetrieveParams = {}
  return await getStripe()
    .setupIntents.retrieve(setupIntentId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.SetupIntent>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Update a SetupIntent
const setupIntentOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const setupIntentId: string = (request.data as any).setupIntentId
  const description = (request.data as any).description
  const metadata = (request.data as any).metadata
  const paymentMethodData = (request.data as any).payment_method_data
  const paymentMethodOptions = (request.data as any).payment_method_options
  const paymentMethod = (request.data as any).payment_method

  const params: Stripe.SetupIntentUpdateParams = {
    description: description,
    metadata: metadata,
    payment_method_data: paymentMethodData,
    payment_method_options: paymentMethodOptions,
    payment_method: paymentMethod,
  }

  stripeOptions.idempotencyKey = generateIdempotencyKey(
    'update_setup_intent',
    setupIntentId,
    description,
    metadata?.orderId,
    paymentMethod,
  )

  return await getStripe()
    .setupIntents.update(setupIntentId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.SetupIntent>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Confirm a SetupIntent
const setupIntentOnConfirm = onCall(async (request) => {
  checkAuth(request)
  const setupIntentId: string = (request.data as any).setupIntentId
  const paymentMethodData = (request.data as any).payment_method_data
  const paymentMethodOptions = (request.data as any).payment_method_options
  const paymentMethod = (request.data as any).payment_method
  const returnUrl = (request.data as any).return_url
  const mandateData = (request.data as any).mandate_data
  const useStripeSdk = (request.data as any).use_stripe_sdk

  const params: Stripe.SetupIntentConfirmParams = {
    payment_method_data: paymentMethodData,
    payment_method_options: paymentMethodOptions,
    payment_method: paymentMethod,
    return_url: returnUrl,
    mandate_data: mandateData,
    use_stripe_sdk: useStripeSdk,
  }

  stripeOptions.idempotencyKey = generateIdempotencyKey(
    'confirm_setup_intent',
    setupIntentId,
    paymentMethod,
    returnUrl,
  )

  return await getStripe()
    .setupIntents.confirm(setupIntentId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.SetupIntent>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Cancel a SetupIntent
const setupIntentOnCancel = onCall(async (request) => {
  checkAuth(request)
  const setupIntentId: string = (request.data as any).setupIntentId
  const cancellationReason = (request.data as any).cancellation_reason

  const params: Stripe.SetupIntentCancelParams = {
    cancellation_reason: cancellationReason,
  }

  stripeOptions.idempotencyKey = generateIdempotencyKey(
    'cancel_setup_intent',
    setupIntentId,
    cancellationReason,
  )

  return await getStripe()
    .setupIntents.cancel(setupIntentId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.SetupIntent>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// List all SetupIntents
const setupIntentOnList = onCall(async (request) => {
  checkAuth(request)
  const customer = (request.data as any).customer
  const limit = (request.data as any).limit
  const startingAfter = (request.data as any).starting_after
  const endingBefore = (request.data as any).ending_before
  const created = (request.data as any).created

  const params: Stripe.SetupIntentListParams = {
    customer: customer,
    limit: limit,
    starting_after: startingAfter,
    ending_before: endingBefore,
    created: created,
  }

  return await getStripe()
    .setupIntents.list(params, stripeOptions)
    .then(
      (result: Stripe.ApiList<Stripe.SetupIntent>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

export {
  setupIntentOnCreate as 'v2_payment_setup_intent_onCreate',
  setupIntentOnRetrieve as 'v2_payment_setup_intent_onRetrieve',
  setupIntentOnUpdate as 'v2_payment_setup_intent_onUpdate',
  setupIntentOnConfirm as 'v2_payment_setup_intent_onConfirm',
  setupIntentOnCancel as 'v2_payment_setup_intent_onCancel',
  setupIntentOnList as 'v2_payment_setup_intent_onList',
}
