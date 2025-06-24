/* eslint-disable require-jsdoc */
const defaultPath = '/v/1'
// App
const usersCollectionPath = `${defaultPath}/users`
const publicUsersCollectionPath = `${defaultPath}/public_users`
const cartCollectionPath = '/cart'
const settlementCollectionPath = '/settlement'
// function cartsCollectionPath(uid: string) {
//   const path = `${usersCollectionPath}/${uid}/cart_items`
//   return path
// }
// const preOrdersCollectionPath = `${defaultPath}/pre_orders`
const ordersCollectionPath = `${defaultPath}/orders`
const ticketsCollectionPath = `${defaultPath}/tickets`
const assignmentCollectionPath = '/assignment'
const productsCollectionPath = `${defaultPath}/products`
const eventsCollectionPath = `${defaultPath}/events`
// Stripe
// customer
const customersCollectionPath = `${defaultPath}/stripe_customers`
const paymentMethodsCollectionPath = '/payment_methods'
const paymentsCollectionPath = '/payments'
// connectAccount
const connectAccountsCollectionPath = `${defaultPath}/stripe_connect_accounts`
const connectProductsCollectionPath = '/products'
// platform
const platformCollectionPath = `${defaultPath}/platform/spel1`
const webhookEventsCollectionPath = `${platformCollectionPath}/stripe_events`
const transfersCollectionPath = `${platformCollectionPath}/transfer`

export default {
  defaultPath: defaultPath,
  usersCollectionPath: usersCollectionPath,
  publicUsersCollectionPath: publicUsersCollectionPath,
  cartCollectionPath: cartCollectionPath,
  // preOrdersCollectionPath: preOrdersCollectionPath,
  ordersCollectionPath: ordersCollectionPath,
  settlementCollectionPath: settlementCollectionPath,
  ticketsCollectionPath: ticketsCollectionPath,
  assignmentCollectionPath: assignmentCollectionPath,
  productsCollectionPath: productsCollectionPath,
  eventsCollectionPath: eventsCollectionPath,
  webhookEventsCollectionPath: webhookEventsCollectionPath,
  customersCollectionPath: customersCollectionPath,
  paymentMethodsCollectionPath: paymentMethodsCollectionPath,
  paymentsCollectionPath: paymentsCollectionPath,
  connectAccountsCollectionPath: connectAccountsCollectionPath,
  transfersCollectionPath: transfersCollectionPath,
  connectProductsCollectionPath: connectProductsCollectionPath,
}
