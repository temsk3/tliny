import { onCall } from '../../utils/base_function'
import { getStripe, stripeOptions } from '../payment/utils'
import { checkAuth } from '../../utils/firebase_utils'
import Stripe from 'stripe'

// Firestore Product: Create
const firestoreProductOnCreate = onCall(async (request) => {
  checkAuth(request)
  const params: Stripe.ProductCreateParams = (request.data as any).params
  stripeOptions.idempotencyKey = `create_product_${params.name}`
  return await getStripe().products.create(params, stripeOptions)
})

// Firestore Product: Update
const firestoreProductOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const productId: string = (request.data as any).productId
  const params: Stripe.ProductUpdateParams = (request.data as any).params
  stripeOptions.idempotencyKey = `update_product_${productId}`
  return await getStripe().products.update(productId, params, stripeOptions)
})

// Firestore Product: Archive (Stripeでは削除ではなくarchive)
const firestoreProductOnDelete = onCall(async (request) => {
  checkAuth(request)
  const productId: string = (request.data as any).productId
  stripeOptions.idempotencyKey = `archive_product_${productId}`
  return await getStripe().products.update(
    productId,
    { active: false },
    stripeOptions,
  )
})

export {
  firestoreProductOnCreate as 'v2_firestore_product_onCreate',
  firestoreProductOnUpdate as 'v2_firestore_product_onUpdate',
  firestoreProductOnDelete as 'v2_firestore_product_onDelete',
}
