import Stripe from 'stripe'
import { defineSecret } from 'firebase-functions/params'

export const currency = 'jpy'

// Firebase Functionsのシークレット定義
const stripeDevSk = defineSecret('STRIPE_SECRET')
const stripeWebhookEndpointSecret = defineSecret('STRIPE_EP')

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
export const getStripeWebhookEndpointSecret = () =>
  process.env.STRIPE_EP || stripeWebhookEndpointSecret.value()

export const country = 'JP'

export const accountType = 'standard' // 'express'  'standard' 'custom'

export const capabilities = {
  card_payments: { requested: true },
  transfers: { requested: true },
}
