import Stripe from 'stripe'
import { defineSecret } from 'firebase-functions/params'

export const currency = 'jpy'

// Firebase Functionsのシークレット定義
const stripeDevSk = defineSecret('STRIPE_DEV_SK')
const stripeWebhookEndpointSecret = defineSecret(
  'STRIPE_WEBHOOK_ENDPOINT_SECRET',
)

let stripe: Stripe | null = null

/**
 * Stripeインスタンスを取得する
 * @return Stripeインスタンス
 * @throws Error STRIPE_DEV_SK secret is not set
 */
export function getStripe() {
  if (!stripe) {
    const key = stripeDevSk.value()
    if (!key) throw new Error('STRIPE_DEV_SK secret is not set')
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

export const APPLICATION_FEE_PERCENT = 10 // 10%

// Webhook endpoint secret
export const getStripeWebhookEndpointSecret = () =>
  stripeWebhookEndpointSecret.value()

export const country = 'JP'

export const accountType = 'standard' // 'express'  'standard' 'custom'

export const capabilities = {
  card_payments: { requested: true },
  transfers: { requested: true },
}
