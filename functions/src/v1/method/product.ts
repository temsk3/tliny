/* eslint-disable max-len */
// import * as firebaseAdmin from 'firebase-admin'
// import Stripe from 'stripe'

import {onCall} from '../../utils/base_function';
import {exportFunction} from '../../utils/deploy';
import * as P from '../../utils/function_paths';
// import dbPaths from '../firestore/utils/db_paths'
// import Document from '../firestore/utils/document'
// import * as Model from '../firestore/utils/model'
// import { currency, stripe, stripeOptions } from '../stripe/utils/stripe_config'
// import stripeErrors from '../stripe/utils/stripe_error'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction([P.v1, P.method, 'product', name], exports, f);

_exportFunction('onUpdate', () =>
  onCall(async (data, context) => {
    // const id = data.id
    // const path = `${dbPaths.productsCollectionPath}/${id}`
    // const doc = await firebaseAdmin
    //   .firestore()
    //   .doc(path)
    //   .get()
    //   .then((s) => new Document<Model.Product>(s))
    // const newPrice: number = data.price
    // const oldPrice: number = doc.data.price
    // let newPriceId: string
    // const oldPriceId: string = data.priceId
    // const newName: string = data.name
    // const oldName: string = doc.data.name
    // const newDescription: string = data.desc
    // const oldDescription: string = doc.data.desc
    // //
    // const productId = await stripe.prices
    //   .retrieve(oldPriceId, stripeOptions)
    //   .then(
    //     (result: Stripe.Response<Stripe.Price>) => {
    //       console.log(result)
    //       return result.product
    //     },
    //     (error: any) => {
    //       stripeErrors(error)
    //       console.log('Pricer Retrieve Error')
    //       throw new Error(error.message)
    //     }
    //   )
    // //
    // if (oldPrice !== newPrice) {
    //   const priceParams: Stripe.PriceCreateParams = {
    //     currency: currency,
    //     product: productId as string,
    //     unit_amount: newPrice,
    //   }
    //   newPriceId = await stripe.prices.create(priceParams, stripeOptions).then(
    //     (result: Stripe.Response<Stripe.Price>) => {
    //       console.log(result)
    //       return result.id
    //     },
    //     (error: any) => {
    //       stripeErrors(error)
    //       console.log('Pricer Create Error')
    //       throw new Error(error.message)
    //     }
    //   )
    // } else {
    //   newPriceId = doc.data.priceId
    // }
    // if (oldName !== newName || oldDescription !== newDescription) {
    //   //
    //   const productParams: Stripe.ProductUpdateParams = {
    //     name: newName,
    //     description: newDescription,
    //   }
    //   //
    //   await stripe.products
    //     .update(productId as string, productParams, stripeOptions)
    //     .then(
    //       (result: Stripe.Response<Stripe.Product>) => {
    //         console.log(result)
    //         return result.id
    //       },
    //       (error: any) => {
    //         stripeErrors(error)
    //         console.log('Product Update Error')
    //         throw new Error(error.message)
    //       }
    //     )
    // }
    // const newProduct: Model.Product = {
    //   id: data.id,
    //   organizer: data.organizer, // owner
    //   accountId: data.accountId,
    //   eventId: data.eventId,
    //   eventName: data.eventName,
    //   register: data.register,
    //   exchangeNumber: data.exchangeNumber,
    //   code: data.code,
    //   name: data.name,
    //   genre: data.genre,
    //   desc: data.desc,
    //   stock: data.stock,
    //   priceId: newPriceId,
    //   price: data.price,
    //   picture1Name: data.picture1Name,
    //   picture1URL: data.picture1URL,
    //   expirationFrom: data.expirationFrom,
    //   expirationTo: data.expirationTo,
    //   organizerDocRef: data.organizerDocRef,
    //   eventDocRef: data.eventDocRef,
    // }
    // await firebaseAdmin
    //   .firestore()
    //   .doc(path)
    //   .set(
    //     { newProduct, createdAt: firebaseAdmin.firestore.Timestamp.now() },
    //     { merge: true }
    //   )
  })
);

_exportFunction('onDelete', () =>
  onCall(async (snapshot, context) => {
    //
    // const priceId = '123'
    // await firebaseAdmin
    //   .firestore()
    //   .doc(snapshot.after.ref.path)
    //   .set({ priceId: priceId }, { merge: true })

    console.log(snapshot, context);
  })
);
