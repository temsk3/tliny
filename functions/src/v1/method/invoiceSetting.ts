import * as functions from 'firebase-functions'
// import * as firebaseAdmin from 'firebase-admin'
import { v4 as uuidv4 } from 'uuid'

import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

import {
  stripe,
  stripeOptions,
  // country,
  // accountType,
  // capabilities,
} from '../stripe/utils/stripe_config'
import stripeErrors from '../stripe/utils/stripe_error'
import Stripe from 'stripe'
import {
  // db,
  checkAuth,
  getRequestingUserId,
  getStripeCustomerId,
} from '../../utils/firebase_utils'
// import config from '../firestore/utils/db_paths'
// import Document from '../firestore/utils/document'
// import * as Model from '../firestore/utils/model'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.method, 'invoiceSetting', name], exports, f)

// MARK: Account Links の登録(account_onboarding)or更新(account_update)
_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    console.log('Customer invoiceSetting')
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)
    // uid取得
    const uid = getRequestingUserId(context)
    //
    const customerId = await getStripeCustomerId(uid)
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    //
    // const setupIntent = await db
    //   .collection(config.customersCollectionPath)
    //   .doc(uid)
    //   .get()
    //   .then((s) => new Document<Model.Customer>(s))

    // stripeOptions.idempotencyKey = uuidv4()
    // const setupIntentId = data.setupIntentId
    // console.log(setupIntentId)
    // const paymentMethodId = data.paymentMethodId
    // console.log(paymentMethodId)
    // await stripe.setupIntents
    //   .retrieve(setupIntent.data.setup_secret, stripeOptions)
    //   .then(
    //     (result: Stripe.Response<Stripe.SetupIntent>) => {
    //       console.log(result)
    //       return result.id
    //     },
    //     (error: any) => {
    //       stripeErrors(error)
    //       throw new functions.https.HttpsError('unknown', error)
    //     }
    //   )

    // const params: Stripe.SetupIntentUpdateParams = {
    //   customer: customerId,
    //   payment_method: paymentMethodId,
    // }
    // stripeOptions.idempotencyKey = uuidv4()
    // await stripe.setupIntents.update(setupIntentId, params, stripeOptions).then(
    //   (result: Stripe.Response<Stripe.SetupIntent>) => {
    //     console.log(result)
    //     return result
    //   },
    //   (error: any) => {
    //     stripeErrors(error)
    //     throw new functions.https.HttpsError('unknown', error)
    //   }
    // )
    const paramsA: Stripe.CustomerUpdateParams = {
      invoice_settings: { default_payment_method: data.paymentMethodId },
    }
    stripeOptions.idempotencyKey = uuidv4()
    return await stripe.customers
      .update(customerId, paramsA, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Customer>) => {
          console.log(result)
          return result
        },
        (error: any) => {
          stripeErrors(error)
          throw new functions.https.HttpsError('unknown', error)
        }
      )
  })
)

// const createAccount = async (data: any) => {
//   console.log('createAccount')
//   const params: Stripe.AccountCreateParams = {
//     type: accountType,
//     country: country,
//     email: data.email,
//     capabilities: capabilities,
//   }
//   stripeOptions.idempotencyKey = uuidv4()
//   return await stripe.accounts.create(params, stripeOptions).then(
//     (result: Stripe.Response<Stripe.Account>) => {
//       console.log(result)
//       return result.id
//     },
//     (error: any) => {
//       stripeErrors(error)
//       throw new functions.https.HttpsError('unknown', error)
//     }
//   )
// }

// const retrieveAccount = async (accountId: string) => {
//   console.log('retrieveAccount')
//   stripeOptions.idempotencyKey = uuidv4()
//   return await stripe.accounts.retrieve(accountId, stripeOptions).then(
//     (result: Stripe.Response<Stripe.Account>) => {
//       console.log(result)
//       const detailsSubmitted = result.details_submitted
//       console.log(detailsSubmitted)
//       return detailsSubmitted
//     },
//     (error: any) => {
//       stripeErrors(error)
//       throw new functions.https.HttpsError('unknown', error)
//     }
//   )
// }

// const createAccountLink = async (accountId: string, data: any) => {
//   console.log('createAccountLink')
//   const params: Stripe.AccountLinkCreateParams = {
//     account: accountId,
//     refresh_url: data.refreshUrl,
//     return_url: data.returnUrl,
//     type: 'account_onboarding',
//   }
//   stripeOptions.idempotencyKey = uuidv4()
//   return await stripe.accountLinks.create(params, stripeOptions).then(
//     (result: Stripe.Response<Stripe.AccountLink>) => {
//       const accountUrl = result.url
//       console.log(accountUrl)
//       return { accountUrl: accountUrl }
//     },
//     (error: any) => {
//       stripeErrors(error)
//       throw new functions.https.HttpsError('unknown', error)
//     }
//   )
// }

// const updateAccountLink = async (accountId: string, data: any) => {
//   console.log('updateAccountLink')
//   const params: Stripe.AccountLinkCreateParams = {
//     account: accountId,
//     refresh_url: data.refreshUrl,
//     return_url: data.returnUrl,
//     type: 'account_update',
//   }
//   stripeOptions.idempotencyKey = uuidv4()
//   return await stripe.accountLinks.create(params, stripeOptions).then(
//     (result: Stripe.Response<Stripe.AccountLink>) => {
//       const accountUrl = result.url
//       console.log(accountUrl)
//       return { accountUrl: accountUrl }
//     },
//     (error: any) => {
//       stripeErrors(error)
//       throw new functions.https.HttpsError('unknown', error)
//     }
//   )
// }
