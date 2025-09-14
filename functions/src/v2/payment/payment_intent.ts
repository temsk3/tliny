import Stripe from 'stripe'
import { getStripe } from './utils/stripe_config'
import { onCall } from '../../utils/base_function'
import { HttpsError } from 'firebase-functions/v2/https'
import {
  stripeOptions,
  stripeErrors,
  generateIdempotencyKey,
  getStripeCustomerId,
} from './utils'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'
import {
  stripeSecret,
  stripeEpSecret,
  stripeDevSk,
  stripeDevEp,
} from './utils/stripe_config'

// Create a PaymentIntent
const paymentIntentOnCreate = onCall(
  async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const params: Stripe.PaymentIntentCreateParams = (request.data as any)
      .params

    try {
      const customerId = await getStripeCustomerId(uid)
      if (!customerId) {
        throw new HttpsError(
          'failed-precondition',
          'User has no Stripe customer ID',
        )
      }
      params.customer = customerId
      stripeOptions.idempotencyKey = generateIdempotencyKey(
        'create_payment_intent',
        uid,
        params.amount,
        params.currency,
      )
      const paymentIntent = await getStripe().paymentIntents.create(
        params,
        stripeOptions,
      )
      return paymentIntent
    } catch (error: any) {
      stripeErrors(error)
      throw new HttpsError(
        'internal',
        `Payment intent creation failed: ${error.message}`,
      )
    }
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// Retrieve a PaymentIntent
const paymentIntentOnRetrieve = onCall(
  async (request) => {
    checkAuth(request)
    const paymentIntentId: string = (request.data as any).paymentIntentId
    const expand = (request.data as any).expand
    const params: Stripe.PaymentIntentRetrieveParams = {
      expand: expand,
    }
    return await getStripe()
      .paymentIntents.retrieve(paymentIntentId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// Update a PaymentIntent
const paymentIntentOnUpdate = onCall(
  async (request) => {
    checkAuth(request)
    const paymentIntentId: string = (request.data as any).paymentIntentId
    const amount = (request.data as any).amount
    const currency = (request.data as any).currency
    const description = (request.data as any).description
    const metadata = (request.data as any).metadata
    const receiptEmail = (request.data as any).receipt_email
    const setupFutureUsage = (request.data as any).setup_future_usage
    const applicationFeeAmount = (request.data as any).application_fee_amount
    const transferData = (request.data as any).transfer_data
    const statementDescriptor = (request.data as any).statement_descriptor
    const statementDescriptorSuffix = (request.data as any)
      .statement_descriptor_suffix
    const transferGroup = (request.data as any).transfer_group
    const paymentMethodData = (request.data as any).payment_method_data
    const paymentMethodOptions = (request.data as any).payment_method_options
    const shipping = (request.data as any).shipping

    const params: Stripe.PaymentIntentUpdateParams = {
      amount: amount,
      currency: currency,
      description: description,
      metadata: metadata,
      receipt_email: receiptEmail,
      setup_future_usage: setupFutureUsage,
      application_fee_amount: applicationFeeAmount,
      transfer_data: transferData,
      statement_descriptor: statementDescriptor,
      statement_descriptor_suffix: statementDescriptorSuffix,
      transfer_group: transferGroup,
      payment_method_data: paymentMethodData,
      payment_method_options: paymentMethodOptions,
      shipping: shipping,
    }

    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'update_payment_intent',
      getRequestingUserId(request),
      paymentIntentId,
      amount,
      currency,
      description,
      metadata?.orderId,
    )

    return await getStripe()
      .paymentIntents.update(paymentIntentId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// Confirm a PaymentIntent
const paymentIntentOnConfirm = onCall(
  async (request) => {
    checkAuth(request)
    const paymentIntentId: string = (request.data as any).paymentIntentId
    const mandate = (request.data as any).mandate
    const offSession = (request.data as any).off_session
    const paymentMethodData = (request.data as any).payment_method_data
    const paymentMethodOptions = (request.data as any).payment_method_options
    const paymentMethod = (request.data as any).payment_method
    const returnUrl = (request.data as any).return_url
    const setupFutureUsage = (request.data as any).setup_future_usage
    const shipping = (request.data as any).shipping
    const useStripeSdk = (request.data as any).use_stripe_sdk
    const errorOnRequiresAction = (request.data as any).error_on_requires_action

    const params: Stripe.PaymentIntentConfirmParams = {
      mandate: mandate,
      off_session: offSession,
      payment_method_data: paymentMethodData,
      payment_method_options: paymentMethodOptions,
      payment_method: paymentMethod,
      return_url: returnUrl,
      setup_future_usage: setupFutureUsage,
      shipping: shipping,
      use_stripe_sdk: useStripeSdk,
      error_on_requires_action: errorOnRequiresAction,
    }

    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'confirm_payment_intent',
      getRequestingUserId(request),
      paymentIntentId,
      paymentMethod,
      returnUrl,
    )

    return await getStripe()
      .paymentIntents.confirm(paymentIntentId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// Cancel a PaymentIntent
const paymentIntentOnCancel = onCall(
  async (request) => {
    checkAuth(request)
    const paymentIntentId: string = (request.data as any).paymentIntentId
    const cancellationReason = (request.data as any).cancellation_reason

    const params: Stripe.PaymentIntentCancelParams = {
      cancellation_reason: cancellationReason,
    }

    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'cancel_payment_intent',
      getRequestingUserId(request),
      paymentIntentId,
      cancellationReason,
    )

    return await getStripe()
      .paymentIntents.cancel(paymentIntentId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// Capture a PaymentIntent
const paymentIntentOnCapture = onCall(
  async (request) => {
    checkAuth(request)
    const paymentIntentId: string = (request.data as any).paymentIntentId
    const amountToCapture = (request.data as any).amount_to_capture
    const applicationFeeAmount = (request.data as any).application_fee_amount
    const statementDescriptor = (request.data as any).statement_descriptor
    const statementDescriptorSuffix = (request.data as any)
      .statement_descriptor_suffix
    const transferData = (request.data as any).transfer_data

    const params: Stripe.PaymentIntentCaptureParams = {
      amount_to_capture: amountToCapture,
      application_fee_amount: applicationFeeAmount,
      statement_descriptor: statementDescriptor,
      statement_descriptor_suffix: statementDescriptorSuffix,
      transfer_data: transferData,
    }

    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'capture_payment_intent',
      getRequestingUserId(request),
      paymentIntentId,
      amountToCapture,
      applicationFeeAmount,
      statementDescriptor,
      statementDescriptorSuffix,
    )

    return await getStripe()
      .paymentIntents.capture(paymentIntentId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// List all PaymentIntents
const paymentIntentOnList = onCall(
  async (request) => {
    checkAuth(request)
    const customer = (request.data as any).customer
    const limit = (request.data as any).limit
    const startingAfter = (request.data as any).starting_after
    const endingBefore = (request.data as any).ending_before
    const created = (request.data as any).created

    const params: Stripe.PaymentIntentListParams = {
      customer: customer,
      limit: limit,
      starting_after: startingAfter,
      ending_before: endingBefore,
      created: created,
    }

    return await getStripe()
      .paymentIntents.list(params, stripeOptions)
      .then(
        (result: Stripe.ApiList<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// Create a AutomaticPaymentIntent
const paymentIntentOnCreateAutomatic = onCall(
  async (request) => {
    // 実装例: 必要に応じて追加
    throw new HttpsError('unimplemented', 'Not implemented')
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

// Create a ManualPaymentIntent
const paymentIntentOnCreateManual = onCall(
  async (request) => {
    // 実装例: 必要に応じて追加
    throw new HttpsError('unimplemented', 'Not implemented')
  },
  { secrets: [stripeSecret, stripeEpSecret, stripeDevSk, stripeDevEp] },
)

export {
  paymentIntentOnCreate as 'v2_payment_payment_intent_onCreate',
  paymentIntentOnRetrieve as 'v2_payment_payment_intent_onRetrieve',
  paymentIntentOnUpdate as 'v2_payment_payment_intent_onUpdate',
  paymentIntentOnConfirm as 'v2_payment_payment_intent_onConfirm',
  paymentIntentOnCancel as 'v2_payment_payment_intent_onCancel',
  paymentIntentOnCapture as 'v2_payment_payment_intent_onCapture',
  paymentIntentOnList as 'v2_payment_payment_intent_onList',
  paymentIntentOnCreateAutomatic as 'v2_payment_payment_intent_onCreateAutomatic',
  paymentIntentOnCreateManual as 'v2_payment_payment_intent_onCreateManual',
}
