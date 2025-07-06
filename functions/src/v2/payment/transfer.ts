import { onCall } from '../../utils/base_function'
import { getStripe, stripeOptions, stripeErrors } from './utils'
import { checkAuth, getRequestingUserId } from '../../utils/firebase_utils'
import Stripe from 'stripe'

// Create a Transfer
const transferOnCreate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const amount = (request.data as any).amount
  const currency = (request.data as any).currency
  const destination = (request.data as any).destination
  const description = (request.data as any).description
  const metadata = (request.data as any).metadata
  const sourceTransaction = (request.data as any).source_transaction
  const sourceType = (request.data as any).source_type
  const transferGroup = (request.data as any).transfer_group

  const params: Stripe.TransferCreateParams = {
    amount: amount,
    currency: currency,
    destination: destination,
    description: description,
    metadata: metadata,
    source_transaction: sourceTransaction,
    source_type: sourceType,
    transfer_group: transferGroup,
  }

  stripeOptions.idempotencyKey = `create_transfer_${uid}_${destination}`

  return await getStripe()
    .transfers.create(params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Transfer>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Retrieve a Transfer
const transferOnRetrieve = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const transferId: string = (request.data as any).transferId
  const expand = (request.data as any).expand

  const params: Stripe.TransferRetrieveParams = {
    expand: expand,
  }

  stripeOptions.idempotencyKey = `retrieve_transfer_${uid}_${transferId}`

  return await getStripe()
    .transfers.retrieve(transferId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Transfer>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Update a Transfer
const transferOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const transferId: string = (request.data as any).transferId
  const description = (request.data as any).description
  const metadata = (request.data as any).metadata

  const params: Stripe.TransferUpdateParams = {
    description: description,
    metadata: metadata,
  }

  stripeOptions.idempotencyKey = `update_transfer_${uid}_${transferId}`

  return await getStripe()
    .transfers.update(transferId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Transfer>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// List all Transfers
const transferOnList = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const limit = (request.data as any).limit
  const startingAfter = (request.data as any).starting_after
  const endingBefore = (request.data as any).ending_before
  const destination = (request.data as any).destination
  const transferGroup = (request.data as any).transfer_group

  const params: Stripe.TransferListParams = {
    limit: limit,
    starting_after: startingAfter,
    ending_before: endingBefore,
    destination: destination,
    transfer_group: transferGroup,
  }

  stripeOptions.idempotencyKey = `list_transfers_${uid}`

  return await getStripe()
    .transfers.list(params, stripeOptions)
    .then(
      (result: Stripe.ApiList<Stripe.Transfer>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

// Reverse a Transfer
const transferOnReverse = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const transferId: string = (request.data as any).transferId
  const amount = (request.data as any).amount
  const description = (request.data as any).description
  const metadata = (request.data as any).metadata
  const refundApplicationFee = (request.data as any).refund_application_fee

  const params: any = {
    amount: amount,
    description: description,
    metadata: metadata,
    refund_application_fee: refundApplicationFee,
  }

  stripeOptions.idempotencyKey = `reverse_transfer_${uid}_${transferId}`

  return await getStripe()
    .transfers.createReversal(transferId, params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.TransferReversal>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
      },
    )
})

export {
  transferOnCreate as 'v2_payment_transfer_onCreate',
  transferOnRetrieve as 'v2_payment_transfer_onRetrieve',
  transferOnUpdate as 'v2_payment_transfer_onUpdate',
  transferOnList as 'v2_payment_transfer_onList',
  transferOnReverse as 'v2_payment_transfer_onReverse',
}
