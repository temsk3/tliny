// import * as functions from 'firebase-functions'
// import * as firebaseAdmin from 'firebase-admin'
// import { v4 as uuidv4 } from 'uuid'

// import { onCall } from '../../utils/base_function'
// import { exportFunction } from '../../utils/deploy'
// import * as P from '../../utils/function_paths'

// import {
//   stripe,
//   stripeOptions,
//   country,
//   accountType,
//   // capabilities,
// } from '../stripe/utils/stripe_config'
// import stripeErrors from '../stripe/utils/stripe_error'
// import Stripe from 'stripe'
// import {
//   db,
//   checkAuth,
//   getRequestingUserId,
//   getUserRecord,
//   getStripeConnectAccountId,
//   getStripeCustomerId,
// } from '../../utils/firebase_utils'
// import paths from '../firestore/utils/db_paths'

// const _exportFunction = (name: string, f: () => any) =>
//   exportFunction([P.v1, P.method, 'stripeAccount', name], exports, f)

// // MARK: Account Links の登録(account_onboarding)or更新(account_update)
// _exportFunction('onCreate', () =>
//   onCall(async (data, context) => {
//     console.log('createAccount')
//     // 認証済みユーザーかどうかチェックする
//     checkAuth(context)
//     // uid取得
//     const uid = getRequestingUserId(context)
//     // Stripe ConnectAccount の登録済みでないか確認
//     const user = await getUserRecord(uid)
//     //
//     if (
//       user.customClaims &&
//       Object.hasOwnProperty.call(user.customClaims, 'accountId')
//     ) {
//       //
//       const accountId = await getStripeConnectAccountId(uid)
//       if (accountId !== null) {
//         // throw new functions.https.HttpsError('unknown', 'unknown error')
//         // retrieve
//         const retrieve = await retrieveAccount(accountId)
//         if (retrieve.type === accountType && retrieve.detailsSubmitted) {
//           // update
//           return await updateAccountLink(accountId, data)
//         } else {
//           return await createAccountLink(accountId, data)
//         }
//       }
//     }
//     // create account
//     const accountId = await createAccount(data, uid)

//     // Authenticationの認証で利用するユーザー属性に独自の情報(stripe)を追加
//     const customerId = await getStripeCustomerId(uid)
//     if (customerId === null) {
//       throw new functions.https.HttpsError(
//         'failed-precondition',
//         'User has no Stripe ID',
//       )
//     }
//     const customClaims = { customerId: customerId, accountId: accountId }
//     await firebaseAdmin.auth().setCustomUserClaims(uid, customClaims)

//     // stripe_connect_account collection への登録
//     await db.collection(paths.connectAccountsCollectionPath).doc(uid).set({
//       account_id: accountId,
//       status: 'unverified',
//       chargesEnabled: false,
//     })

//     return await createAccountLink(accountId, data)
//   }),
// )

// const createAccount = async (data: any, uid: string) => {
//   console.log('createAccount')
//   const params: Stripe.AccountCreateParams = {
//     type: accountType,
//     country: country,
//     email: data.email,
//     // capabilities: capabilities,
//     metadata: { uid: uid },
//     business_type: 'individual',
//     business_profile: {
//       url: 'https://tliny-sample.spel1.com',
//       mcc: '5399',
//       product_description: 'gadgets',
//       support_email: data.email,
//     },
//     individual: {
//       email: data.email,
//     },
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
//     },
//   )
// }

// const retrieveAccount = async (accountId: string) => {
//   console.log('retrieveAccount')
//   stripeOptions.idempotencyKey = uuidv4()
//   return await stripe.accounts.retrieve(accountId, stripeOptions).then(
//     (result: Stripe.Response<Stripe.Account>) => {
//       console.log(result)
//       const type = result.type
//       const detailsSubmitted = result.details_submitted
//       const chargesEnabled = result.charges_enabled

//       console.log(type)
//       console.log(detailsSubmitted)
//       console.log(chargesEnabled)

//       return {
//         type: type,
//         detailsSubmitted: detailsSubmitted,
//         chargesEnabled: chargesEnabled,
//       }
//     },
//     (error: any) => {
//       stripeErrors(error)
//       throw new functions.https.HttpsError('unknown', error)
//     },
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
//     },
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
//     },
//   )
// }

