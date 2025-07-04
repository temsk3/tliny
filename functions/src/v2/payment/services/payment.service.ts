import Stripe from 'stripe'
import { logger } from '../../../utils/logger'
import { ErrorHandler } from '../../../utils/error_handler'
import { stripeOptions, getStripe, APPLICATION_FEE_PERCENT } from '../utils'
import {
  createPreOrder,
  cancelOrder,
} from '../../business/services/order.service'
import { updateAccountStatus } from '../../business/services/account.service'
import { createTicketDocument } from '../../business/services/ticket.service'
import { db } from '../../../utils/firebase_utils'
import { checkDocumentExistsByQuery } from '../../firestore/utils/idempotency'

/**
 * 決済関連のビジネスロジックを統合したサービス
 */
export class PaymentService {
  /**
   * チェックアウトセッションを作成
   * @param {any} request - リクエストオブジェクト
   * @return {Promise<any>} チェックアウトセッション情報
   */
  async createCheckoutSession(request: any): Promise<any> {
    const uid = request.auth.uid
    const eventId = request.data.eventId
    const successUrl = request.data.successUrl
    const cancelUrl = request.data.cancelUrl

    logger.info('Creating checkout session', { uid, eventId })

    try {
      // 冪等性保証: 既存のチェックアウトセッションをチェック
      const existingSessionQuery = await db
        .collection('v/1/users')
        .doc(uid)
        .collection('checkout_sessions')
        .where('eventId', '==', eventId)
        .where('status', '==', 'pending')
        .limit(1)
        .get()

      if (!existingSessionQuery.empty) {
        const existingSession = existingSessionQuery.docs[0].data()
        logger.info('Existing checkout session found, validating with Stripe', {
          sessionId: existingSession.checkoutSessionId,
          uid,
          eventId,
        })

        try {
          // 既存セッションの詳細情報を取得（stripeAccount指定）
          const session = await getStripe().checkout.sessions.retrieve(
            existingSession.checkoutSessionId,
            {
              stripeAccount: existingSession.accountId,
            },
          )

          // セッションが有効な場合のみ返す
          if (session.status === 'open') {
            logger.info(
              'Valid existing checkout session found, returning existing session',
              {
                sessionId: existingSession.checkoutSessionId,
                status: session.status,
              },
            )

            return {
              checkoutSessionId: existingSession.checkoutSessionId,
              url: session.url,
              status: session.status,
              accountId: existingSession.accountId,
              lineItem: [], // 既存セッションの場合は空配列
              orderId: existingSession.orderId,
            }
          } else {
            logger.info(
              'Existing session is not open, will create new session',
              {
                sessionId: existingSession.checkoutSessionId,
                status: session.status,
              },
            )
          }
        } catch (stripeError: any) {
          logger.warn(
            'Failed to retrieve existing session from Stripe, will create new session',
            {
              sessionId: existingSession.checkoutSessionId,
              error: stripeError.message,
              errorCode: stripeError.code,
            },
          )

          // 無効なセッションをFirestoreから削除
          try {
            await db
              .collection('v/1/users')
              .doc(uid)
              .collection('checkout_sessions')
              .doc(existingSession.checkoutSessionId)
              .delete()

            logger.info('Invalid session removed from Firestore', {
              sessionId: existingSession.checkoutSessionId,
            })
          } catch (deleteError: any) {
            logger.error('Failed to delete invalid session from Firestore', {
              sessionId: existingSession.checkoutSessionId,
              error: deleteError.message,
            })
          }
        }
      }

      // プレオーダー作成
      const preOrderResult = await createPreOrder(uid, eventId)
      const {
        orderID: orderId,
        lineItems,
        subtotal,
        accountId,
      } = preOrderResult

      // 手数料計算
      const applicationFeeAmount = Math.round(
        subtotal * (APPLICATION_FEE_PERCENT / 100),
      )

      // チェックアウトセッション作成
      const sessionParams: Stripe.Checkout.SessionCreateParams = {
        payment_method_types: ['card'],
        line_items: lineItems,
        mode: 'payment',
        success_url: successUrl,
        cancel_url: cancelUrl,
        metadata: {
          orderId: orderId,
          eventId: eventId,
          userId: uid,
        },
        payment_intent_data: {
          application_fee_amount: applicationFeeAmount,
        },
      }

      // 主要パラメータを含めたidempotencyKeyを生成
      stripeOptions.idempotencyKey = `create_checkout_session_${uid}_${eventId}_${orderId}`

      const session = await getStripe().checkout.sessions.create(
        sessionParams,
        {
          ...stripeOptions,
          stripeAccount: accountId,
        },
      )

      // チェックアウトセッション情報を保存
      await db
        .collection('v/1/users')
        .doc(uid)
        .collection('checkout_sessions')
        .doc(session.id)
        .set({
          checkoutSessionId: session.id,
          orderId: orderId,
          eventId: eventId,
          accountId: accountId,
          status: 'pending',
          createdAt: new Date(),
        })

      logger.info('Checkout session created successfully', {
        sessionId: session.id,
        orderId: orderId,
        uid,
        eventId,
        accountId,
      })

      return {
        checkoutSessionId: session.id,
        url: session.url,
        status: session.status,
        accountId: accountId,
        lineItem: lineItems,
        orderId: orderId,
      }
    } catch (error: any) {
      logger.error('Error creating checkout session', {
        uid,
        eventId,
        error: error.message,
      })
      throw ErrorHandler.convertToHttpsError(
        ErrorHandler.convertToAppException(error, 'payment.service.ts'),
      )
    }
  }

