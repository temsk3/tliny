/* eslint-disable max-len */
// import * as firebaseAdmin from 'firebase-admin'
import Stripe from 'stripe';
import {v4 as uuidv4} from 'uuid';

import functions from '../../utils/base_function';
import {exportFunction} from '../../utils/deploy';
import * as P from '../../utils/function_paths';
import triggerOnce from '../../utils/trigger_once';
import {currency, stripe, stripeOptions} from '../stripe/utils/stripe_config';
import stripeErrors from '../stripe/utils/stripe_error';
import {db, getStripeConnectAccountId} from '../../utils/firebase_utils';
import paths from './utils/db_paths';

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction([P.v1, P.firestore, 'product', name], exports, f);

const path = '/v/{version}/products/{productID}';
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
  functions()
      .firestore.document(path)
      .onCreate(
      // 冪等性の担保(eventIdの重複対策用function)
          triggerOnce('productCreateNotification', async (snapshot, context) => {
            try {
              console.log(snapshot.id);
              console.log(snapshot.data().name);

              const id = snapshot.id;
              const uid = snapshot.data().organizerId;
              const accountId = await getStripeConnectAccountId(
                  snapshot.data().organizerId
              );
              if (accountId === null) {
                console.log('Stripe Product Create Error');
                throw new Error('StripeConnectAccountId not found');
              }
              const price = snapshot.data().price;
              const productDocRef = db
                  .collection(paths.connectAccountsCollectionPath)
                  .doc(uid)
                  .collection(paths.connectProductsCollectionPath)
                  .doc(id);
              // const productPath = `${paths.connectAccountsCollectionPath}/${uid}${paths.connectProductsCollectionPath}/${id}`

              //
              const productParams: Stripe.ProductCreateParams = {
                name: snapshot.data().name,
                description: snapshot.data().desc,
                metadata: {id: id},
              };
              stripeOptions.idempotencyKey = uuidv4();
              //
              // stripeOptions.stripeAccount = accountId
              const productId = await stripe.products
                  .create(productParams, stripeOptions)
                  .then(
                      (result: Stripe.Response<Stripe.Product>) => {
                        console.log(result);
                        return result.id;
                      },
                      (error: any) => {
                        stripeErrors(error);
                        console.log('Stripe Product Create Error');
                        throw new Error(error.message);
                      }
                  );

              //
              const priceParams: Stripe.PriceCreateParams = {
                currency: currency,
                product: productId,
                unit_amount: price,
              };
              stripeOptions.idempotencyKey = uuidv4();
              //
              // stripeOptions.stripeAccount = accountId
              const priceId = stripe.prices.create(priceParams, stripeOptions).then(
                  (result: Stripe.Response<Stripe.Price>) => {
                    console.log(result);
                    return result.id;
                  },
                  (error: any) => {
                    stripeErrors(error);
                    console.log('Stripe Pricer Create Error');
                    throw new Error(error.message);
                  }
              );

              //
              await productDocRef.set(
                  {priceId: priceId, productId: productId},
                  {merge: true}
              );

              console.log(snapshot, context);
            } catch (error: any) {
              console.log('Product Create Error');
              throw new Error(error.message);
            }
          })
      )
);

_exportFunction('onUpdate', () =>
  functions()
      .firestore.document(path)
      .onUpdate(
          triggerOnce('productUpdateNotification', async (snapshot, context) => {
            try {
              //
              const id = snapshot.after.id;
              const uid = snapshot.after.data().organizerId;
              const accountId = await getStripeConnectAccountId(
                  snapshot.after.data().organizerId
              );
              if (accountId === null) {
                console.log('Stripe Product Update Error');
                throw new Error('StripeConnectAccountId not found');
              }
              const productDocRef = db
                  .collection(paths.connectAccountsCollectionPath)
                  .doc(uid)
                  .collection(paths.connectProductsCollectionPath)
                  .doc(id);
              const oldPrice = snapshot.before.data().price;
              const newPrice = snapshot.after.data().price;
              const oldName = snapshot.before.data().name;
              const newName = snapshot.after.data().name;
              const oldDesc = snapshot.before.data().desc;
              const newDesc = snapshot.after.data().desc;

              const data = (await productDocRef.get()).data();
              if (data === undefined) {
                console.log();
                throw new Error('productData is undefined');
              }
              const productId = data.productId;

              //
              if (oldPrice !== newPrice) {
                const priceParams: Stripe.PriceCreateParams = {
                  currency: currency,
                  product: productId,
                  unit_amount: newPrice,
                };
                stripeOptions.idempotencyKey = uuidv4();
                //
                // stripeOptions.stripeAccount = accountId
                const priceId = await stripe.prices
                    .create(priceParams, stripeOptions)
                    .then(
                        (result: Stripe.Response<Stripe.Price>) => {
                          console.log(result);
                          return result.id;
                        },
                        (error: any) => {
                          stripeErrors(error);
                          console.log('Stripe Pricer Create Error');
                          throw new Error(error.message);
                        }
                    );
                await productDocRef.set({priceId: priceId}, {merge: true});
              }

              //
              if (oldName !== newName || oldDesc !== newDesc) {
                const productParams: Stripe.ProductUpdateParams = {
                  name: newName,
                  description: newDesc,
                };
                stripeOptions.idempotencyKey = uuidv4();
                //
                // stripeOptions.stripeAccount = accountId
                await stripe.products
                    .update(productId, productParams, stripeOptions)
                    .then(
                        (result: Stripe.Response<Stripe.Product>) => {
                          return result;
                        },
                        (error: any) => {
                          stripeErrors(error);
                          console.log('Stripe Product Update Error');
                          throw new Error(error.message);
                        }
                    );
              }

              console.log(snapshot, context);
            } catch (error: any) {
              console.log('Product Update Error');
              throw new Error(error.message);
            }
          })
      )
);

_exportFunction('onDelete', () =>
  functions()
      .firestore.document(path)
      .onDelete(
          triggerOnce('productDeleteNotification', async (snapshot, context) => {
            try {
              //
              const id = snapshot.id;
              const uid = snapshot.data().organizerId;
              const productDocRef = db
                  .collection(paths.connectAccountsCollectionPath)
                  .doc(uid)
                  .collection(paths.connectProductsCollectionPath)
                  .doc(id);

              const data = (await productDocRef.get()).data();
              if (data === undefined) {
                console.log();
                throw new Error('productData is undefined');
              }
              const productId = data.productId;
              await stripe.products.del(productId).then(
                  (result: Stripe.Response<Stripe.DeletedProduct>) => {
                    return result;
                  },
                  (error: any) => {
                    stripeErrors(error);
                    console.log('Stripe Product Delete Error');
                    throw new Error(error.message);
                  }
              );

              productDocRef.delete;
              console.log(snapshot, context);
            } catch (error: any) {
              console.log('Product Delete Error');
              throw new Error(error.message);
            }
          })
      )
);
