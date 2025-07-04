import Stripe from 'stripe'
import {
  getStripe,
  stripeOptions,
  stripeErrors,
  generateIdempotencyKey,
} from './utils'
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'payment', 'setup_intent', name], exports, f)

// Create a SetupIntent
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    const uid = getRequestingUserId(request)
    const customer = request.data.customer
    const paymentMethodTypes = request.data.payment_method_types || ['card']
    const description = request.data.description
    const metadata = request.data.metadata
    const usage = request.data.usage
    const mandateData = request.data.mandate_data
    const onBehalfOf = request.data.on_behalf_of
    const paymentMethodOptions = request.data.payment_method_options
    const paymentMethod = request.data.payment_method
    const returnUrl = request.data.return_url
    const singleUse = request.data.single_use
    const confirm = request.data.confirm
    const paymentMethodData = request.data.payment_method_data
    const useStripeSdk = request.data.use_stripe_sdk

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

    // 主要パラメータを含めたidempotencyKeyを生成
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
  }),
)

// Retrieve a SetupIntent
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    checkAuth(request)
    const setupIntentId: string = request.data.setupIntentId
    const params: Stripe.SetupIntentRetrieveParams = {}

    // 取得系はidempotencyKey不要
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
  }),
)

// Update a SetupIntent
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    checkAuth(request)
    const setupIntentId: string = request.data.setupIntentId
    const description = request.data.description
    const metadata = request.data.metadata
    const paymentMethodData = request.data.payment_method_data
    const paymentMethodOptions = request.data.payment_method_options
    const paymentMethod = request.data.payment_method

    const params: Stripe.SetupIntentUpdateParams = {
      description: description,
      metadata: metadata,
      payment_method_data: paymentMethodData,
      payment_method_options: paymentMethodOptions,
      payment_method: paymentMethod,
    }

    // 主要パラメータを含めたidempotencyKeyを生成
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
  }),
)

// Confirm a SetupIntent
_exportFunction('onConfirm', () =>
  onCall(async (request) => {
    checkAuth(request)
    const setupIntentId: string = request.data.setupIntentId
    const paymentMethodData = request.data.payment_method_data
    const paymentMethodOptions = request.data.payment_method_options
    const paymentMethod = request.data.payment_method
    const returnUrl = request.data.return_url
    const mandateData = request.data.mandate_data
    const useStripeSdk = request.data.use_stripe_sdk

    const params: Stripe.SetupIntentConfirmParams = {
      payment_method_data: paymentMethodData,
      payment_method_options: paymentMethodOptions,
      payment_method: paymentMethod,
      return_url: returnUrl,
      mandate_data: mandateData,
      use_stripe_sdk: useStripeSdk,
    }

    // 主要パラメータを含めたidempotencyKeyを生成
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
  }),
)

// Cancel a SetupIntent
_exportFunction('onCancel', () =>
  onCall(async (request) => {
    checkAuth(request)
    const setupIntentId: string = request.data.setupIntentId
    const cancellationReason = request.data.cancellation_reason

    const params: Stripe.SetupIntentCancelParams = {
      cancellation_reason: cancellationReason,
    }

    // 主要パラメータを含めたidempotencyKeyを生成
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
  }),
)

// List all SetupIntents
_exportFunction('onList', () =>
  onCall(async (request) => {
    checkAuth(request)
    const customer = request.data.customer
    const limit = request.data.limit
    const startingAfter = request.data.starting_after
    const endingBefore = request.data.ending_before
    const created = request.data.created

    const params: Stripe.SetupIntentListParams = {
      customer: customer,
      limit: limit,
      starting_after: startingAfter,
      ending_before: endingBefore,
      created: created,
    }

    // 取得系はidempotencyKey不要
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
  }),
)
