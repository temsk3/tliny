/* eslint-disable max-len */
import * as firebaseAdmin from 'firebase-admin'
import * as functions from 'firebase-functions'
import Stripe from 'stripe'
import { v4 as uuidv4 } from 'uuid'

import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

import {
  checkAuth,
  db,
  getRequestingUserId,
  getStripeConnectAccountId,
} from '../../utils/firebase_utils'
import config from '../firestore/utils/db_paths'
import { stripe, stripeOptions } from './utils/stripe_config'
import stripeErrors from './utils/stripe_error'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.stripe, 'account', name], exports, f)

// /
// / Connect Account（お金を受け取る側）
// /

// MARK: - ConnectAccountを作成し、accountIdを返す
// _exportFunction('onCreate2', () =>
//   functions().https.onCall(async (data, context) => {
//     // 認証済みユーザーかどうかチェックする
//     if (!context.auth || !context.auth.uid) {
//       throw new f.https.HttpsError(
//         'unauthenticated',
//         'User is not authenticated.'
//       )
//     }
//     const type = 'custom'
//     const country = 'JP'
//     const businessProfile = {
//       mcc: '5818', // 業種コード（5834 → Computer Software Stores）
//       url: 'https://spel1.com/tliny', // 事業のウェブサイト
//       product_description: 'プラットフォーム型サービスのテストアカウントです', // 事業の内容
//     }
//     const capabilities = {
//       card_payments: { requested: true }, // カード決済
//       transfers: { requested: true }, // 送金
//       jcb_payments: { requested: true },
//     }
//     const externalAccounts = data.externalAccounts
//     const idempotencyKey = data.idempotencyKey
//     if (
//       data.accountToken != null ||
//       data.accountToken != undefined ||
//       data.accountToken != ''
//     ) {
//       // token での作成
//       const accountToken = data.accountToken
//       await stripe.accounts
//         .create(
//           {
//             account_token: accountToken,

//             type: type,
//             country: country,
//             business_profile: businessProfile,
//             capabilities: capabilities,
//             external_accounts: { data: externalAccounts },
//           },
//           {
//             idempotencyKey: idempotencyKey,
//           }
//         )
//         .then(
//           (result: any) => {
//             const accountId = result.id
//             if (data.personToken) {
//               const personToken = data.personToken
//               stripe.accounts
//                 .createPerson(accountId, {
//                   person_token: personToken,
//                 })
//                 .then(
//                   (result: any) => {
//                     const accountId = result.id
//                     return { accountId: accountId }
//                   },
//                   (error: any) => {
//                     stripeErrors(error)
//                   }
//                 )
//             }
//             return { accountId: accountId }
//           },
//           (error: any) => {
//             stripeErrors(error)
//           }
//         )
//     } else {
//       //
//       const email = data.email
//       const individual = data.individual
//       const tosAcceptance = data.tos_acceptance
//       await stripe.accounts
//         .create(
//           {
//             type: type, // 必須
//             country: country,
//             email: email,
//             business_type: 'individual', // 個人
//             business_profile: businessProfile,
//             external_accounts: { data: externalAccounts },
//             capabilities: capabilities,
//             individual: individual, // 本人確認情報
//             tos_acceptance: tosAcceptance, // 利用規約への同意
//             // individual: {
//             //   email: email,
//             // },
//             settings: {
//               payouts: {
//                 schedule: {
//                   interval: 'manual',
//                 },
//               },
//             },
//           },
//           {
//             idempotencyKey: idempotencyKey,
//           }
//         )
//         .then(
//           (result: any) => {
//             const accountId = result.id
//             return { accountId: accountId }
//           },
//           (error: any) => {
//             stripeErrors(error)
//           }
//         )
//     }
//   })
// )

_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    console.log('connectAccountOnCreate')
    // // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    // Stripe ConnectAccount の登録済みでないか確認
    const user = await firebaseAdmin
      .auth()
      .getUser(getRequestingUserId(context))
    if (
      user.customClaims &&
      Object.hasOwnProperty.call(user.customClaims, 'accountId')
    ) {
      console.log('User is already connected to a stripe account. Exiting.')
      return
    }

    // parameters
    //  data.params // {name:"xxx",metadata:{order_id:"xxx"}} etc
    //  data.idempotencyKey // {idempotencyKey:"xxxx"}
    const params: Stripe.AccountCreateParams = data.params

    stripeOptions.idempotencyKey = uuidv4()

    const accountId = await stripe.accounts.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.Account>) => {
        console.log(result)
        const accountId = result.id
        console.log(accountId)
        return { accountId: accountId }
      },
      (error: any) => {
        stripeErrors(error)
        throw new functions.https.HttpsError('unknown', error)
      }
    )

    const uid = getRequestingUserId(context)
    // Authenticationの認証で利用するユーザー属性に独自の情報(stripe)を追加
    await firebaseAdmin
      .auth()
      .setCustomUserClaims(uid, { connectAccountId: accountId })

    // stripe_stripe_connect_account collection への登録
    await db.collection(config.connectAccountsCollectionPath).doc(uid).set({
      account_id: accountId,
    })

    return { accountId: accountId }
  })
)

