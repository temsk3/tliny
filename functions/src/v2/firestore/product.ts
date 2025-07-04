/* eslint-disable max-len */
// import * as firebaseAdmin from 'firebase-admin'
import Stripe from 'stripe'

import {
  onDocumentCreated,
  onDocumentUpdated,
  onDocumentDeleted,
} from 'firebase-functions/v2/firestore'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'
import triggerOnce from '../../utils/trigger_once'
import {
  currency,
  getStripe,
  stripeOptions,
} from '../payment/utils/stripe_config'
import stripeErrors from '../payment/utils/stripe_error'
import { db, getStripeConnectAccountId } from '../../utils/firebase_utils'
import paths from './utils/db_paths'
import { ErrorHandler } from '../../utils/error_handler'
import { logger } from '../../utils/logger'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction([P.v2, P.firestore, 'product', name], exports, f)

const path = '/v/{version}/products/{productID}'
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

_exportFunction('onCreate', () =>
  onDocumentCreated(path, async (event) => {
    const snapshot = event.data
    if (!snapshot) return

    await triggerOnce(
      'productCreateNotification',
      async (data: any, context: any) => {
        try {
          logger.info('Product data is undefined')
          logger.info('Product operation completed', {
            snapshotId: snapshot.id,
            context,
          })

          const id = snapshot.id
          const uid = snapshot.data()?.organizerId
          const accountId = await getStripeConnectAccountId(
            snapshot.data()?.organizerId,
          )
          if (accountId === null) {
            logger.error('Stripe Product Create Error')
            throw new Error('StripeConnectAccountId not found')
          }
          const price = snapshot.data()?.price
          const productDocRef = db
            .collection(paths.connectAccountsCollectionPath)
            .doc(uid)
            .collection(paths.connectProductsCollectionPath)
            .doc(id)

          //
          const productParams: Stripe.ProductCreateParams = {
            name: snapshot.data()?.name,
            description: snapshot.data()?.desc,
            metadata: { id: id },
          }
          stripeOptions.idempotencyKey = `create_product_${uid}_${id}`
          //
          // stripeOptions.stripeAccount = accountId
          const productId = await getStripe()
            .products.create(productParams, stripeOptions)
            .then(
              (result: Stripe.Response<Stripe.Product>) => {
                logger.info('Product created successfully', {
                  productId: result.id,
                })
                return result.id
              },
              (error: any) => {
                stripeErrors(error)
                logger.error('Stripe Product Create Error')
                throw new Error(error.message)
              },
            )

          //
          const priceParams: Stripe.PriceCreateParams = {
            currency: currency,
            product: productId,
            unit_amount: price,
          }
          stripeOptions.idempotencyKey = `create_price_${uid}_${id}_${productId}`
          //
          // stripeOptions.stripeAccount = accountId
          const priceId = await getStripe()
            .prices.create(priceParams, stripeOptions)
            .then(
              (result: Stripe.Response<Stripe.Price>) => {
                logger.info('Price created successfully', {
                  priceId: result.id,
                })
                return result.id
              },
              (error: any) => {
                stripeErrors(error)
                logger.error('Stripe Pricer Create Error')
                throw new Error(error.message)
              },
            )

          //
          await productDocRef.set(
            { priceId: priceId, productId: productId },
            { merge: true },
          )

          logger.info('Product operation completed', {
            snapshotId: snapshot.id,
            context,
          })
        } catch (error: any) {
          ErrorHandler.logError(error, error.stack, 'product.ts')
          const appEx = ErrorHandler.convertToAppException(error, 'product.ts')
          throw ErrorHandler.convertToHttpsError(appEx)
        }
      },
    )(snapshot.data(), { eventId: event.id })
  }),
)

