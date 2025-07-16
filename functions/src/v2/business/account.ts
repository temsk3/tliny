import { onCall } from '../../utils/base_function'
import { getStripe, stripeOptions } from '../payment/utils/stripe_config'
import {
  checkAuth,
  getRequestingUserId,
  getUserRecord,
  getStripeConnectAccountId,
  getStripeCustomerId,
  db,
} from '../../utils/firebase_utils'
import * as firebaseAdmin from 'firebase-admin'
import Stripe from 'stripe'
import paths from '../firestore/utils/db_paths'

// Stripe Connect アカウントの作成または更新
const businessAccountOnCreate = onCall(async (request) => {
  checkAuth(request)
  const uid = getRequestingUserId(request)
  const accountType = (request.data as any).accountType || 'standard'
  const country = (request.data as any).country || 'JP'

  // 既存のStripe Connect アカウントを確認
  const user = await getUserRecord(uid)
  if (
    user.customClaims &&
    Object.prototype.hasOwnProperty.call(user.customClaims, 'accountId')
  ) {
    const accountId = await getStripeConnectAccountId(uid)
    if (!accountId) {
      throw new Error('accountId not found')
    }
    return { accountId }
  }

  // 新規アカウントを作成
  const params: Stripe.AccountCreateParams = {
    type: accountType as Stripe.AccountCreateParams.Type,
    country: country,
    email: (request.data as any).email,
    metadata: { uid },
    business_type: 'individual',
    business_profile: {
      url: 'https://web.tliny.jp',
      mcc: '5399',
      product_description: 'オンライン販売',
      support_email: (request.data as any).email,
    },
    individual: {
      email: (request.data as any).email,
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
  stripeOptions.idempotencyKey = `create_account_${uid}`
  const account = await getStripe().accounts.create(params, stripeOptions)
  const accountId = account.id

  // ユーザーのStripe Customer IDを取得
  const customerId = await getStripeCustomerId(uid)
  if (!customerId) {
    throw new Error('User has no Stripe ID')
  }

  // ユーザーのカスタムクレームを更新
  const customClaims = { customerId, accountId }
  await firebaseAdmin.auth().setCustomUserClaims(uid, customClaims)

  // Firestoreにアカウント情報を登録
  await db
    .collection(paths.connectAccountsCollectionPath)
    .doc(uid)
    .set(
      {
        account_id: accountId,
        status: 'unverified',
        chargesEnabled: false,
        payoutsEnabled: false,
        accountType: accountType,
        email: (request.data as any).email,
        createdAt: new Date(new Date().getTime()),
        updatedAt: new Date(new Date().getTime()),
      },
      { merge: true },
    )

  return { accountId }
})

export { businessAccountOnCreate as 'v2_business_account_onCreate' }
