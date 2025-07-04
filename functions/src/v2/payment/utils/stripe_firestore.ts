import { db } from '../../../utils/firebase_utils'
import { logger } from '../../../utils/logger'
import { Stripe } from 'stripe'
import { ErrorHandler } from '../../../utils/error_handler'

// Webhookイベントドキュメントの作成
export const createWebhookEventDocument = async (event: Stripe.Event) => {
  try {
    await db.collection('stripe_events').doc(event.id).set({
      event_id: event.id,
      event_type: event.type,
      created: new Date(),
      data: event.data,
    })
    logger.info('Webhook event document created', { eventId: event.id })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'stripe_firestore.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'stripe_firestore.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

// 転送ドキュメントの作成
export const createTransferDocument = async (
  transferId: string,
): Promise<void> => {
  try {
    await db.collection('transfers').doc(transferId).set({
      transfer_id: transferId,
      created: new Date(),
    })
    logger.info('Transfer document created', { transferId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'stripe_firestore.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'stripe_firestore.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

// Stripe顧客IDからUIDを取得
export const getUidFromStripeCustomerId = async (
  customerId: string,
): Promise<string | null> => {
  try {
    const snapshot = await db
      .collection('v/1/stripe_customers')
      .where('customer_id', '==', customerId)
      .limit(1)
      .get()

    if (!snapshot.empty) {
      return snapshot.docs[0].id
    }
    return null
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'stripe_firestore.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'stripe_firestore.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

// 支払いドキュメントの更新
export const updatePaymentDocument = async (data: {
  uid: string
  paymentIntentId: string
  status: string
}): Promise<void> => {
  try {
    await db
      .collection('v/1/users')
      .doc(data.uid)
      .collection('payments')
      .doc(data.paymentIntentId)
      .set(
        {
          payment_intent_id: data.paymentIntentId,
          status: data.status,
          updated: new Date(),
        },
        { merge: true },
      )
    logger.info('Payment document updated', {
      paymentIntentId: data.paymentIntentId,
    })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'stripe_firestore.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'stripe_firestore.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

// 注文ドキュメントの更新
export const updateOderDocument = async (data: {
  orderId: string
  status: string
}): Promise<void> => {
  try {
    await db.collection('v/1/orders').doc(data.orderId).set(
      {
        status: data.status,
        updated: new Date(),
      },
      { merge: true },
    )
    logger.info('Order document updated', { orderId: data.orderId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'stripe_firestore.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'stripe_firestore.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}
