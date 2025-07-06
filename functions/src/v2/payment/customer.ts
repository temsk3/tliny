import Stripe from 'stripe'
import { onCall } from '../../utils/base_function'
import { logger } from 'firebase-functions'
import { HttpsError } from 'firebase-functions/v2/https'
import { requireAuth } from '../../utils/auth-guard'
import { getRequestingUserId } from '../../utils/firebase_utils'
import { CustomerRequestData } from '../../utils/types'

import {
  getStripe,
  stripeOptions,
  stripeErrors,
  getStripeCustomerId,
} from './utils'

// MARK: - EphemeralKeyを返す
export const v2_payment_customer_getEphemeralKey = onCall<CustomerRequestData>(
  async (request) => {
    const uid = requireAuth(request)

    const customerId = await getStripeCustomerId(uid)
    if (customerId === null) {
      throw new HttpsError('failed-precondition', 'User has no Stripe ID')
    }
    const params: Stripe.EphemeralKeyCreateParams = { customer: customerId }

    if (request.data.apiVersion)
      stripeOptions.apiVersion = request.data.apiVersion as '2025-06-30.basil'

    stripeOptions.idempotencyKey = `create_ephemeral_key_${uid}_${customerId}`

    return await getStripe()
      .ephemeralKeys.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.EphemeralKey>) => {
          return { key: result }
        },
        (error: unknown) => {
          logger.error('Error creating ephemeral key:', { error })
          stripeErrors(error)
        },
      )
  },
)

// MARK: - stripeのcustomerを作ってcustomerIdを返す
export const v2_payment_customer_onCreate = onCall<CustomerRequestData>(
  async (request) => {
    const uid = getRequestingUserId(request)
    const { email, name, phone, address, shipping, tax, source, tax_exempt } =
      request.data

    const params: Stripe.CustomerCreateParams = {
      email,
      name,
      phone,
      address,
      shipping,
      tax,
      source,
      tax_exempt,
    }

    stripeOptions.idempotencyKey = `create_customer_${uid}`

    return await getStripe()
      .customers.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Customer>) => {
          return result
        },
        (error: unknown) => {
          stripeErrors(error)
        },
      )
  },
)

// MARK: customerのretrieve
export const v2_payment_customer_onRetrieve = onCall<CustomerRequestData>(
  async (request) => {
    requireAuth(request)
    const uid = requireAuth(request)
    const customerId: string = request.data.customerId || ''

    stripeOptions.idempotencyKey = `retrieve_customer_${uid}_${customerId}`

    return await getStripe()
      .customers.retrieve(customerId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Customer | Stripe.DeletedCustomer>) => {
          return result
        },
        (error: unknown) => {
          stripeErrors(error)
        },
      )
  },
)

// MARK: customerのupdate
export const v2_payment_customer_onUpdate = onCall<CustomerRequestData>(
  async (request) => {
    const uid = requireAuth(request)
    const {
      customerId = '',
      email,
      name,
      phone,
      address,
      shipping,
      tax,
      source,
      tax_exempt,
    } = request.data

    const params: Stripe.CustomerUpdateParams = {
      email,
      name,
      phone,
      address,
      shipping,
      tax,
      source,
      tax_exempt,
    }

    stripeOptions.idempotencyKey = `update_customer_${uid}_${customerId}`

    return await getStripe()
      .customers.update(customerId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Customer>) => {
          return result
        },
        (error: unknown) => {
          stripeErrors(error)
        },
      )
  },
)

// MARK: stripeのcustomerを削除
export const v2_payment_customer_onDelete = onCall<CustomerRequestData>(
  async (request) => {
    const uid = requireAuth(request)
    const customerId: string = request.data.customerId || ''

    stripeOptions.idempotencyKey = `delete_customer_${uid}_${customerId}`

    return await getStripe()
      .customers.del(customerId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.DeletedCustomer>) => {
          return result
        },
        (error: unknown) => {
          stripeErrors(error)
        },
      )
  },
)

// MARK: stripeのcustomerを検索
export const v2_payment_customer_onSearch = onCall<CustomerRequestData>(
  async (request) => {
    const uid = requireAuth(request)
    const { query, limit, page } = request.data

    const params: Stripe.CustomerSearchParams = {
      query: query ?? '',
      limit,
      page,
    }

    stripeOptions.idempotencyKey = `search_customers_${uid}`

    return await getStripe()
      .customers.search(params, stripeOptions)
      .then(
        (result: Stripe.ApiSearchResult<Stripe.Customer>) => {
          return result
        },
        (error: unknown) => {
          stripeErrors(error)
        },
      )
  },
)
