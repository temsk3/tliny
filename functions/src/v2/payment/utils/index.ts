import * as crypto from 'crypto'

// Stripe Firestore utilities
export {
  createTransferDocument,
  createWebhookEventDocument,
  getUidFromStripeCustomerId,
  updateOderDocument,
  updatePaymentDocument,
} from './stripe_firestore'

// Stripe configuration
export {
  getStripe,
  stripeOptions,
  getStripeWebhookEndpointSecret,
  currency,
  APPLICATION_FEE_PERCENT,
} from './stripe_config'

// Stripe utilities
export * from './stripe_utils'

// Stripe error handling
export { default as stripeErrors } from './stripe_error'

// idempotencyKey生成用のユーティリティ関数
export const generateIdempotencyKey = (
  ...params: (string | number | boolean | undefined)[]
): string => {
  const keySource = params
    .filter((param) => param !== undefined)
    .map((param) => String(param))
    .join('_')

  return crypto.createHash('sha256').update(keySource).digest('hex')
}