// export const updateAccountStatus = async (
//   uid: string | undefined,
//   accountId: string,
//   stripeStatus: string,
//   chargesEnabled: boolean,
//   payoutsEnabled: boolean,
// ) => {
//   console.log('account status update')
//   try {
//     let userDoc
//     if (uid === undefined) {
//       const snap = await db
//         .collection(paths.connectAccountsCollectionPath)
//         .where('account_id', '==', accountId)
//         .get()
//       userDoc = snap.docs[0]
//     } else {
//       userDoc = await db
//         .collection(paths.connectAccountsCollectionPath)
//         .doc(uid)
//         .get()
//     }
//     await userDoc.ref.update({
//       status: stripeStatus,
//       chargesEnabled: chargesEnabled,
//       payoutsEnabled: payoutsEnabled,
//     })
//   } catch (error: any) {
//     console.log('========== Account Update 失敗===============')
//     console.log(error)
//     console.log('=========================')
//     throw new Error(error)
//   }
// }
import * as functions from 'firebase-functions'
import * as firebaseAdmin from 'firebase-admin'
import { v4 as uuidv4 } from 'uuid'
import Stripe from 'stripe'

import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

import {
  stripe,
  stripeOptions,
  country,
  accountType,
} from '../stripe/utils/stripe_config'
import stripeErrors from '../stripe/utils/stripe_error'
import {
  db,
  checkAuth,
  getRequestingUserId,
  getUserRecord,
  getStripeConnectAccountId,
  getStripeCustomerId,
} from '../../utils/firebase_utils'
import paths from '../firestore/utils/db_paths'

// ヘルパー関数：エクスポート用の関数を作成
const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.method, 'stripeAccount', name], exports, f)

// ヘルパー関数：エラー処理をまとめる
const handleError = (error: any, message = 'An unknown error occurred.') => {
  console.error(message, error)
  stripeErrors(error)
  // throw new functions.https.HttpsError('unknown', message)
}

/**
 * Stripe Connect アカウントの作成または更新を行う
 */
_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    console.log('createAccount')
    // 認証済みユーザーかどうかをチェック
    checkAuth(context)
    // ユーザーIDを取得
    const uid = getRequestingUserId(context)

    try {
      // 既存のStripe Connect アカウントを確認
      const user = await getUserRecord(uid)
      if (
        user.customClaims &&
        Object.prototype.hasOwnProperty.call(user.customClaims, 'accountId')
      ) {
        const accountId = await getStripeConnectAccountId(uid)
        if (!accountId) {
          throw new functions.https.HttpsError(
            'not-found',
            'accountId not found',
          )
        }
        const retrievedAccount = await retrieveAccount(accountId)
        if (
          retrievedAccount.type === accountType &&
          retrievedAccount.detailsSubmitted
        ) {
          // アカウントを更新
          return await updateAccountLink(accountId, data)
        } else {
          // 新規アカウントリンクを作成
          return await createAccountLink(accountId, data)
        }
      }

      // 新規アカウントを作成
      const accountId = await createAccount(data, uid)

      // ユーザーのStripe Customer IDを取得
      const customerId = await getStripeCustomerId(uid)
      if (!customerId) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID',
        )
      }

      // ユーザーのカスタムクレームを更新
      const customClaims = { customerId, accountId }
      await firebaseAdmin.auth().setCustomUserClaims(uid, customClaims)

      // Firestoreにアカウント情報を登録
      await db
        .collection(paths.connectAccountsCollectionPath)
        .doc(uid)
        .set({
          account_id: accountId,
          status: 'unverified',
          chargesEnabled: false,
          payoutsEnabled: false,
          createdAt: new Date(new Date().getTime()),
        })

      // 新規アカウントリンクを作成
      return await createAccountLink(accountId, data)
    } catch (error) {
      handleError(error, 'Failed to create or update Stripe account.')
    }
  }),
)

/**
 * Stripe Connect アカウントを作成する
 * @param {any}data - リクエストデータ
 * @param {string}uid - ユーザーID
 * @return {string}作成されたアカウントID
 */
const createAccount = async (data: any, uid: string): Promise<string> => {
  console.log('createAccount')
  const params: Stripe.AccountCreateParams = {
    type: accountType,
    country: country,
    email: data.email,
    metadata: { uid },
    business_type: 'individual',
    business_profile: {
      url: 'https://tliny-sample.spel1.com',
      mcc: '5399',
      product_description: 'gadgets',
      support_email: data.email,
    },
    individual: {
      email: data.email,
    },
  }
  stripeOptions.idempotencyKey = uuidv4()
  try {
    const account = await stripe.accounts.create(params, stripeOptions)
    return account.id
  } catch (error) {
    handleError(error, 'Failed to create Stripe account.')
    throw new Error('Failed to create Stripe account.')
  }
}

