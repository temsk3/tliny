import * as admin from 'firebase-admin'
import { db } from '../../utils/firebase_utils'
import * as functions from 'firebase-functions/v1'
import { exportFunction } from '../../utils/deploy'
import triggerOnce from '../../utils/trigger_once'
import Stripe from 'stripe'
import { getStripe, stripeOptions } from '../payment/utils/stripe_config'
import stripeErrors from '../payment/utils/stripe_error'
import paths from './utils/db_paths'
import { ErrorHandler } from '../../utils/error_handler'
import { logger } from '../../utils/logger'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction(['v2', 'firestore', 'user', name], exports, f)

_exportFunction('onCreateStripeCustomer', () =>
  functions
    .runWith({
      memory: '512MB',
      secrets: ['STRIPE_DEV_SK', 'STRIPE_DEV_PK', 'STRIPE_DEV_EP'],
    })
    .region('asia-northeast1')
    .auth.user()
    .onCreate(
      triggerOnce(
        'createStripeCustomerNotification',
        async (user: any, context: any) => {
          logger.info('=== onCreateStripeCustomer START ===')
          logger.info('User customClaims:', { customClaims: user.customClaims })

          if (
            user.customClaims &&
            Object.hasOwnProperty.call(user.customClaims, 'customerId')
          ) {
            logger.info(
              'User is already connected to a stripe customer. Exiting.',
            )
            return
          }

          try {
            logger.info('Creating Stripe customer...')
            // 冪等性保証のためのidempotencyKeyを設定
            const customerIdempotencyKey = `create_customer_${user.uid}`
            const customerStripeOptions = {
              ...stripeOptions,
              idempotencyKey: customerIdempotencyKey,
            }

            // stripe customer登録
            const customer = await getStripe()
              .customers.create(
                {
                  name: user.displayName,
                  email: user.email,
                  phone: user.phoneNumber,
                  metadata: { uid: user.uid },
                },
                customerStripeOptions,
              )
              .then(
                (result: Stripe.Response<Stripe.Customer>) => {
                  logger.info('Stripe customer created:', {
                    customerId: result.id,
                    idempotencyKey: customerIdempotencyKey,
                  })
                  return result
                },
                (error: any) => {
                  logger.error('Stripe customer creation failed:', { error })
                  stripeErrors(error)
                  throw new Error(error)
                },
              )

            logger.info('Creating setup intent...')
            // 冪等性保証のためのidempotencyKeyを設定
            const setupIntentIdempotencyKey = `create_setup_intent_${user.uid}_${customer.id}`
            const setupIntentStripeOptions = {
              ...stripeOptions,
              idempotencyKey: setupIntentIdempotencyKey,
            }

            const intent = await getStripe()
              .setupIntents.create(
                {
                  customer: customer.id,
                },
                setupIntentStripeOptions,
              )
              .then(
                (result: Stripe.Response<Stripe.SetupIntent>) => {
                  logger.info('Setup intent created:', {
                    intentId: result.id,
                    idempotencyKey: setupIntentIdempotencyKey,
                  })
                  return result
                },
                (error: any) => {
                  logger.error('Setup intent creation failed:', { error })
                  stripeErrors(error)
                  throw new Error(error)
                },
              )

            logger.info('Setting custom claims...')
            // Authenticationの認証で利用するユーザー属性に独自の情報(stripe)を追加
            await admin
              .auth()
              .setCustomUserClaims(user.uid, { customerId: customer.id })

            logger.info('Saving to stripe_customers collection...')
            // stripe_customers collection への登録
            await db
              .collection(paths.customersCollectionPath)
              .doc(user.uid)
              .set({
                customer_id: customer.id,
                setup_secret: intent.client_secret,
              })

            let displayName: string | undefined = user.displayName
            if (!displayName || !displayName.trim()) {
              displayName = user.email?.substring(
                0,
                user.email.lastIndexOf('@'),
              )
            } else {
              displayName = displayName.trim()
            }

            logger.info('Saving to users collection...')
            // users collection への登録
            await db
              .collection(paths.usersCollectionPath)
              .doc(user.uid)
              .set({
                displayName: displayName,
                name: displayName,
                email: user.email,
                phoneNumber: user.phoneNumber,
                photoUrl: user.photoURL,
                isActive: true,
                createdAt: new Date(new Date().getTime()),
              })

            logger.info('Saving to public_users collection...')
            // public_users への登録
            await db
              .collection(paths.publicUsersCollectionPath)
              .doc(user.uid)
              .set({
                displayName: displayName,
                photoUrl: user.photoURL,
                createdAt: new Date(new Date().getTime()),
              })

            logger.info('=== onCreateStripeCustomer SUCCESS ===')
            return
          } catch (error: any) {
            logger.error('=== onCreateStripeCustomer ERROR ===')
            logger.error('Error details:', { error })
            ErrorHandler.logError(error, error.stack, 'user.ts')
            const appEx = ErrorHandler.convertToAppException(error, 'user.ts')
            throw ErrorHandler.convertToHttpsError(appEx)
          }
        },
      ),
    ),
)

_exportFunction('onDeleteStripeCustomer', () =>
  functions
    .runWith({
      memory: '512MB',
      secrets: ['STRIPE_DEV_SK', 'STRIPE_DEV_PK', 'STRIPE_DEV_EP'],
    })
    .region('asia-northeast1')
    .auth.user()
    .onDelete(
      triggerOnce(
        'deleteStripeCustomerNotification',
        async (user: any, context: any) => {
          await db.collection(paths.usersCollectionPath).doc(user.uid).delete()

          logger.info('User deleted:', { user, context })
          return
        },
      ),
    ),
)