// MARK: ConnectAccountのretrieve
_exportFunction('onRetrieve', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    // parameters
    //  data.accountId // "xxx"
    //  data.idempotencyKey //{idempotencyKey:"xxxx"}

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.accounts.retrieve(data.accountId, stripeOptions).then(
      (result: Stripe.Response<Stripe.Account>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
        throw new functions.https.HttpsError('unknown', error)
      }
    )
  })
)

// ConnectAccountのupdate
_exportFunction('onUpdate', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    // parameters
    //  data.accountId // "xxx"
    //  data.params // {name:"xxx",metadata:{order_id:"xxx"}} etc
    //  data.idempotencyKey // {idempotencyKey:"xxxx"}
    const params: Stripe.AccountUpdateParams = data.params

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.accounts
      .update(data.accountId, params, stripeOptions)
      .then(
        (result: Stripe.Response<Stripe.Account>) => {
          return result
        },
        (error: any) => {
          stripeErrors(error)
        }
      )
  })
)

// MARK: stripeのConnectAccountを削除
_exportFunction('onDelete', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    // parameters
    //  data.accountId // "xxx"

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.accounts.del(data.accountId, stripeOptions).then(
      (result: Stripe.Response<Stripe.DeletedAccount>) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
        throw new functions.https.HttpsError('unknown', error)
      }
    )
  })
)

// ConnectAccountを検索
_exportFunction('onList', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    const params: Stripe.AccountListParams = {}

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.accounts.list(params, stripeOptions).then(
      (result: any) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
        throw new functions.https.HttpsError('unknown', error)
      }
    )
  })
)

// MARK: Account Links の登録(account_onboarding)
_exportFunction('onCreateAccountLink', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)

    // parameters
    //  data.params // {account: "xxx",refresh_url: "xxx",return_url: "xxx",type: "xxx"}
    const params: Stripe.AccountLinkCreateParams = {
      account: data.accountId,
      refresh_url: data.refreshUrl,
      return_url: data.returnUrl,
      type: 'account_onboarding',
    }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.accountLinks.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.AccountLink>) => {
        const accountUrl = result.url
        console.log(accountUrl)
        return { accountUrl: accountUrl }
      },
      (error: any) => {
        stripeErrors(error)
        throw new functions.https.HttpsError('unknown', error)
      }
    )
  })
)

// MARK: Account Links の更新(account_update)
_exportFunction('onUpdateAccountLink', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)
    //
    const accountId = await getStripeConnectAccountId(
      getRequestingUserId(context)
    )
    if (accountId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ConnectAccount ID'
      )
    }

    // parameters
    //  data.params // {account: "xxx",refresh_url: "xxx",return_url: "xxx",type: "xxx"}
    const params: Stripe.AccountLinkCreateParams = {
      account: data.accountId,
      refresh_url: data.refreshUrl,
      return_url: data.returnUrl,
      type: 'account_update',
    }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.accountLinks.create(params, stripeOptions).then(
      (result: Stripe.Response<Stripe.AccountLink>) => {
        const accountUrl = result.url
        console.log(accountUrl)
        return { accountUrl: accountUrl }
      },
      (error: any) => {
        stripeErrors(error)
        throw new functions.https.HttpsError('unknown', error)
      }
    )
  })
)

// MARK: 管理画面へのリンク
_exportFunction('onCreateLoginLink', () =>
  onCall(async (data, context) => {
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)
    //
    const accountId = await getStripeConnectAccountId(
      getRequestingUserId(context)
    )
    if (accountId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ConnectAccount ID'
      )
    }

    stripeOptions.idempotencyKey = uuidv4()

    return await stripe.accounts.createLoginLink(accountId, stripeOptions).then(
      (result: Stripe.Response<Stripe.LoginLink>) => {
        const loginUrl = result.url
        console.log(loginUrl)
        return { loginUrl: loginUrl }
      },
      (error: any) => {
        stripeErrors(error)
        throw new functions.https.HttpsError('unknown', error)
      }
    )
  })
)
