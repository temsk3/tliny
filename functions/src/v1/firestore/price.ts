/* eslint-disable max-len */
// import * as firebaseAdmin from 'firebase-admin'

import functions from '../../utils/base_function';
import {exportFunction} from '../../utils/deploy';
import * as P from '../../utils/function_paths';
import triggerOnce from '../../utils/trigger_once';
// import { currency, stripe, stripeOptions } from '../stripe/utils/stripe_config'
// import stripeErrors from '../stripe/utils/stripe_error'
// import Stripe from 'stripe'

const _exportFunction = (name: string, f: () => any): void =>
  exportFunction([P.v1, P.firestore, 'product', name], exports, f);

const path = '/v/{version}/price/{productID}';
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
            console.log(snapshot.id);
            console.log(snapshot.data().name);

            console.log(snapshot, context);
          })
      )
);

_exportFunction('onUpdate', () =>
  functions()
      .firestore.document(path)
      .onUpdate(
          triggerOnce('productUpdateNotification', async (snapshot, context) => {
            //

            console.log(snapshot, context);
          })
      )
);

_exportFunction('onDelete', () =>
  functions()
      .firestore.document(path)
      .onDelete(
          triggerOnce('productDeleteNotification', async (snapshot, context) => {
            //
            // const priceId = '123'
            // await firebaseAdmin
            //   .firestore()
            //   .doc(snapshot.after.ref.path)
            //   .set({ priceId: priceId }, { merge: true })

            console.log(snapshot, context);
          })
      )
);
