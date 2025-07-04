import Stripe from 'stripe'
import { getStripe, stripeOptions, stripeErrors } from '../../payment/utils'
import { ErrorHandler } from '../../../utils/error_handler'
import { logger } from 'firebase-functions'

export const cloneCustomer = async (
  uid: string,
  customerId: string,
  accountId: string,
) => {
  logger.info('Customer creation requested', { customerId, accountId })

  const paymentMethods = await customerOfPaymentMethodList(customerId)
  logger.info('Customer payment methods list requested', { customerId })

  const paymentMethodId = await createPaymentMethod(
    customerId,
    accountId,
    paymentMethods.data[0].id,
  )
  logger.info('Payment method creation requested', { customerId, accountId })

  const customer = await createCustomer(customerId, accountId, paymentMethodId)
  logger.info('Customer retrieved successfully', { customerId: customer })

  return customer
}

const customerOfPaymentMethodList = async (customerId: string) => {
  logger.info('Customer payment methods list requested', { customerId })
  const params: Stripe.CustomerListPaymentMethodsParams = { type: 'card' }
  return await getStripe()
    .customers.listPaymentMethods(customerId, params, stripeOptions)
    .then(
      (result: any) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
        ErrorHandler.logError(error, error.stack, 'clone-customer.service.ts')
        const appEx = ErrorHandler.convertToAppException(
          error,
          'clone-customer.service.ts',
        )
        throw ErrorHandler.convertToHttpsError(appEx)
      },
    )
}

const createPaymentMethod = async (
  paymentMethods: string,
  customerId: string,
  accountId: string,
) => {
  logger.info('Payment method creation requested', { customerId, accountId })
  const params: Stripe.PaymentMethodCreateParams = {
    customer: customerId,
    payment_method: paymentMethods,
  }
  stripeOptions.idempotencyKey = `create_payment_method_${customerId}_${accountId}`
  stripeOptions.stripeAccount = accountId
  return await getStripe()
    .paymentMethods.create(params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.PaymentMethod>) => {
        return result.id
      },
      (error: any) => {
        stripeErrors(error)
        ErrorHandler.logError(error, error.stack, 'clone-customer.service.ts')
        const appEx = ErrorHandler.convertToAppException(
          error,
          'clone-customer.service.ts',
        )
        throw ErrorHandler.convertToHttpsError(appEx)
      },
    )
}

const createCustomer = async (
  customerId: string,
  accountId: string,
  paymentMethodId?: string,
) => {
  logger.info('Customer creation requested', { customerId, accountId })

  const email = await retrieveCustomer(customerId)

  const params: Stripe.CustomerCreateParams = {
    email: email,
  }
  if (paymentMethodId) {
    params.payment_method = paymentMethodId
    params.invoice_settings = { default_payment_method: paymentMethodId }
  }

  stripeOptions.idempotencyKey = `create_customer_${customerId}_${accountId}`
  stripeOptions.stripeAccount = accountId

  return await getStripe()
    .customers.create(params, stripeOptions)
    .then(
      (result: Stripe.Response<Stripe.Customer>) => {
        return result.id
      },
      (error: any) => {
        stripeErrors(error)
        ErrorHandler.logError(error, error.stack, 'clone-customer.service.ts')
        const appEx = ErrorHandler.convertToAppException(
          error,
          'clone-customer.service.ts',
        )
        throw ErrorHandler.convertToHttpsError(appEx)
      },
    )
}

const retrieveCustomer = async (customerId: string) => {
  logger.info('Customer retrieval requested', { customerId })
  const customer = await getStripe()
    .customers.retrieve(customerId)
    .then(
      (result: any) => {
        logger.info('Customer retrieved successfully', {
          customerId: result.id,
        })
        return result
      },
      (error: any) => {
        stripeErrors(error)
        ErrorHandler.logError(error, error.stack, 'clone-customer.service.ts')
        const appEx = ErrorHandler.convertToAppException(
          error,
          'clone-customer.service.ts',
        )
        throw ErrorHandler.convertToHttpsError(appEx)
      },
    )
  logger.info('Customer email retrieved', { email: customer.email })
  return customer.email
}
