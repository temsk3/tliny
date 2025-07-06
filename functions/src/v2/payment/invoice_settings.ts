import { onCall } from '../../utils/base_function'
import { getStripe, stripeOptions, stripeErrors } from './utils'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'
import Stripe from 'stripe'

// Create Invoice Settings
const invoiceSettingsOnCreate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const customerId = (request.data as any).customerId
  const params: Stripe.CustomerUpdateParams = (request.data as any).params

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
})

// Retrieve Invoice Settings
const invoiceSettingsOnRetrieve = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const customerId = (request.data as any).customerId

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
})

// Update Invoice Settings
const invoiceSettingsOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const accountId: string = (request.data as any).accountId
  const metadata = (request.data as any).metadata

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
})

// Delete Invoice Settings
const invoiceSettingsOnDelete = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const customerId = (request.data as any).customerId
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
})

export {
  invoiceSettingsOnCreate as 'v2_payment_invoice_settings_onCreate',
  invoiceSettingsOnRetrieve as 'v2_payment_invoice_settings_onRetrieve',
  invoiceSettingsOnUpdate as 'v2_payment_invoice_settings_onUpdate',
  invoiceSettingsOnDelete as 'v2_payment_invoice_settings_onDelete',
}
