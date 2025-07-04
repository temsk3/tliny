import Stripe from 'stripe'
import {
  getStripe,
  stripeOptions,
  stripeErrors,
  APPLICATION_FEE_PERCENT,
} from './utils'
import { getStripeWebhookEndpointSecret } from './utils/stripe_config'
import { onRequest } from 'firebase-functions/v2/https'
import { logger } from 'firebase-functions'
import { exportFunction } from '../../utils/deploy'
import { createTicketDocument } from '../business/services/ticket.service'
import {
  createTransferDocument,
  createWebhookEventDocument,
  getUidFromStripeCustomerId,
  updateOderDocument,
  updatePaymentDocument,
} from './utils/stripe_firestore'
import { updateAccountStatus } from '../business/services/account.service'
import triggerOnce from '../../utils/trigger_once'
import { checkDocumentExistsByQuery } from '../firestore/utils/idempotency'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction(['v2', 'payment', 'webhook', name], exports, f)

const handleError = (
  error: any,
  response: any,
  status = 500,
  message = 'Webhook handler failed.',
) => {
  logger.error(message, { error: error.message, status })
  response.status(status).send(message)
}

const handleAccountUpdated = async (
  accountUpdatedEvent: Stripe.Account,
  response: any,
) => {
  await triggerOnce(
    `account_updated_${accountUpdatedEvent.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Account updated', { accountId: accountUpdatedEvent.id })

        let stripeStatus = 'unverified'
        if (accountUpdatedEvent.individual?.verification) {
          stripeStatus = accountUpdatedEvent.individual.verification.status
        }

        const uid = accountUpdatedEvent.metadata?.uid
        const chargesEnabled = accountUpdatedEvent.charges_enabled

        await updateAccountStatus(
          uid,
          accountUpdatedEvent.id,
          stripeStatus,
          chargesEnabled,
        )

        response.json({ received: true })
      } catch (error: any) {
        logger.error('Account update failed', { error: error.message })
        handleError(error, response)
      }
    },
  )
}

const handlePaymentIntentSucceeded = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  await triggerOnce(
    `payment_success_${paymentIntent.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Payment intent succeeded', {
          paymentIntentId: paymentIntent.id,
        })

        const customer = paymentIntent.customer
        if (!customer) {
          throw new Error('customer is null')
        }

        const uid = await getUidFromStripeCustomerId(customer as string)
        if (!uid) {
          throw new Error('uid not found')
        }

        await updatePaymentDocument({
          uid,
          paymentIntentId: paymentIntent.id,
          status: paymentIntent.status,
        })

        await updateOderDocument({
          orderId: paymentIntent.metadata.orderId,
          status: paymentIntent.status,
        })

        const fee = Math.floor(
          paymentIntent.amount * (APPLICATION_FEE_PERCENT / 100),
        )
        const amount = paymentIntent.amount - fee
        const params: Stripe.TransferCreateParams = {
          amount: amount,
          currency: 'jpy',
          destination: paymentIntent.metadata.account_id,
          transfer_group: paymentIntent.metadata.orderId,
        }

        stripeOptions.idempotencyKey = `create_transfer_${uid}`
        const transfer = await getStripe()
          .transfers.create(params, stripeOptions)
          .then(
            (result: Stripe.Response<Stripe.Transfer>) => result,
            (error: any) => {
              stripeErrors(error)
              throw new Error('transfer failed')
            },
          )

        await createTransferDocument(transfer.id)
        await createTicketDocument(paymentIntent.metadata.orderId)

        response.json({ received: true })
      } catch (error: any) {
        logger.error('Payment intent succeeded failed', {
          error: error.message,
        })
        handleError(error, response)
      }
    },
  )
}

const handlePaymentIntentFailed = async (
  paymentIntent: Stripe.PaymentIntent,
  response: any,
) => {
  await triggerOnce(
    `payment_failed_${paymentIntent.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Payment intent failed', {
          paymentIntentId: paymentIntent.id,
        })
        response.json({ received: true })
      } catch (error: any) {
        logger.error('Payment intent failed handler failed', {
          error: error.message,
        })
        handleError(error, response)
      }
    },
  )
}

const handleCheckoutSessionCompleted = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  await triggerOnce(
    `checkout_completed_${checkoutSession.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Checkout session completed', {
          checkoutSessionId: checkoutSession.id,
        })
        response.json({ received: true })
      } catch (error: any) {
        logger.error('Checkout session completed failed', {
          error: error.message,
        })
        handleError(error, response)
      }
    },
  )
}

