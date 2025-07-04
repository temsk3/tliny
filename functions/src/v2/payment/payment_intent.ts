import Stripe from 'stripe'
import { getStripe } from './utils/stripe_config'
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { HttpsError } from 'firebase-functions/v2/https'
import {
  currency,
  stripeOptions,
  stripeErrors,
  generateIdempotencyKey,
  getStripeCustomerId,
} from './utils'
import {
  checkAuth,
  getRequestingUserId,
  getUserEmail,
} from '../../utils/firebase_utils'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'payment', 'payment_intent', name], exports, f)

// Create a PaymentIntent
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const params: Stripe.PaymentIntentCreateParams = request.data.params

    try {
      const customerId = await getStripeCustomerId(uid)
      if (!customerId) {
        throw new HttpsError(
          'failed-precondition',
          'User has no Stripe customer ID',
        )
      }

      // v1と同じようにcustomerIdを設定
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
  }),
)

// Retrieve a PaymentIntent
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    checkAuth(request)
    const paymentIntentId: string = request.data.paymentIntentId
    const expand = request.data.expand

    const params: Stripe.PaymentIntentRetrieveParams = {
      expand: expand,
    }

    // 取得系はidempotencyKey不要
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
  }),
)

// Update a PaymentIntent
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    checkAuth(request)
    const paymentIntentId: string = request.data.paymentIntentId
    const amount = request.data.amount
    const currency = request.data.currency
    const description = request.data.description
    const metadata = request.data.metadata
    const receiptEmail = request.data.receipt_email
    const setupFutureUsage = request.data.setup_future_usage
    const applicationFeeAmount = request.data.application_fee_amount
    const transferData = request.data.transfer_data
    const statementDescriptor = request.data.statement_descriptor
    const statementDescriptorSuffix = request.data.statement_descriptor_suffix
    const transferGroup = request.data.transfer_group
    const paymentMethodData = request.data.payment_method_data
    const paymentMethodOptions = request.data.payment_method_options
    const shipping = request.data.shipping

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

    // 主要パラメータを含めたidempotencyKeyを生成
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
  }),
)

// Confirm a PaymentIntent
_exportFunction('onConfirm', () =>
  onCall(async (request) => {
    checkAuth(request)
    const paymentIntentId: string = request.data.paymentIntentId
    const mandate = request.data.mandate
    const offSession = request.data.off_session
    const paymentMethodData = request.data.payment_method_data
    const paymentMethodOptions = request.data.payment_method_options
    const paymentMethod = request.data.payment_method
    const returnUrl = request.data.return_url
    const setupFutureUsage = request.data.setup_future_usage
    const shipping = request.data.shipping
    const useStripeSdk = request.data.use_stripe_sdk
    const errorOnRequiresAction = request.data.error_on_requires_action

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

    // 主要パラメータを含めたidempotencyKeyを生成
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
  }),
)

// Cancel a PaymentIntent
_exportFunction('onCancel', () =>
  onCall(async (request) => {
    checkAuth(request)
    const paymentIntentId: string = request.data.paymentIntentId
    const cancellationReason = request.data.cancellation_reason

    const params: Stripe.PaymentIntentCancelParams = {
      cancellation_reason: cancellationReason,
    }

    // 主要パラメータを含めたidempotencyKeyを生成
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
  }),
)

// Capture a PaymentIntent
_exportFunction('onCapture', () =>
  onCall(async (request) => {
    checkAuth(request)
    const paymentIntentId: string = request.data.paymentIntentId
    const amountToCapture = request.data.amount_to_capture
    const applicationFeeAmount = request.data.application_fee_amount
    const statementDescriptor = request.data.statement_descriptor
    const statementDescriptorSuffix = request.data.statement_descriptor_suffix
    const transferData = request.data.transfer_data

    const params: Stripe.PaymentIntentCaptureParams = {
      amount_to_capture: amountToCapture,
      application_fee_amount: applicationFeeAmount,
      statement_descriptor: statementDescriptor,
      statement_descriptor_suffix: statementDescriptorSuffix,
      transfer_data: transferData,
    }

    // 主要パラメータを含めたidempotencyKeyを生成
    stripeOptions.idempotencyKey = generateIdempotencyKey(
      'capture_payment_intent',
      getRequestingUserId(request),
      paymentIntentId,
      amountToCapture,
      applicationFeeAmount,
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
  }),
)

// List all PaymentIntents
_exportFunction('onList', () =>
  onCall(async (request) => {
    checkAuth(request)
    const limit = request.data.limit
    const startingAfter = request.data.starting_after
    const endingBefore = request.data.ending_before
    const created = request.data.created
    const customer = request.data.customer

    const params: Stripe.PaymentIntentListParams = {
      limit: limit,
      starting_after: startingAfter,
      ending_before: endingBefore,
      created: created,
      customer: customer,
    }

    // 取得系はidempotencyKey不要
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
  }),
)

// Create a AutomaticPaymentIntent
_exportFunction('onCreateAutomatic', () =>
  onCall(async (request) => {
    const customerId = await getStripeCustomerId(getRequestingUserId(request))
    if (customerId === null) {
      throw new HttpsError('failed-precondition', 'User has no Stripe ID')
    }
    const amount = request.data.amount || 50
    stripeOptions.idempotencyKey = `create_automatic_payment_intent_${getRequestingUserId(request)}_${amount}`
    const params: Stripe.PaymentIntentCreateParams = {
      customer: customerId,
      amount: amount,
      currency: currency,
    }
    if (request.data.returnUrl) params.return_url = request.data.returnUrl

    return await getStripe()
      .paymentIntents.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Create a ManualPaymentIntent
_exportFunction('onCreateManual', () =>
  onCall(async (request) => {
    const customerId = await getStripeCustomerId(getRequestingUserId(request))
    if (customerId === null) {
      throw new HttpsError('failed-precondition', 'User has no Stripe ID')
    }
    const amount = request.data.amount
    stripeOptions.idempotencyKey = `create_manual_payment_intent_${getRequestingUserId(request)}_${amount}`
    const params: Stripe.PaymentIntentCreateParams = {
      customer: customerId,
      payment_method: request.data.paymentMethod,
      confirmation_method: 'manual',
      amount: amount,
      return_url: request.data.returnUrl,
      confirm: true,
      currency: currency,
      setup_future_usage: 'on_session',
    }
    const userEmail = await getUserEmail(getRequestingUserId(request))
    if (userEmail !== undefined) {
      params.receipt_email = userEmail
    }

    return await getStripe()
      .paymentIntents.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.PaymentIntent>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)
