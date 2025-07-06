// import * as firebaseAdmin from 'firebase-admin'

import { onCall } from '../../utils/base_function'
import { getStripe, stripeOptions } from '../payment/utils'
import { checkAuth } from '../../utils/firebase_utils'
import Stripe from 'stripe'
// _exportFunction('onXxx', () =>
//   functions()
//     .firestore.document(path)
//     .onCreate(
//       // 冪等性の担保(eventIdの重複対策用function)
//       triggerOnce('xxxNotification', async (snapshot, context) => {
//         //

//         console.log(snapshot, context)
//       })
//     )
// )

// Firestore Price: Create
const firestorePriceOnCreate = onCall(async (request) => {
  checkAuth(request)
  const params: Stripe.PriceCreateParams = (request.data as any).params
  stripeOptions.idempotencyKey = `create_price_${params.product}`
  return await getStripe().prices.create(params, stripeOptions)
})

// Firestore Price: Update
const firestorePriceOnUpdate = onCall(async (request) => {
  checkAuth(request)
  const priceId: string = (request.data as any).priceId
  const params: Stripe.PriceUpdateParams = (request.data as any).params
  stripeOptions.idempotencyKey = `update_price_${priceId}`
  return await getStripe().prices.update(priceId, params, stripeOptions)
})

// Firestore Price: Archive (Stripeでは削除ではなくarchive)
const firestorePriceOnDelete = onCall(async (request) => {
  checkAuth(request)
  const priceId: string = (request.data as any).priceId
  stripeOptions.idempotencyKey = `archive_price_${priceId}`
  return await getStripe().prices.update(
    priceId,
    { active: false },
    stripeOptions,
  )
})

export {
  firestorePriceOnCreate as 'v2_firestore_price_onCreate',
  firestorePriceOnUpdate as 'v2_firestore_price_onUpdate',
  firestorePriceOnDelete as 'v2_firestore_price_onDelete',
}
