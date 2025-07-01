/* eslint-disable max-len */
// import { defineSecret } from 'firebase-functions/params'
// const stripeSecret = defineSecret('STRIPE_SECRET')
// const stripePublic = defineSecret('STRIPE_PUBLIC')
import { Stripe } from 'stripe'
// import { v4 as uuidv4 } from 'uuid'
// import { randomUUID } from 'crypto'

const apiVersion = '2023-10-16'
const typescript = true
const config: Stripe.StripeConfig = {
  apiVersion: apiVersion,
  typescript: typescript,
}

// export const stripe = new Stripe(process.env.STRIPE_SECRET as string, config)
// export const stripePK = new Stripe(process.env.STRIPE_PUBLIC as string, config)
// export const stripeWebhookEndpointSecret = process.env.STRIPE_EP as string
// 'whsec_owW3jdgvKyUrtu3ViDUy7hwuzKD4LPfD'

export const stripe = new Stripe(process.env.STRIPE_DEV_SK as string, config)
export const stripePK = new Stripe(process.env.STRIPE_DEV_PK as string, config)
export const stripeWebhookEndpointSecret = process.env.STRIPE_DEV_EP as string
// 'whsec_HHnv4X4J0h49YOoY515JuRHQrWS7lDXW'

export const stripeOptions: Stripe.RequestOptions = {
  // idempotencyKey: uuidv4(),
  // idempotencyKey: randomUUID(),
  apiVersion: apiVersion,
}

export const APPLICATION_FEE_PERCENT = 1.4 // 3.4

export const currency = 'JPY'

export const country = 'JP'

export const accountType = 'standard' // 'express'  'standard' 'custom'

export const capabilities = {
  card_payments: { requested: true },
  transfers: { requested: true },
}
