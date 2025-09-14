import Stripe from 'stripe'
import { defineSecret } from 'firebase-functions/params'

export const currency = 'jpy'

// Firebase Functionsのシークレット定義
export const stripeSecret = defineSecret('STRIPE_SECRET')
export const stripeEpSecret = defineSecret('STRIPE_EP')
export const stripeDevSk = defineSecret('STRIPE_DEV_SK')
export const stripeDevEp = defineSecret('STRIPE_DEV_EP')

// デバッグ用: シークレット定義の確認
console.log('Secret definitions debug:', {
  hasStripeSecret: !!stripeSecret,
  hasStripeEpSecret: !!stripeEpSecret,
  hasStripeDevSk: !!stripeDevSk,
  hasStripeDevEp: !!stripeDevEp,
})

let stripe: Stripe | null = null

/**
 * Stripeインスタンスを取得する
 * @return Stripeインスタンス
 * @throws Error STRIPE_SECRET secret is not set
 */
export function getStripe() {
  if (!stripe) {
    const projectId = getProjectId()
    let key: string | undefined
    const processEnvDevSk = process.env.STRIPE_DEV_SK
    const secretDevSk = stripeDevSk.value()
    if (projectId === 'tliny-c9630') {
      key = process.env.STRIPE_SECRET || stripeSecret.value()
    } else {
      // tliny-sample またはデフォルト
      key = processEnvDevSk || secretDevSk
    }
    console.log('Stripe key check (detailed):', {
      projectId,
      processEnvDevSk: processEnvDevSk
        ? processEnvDevSk.substring(0, 10) + '...'
        : 'undefined',
      secretDevSk: secretDevSk
        ? secretDevSk.substring(0, 10) + '...'
        : 'undefined',
      keyLength: key ? key.length : 0,
      keyPrefix: key ? key.substring(0, 10) + '...' : 'undefined',
      hasProcessEnv: !!processEnvDevSk,
      hasSecret: !!secretDevSk,
    })
    if (!key) throw new Error('Stripe secret key is not set')
    stripe = new Stripe(key, { apiVersion: '2025-06-30.basil' })
  }
  return stripe
}

export const stripeOptions: Stripe.StripeConfig & {
  idempotencyKey?: string
  stripeAccount?: string
} = {
  apiVersion: '2025-06-30.basil',
}

export const APPLICATION_FEE_PERCENT = 1.3 // 10%

// Webhook endpoint secret
export const getStripeWebhookEndpointSecret = () => {
  const projectId = getProjectId()
  let result: string | undefined
  if (projectId === 'tliny-c9630') {
    result = process.env.STRIPE_EP || stripeEpSecret.value()
  } else {
    // tliny-sample またはデフォルト
    result = process.env.STRIPE_DEV_EP || stripeDevEp.value()
  }
  console.log('getStripeWebhookEndpointSecret result:', {
    projectId,
    resultLength: result ? result.length : 0,
    resultPrefix: result ? result.substring(0, 10) + '...' : 'undefined',
  })
  return result
}

export const country = 'JP'

export const accountType = 'standard' // 'express'  'standard' 'custom'

export const capabilities = {
  card_payments: { requested: true },
  transfers: { requested: true },
}

// アカウントリンクの設定
export const ACCOUNT_LINK_CONFIG = {
  // デフォルトで account_onboarding を使用するかどうか
  // true: より保守的、false: より積極的に account_update を試行
  DEFAULT_TO_ONBOARDING: true,

  // account_update を試行するための厳密な条件
  REQUIRE_FULL_ONBOARDING: true,

  // エラー時のフォールバック設定
  FALLBACK_TO_ONBOARDING_ON_ERROR: true,
}

function getProjectId() {
  // GCP/FirebaseのプロジェクトIDは環境変数で取得可能
  return (
    process.env.GCLOUD_PROJECT ||
    process.env.GCP_PROJECT ||
    process.env.FUNCTIONS_EMULATOR_PROJECT_ID ||
    (process.env.FIREBASE_CONFIG &&
      (() => {
        try {
          return JSON.parse(process.env.FIREBASE_CONFIG).projectId
        } catch {
          return undefined
        }
      })()) ||
    undefined
  )
}
