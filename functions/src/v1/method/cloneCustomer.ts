import Stripe from 'stripe'
import { v4 as uuidv4 } from 'uuid'
import { stripe, stripeOptions } from '../stripe/utils/stripe_config'
import stripeErrors from '../stripe/utils/stripe_error'

//
export const cloneCustomer = async (
  uid: string,
  customerId: string,
  accountId: string
) => {
  console.log('copyCustomer')
  //
  const paymentMethods = await customerOfPaymentMethodList(customerId)
  console.log(paymentMethods)
  //
  const paymentMethodId = await createPaymentMethod(
    customerId,
    accountId,
    paymentMethods.data[0].id
  )
  console.log(paymentMethodId)
  //
  const customer = await createCustomer(customerId, accountId, paymentMethodId)
  console.log(customer)
  //
  return customer
}

const customerOfPaymentMethodList = async (customerId: string) => {
  console.log('customerListPaymentMethods')
  const params: Stripe.CustomerListPaymentMethodsParams = { type: 'card' }
  return await stripe.customers
    .listPaymentMethods(customerId, params, stripeOptions)
    .then(
      (result: any) => {
        return result
      },
      (error: any) => {
        stripeErrors(error)
        console.log('Stripe PaymentMethod List Error')
        throw new Error(error.message)
      }
    )
}

const createPaymentMethod = async (
  paymentMethods: string,
  customerId: string,
  accountId: string
) => {
  console.log('createPaymentMethod')
  const params: Stripe.PaymentMethodCreateParams = {
    customer: customerId,
    payment_method: paymentMethods,
  }
  stripeOptions.idempotencyKey = uuidv4()
  stripeOptions.stripeAccount = accountId
  return await stripe.paymentMethods.create(params, stripeOptions).then(
    (result: Stripe.Response<Stripe.PaymentMethod>) => {
      return result.id
    },
    (error: any) => {
      stripeErrors(error)
      console.log('Stripe PaymentMethod Create Error')
      throw new Error(error.message)
    }
  )
}

const createCustomer = async (
  customerId: string,
  accountId: string,
  paymentMethodId?: string
) => {
  console.log('createCustomer')
  //
  const email = await retrieveCustomer(customerId)
  //
  const params: Stripe.CustomerCreateParams = {
    email: email,
  }
  if (paymentMethodId) {
    params.payment_method = paymentMethodId
    params.invoice_settings = { default_payment_method: paymentMethodId }
  }
  //
  stripeOptions.idempotencyKey = uuidv4()
  stripeOptions.stripeAccount = accountId
  //
  return await stripe.customers.create(params, stripeOptions).then(
    (result: Stripe.Response<Stripe.Customer>) => {
      return result.id
    },
    (error: any) => {
      stripeErrors(error)
      console.log('Stripe Customer Create Error')
      throw new Error(error.message)
    }
  )
}

const retrieveCustomer = async (customerId: string) => {
  console.log('retrieveCustomer')
  stripeOptions.idempotencyKey = uuidv4()
  const customer = await stripe.customers.retrieve(customerId).then(
    (result: any) => {
      console.log(result)
      return result
    },
    (error: any) => {
      stripeErrors(error)
      console.log('Stripe Customer Create Error')
      throw new Error(error.message)
    }
  )
  console.log(customer.email)
  return customer.email
}
