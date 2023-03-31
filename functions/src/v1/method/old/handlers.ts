/* eslint-disable require-jsdoc */
import * as firebaseAdmin from 'firebase-admin'
import * as functions from 'firebase-functions'
import {
  db,
  getRequestingUserId,
  getUserEmail,
} from '../../../utils/firebase_utils'
import {
  adminVisibilityForState,
  clientVisibilityForState,
  getStripeCustomerId,
  getStripeCustomerIdForUser,
  intentToStatus,
} from '../../stripe/utils/stripe_utils'
import { Stripe } from 'stripe'
import { stripe } from '../../stripe/utils/stripe_config'
import { UserRecord } from 'firebase-admin/auth'

export async function createSetupIntentHandler(
  data: any,
  context: functions.https.CallableContext
) {
  const customerId = await getStripeCustomerId(getRequestingUserId(context))
  if (customerId === null) {
    throw new functions.https.HttpsError(
      'failed-precondition',
      'User has no Stripe ID'
    )
  }
  const params: Stripe.SetupIntentCreateParams = {
    customer: customerId,
    usage: 'on_session',
  }

  if (data.paymentMethod) params.payment_method = data.paymentMethod
  if (data.returnUrl) params.return_url = data.returnUrl

  const setupIntent = await stripe.setupIntents.create(params)
  return { status: setupIntent.status, clientSecret: setupIntent.client_secret }
}

export async function confirmPaymentHandler(
  data: any,
  context: functions.https.CallableContext
) {
  console.log(data)
  const reservation = await db
    .collection('reservations')
    .doc(data.reservationId)
    .get()
  const paymentIntentId = reservation.get('paymentIntent')
  const paymentData: Stripe.PaymentIntentConfirmParams = {}
  paymentData.return_url = 'stripesdk://3ds.stripesdk.io'
  if ('paymentMethodId' in data)
    paymentData.payment_method = data.paymentMethodId
  // todo: confirm on client first
  const intent = await stripe.paymentIntents.confirm(
    paymentIntentId,
    paymentData
  )
  const status = intentToStatus(intent)
  await reservation.ref.update({
    state: status,
    visibleInApp: clientVisibilityForState(status),
    visibleInAdmin: adminVisibilityForState(status),
  })
  return { status: intent.status, clientSecret: intent.client_secret }
}

export async function getEphemeralKeyHandler(
  data: any,
  context: functions.https.CallableContext
) {
  const customerId = await getStripeCustomerId(getRequestingUserId(context))
  if (customerId === null) {
    throw new functions.https.HttpsError(
      'failed-precondition',
      'User has no Stripe ID'
    )
  }
  const apiVersion = data.stripeVersion
  if (apiVersion === undefined) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'stripe_version must be specified to create an ephemeral key'
    )
  }

  const key = await stripe.ephemeralKeys.create(
    { customer: customerId },
    { stripe_version: apiVersion }
  )
  return { key: key }
}

export async function createAutomaticPaymentIntentHandler(
  data: any,
  context: functions.https.CallableContext
) {
  const customerId = await getStripeCustomerId(getRequestingUserId(context))
  if (customerId === null) {
    throw new functions.https.HttpsError(
      'failed-precondition',
      'User has no Stripe ID'
    )
  }
  const amount = data.amount

  const intent = await stripe.paymentIntents.create({
    customer: customerId,
    amount: amount,
    currency: 'USD',
  })
  return { status: intent.status, clientSecret: intent.client_secret }
}

export async function createManualPaymentIntentHandler(
  data: any,
  context: functions.https.CallableContext
) {
  const customerId = await getStripeCustomerId(getRequestingUserId(context))
  if (customerId === null) {
    throw new functions.https.HttpsError(
      'failed-precondition',
      'User has no Stripe ID'
    )
  }
  const paymentMethod = data.paymentMethod
  const amount = data.amount
  const returnUrl = data.return_url
  // const userEmail = 'lars.dahl@gmail.com'

  const params: Stripe.PaymentIntentCreateParams = {
    customer: customerId,
    payment_method: paymentMethod,
    confirmation_method: 'manual',
    amount: amount,
    return_url: returnUrl,
    confirm: true,
    currency: 'USD',
    setup_future_usage: 'on_session',
  }
  const userEmail = await getUserEmail(getRequestingUserId(context))
  if (userEmail !== undefined) {
    params.receipt_email = userEmail
  }

  const intent = await stripe.paymentIntents.create(params)
  return {
    status: intent.status,
    clientSecret: intent.client_secret,
    nextAction: intent.next_action,
  }
}

export async function setupUserHandler(user: UserRecord) {
  if (
    user.customClaims &&
    Object.hasOwnProperty.call(user.customClaims, 'customerId')
  ) {
    console.log('User is already connected to a stripe customer. Exiting.')
    return
  }
  const customer = await stripe.customers.create({
    name: user.displayName,
    email: user.email,
    phone: user.phoneNumber,
    metadata: { uid: user.uid },
  })

  await firebaseAdmin
    .auth()
    .setCustomUserClaims(user.uid, { stripeId: customer.id })
  // TODO: use data from login provider
  return db.collection('users').doc(user.uid).set(
    {
      stripeId: customer.id,
      name: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
    },
    { merge: true }
  )
}

export async function cleanupUserHandler(user: UserRecord) {
  await db.collection('users').doc(user.uid).delete()
  const customerId = await getStripeCustomerIdForUser(user)
  if (customerId !== null) {
    await stripe.customers.del(customerId)
  } else {
    console.error(
      new Error(`Unable to find and delete stripe ID for user ${user.uid}.}`)
    )
  }
}
