/* eslint-disable max-len */
import Stripe from 'stripe'
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { logger } from 'firebase-functions'
import { HttpsError } from 'firebase-functions/v2/https'
import { requireAuth } from '../../utils/auth-guard'
import { getRequestingUserId } from '../../utils/firebase_utils'

import {
  getStripe,
  stripeOptions,
  stripeErrors,
  getStripeCustomerId,
} from './utils'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'payment', 'customer', name], exports, f)

// MARK: - EphemeralKeyを返す
_exportFunction('getEphemeralKey', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)

    const customerId = await getStripeCustomerId(uid)
    if (customerId === null) {
      throw new HttpsError('failed-precondition', 'User has no Stripe ID')
    }
    const params: Stripe.EphemeralKeyCreateParams = { customer: customerId }

    if (request.data.apiVersion)
      stripeOptions.apiVersion = request.data.apiVersion

    stripeOptions.idempotencyKey = `create_ephemeral_key_${uid}_${customerId}`

    return await getStripe()
      .ephemeralKeys.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.EphemeralKey>) => {
          return { key: result }
        },
        (error: any) => {
          logger.error('Error creating ephemeral key:', { error })
          stripeErrors(error)
        },
      )
  }),
)

// MARK: - stripeのcustomerを作ってcustomerIdを返す
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    const uid = getRequestingUserId(request)
    const email = request.data.email
    const name = request.data.name
    const phone = request.data.phone
    const address = request.data.address
    const shipping = request.data.shipping
    const tax = request.data.tax
    const source = request.data.source
    const taxExempt = request.data.tax_exempt

    const params: Stripe.CustomerCreateParams = {
      email: email,
      name: name,
      phone: phone,
      address: address,
      shipping: shipping,
      tax: tax,
      source: source,
      tax_exempt: taxExempt,
    }

    stripeOptions.idempotencyKey = `create_customer_${uid}`

    return await getStripe()
      .customers.create(params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Customer>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// MARK: customerのretrieve
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    requireAuth(request)
    const uid = requireAuth(request)
    const customerId: string = request.data.customerId

    stripeOptions.idempotencyKey = `retrieve_customer_${uid}_${customerId}`

    return await getStripe()
      .customers.retrieve(customerId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Customer | Stripe.DeletedCustomer>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// MARK: customerのupdate
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const customerId: string = request.data.customerId
    const email = request.data.email
    const name = request.data.name
    const phone = request.data.phone
    const address = request.data.address
    const shipping = request.data.shipping
    const tax = request.data.tax
    const source = request.data.source
    const taxExempt = request.data.tax_exempt

    const params: Stripe.CustomerUpdateParams = {
      email: email,
      name: name,
      phone: phone,
      address: address,
      shipping: shipping,
      tax: tax,
      source: source,
      tax_exempt: taxExempt,
    }

    stripeOptions.idempotencyKey = `update_customer_${uid}_${customerId}`

    return await getStripe()
      .customers.update(customerId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Customer>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// MARK: stripeのcustomerを削除
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const customerId: string = request.data.customerId

    stripeOptions.idempotencyKey = `delete_customer_${uid}_${customerId}`

    return await getStripe()
      .customers.del(customerId, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.DeletedCustomer>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// MARK: stripeのcustomerを検索
_exportFunction('onSearch', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const query = request.data.query
    const limit = request.data.limit
    const page = request.data.page

    const params: Stripe.CustomerSearchParams = {
      query: query,
      limit: limit,
      page: page,
    }

    stripeOptions.idempotencyKey = `search_customers_${uid}`

    return await getStripe()
      .customers.search(params, stripeOptions)
      .then(
        (result: Stripe.ApiSearchResult<Stripe.Customer>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)
