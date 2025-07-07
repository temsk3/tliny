import Stripe from 'stripe'
import { onCall } from '../../utils/base_function'
import { HttpsError } from 'firebase-functions/v2/https'
import { logger, V2Logger } from '../../utils/logger'
import { requireAuth } from '../../utils/auth-guard'
import { getStripe } from './utils'
import { PaymentService } from './services/payment.service'
import { cancelOrder } from '../business/services/order.service'

// Direct exports - no more _exportFunction
export const v2_payment_checkout_onSetup = onCall(async (request) => {
  const methodName = 'v2_payment_checkout_onSetup'

  try {
    V2Logger.start(methodName, {
      hasAuth: !!request.auth,
      authUid: request.auth?.uid,
    })

    requireAuth(request)
    const successUrl = (request.data as any).successUrl
    const cancelUrl = (request.data as any).cancelUrl

    const params: Stripe.Checkout.SessionCreateParams = {
      payment_method_types: ['card'],
      mode: 'setup',
      customer_update: { name: 'auto' as const },
      success_url: successUrl,
      cancel_url: cancelUrl,
    }

    const session = await getStripe().checkout.sessions.create(params)

    const result = {
      checkoutSessionId: session.id,
      url: session.url,
    }

    V2Logger.success(methodName, result)
    return result
  } catch (error: unknown) {
    V2Logger.error(methodName, error as any, {
      hasAuth: !!request.auth,
      authUid: request.auth?.uid,
    })
    throw error
  }
})

export const v2_payment_checkout_onSubscription = onCall(async (request) => {
  const uid = requireAuth(request)
  const orderId = (request.data as any).orderId
  const lineItems = (request.data as any).lineItems
  const successUrl = (request.data as any).successUrl
  const cancelUrl = (request.data as any).cancelUrl

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
  } catch (error: unknown) {
    logger.error('Failed to create subscription session', { error })
    throw error
  }
})

export const v2_payment_checkout_onListOfLineItems = onCall(async (request) => {
  requireAuth(request)
  const checkoutSessionId = (request.data as any).checkoutSessionId
  const accountId = (request.data as any).accountId

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
  } catch (error: unknown) {
    logger.error('Failed to list line items', { error })
    throw error
  }
})

export const v2_payment_checkout_createPaymentSession = onCall(
  async (request) => {
    try {
      logger.info('Function called with request', {
        hasAuth: !!request.auth,
        authUid: request.auth?.uid,
        hasData: !!request.data,
        dataKeys: request.data ? Object.keys(request.data) : [],
        requestData: request.data,
      })

      const uid = requireAuth(request)
      const eventId = (request.data as any).eventId
      const successUrl = (request.data as any).successUrl
      const cancelUrl = (request.data as any).cancelUrl

      logger.info('Creating payment session', {
        uid,
        eventId,
        successUrl,
        cancelUrl,
        requestData: request.data,
      })

      // パラメータの検証
      if (!eventId) {
        throw new Error('eventId is required')
      }
      if (!successUrl) {
        throw new Error('successUrl is required')
      }
      if (!cancelUrl) {
        throw new Error('cancelUrl is required')
      }

      const paymentService = new PaymentService()
      const result = await paymentService.createCheckoutSession({
        auth: { uid },
        data: {
          eventId,
          successUrl,
          cancelUrl,
        },
      })

      logger.info('Payment session created successfully', {
        sessionId: result.checkoutSessionId,
        orderId: result.orderId,
      })

      return result
    } catch (error: unknown) {
      logger.error('Failed to create payment session', {
        error: error instanceof Error ? error.message : String(error),
        stack: error instanceof Error ? error.stack : undefined,
        requestData: request.data,
        errorType: typeof error,
        errorConstructor: error?.constructor?.name,
      })
      throw error
    }
  },
)