_exportFunction('onUpdate', () =>
  onDocumentUpdated(path, async (event) => {
    const before = event.data?.before
    const after = event.data?.after
    if (!after) return

    await triggerOnce(
      'productUpdateNotification',
      async (data: any, context: any) => {
        try {
          //
          const id = after.id
          const uid = after.data()?.organizerId
          const accountId = await getStripeConnectAccountId(
            after.data()?.organizerId,
          )
          if (accountId === null) {
            logger.error('Stripe Product Update Error')
            throw new Error('StripeConnectAccountId not found')
          }
          const productDocRef = db
            .collection(paths.connectAccountsCollectionPath)
            .doc(uid)
            .collection(paths.connectProductsCollectionPath)
            .doc(id)
          const oldPrice = before?.data()?.price
          const newPrice = after.data()?.price
          const oldName = before?.data()?.name
          const newName = after.data()?.name
          const oldDesc = before?.data()?.desc
          const newDesc = after.data()?.desc

          const data = (await productDocRef.get()).data()
          if (data === undefined) {
            logger.info(
              'Product data is undefined, creating new Stripe product',
              {
                uid,
                productId: id,
              },
            )

            // Stripe Connectの商品データが存在しない場合は新規作成
            const productParams: Stripe.ProductCreateParams = {
              name: after.data()?.name || 'Unknown Product',
              description: after.data()?.desc || '',
            }
            stripeOptions.idempotencyKey = `create_product_${uid}_${id}`

            const stripeProduct = await getStripe()
              .products.create(productParams, stripeOptions)
              .then(
                (result: Stripe.Response<Stripe.Product>) => {
                  logger.info('Stripe product created successfully', {
                    productId: result.id,
                  })
                  return result
                },
                (error: any) => {
                  stripeErrors(error)
                  logger.error('Stripe Product Create Error')
                  throw new Error(error.message)
                },
              )

            // 価格も作成
            const priceParams: Stripe.PriceCreateParams = {
              currency: currency,
              product: stripeProduct.id,
              unit_amount: after.data()?.price || 0,
            }
            stripeOptions.idempotencyKey = `create_price_${uid}_${id}_${stripeProduct.id}`

            const priceId = await getStripe()
              .prices.create(priceParams, stripeOptions)
              .then(
                (result: Stripe.Response<Stripe.Price>) => {
                  logger.info('Price created successfully', {
                    priceId: result.id,
                  })
                  return result.id
                },
                (error: any) => {
                  stripeErrors(error)
                  logger.error('Stripe Price Create Error')
                  throw new Error(error.message)
                },
              )

            // Stripe Connectの商品データを保存
            await productDocRef.set(
              {
                productId: stripeProduct.id,
                priceId: priceId,
                name: after.data()?.name,
                description: after.data()?.desc,
                price: after.data()?.price,
              },
              { merge: true },
            )

            logger.info('Product operation completed (new product created)', {
              snapshotId: after.id,
              context,
            })
            return
          }

          const productId = data.productId

          //
          if (oldPrice !== newPrice) {
            const priceParams: Stripe.PriceCreateParams = {
              currency: currency,
              product: productId,
              unit_amount: newPrice,
            }
            stripeOptions.idempotencyKey = `create_price_${uid}_${id}_${productId}`
            //
            // stripeOptions.stripeAccount = accountId
            const priceId = await getStripe()
              .prices.create(priceParams, stripeOptions)
              .then(
                (result: Stripe.Response<Stripe.Price>) => {
                  logger.info('Price created successfully', {
                    priceId: result.id,
                  })
                  return result.id
                },
                (error: any) => {
                  stripeErrors(error)
                  logger.error('Stripe Pricer Create Error')
                  throw new Error(error.message)
                },
              )
            await productDocRef.set({ priceId: priceId }, { merge: true })
          }

          //
          if (oldName !== newName || oldDesc !== newDesc) {
            const productParams: Stripe.ProductUpdateParams = {
              name: newName,
              description: newDesc,
            }
            stripeOptions.idempotencyKey = `update_product_${uid}_${id}`
            //
            // stripeOptions.stripeAccount = accountId
            await getStripe()
              .products.update(productId, productParams, stripeOptions)
              .then(
                (result: Stripe.Response<Stripe.Product>) => {
                  return result
                },
                (error: any) => {
                  stripeErrors(error)
                  logger.error('Stripe Product Update Error')
                  throw new Error(error.message)
                },
              )
          }

          logger.info('Product operation completed', {
            snapshotId: after.id,
            context,
          })
        } catch (error: any) {
          ErrorHandler.logError(error, error.stack, 'product.ts')
          const appEx = ErrorHandler.convertToAppException(error, 'product.ts')
          throw ErrorHandler.convertToHttpsError(appEx)
        }
      },
    )(after.data(), { eventId: event.id })
  }),
)

_exportFunction('onDelete', () =>
  onDocumentDeleted(path, async (event) => {
    const snapshot = event.data
    if (!snapshot) return

    await triggerOnce(
      'productDeleteNotification',
      async (data: any, context: any) => {
        try {
          //
          const id = snapshot.id
          const uid = snapshot.data()?.organizerId
          const productDocRef = db
            .collection(paths.connectAccountsCollectionPath)
            .doc(uid)
            .collection(paths.connectProductsCollectionPath)
            .doc(id)

          const data = (await productDocRef.get()).data()
          if (data === undefined) {
            logger.info('Product data is undefined')
            throw new Error('productData is undefined')
          }
          const productId = data.productId
          await getStripe()
            .products.del(productId)
            .then(
              (result: Stripe.Response<Stripe.DeletedProduct>) => {
                return result
              },
              (error: any) => {
                stripeErrors(error)
                logger.error('Stripe Product Delete Error')
                throw new Error(error.message)
              },
            )

          productDocRef.delete
          logger.info('Product operation completed', {
            snapshotId: snapshot.id,
            context,
          })
        } catch (error: any) {
          ErrorHandler.logError(error, error.stack, 'product.ts')
          const appEx = ErrorHandler.convertToAppException(error, 'product.ts')
          throw ErrorHandler.convertToHttpsError(appEx)
        }
      },
    )(snapshot.data(), { eventId: event.id })
  }),
)
