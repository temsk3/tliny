// import { defineSecret } from 'firebase-functions/params'
// const stripeSecret = defineSecret('STRIPE_SECRET')
// const stripePublic = defineSecret('STRIPE_PUBLIC')
import { Stripe } from 'stripe'
// import { v4 as uuidv4 } from 'uuid'
// import { randomUUID } from 'crypto'

const apiVersion = '2022-11-15'
const typescript = true
const config: Stripe.StripeConfig = {
  apiVersion: apiVersion,
  typescript: typescript,
}

export const stripe = new Stripe(process.env.STRIPE_SECRET as string, config)

// export const stripeSK = new Stripe(process.env.STRIPE_SECRET as string, config)

export const stripePK = new Stripe(process.env.STRIPE_PUBLIC as string, config)

export const stripeWebhookEndpointSecret =
  'whsec_752d0401134a9884035a683199dd64fb57ae7236fcfb0b8424d1d492f86e44c7'

export const stripeOptions: Stripe.RequestOptions = {
  // idempotencyKey: uuidv4(),
  // idempotencyKey: randomUUID(),
  apiVersion: apiVersion,
}

export const currency = 'JPY'

export const country = 'JP'

export const accountType = 'standard' // 'express'  'standard' 'custom'

export const capabilities = {
  card_payments: { requested: true },
  transfers: { requested: true },
}
