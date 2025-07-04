import * as functions from 'firebase-functions'
import * as firebaseAdmin from 'firebase-admin'
import Stripe from 'stripe'
import { onCall } from '../../utils/base_function'
import { exportFunction } from '../../utils/deploy'
import * as P from '../../utils/function_paths'
import { logger } from 'firebase-functions'
import { ErrorHandler } from '../../utils/error_handler'

import { getStripe, stripeOptions } from '../payment/utils/stripe_config'
import stripeErrors from '../payment/utils/stripe_error'
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
  exportFunction([P.v2, P.business, 'account', name], exports, f)

/**
 * Stripe Connect アカウントの作成または更新を行う
 */
_exportFunction('onCreate', () =>
  onCall(async (request) => {
    logger.info('createAccount')
    checkAuth(request)
    const uid = getRequestingUserId(request)
    const accountType = request.data.accountType || 'standard'
    const country = request.data.country || 'JP'

    // 既存のStripe Connect アカウントを確認
    const user = await getUserRecord(uid)
    if (
      user.customClaims &&
      Object.prototype.hasOwnProperty.call(user.customClaims, 'accountId')
    ) {
      const accountId = await getStripeConnectAccountId(uid)
      if (!accountId) {
        throw new functions.https.HttpsError('not-found', 'accountId not found')
      }
      const retrievedAccount = await retrieveAccount(accountId)
      if (
        retrievedAccount.type === accountType &&
        retrievedAccount.detailsSubmitted
      ) {
        // アカウントを更新
        return await updateAccountLink(accountId, request.data)
      } else {
        // 新規アカウントリンクを作成
        return await createAccountLink(accountId, request.data)
      }
    }

    // 新規アカウントを作成
    const accountId = await createAccount(
      request.data,
      uid,
      accountType,
      country,
    )

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
        accountType: accountType,
        email: request.data.email,
        createdAt: new Date(new Date().getTime()),
        updatedAt: new Date(new Date().getTime()),
      })

    // 新規アカウントリンクを作成
    return await createAccountLink(accountId, request.data)
  }),
)

/**
 * Stripe Connect アカウントを作成する
 * @param {any}data - リクエストデータ
 * @param {string}uid - ユーザーID
 * @param {string}accountType - アカウントタイプ
 * @param {string}country - 国
 * @return {string}作成されたアカウントID
 */