  /**
   * Webhookイベントを処理
   * @param {Stripe.Event} event - Webhookイベント
   * @return {Promise<void>}
   */
  async processWebhook(event: Stripe.Event): Promise<void> {
    logger.info('Processing webhook event', { eventType: event.type })

    try {
      switch (event.type) {
        case 'payment_intent.succeeded':
          await this.handlePaymentIntentSucceeded(
            event.data.object as Stripe.PaymentIntent,
          )
          break
        case 'payment_intent.payment_failed':
          await this.handlePaymentIntentFailed(
            event.data.object as Stripe.PaymentIntent,
          )
          break
        case 'account.updated':
          await this.handleAccountUpdated(event.data.object as Stripe.Account)
          break
        default:
          logger.info('Unhandled webhook event type', { eventType: event.type })
      }
    } catch (error: any) {
      logger.error('Webhook processing failed', {
        error,
        eventType: event.type,
      })
      ErrorHandler.logError(error, error.stack, 'payment.service.ts')
      const appEx = ErrorHandler.convertToAppException(
        error,
        'payment.service.ts',
      )
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  }

  /**
   * 決済成功時の処理
   * @param {Stripe.PaymentIntent} paymentIntent - 決済インテント
   * @return {Promise<void>}
   */
  private async handlePaymentIntentSucceeded(
    paymentIntent: Stripe.PaymentIntent,
  ): Promise<void> {
    logger.info('Payment succeeded', { paymentIntentId: paymentIntent.id })

    // 冪等性保証: 既に処理済みかチェック
    const orderId = paymentIntent.metadata.orderId
    if (orderId) {
      const orderExists = await checkDocumentExistsByQuery(
        'v/1/orders',
        'orderId',
        orderId,
      )

      if (orderExists) {
        const orderDoc = await db.collection('v/1/orders').doc(orderId).get()
        const orderData = orderDoc.data()

        if (orderData?.status === 'paid') {
          logger.info('Order already processed as paid, skipping', {
            orderId,
            paymentIntentId: paymentIntent.id,
          })
          return
        }
      }

      // 注文ステータス更新
      await db.collection('v/1/orders').doc(orderId).update({
        status: 'paid',
        paymentIntentId: paymentIntent.id,
        updatedAt: new Date(),
      })
    }

    // チケット作成
    if (orderId) {
      await createTicketDocument(orderId)
    }
  }

  /**
   * 決済失敗時の処理
   * @param {Stripe.PaymentIntent} paymentIntent - 決済インテント
   * @return {Promise<void>}
   */
  private async handlePaymentIntentFailed(
    paymentIntent: Stripe.PaymentIntent,
  ): Promise<void> {
    logger.info('Payment failed', { paymentIntentId: paymentIntent.id })

    // 注文キャンセル
    const orderId = paymentIntent.metadata.orderId
    if (orderId) {
      await cancelOrder(orderId)
    }
  }

  /**
   * アカウント更新時の処理
   * @param {Stripe.Account} account - Stripeアカウント
   * @return {Promise<void>}
   */
  private async handleAccountUpdated(account: Stripe.Account): Promise<void> {
    logger.info('Account updated', { accountId: account.id })

    // アカウントステータス更新
    const uid = account.metadata?.uid
    if (uid) {
      await updateAccountStatus(
        uid,
        account.id,
        (account as any).status || 'unknown',
        account.charges_enabled || false,
      )
    }
  }

  /**
   * 決済メソッドを作成
   * @param {any} request - リクエストオブジェクト
   * @return {Promise<any>} 作成された決済メソッド
   */
  async createPaymentMethod(request: any): Promise<any> {
    const uid = request.auth.uid
    const paymentMethodData = request.data

    stripeOptions.idempotencyKey = `create_payment_method_${uid}`

    return await getStripe().paymentMethods.create(
      paymentMethodData,
      stripeOptions,
    )
  }
}
