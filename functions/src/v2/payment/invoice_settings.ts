import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { getStripe, stripeOptions, stripeErrors } from './utils'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'
import Stripe from 'stripe'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction(['v2', 'payment', 'invoice_settings', name], exports, f)

// Create Invoice Settings
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const customerId = request.data.customerId
    const params: Stripe.CustomerUpdateParams = request.data.params

    stripeOptions.idempotencyKey = `create_invoice_settings_${uid}_${customerId}`

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

// Retrieve Invoice Settings
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const customerId = request.data.customerId

    stripeOptions.idempotencyKey = `retrieve_invoice_settings_${uid}_${customerId}`

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

// Update Invoice Settings
_exportFunction('onUpdate', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountId: string = request.data.accountId
    const metadata = request.data.metadata

    const params: Stripe.AccountUpdateParams = {
      metadata: metadata,
    }

    stripeOptions.idempotencyKey = `update_invoice_settings_${uid}_${accountId}`

    return await getStripe()
      .accounts.update(accountId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Account>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        },
      )
  }),
)

// Delete Invoice Settings
_exportFunction('onDelete', () =>
  onCall(async (request) => {
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const customerId = request.data.customerId
    const params: Stripe.CustomerUpdateParams = {
      invoice_settings: {
        default_payment_method: undefined,
      },
    }

    stripeOptions.idempotencyKey = `delete_invoice_settings_${uid}_${customerId}`

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