// セッション取得
export const v2_payment_checkout_retrieveSession = onCall(async (request) => {
  requireAuth(request)
  const checkoutSessionId = (request.data as any).checkoutSessionId
  const accountId = (request.data as any).accountId

  logger.info('Retrieving checkout session')

  if (
    !checkoutSessionId ||
    checkoutSessionId === 'null' ||
    checkoutSessionId === 'undefined'
  ) {
    logger.error('Invalid checkout session ID', {
      checkoutSessionId,
      requestData: request.data,
    })
    // Log error (Firestore logging removed for now)
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
    logger.info('Checkout session retrieved')
    return session
  } catch (error: unknown) {
    logger.error('Failed to retrieve checkout session', {
      error: (error as Error).message,
      checkoutSessionId,
      errorCode: (error as any).code,
      errorType: (error as any).type,
      requestData: request.data,
    })
    // Log error (Firestore logging removed for now)
    if ((error as any).code === 'resource_missing') {
      throw new Error(
        `Checkout session not found: ${checkoutSessionId} (request: ${JSON.stringify(request.data)})`,
      )
    } else {
      throw new Error(
        `Failed to retrieve checkout session: ${(error as Error).message} (request: ${JSON.stringify(request.data)})`,
      )
    }
  }
})

export const v2_payment_checkout_listLineItems = onCall(async (request) => {
  requireAuth(request)
  const checkoutSessionId = (request.data as any).checkoutSessionId
  const accountId = (request.data as any).accountId

  logger.info('Listing line items', { checkoutSessionId, accountId })

  try {
    const lineItems = await getStripe().checkout.sessions.listLineItems(
      checkoutSessionId,
      {
        stripeAccount: accountId,
      },
    )
    return lineItems
  } catch (error: unknown) {
    logger.error('Failed to list line items', { error })
    throw error
  }
})

export const v2_payment_checkout_expireSession = onCall(async (request) => {
  requireAuth(request)
  const checkoutSessionId = (request.data as any).checkoutSessionId
  const accountId = (request.data as any).accountId

  logger.info('Expiring checkout session')

  try {
    const session = await getStripe().checkout.sessions.expire(
      checkoutSessionId,
      {
        stripeAccount: accountId,
      },
    )
    logger.info('Checkout session expired')
    return session
  } catch (error: unknown) {
    logger.error('Failed to expire checkout session', { error })
    throw error
  }
})

export const v2_payment_checkout_listSessions = onCall(async (request) => {
  requireAuth(request)
  const accountId = (request.data as any).accountId
  const limit = (request.data as any).limit || 10

  logger.info('Listing checkout sessions', { accountId, limit })

  try {
    const sessions = await getStripe().checkout.sessions.list(
      {
        limit: limit,
      },
      {
        stripeAccount: accountId,
      },
    )
    return sessions
  } catch (error: unknown) {
    logger.error('Failed to list checkout sessions', { error })
    throw error
  }
})

export const v2_payment_checkout_listSessionsByOrder = onCall(
  async (request) => {
    requireAuth(request)
    const orderId = (request.data as any).orderId
    const accountId = (request.data as any).accountId

    logger.info('Listing checkout sessions by order', { orderId, accountId })

    try {
      const sessions = await getStripe().checkout.sessions.list(
        {
          limit: 100,
        },
        {
          stripeAccount: accountId,
        },
      )
      // Filter sessions by orderId in metadata
      const filteredSessions = sessions.data.filter(
        (session) => session.metadata?.orderId === orderId,
      )
      return { ...sessions, data: filteredSessions }
    } catch (error: unknown) {
      logger.error('Failed to list checkout sessions by order', { error })
      throw error
    }
  },
)

// 注文キャンセル
export const v2_payment_checkout_cancelOrder = onCall(async (request) => {
  const uid = requireAuth(request)
  const orderId = (request.data as any).orderId

  logger.info('Canceling order', { uid, orderId })

  if (!orderId) {
    throw new Error('orderId is required')
  }

  try {
    await cancelOrder(orderId)

    logger.info('Order canceled successfully', { orderId })
    return { success: true, orderId }
  } catch (error: unknown) {
    const errorMessage = error instanceof Error ? error.message : String(error)

    // 特定のエラーメッセージに基づいて適切なエラーを投げる
    if (errorMessage.includes('Order is already confirmed')) {
      throw new HttpsError(
        'failed-precondition',
        '注文は既に確定済みのため、キャンセルできません',
      )
    } else if (errorMessage.includes('Order not found')) {
      throw new HttpsError('not-found', '注文が見つかりません')
    } else {
      logger.error('Failed to cancel order', {
        error: errorMessage,
        stack: error instanceof Error ? error.stack : undefined,
        orderId,
        requestData: request.data,
      })
      throw new HttpsError('internal', '注文のキャンセルに失敗しました')
    }
  }
})
