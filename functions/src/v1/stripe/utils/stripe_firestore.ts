// import * as firebaseAdmin from 'firebase-admin'
import { Timestamp } from 'firebase-admin/firestore'
import { Stripe } from 'stripe'

import * as logs from './logs'

import config from '../../firestore/utils/db_paths'
// import functions from '../../../utils/base_function'

import { db } from '../../../utils/firebase_utils'

export const createWebhookEventDocument = async (event: Stripe.Event) => {
  await db
    .collection(config.webhookEventsCollectionPath)
    .doc(event.id)
    .set(
      Object.assign(
        {
          createdAt: Timestamp.now(),
        },
        event
      )
    )
  logs.firestoreDocCreated(config.webhookEventsCollectionPath, event.id)
}

const dbRef = db.collection(config.customersCollectionPath)

export const getUidFromStripeCustomerId = async (
  customerId: string
): Promise<string> => {
  const querySnapshot = await dbRef.where('customer_id', '==', customerId).get()
  if (querySnapshot.size !== 1) {
    throw new Error('User not found!')
  }
  return querySnapshot.docs[0].id
}

export const updatePaymentDocument = async ({
  uid,
  paymentIntentId,
  status,
}: {
  uid: string
  paymentIntentId: string
  status: Stripe.PaymentIntent.Status
}): Promise<void> => {
  const paymentDbRef = dbRef.doc(uid).collection(config.paymentsCollectionPath)
  const querySnapshot = await paymentDbRef
    .where('id', '==', paymentIntentId)
    .get()
  if (querySnapshot.size !== 1) {
    throw new Error('Payment not found!')
  }

  await paymentDbRef.doc(querySnapshot.docs[0].id).update({ status: status })
}

export const updateOderDocument = async ({
  orderId,
  status,
}: {
  orderId: string
  status: Stripe.PaymentIntent.Status
}) => {
  const orderDbRef = db.collection(config.ordersCollectionPath)

  await orderDbRef.doc(orderId).update({ status: status })
}

export const createTransferDocument = async (transferId: string) => {
  const transferDbRef = db.collection(config.transfersCollectionPath)

  await transferDbRef.doc().create({ transferId: transferId })
}
