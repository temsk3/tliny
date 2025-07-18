import Stripe from 'stripe'
import { defineSecret } from 'firebase-functions/params'

export const currency = 'jpy'

// Firebase Functionsのシークレット定義
const stripeDevSk = defineSecret('STRIPE_SECRET')
const stripeWebhookEndpointSecret = defineSecret('STRIPE_EP')

// デバッグ用: シークレット定義の確認
console.log('Secret definitions debug:', {
  hasStripeDevSk: !!stripeDevSk,
  hasStripeWebhookEndpointSecret: !!stripeWebhookEndpointSecret,
})

let stripe: Stripe | null = null

/**
 * Stripeインスタンスを取得する
 * @return Stripeインスタンス
 * @throws Error STRIPE_SECRET secret is not set
 */
export function getStripe() {
  if (!stripe) {
    // エミュレータでは process.env から読む
    const key = process.env.STRIPE_SECRET || stripeDevSk.value()
    console.log('Stripe key check:', {
      hasProcessEnv: !!process.env.STRIPE_SECRET,
      hasSecret: !!stripeDevSk.value(),
      keyLength: key ? key.length : 0,
      keyPrefix: key ? key.substring(0, 10) + '...' : 'undefined',
    })
    if (!key) throw new Error('STRIPE_SECRET secret is not set')
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
  const processEnvValue = process.env.STRIPE_EP
  const secretValue = stripeWebhookEndpointSecret.value()

  console.log('getStripeWebhookEndpointSecret debug:', {
    hasProcessEnv: !!processEnvValue,
    hasSecretValue: !!secretValue,
    processEnvLength: processEnvValue ? processEnvValue.length : 0,
    secretValueLength: secretValue ? secretValue.length : 0,
    processEnvPrefix: processEnvValue
      ? processEnvValue.substring(0, 10) + '...'
      : 'undefined',
    secretValuePrefix: secretValue
      ? secretValue.substring(0, 10) + '...'
      : 'undefined',
    stripeWebhookEndpointSecretType: typeof stripeWebhookEndpointSecret,
    stripeWebhookEndpointSecretValueType:
      typeof stripeWebhookEndpointSecret.value,
  })

  // エラーハンドリングを追加
  try {
    const result = processEnvValue || secretValue
    console.log('getStripeWebhookEndpointSecret result:', {
      hasResult: !!result,
      resultLength: result ? result.length : 0,
      resultPrefix: result ? result.substring(0, 10) + '...' : 'undefined',
    })
    return result
  } catch (error) {
    console.error('getStripeWebhookEndpointSecret error:', error)
    return null
  }
}

export const country = 'JP'

export const accountType = 'standard' // 'express'  'standard' 'custom'

export const capabilities = {
  card_payments: { requested: true },
  transfers: { requested: true },
}
