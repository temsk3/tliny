/* eslint-disable max-len */
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import { logger } from 'firebase-functions'
import { requireAuth } from '../../utils/auth-guard'
import { PaymentService } from './services/payment.service'
import { getStripe } from './utils'
import { db } from '../../utils/firebase_utils'
import Stripe from 'stripe'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'payment', 'checkout', name], exports, f)

const paymentService = new PaymentService()

// v1互換: 決済セッション作成
_exportFunction('onPayment', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const eventId = request.data.eventId

    logger.info('Creating payment session (v1 compatible)', { uid, eventId })
    return await paymentService.createCheckoutSession(request)
  }),
)

// v1互換: セットアップセッション作成
_exportFunction('onSetup', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const successUrl = request.data.successUrl
    const cancelUrl = request.data.cancelUrl

    logger.info('Creating setup session (v1 compatible)', { uid })

    try {
      const params: Stripe.Checkout.SessionCreateParams = {
        payment_method_types: ['card'],
        mode: 'setup',
        customer_update: { name: 'auto' as const },
        success_url: successUrl,
        cancel_url: cancelUrl,
      }

      const session = await getStripe().checkout.sessions.create(params)
      logger.info('Setup session created', { sessionId: session.id })

      return {
        checkoutSessionId: session.id,
        url: session.url,
      }
    } catch (error: any) {
      logger.error('Failed to create setup session', { error })
      throw error
    }
  }),
)

// v1互換: サブスクリプションセッション作成
_exportFunction('onSubscription', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const orderId = request.data.orderId
    const lineItems = request.data.lineItems
    const successUrl = request.data.successUrl
    const cancelUrl = request.data.cancelUrl

    logger.info('Creating subscription session (v1 compatible)', {
      uid,
      orderId,
    })

    try {
      const params: Stripe.Checkout.SessionCreateParams = {
        mode: 'subscription' as const,
        line_items: lineItems,
        success_url: successUrl,
        cancel_url: cancelUrl,
        metadata: { orderId: orderId },
      }

      const session = await getStripe().checkout.sessions.create(params)
      logger.info('Subscription session created', { sessionId: session.id })

      return {
        checkoutSessionId: session.id,
        url: session.url,
      }
    } catch (error: any) {
      logger.error('Failed to create subscription session', { error })
      throw error
    }
  }),
)

// v1互換: ラインアイテム一覧取得
_exportFunction('onListOfLineItems', () =>
  onCall(async (request) => {
    requireAuth(request)
    const checkoutSessionId = request.data.checkoutSessionId
    const accountId = request.data.accountId

    logger.info('Listing line items (v1 compatible)', {
      checkoutSessionId,
      accountId,
    })

    try {
      const lineItems = await getStripe().checkout.sessions.listLineItems(
        checkoutSessionId,
        {
          stripeAccount: accountId,
        },
      )
      return lineItems.data
    } catch (error: any) {
      logger.error('Failed to list line items', { error })
      throw error
    }
  }),
)

_exportFunction('createPaymentSession', () =>
  onCall(async (request) => {
    const uid = requireAuth(request)
    const eventId = request.data.eventId

    logger.info('Creating payment session', { uid, eventId })
    return await paymentService.createCheckoutSession(request)
  }),
)

_exportFunction('retrieveSession', () =>
  onCall(async (request) => {
    requireAuth(request)
    const checkoutSessionId = request.data.checkoutSessionId
    const accountId = request.data.accountId

    logger.info('Retrieving checkout session', {
      checkoutSessionId,
      accountId,
      requestData: request.data,
    })

    if (
      !checkoutSessionId ||
      checkoutSessionId === 'null' ||
      checkoutSessionId === 'undefined'
    ) {
      logger.error('Invalid checkout session ID', {
        checkoutSessionId,
        requestData: request.data,
      })
      await db.collection('logs').add({
        type: 'checkoutSessionIdError',
        checkoutSessionId,
        requestData: request.data,
        timestamp: new Date(),
      })
      throw new Error(
        `Invalid checkout session ID: ${checkoutSessionId} (request: ${JSON.stringify(request.data)})`,
      )
    }

    try {
      const session = await getStripe().checkout.sessions.retrieve(
        checkoutSessionId,
        {
          stripeAccount: accountId,
        },
      )
      logger.info('Checkout session retrieved', { sessionId: session.id })
      return session
    } catch (error: any) {
      logger.error('Failed to retrieve checkout session', {
        error: error.message,
        checkoutSessionId,
        errorCode: error.code,
        errorType: error.type,
        requestData: request.data,
      })
      await db.collection('logs').add({
        type: 'checkoutSessionRetrieveError',
        error: error.message,
        errorCode: error.code,
        errorType: error.type,
        checkoutSessionId,
        requestData: request.data,
        timestamp: new Date(),
      })
      if (error.code === 'resource_missing') {
        throw new Error(
          `Checkout session not found: ${checkoutSessionId} (request: ${JSON.stringify(request.data)})`,
        )
      } else {
        throw new Error(
          `Failed to retrieve checkout session: ${error.message} (request: ${JSON.stringify(request.data)})`,
        )
      }
    }
  }),
)

