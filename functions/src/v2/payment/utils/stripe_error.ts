import Stripe from 'stripe'
import { logger } from '../../../utils/logger'

const stripeErrors = (error: any) => {
  if (error instanceof Stripe.errors.StripeError) {
    logger.error('Stripe Error', {
      message: error.message,
      code: error.code,
      type: error.type,
    })
  } else {
    logger.error('Non-Stripe Error', { error: error })
  }
}

export default stripeErrors