const createAccount = async (
  data: any,
  uid: string,
  accountType: string,
  country: string,
): Promise<string> => {
  logger.info('createAccount')
  const params: Stripe.AccountCreateParams = {
    type: accountType as Stripe.AccountCreateParams.Type,
    country: country,
    email: data.email,
    metadata: { uid },
    business_type: 'individual',
    business_profile: {
      url: 'https://tliny-sample.spel1.com',
      mcc: '5399',
      product_description: 'オンライン販売プラットフォーム',
      support_email: data.email,
    },
    individual: {
      email: data.email,
    },
    capabilities: {
      card_payments: { requested: true },
      transfers: { requested: true },
      jcb_payments: { requested: true },
    },
    settings: {
      payouts: {
        schedule: {
          interval: 'manual',
        },
      },
    },
  }

  logger.info('Creating Stripe Connect account with params:', { params })
  logger.info('=== Account Creation Parameters ===')
  logger.info('Type:', { type: params.type })
  logger.info('Country:', { country: params.country })
  logger.info('Email:', { email: params.email })
  logger.info('Business Type:', { businessType: params.business_type })
  logger.info('Capabilities:', {
    capabilities: JSON.stringify(params.capabilities, null, 2),
  })
  logger.info('Settings:', {
    settings: JSON.stringify(params.settings, null, 2),
  })
  logger.info('===================================')

  try {
    // 冪等性キーを生成
    stripeOptions.idempotencyKey = `create_account_${uid}`
    logger.info('Using idempotency key:', {
      idempotencyKey: stripeOptions.idempotencyKey,
    })

    // Stripe Connect アカウントを作成
    const account = await getStripe()
      .accounts.create(params, stripeOptions)
      .catch((error: any) => {
        logger.error('Stripe account creation error:', { error })
        stripeErrors(error)
        throw new Error('account creation failed')
      })

    const accountId = account.id
    logger.info('Stripe Connect account created:', { accountId })

    // 作成されたアカウントの詳細ログを出力
    logger.info('=== Created Account Details ===')
    logger.info('Account ID:', { accountId: account.id })
    logger.info('Account Type:', { accountType: account.type })
    logger.info('Business Type:', { businessType: account.business_type })
    logger.info('Country:', { country: account.country })
    logger.info('Charges Enabled:', { chargesEnabled: account.charges_enabled })
    logger.info('Payouts Enabled:', { payoutsEnabled: account.payouts_enabled })
    logger.info('Details Submitted:', {
      detailsSubmitted: account.details_submitted,
    })
    logger.info('Requested Type:', { requestedType: accountType })
    logger.info('================================')

    // アカウントタイプの確認
    if (account.type !== accountType) {
      logger.warn(
        `WARNING: Requested type was '${accountType}' but created type is '${account.type}'`,
      )
    } else {
      logger.info(
        `SUCCESS: Account created with correct type '${account.type}'`,
      )
    }

    // アカウント作成後にEmail receipts設定を有効化
    try {
      await getStripe().accounts.update(
        accountId,
        {
          settings: {
            payouts: {
              schedule: {
                interval: 'manual',
              },
            },
          },
        },
        stripeOptions,
      )
      logger.info('Email receipts setting updated successfully')
    } catch (error: any) {
      logger.error('Failed to update email receipts setting:', { error })
    }

    return accountId
  } catch (error: unknown) {
    ErrorHandler.logError(
      error,
      error instanceof Error ? error.stack : undefined,
      'account.ts',
    )
    const appEx = ErrorHandler.convertToAppException(error, 'account.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * Stripe Connect アカウントを取得する
 * @param {string}accountId - アカウントID
 * @return {Promise<{type: string, detailsSubmitted: boolean, chargesEnabled: boolean, payoutsEnabled: boolean}>}
 */
const retrieveAccount = async (
  accountId: string,
): Promise<{
  type: string
  detailsSubmitted: boolean
  chargesEnabled: boolean
  payoutsEnabled: boolean
}> => {
  try {
    const account = await getStripe().accounts.retrieve(
      accountId,
      stripeOptions,
    )
    return {
      type: account.type,
      detailsSubmitted: account.details_submitted,
      chargesEnabled: account.charges_enabled,
      payoutsEnabled: account.payouts_enabled,
    }
  } catch (error) {
    logger.error('Failed to retrieve account:', { error })
    throw error
  }
}

/**
 * Stripe Connect アカウントリンクを作成する
 * @param {string}accountId - アカウントID
 * @param {any}data - リクエストデータ
 * @return {Promise<{accountUrl: string}>}
 */
const createAccountLink = async (
  accountId: string,
  data: any,
): Promise<{ accountUrl: string }> => {
  try {
    const params: Stripe.AccountLinkCreateParams = {
      account: accountId,
      refresh_url: data.refreshUrl || 'https://tliny-sample.spel1.com/user',
      return_url: data.returnUrl || 'https://tliny-sample.spel1.com/user',
      type: 'account_onboarding',
    }

    stripeOptions.idempotencyKey = `create_account_link_${accountId}`
    const accountLink = await getStripe().accountLinks.create(
      params,
      stripeOptions,
    )
    return { accountUrl: accountLink.url }
  } catch (error) {
    logger.error('Failed to create account link:', { error })
    throw error
  }
}

/**
 * Stripe Connect アカウントリンクを更新する
 * @param {string}accountId - アカウントID
 * @param {any}data - リクエストデータ
 * @return {Promise<{accountUrl: string}>}
 */
const updateAccountLink = async (
  accountId: string,
  data: any,
): Promise<{ accountUrl: string }> => {
  try {
    const params: Stripe.AccountLinkCreateParams = {
      account: accountId,
      refresh_url: data.refreshUrl || 'https://tliny-sample.spel1.com/user',
      return_url: data.returnUrl || 'https://tliny-sample.spel1.com/user',
      type: 'account_update',
    }

    stripeOptions.idempotencyKey = `update_account_link_${accountId}`
    const accountLink = await getStripe().accountLinks.create(
      params,
      stripeOptions,
    )
    return { accountUrl: accountLink.url }
  } catch (error) {
    logger.error('Failed to update account link:', { error })
    throw error
  }
}

/**
 * アカウントステータスを更新する
 * @param {string|undefined}uid - ユーザーID
 * @param {string}accountId - アカウントID
 * @param {'unverified'|'pending'|'verified'}stripeStatus - Stripeステータス
 * @param {boolean}chargesEnabled - 課金有効フラグ
 * @param {boolean}payoutsEnabled - 支払い有効フラグ
 * @return {Promise<void>}
 */
export const updateAccountStatus = async (
  uid: string | undefined,
  accountId: string,
  stripeStatus: 'unverified' | 'pending' | 'verified',
  chargesEnabled: boolean,
  payoutsEnabled: boolean,
): Promise<void> => {
  try {
    if (!uid) {
      logger.error('UID is undefined, cannot update account status')
      return
    }

    await db
      .collection(paths.connectAccountsCollectionPath)
      .doc(uid)
      .update({
        status: stripeStatus,
        chargesEnabled: chargesEnabled,
        payoutsEnabled: payoutsEnabled,
        updatedAt: new Date(new Date().getTime()),
      })

    logger.info('Account status updated successfully:', {
      uid,
      accountId,
      stripeStatus,
      chargesEnabled,
      payoutsEnabled,
    })
  } catch (error) {
    logger.error('Failed to update account status:', { error })
    throw error
  }
}
