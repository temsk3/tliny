/* eslint-disable max-len */
import * as functions from 'firebase-functions';
import {v4 as uuidv4} from 'uuid';

import {onCall} from '../../utils/base_function';
import {exportFunction} from '../../utils/deploy';
import * as P from '../../utils/function_paths';

import {stripe, stripeOptions} from './utils/stripe_config';
import stripeErrors from './utils/stripe_error';
import {getStripeCustomerId} from './utils/stripe_utils';
import {getRequestingUserId, checkAuth} from '../../utils/firebase_utils';
import Stripe from 'stripe';

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'customer', name], exports, f);

// /
// / Customer（お金を払うアカウント）
// /

// MARK: - EphemeralKeyを返す
_exportFunction('getEphemeralKey', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context);

    const customerId = await getStripeCustomerId(getRequestingUserId(context));
    if (customerId === null) {
      throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
      );
    }
    const params: Stripe.EphemeralKeyCreateParams = {customer: customerId};
    // console.log('params', params)

    if (data.apiVersion) stripeOptions.apiVersion = data.apiVersion;

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.ephemeralKeys.create(params, stripeOptions).then(
        (result: Stripe.Response<Stripe.EphemeralKey>) => {
        // console.log('key', result)
          return {key: result};
        },
        (error: any) => {
          console.log('error', error);
          stripeErrors(error);
        }
    );
  })
);

// MARK: - stripeのcustomerを作ってcustomerIdを返す
_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context);

    const uid = getRequestingUserId(context);
    const params: Stripe.CustomerCreateParams = {
      email: data.email,
      metadata: {uid: uid},
    };

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.customers.create(params, stripeOptions).then(
        (result: any) => {
          const customerId = result.id;
          return {customerId: customerId};
        },
        (error: any) => {
          stripeErrors(error);
        }
    );
  })
);

// MARK: customerのretrieve
_exportFunction('onRetrieve', () =>
  onCall(async (data, context) => {
    //
    checkAuth(context);

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.customers.retrieve(data.customerId, stripeOptions).then(
        (result: Stripe.Response<Stripe.Customer | Stripe.DeletedCustomer>) => {
          return result;
        },
        (error: any) => {
          stripeErrors(error);
        }
    );
  })
);

// MARK: customerのupdate
_exportFunction('onUpdate', () =>
  onCall(async (data, context) => {
    //
    checkAuth(context);

    const customerId = await getStripeCustomerId(getRequestingUserId(context));
    if (customerId === null) {
      throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
      );
    }
    const params: Stripe.CustomerUpdateParams = data.params;

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.customers
        .update(customerId, params, stripeOptions)
        .then(
            (result: Stripe.Response<Stripe.Customer>) => {
              return result;
            },
            (error: any) => {
              stripeErrors(error);
            }
        );
  })
);

// // MARK: customerのupdate（基本情報）
// _exportFunction('onUpdateAddress', () =>
//   onCall(async (data, context) => {
//     const customerId = data.customerId
//     return await stripe.customers
//       .update(customerId, {
//         name: data.name,
//         email: data.email,
//         phone: data.phone,
//         address: {
//           country: data.country, // Two-letter country code (ISO 3166-1 alpha-2).
//           postal_code: data.postal_code,
//           state: data.state,
//           city: data.city,
//           line1: data.line1,
//           line2: data.line2,
//         },
//       })
//       .then(
//         (result: any) => {
//           return result
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )

// // MARK: customerのupdate（配送情報）
// _exportFunction('onUpdateShippingInformation', () =>
//   onCall(async (data, context) => {
//     const customerId = data.customerId
//     return await stripe.customers
//       .update(customerId, {
//         shipping: {
//           name: data.name,
//           phone: data.phone,
//           address: {
//             country: data.country, // Two-letter country code (ISO 3166-1 alpha-2).
//             postal_code: data.postal_code,
//             state: data.state,
//             city: data.city,
//             line1: data.line1,
//             line2: data.line2,
//           },
//         },
//       })
//       .then(
//         (result: any) => {
//           return result
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )

// MARK: stripeのcustomerを削除
_exportFunction('onDelete', () =>
  onCall(async (data, context) => {
    //
    checkAuth(context);

    const customerId = await getStripeCustomerId(getRequestingUserId(context));
    if (customerId === null) {
      throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
      );
    }

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.customers.del(customerId, stripeOptions).then(
        (result: Stripe.Response<Stripe.DeletedCustomer>) => {
          return result;
        },
        (error: any) => {
          stripeErrors(error);
        }
    );
  })
);

// MARK: stripeのcustomerを検索
_exportFunction('onSearch', () =>
  onCall(async (data, context) => {
    //
    checkAuth(context);

    const customerId = await getStripeCustomerId(getRequestingUserId(context));
    if (customerId === null) {
      throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
      );
    }
    // {query: 'name:\'xxx\' AND metadata[\'foo\']:\'bar\'',}
    const query = 'metadata[\'uid\']:\'' + customerId + '\'';
    const params: Stripe.CustomerSearchParams = {query: query};

    stripeOptions.idempotencyKey = uuidv4();

    return await stripe.customers.search(params, stripeOptions).then(
        (result: any) => {
          return result;
        },
        (error: any) => {
          stripeErrors(error);
        }
    );
  })
);

// //
// //
// // カード情報の登録
// _exportFunction('createCardInfo', () =>
//   onCall(async (data, context) => {
//     //
//     authCheck(context)
//     const customerId = data.customerId
//     const cardToken = data.cardToken
//     return await stripe.customers
//       .createSource(customerId, { source: cardToken })
//       .then(
//         (result: any) => {
//           return result
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )
// // カード情報の取得
// _exportFunction('retrieveCardInfo', () =>
//   onCall(async (data, context) => {
//     //
//     authCheck(context)
//     const customerId = data.customerId
//     const cardToken = data.cardToken
//     return await stripe.customers
//       .retrieveSource(customerId, { source: cardToken })
//       .then(
//         (result: any) => {
//           return result
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )
// // カード情報の削除
// _exportFunction('deleteCardInfo', () =>
//   onCall(async (data, context) => {
//     //
//     authCheck(context)
//     const customerId = data.customerId
//     const cardToken = data.cardToken
//     return await stripe.customers
//       .deleteSource(customerId, { source: cardToken })
//       .then(
//         (result: any) => {
//           return result
//         },
//         (error: any) => {
//           stripeErrors(error)
//         }
//       )
//   })
// )