const handleCheckoutSessionSucceeded = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  await triggerOnce(
    `checkout_succeeded_${checkoutSession.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Checkout session succeeded', {
          checkoutSessionId: checkoutSession.id,
        })
        response.json({ received: true })
      } catch (error: any) {
        logger.error('Checkout session succeeded failed', {
          error: error.message,
        })
        handleError(error, response)
      }
    },
  )
}

const handleCheckoutSessionFailed = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  await triggerOnce(
    `checkout_failed_${checkoutSession.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Checkout session failed', {
          checkoutSessionId: checkoutSession.id,
        })
        response.json({ received: true })
      } catch (error: any) {
        logger.error('Checkout session failed handler failed', {
          error: error.message,
        })
        handleError(error, response)
      }
    },
  )
}

const handleCheckoutSessionExpired = async (
  checkoutSession: Stripe.Checkout.Session,
  response: any,
) => {
  await triggerOnce(
    `checkout_expired_${checkoutSession.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Checkout session expired', {
          checkoutSessionId: checkoutSession.id,
        })
        response.json({ received: true })
      } catch (error: any) {
        logger.error('Checkout session expired failed', {
          error: error.message,
        })
        handleError(error, response)
      }
    },
  )
}

const handlePaymentMethodAttached = async (
  paymentMethod: any,
  response: any,
) => {
  await triggerOnce(
    `payment_method_attached_${paymentMethod.id}`,
    async (data: any, context: any) => {
      try {
        logger.info('Payment method attached', {
          paymentMethodId: paymentMethod.id,
        })
        response.json({ received: true })
      } catch (error: any) {
        logger.error('Payment method attached failed', {
          error: error.message,
        })
        handleError(error, response)
      }
    },
  )
}

// Webhook処理（冪等性保証）
_exportFunction('onStripeWebhook', () =>
  onRequest(async (request, response) => {
    const sig = request.headers['stripe-signature']
    const endpointSecret = getStripeWebhookEndpointSecret()

    let event: Stripe.Event

    try {
      event = getStripe().webhooks.constructEvent(
        request.rawBody,
        sig as string,
        endpointSecret,
      )
    } catch (err: any) {
      logger.error('Webhook signature verification failed', {
        error: err.message,
      })
      response.status(400).send(`Webhook Error: ${err.message}`)
      return
    }

    // 冪等性保証: 同じWebhookイベントが既に処理済みかチェック
    const eventExists = await checkDocumentExistsByQuery(
      'v/1/platform/spel1/stripe_events',
      'stripe_event_id',
      event.id,
    )

    if (eventExists) {
      logger.info('Webhook event already processed, skipping', {
        eventId: event.id,
        eventType: event.type,
      })
      response.status(200).send('Event already processed')
      return
    }

    // Webhookイベントドキュメントを作成
    await createWebhookEventDocument(event)

    logger.info('Processing webhook event', {
      eventId: event.id,
      eventType: event.type,
    })

    try {
      switch (event.type) {
        case 'payment_intent.succeeded':
          await handlePaymentIntentSucceeded(
            event.data.object as Stripe.PaymentIntent,
            response,
          )
          break
        case 'payment_intent.payment_failed':
          await handlePaymentIntentFailed(
            event.data.object as Stripe.PaymentIntent,
            response,
          )
          break
        case 'account.updated':
          await handleAccountUpdated(
            event.data.object as Stripe.Account,
            response,
          )
          break
        case 'transfer.created':
          await handleTransferCreated(
            event.data.object as Stripe.Transfer,
            response,
          )
          break
        case 'checkout.session.completed':
          await handleCheckoutSessionCompleted(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          break
        case 'checkout.session.async_payment_succeeded':
          await handleCheckoutSessionSucceeded(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          break
        case 'checkout.session.async_payment_failed':
          await handleCheckoutSessionFailed(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          break
        case 'checkout.session.expired':
          await handleCheckoutSessionExpired(
            event.data.object as Stripe.Checkout.Session,
            response,
          )
          break
        case 'payment_method.attached':
          await handlePaymentMethodAttached(event.data.object, response)
          break
        default:
          logger.info('Unhandled event type', { eventType: event.type })
          response.status(200).send('Event type not handled')
      }
    } catch (error: any) {
      logger.error('Error processing webhook', {
        eventId: event.id,
        eventType: event.type,
        error: error.message,
      })
      response.status(500).send('Webhook processing failed')
    }
  }),
)

/**
 * 送金作成時の処理
 * @param {Stripe.Transfer} transfer - Stripe送金
 * @param {any} response - レスポンスオブジェクト
 * @return {Promise<void>}
 */
async function handleTransferCreated(
  transfer: Stripe.Transfer,
  response: any,
): Promise<void> {
  logger.info('Transfer created', { transferId: transfer.id })

  try {
    await createTransferDocument(transfer.id)
    logger.info('Transfer document created successfully', {
      transferId: transfer.id,
    })
    response.json({ received: true })
  } catch (error: any) {
    logger.error('Error creating transfer document', {
      transferId: transfer.id,
      error: error.message,
    })
    handleError(error, response)
  }
}
