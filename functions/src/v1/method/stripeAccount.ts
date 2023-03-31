import * as functions from 'firebase-functions'
import * as firebaseAdmin from 'firebase-admin'
import { v4 as uuidv4 } from 'uuid'

import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'

import {
  stripe,
  stripeOptions,
  country,
  accountType,
  // capabilities,
} from '../stripe/utils/stripe_config'
import stripeErrors from '../stripe/utils/stripe_error'
import Stripe from 'stripe'
import {
  db,
  checkAuth,
  getRequestingUserId,
  getUserRecord,
  getStripeConnectAccountId,
  getStripeCustomerId,
} from '../../utils/firebase_utils'
import config from '../firestore/utils/db_paths'

const _exportFunction = (name: string, f: () => any) =>
  exportFunction([P.v1, P.method, 'stripeAccount', name], exports, f)

// MARK: Account Links の登録(account_onboarding)or更新(account_update)
_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    console.log('createAccount')
    // 認証済みユーザーかどうかチェックする
    checkAuth(context)
    // uid取得
    const uid = getRequestingUserId(context)
    // Stripe ConnectAccount の登録済みでないか確認
    const user = await getUserRecord(uid)
    //
    if (
      user.customClaims &&
      Object.hasOwnProperty.call(user.customClaims, 'accountId')
    ) {
      //
      const accountId = await getStripeConnectAccountId(uid)
      if (accountId !== null) {
        // throw new functions.https.HttpsError('unknown', 'unknown error')
        // retrieve
        const retrieve = await retrieveAccount(accountId)
        if (retrieve.type === 'custom' && retrieve.detailsSubmitted) {
          // update
          return await updateAccountLink(accountId, data)
        } else {
          return await createAccountLink(accountId, data)
        }
      }
    }
    // create account
    const accountId = await createAccount(data)

    // Authenticationの認証で利用するユーザー属性に独自の情報(stripe)を追加
    const customerId = await getStripeCustomerId(uid)
    if (customerId === null) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'User has no Stripe ID'
      )
    }
    const customClaims = { customerId: customerId, accountId: accountId }
    await firebaseAdmin.auth().setCustomUserClaims(uid, customClaims)

    // stripe_connect_account collection への登録
    await db.collection(config.connectAccountsCollectionPath).doc(uid).set({
      account_id: accountId,
    })

    return await createAccountLink(accountId, data)
  })
)

const createAccount = async (data: any) => {
  console.log('createAccount')
  const params: Stripe.AccountCreateParams = {
    type: accountType,
    country: country,
    email: data.email,
    // capabilities: capabilities,
  }
  stripeOptions.idempotencyKey = uuidv4()
  return await stripe.accounts.create(params, stripeOptions).then(
    (result: Stripe.Response<Stripe.Account>) => {
      console.log(result)
      return result.id
    },
    (error: any) => {
      stripeErrors(error)
      throw new functions.https.HttpsError('unknown', error)
    }
  )
}

const retrieveAccount = async (accountId: string) => {
  console.log('retrieveAccount')
  stripeOptions.idempotencyKey = uuidv4()
  return await stripe.accounts.retrieve(accountId, stripeOptions).then(
    (result: Stripe.Response<Stripe.Account>) => {
      console.log(result)
      const type = result.type
      const detailsSubmitted = result.details_submitted
      const chargesEnabled = result.charges_enabled

      console.log(type)
      console.log(detailsSubmitted)
      console.log(chargesEnabled)

      return {
        type: type,
        detailsSubmitted: detailsSubmitted,
        chargesEnabled: chargesEnabled,
      }
    },
    (error: any) => {
      stripeErrors(error)
      throw new functions.https.HttpsError('unknown', error)
    }
  )
}

const createAccountLink = async (accountId: string, data: any) => {
  console.log('createAccountLink')
  const params: Stripe.AccountLinkCreateParams = {
    account: accountId,
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
}

const updateAccountLink = async (accountId: string, data: any) => {
  console.log('updateAccountLink')
  const params: Stripe.AccountLinkCreateParams = {
    account: accountId,
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
}