_exportFunction('listLineItems', () =>
  onCall(async (request) => {
    requireAuth(request)
    const checkoutSessionId = request.data.checkoutSessionId
    const accountId = request.data.accountId

    logger.info('Listing line items', { checkoutSessionId, accountId })

    try {
      const lineItems = await getStripe().checkout.sessions.listLineItems(
        checkoutSessionId,
        {
          stripeAccount: accountId,
        },
      )
      return lineItems
    } catch (error: any) {
      logger.error('Failed to list line items', { error })
      throw error
    }
  }),
)

_exportFunction('expireSession', () =>
  onCall(async (request) => {
    requireAuth(request)
    const checkoutSessionId = request.data.checkoutSessionId
    const accountId = request.data.accountId

    logger.info('Expiring checkout session', { checkoutSessionId, accountId })

    try {
      const session = await getStripe().checkout.sessions.expire(
        checkoutSessionId,
        {
          stripeAccount: accountId,
        },
      )
      logger.info('Checkout session expired', { sessionId: session.id })
      return { checkoutSessionId: session.id }
    } catch (error: any) {
      logger.error('Failed to expire checkout session', { error })
      throw error
    }
  }),
)

// v1互換: セッション期限切れ
_exportFunction('onExpire', () =>
  onCall(async (request) => {
    requireAuth(request)
    const checkoutSessionId = request.data.checkoutSessionId
    const accountId = request.data.accountId

    logger.info('Expiring checkout session (v1 compatible)', {
      checkoutSessionId,
      accountId,
    })

    try {
      const session = await getStripe().checkout.sessions.expire(
        checkoutSessionId,
        {
          stripeAccount: accountId,
        },
      )
      logger.info('Checkout session expired', { sessionId: session.id })
      return { checkoutSessionId: session.id }
    } catch (error: any) {
      logger.error('Failed to expire checkout session', { error })
      throw error
    }
  }),
)

// v1互換: セッション取得
_exportFunction('onRetrieve', () =>
  onCall(async (request) => {
    requireAuth(request)
    const checkoutSessionId = request.data.checkoutSessionId
    const accountId = request.data.accountId

    logger.info('Retrieving checkout session (v1 compatible)', {
      checkoutSessionId,
      accountId,
    })

    try {
      const session = await getStripe().checkout.sessions.retrieve(
        checkoutSessionId,
        {
          stripeAccount: accountId,
        },
      )
      logger.info('Checkout session retrieved', { sessionId: session.id })
      return { checkoutSessionId: session.id }
    } catch (error: any) {
      logger.error('Failed to retrieve checkout session', { error })
      throw error
    }
  }),
)

_exportFunction('cancelOrder', () =>
  onCall(async (request) => {
    requireAuth(request)
    const orderId = request.data.orderId

    logger.info('Cancelling order', { orderId })

    try {
      // 注文キャンセル処理を実装
      // ここではプレースホルダーとして空の処理
      logger.info('Order cancelled successfully', { orderId })
      return
    } catch (error: any) {
      logger.error('Failed to cancel order', { error })
      throw error
    }
  }),
)

// v1互換: 注文キャンセル
_exportFunction('onCancel', () =>
  onCall(async (request) => {
    requireAuth(request)
    const orderId = request.data.orderId

    logger.info('Cancelling order (v1 compatible)', { orderId })

    try {
      // 注文キャンセル処理を実装
      // ここではプレースホルダーとして空の処理
      logger.info('Order cancelled successfully', { orderId })
      return
    } catch (error: any) {
      logger.error('Failed to cancel order', { error })
      throw error
    }
  }),
)