/**
 * Stripe Connect アカウントの詳細情報を取得する
 * @param {string}accountId - Stripe Connect アカウントID
 * @return {Map}アカウントの詳細情報
 */
const retrieveAccount = async (
  accountId: string,
): Promise<{
  type: string
  detailsSubmitted: boolean
  chargesEnabled: boolean
  payoutsEnabled: boolean
}> => {
  console.log('retrieveAccount')
  stripeOptions.idempotencyKey = uuidv4()
  try {
    const account = await stripe.accounts.retrieve(accountId, stripeOptions)
    return {
      type: account.type,
      detailsSubmitted: account.details_submitted,
      chargesEnabled: account.charges_enabled,
      payoutsEnabled: account.payouts_enabled,
    }
  } catch (error) {
    handleError(error, 'Failed to retrieve Stripe account.')
    throw new Error('Failed to retrieve Stripe account.')
  }
}

/**
 * Stripe Account Link を作成する (新規登録用)
 * @param {string}accountId - Stripe Connect アカウントID
 * @param {any}data - リクエストデータ
 * @return {Map}Account Link の URL
 */
const createAccountLink = async (
  accountId: string,
  data: any,
): Promise<{ accountUrl: string }> => {
  console.log('createAccountLink')
  const params: Stripe.AccountLinkCreateParams = {
    account: accountId,
    refresh_url: data.refreshUrl,
    return_url: data.returnUrl,
    type: 'account_onboarding',
  }
  stripeOptions.idempotencyKey = uuidv4()
  try {
    const accountLink = await stripe.accountLinks.create(params, stripeOptions)
    return { accountUrl: accountLink.url }
  } catch (error) {
    handleError(error, 'Failed to create Stripe account link.')
    throw new Error('Failed to create Stripe account link.')
  }
}

/**
 * Stripe Account Link を作成する (更新用)
 * @param {string}accountId - Stripe Connect アカウントID
 * @param {any}data - リクエストデータ
 * @return {Map}Account Link の URL
 */
const updateAccountLink = async (
  accountId: string,
  data: any,
): Promise<{ accountUrl: string }> => {
  console.log('updateAccountLink')
  const params: Stripe.AccountLinkCreateParams = {
    account: accountId,
    refresh_url: data.refreshUrl,
    return_url: data.returnUrl,
    type: 'account_update',
  }
  stripeOptions.idempotencyKey = uuidv4()
  try {
    const accountLink = await stripe.accountLinks.create(params, stripeOptions)
    return { accountUrl: accountLink.url }
  } catch (error) {
    handleError(error, 'Failed to update Stripe account link.')
    throw new Error('Failed to update Stripe account link.')
  }
}

/**
 * Stripe Connect アカウントの状態を更新する
 * @param {string}uid - ユーザーID
 * @param {string}accountId - Stripe Connect アカウントID
 * @param {'unverified' | 'pending' | 'verified'}stripeStatus - Stripe のアカウントステータス
 * @param {boolean}chargesEnabled - 決済が有効かどうか
 * @param {boolean}payoutsEnabled - 払い出しが有効かどうか
 */
export const updateAccountStatus = async (
  uid: string | undefined,
  accountId: string,
  stripeStatus: 'unverified' | 'pending' | 'verified',
  chargesEnabled: boolean,
  payoutsEnabled: boolean,
): Promise<void> => {
  console.log('account status update')
  try {
    let userDoc
    if (uid === undefined) {
      const snap = await db
        .collection(paths.connectAccountsCollectionPath)
        .where('account_id', '==', accountId)
        .get()
      if (snap.empty) {
        throw new Error('account not found')
      }
      userDoc = snap.docs[0]
    } else {
      userDoc = await db
        .collection(paths.connectAccountsCollectionPath)
        .doc(uid)
        .get()
    }
    await userDoc.ref.update({
      status: stripeStatus,
      chargesEnabled,
      payoutsEnabled,
      updatedAt: new Date(new Date().getTime()),
    })
  } catch (error) {
    console.error('Failed to update account status', error)
    throw new Error('Failed to update account status')
  }
}
