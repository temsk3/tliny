// import * as firebaseAdmin from 'firebase-admin'
// import { db } from '../../utils/firebase_utils'
// import functions from '../../utils/base_function'
// import { exportFunction } from '../../utils/deploy'
// import * as P from '../../utils/function_paths'
// import triggerOnce from '../../utils/trigger_once'
// import paths from './utils/db_paths'
// import { Stripe } from 'stripe'
// import { stripe, stripeOptions } from '../stripe/utils/stripe_config'
// // import { error } from 'firebase-functions/logger'
// import stripeErrors from '../stripe/utils/stripe_error'

// const _exportFunction = (name: string, f: () => any): void =>
//   exportFunction([P.v1, P.firestore, 'user', name], exports, f)

// _exportFunction('onCreateStripeCustomer', () =>
//   functions()
//     .auth.user()
//     .onCreate(
//       // 冪等性の担保(eventIdの重複対策用function)
//       triggerOnce('createStripeCustomerNotification', async (user, context) => {
//         if (
//           user.customClaims &&
//           Object.hasOwnProperty.call(user.customClaims, 'customerId')
//         ) {
//           console.log(
//             'User is already connected to a stripe customer. Exiting.',
//           )
//           return
//         }
//         // stripe customer登録
//         const customer = await stripe.customers
//           .create(
//             {
//               name: user.displayName,
//               email: user.email,
//               phone: user.phoneNumber,
//               metadata: { uid: user.uid },
//             },
//             stripeOptions,
//           )
//           .then(
//             (result: Stripe.Response<Stripe.Customer>) => {
//               return result
//             },
//             (error: any) => {
//               stripeErrors(error)
//               throw new Error(error)
//             },
//           )
//         const intent = await stripe.setupIntents
//           .create(
//             {
//               customer: customer.id,
//             },
//             stripeOptions,
//           )
//           .then(
//             (result: Stripe.Response<Stripe.SetupIntent>) => {
//               return result
//             },
//             (error: any) => {
//               stripeErrors(error)
//               throw new Error(error)
//             },
//           )

//         // Authenticationの認証で利用するユーザー属性に独自の情報(stripe)を追加
//         await firebaseAdmin
//           .auth()
//           .setCustomUserClaims(user.uid, { customerId: customer.id })

//         // stripe_customers collection への登録
//         await db.collection(paths.customersCollectionPath).doc(user.uid).set({
//           customer_id: customer.id,
//           setup_secret: intent.client_secret,
//         })

//         //
//         let displayName: string | undefined = user.displayName
//         if (!displayName || !displayName.trim()) {
//           displayName = user.email?.substring(0, user.email.lastIndexOf('@'))
//         } else {
//           displayName = displayName.trim()
//         }
//         // users collection への登録
//         await db
//           .collection(paths.usersCollectionPath)
//           .doc(user.uid)
//           .set({
//             displayName: displayName,
//             name: displayName,
//             email: user.email,
//             phoneNumber: user.phoneNumber,
//             photoUrl: user.photoURL,
//             isActive: true,
//             createdAt: new Date(new Date().getTime()),
//           })

//         console.log(user, context)

//         // public_users への登録
//         await db
//           .collection(paths.publicUsersCollectionPath)
//           .doc(user.uid)
//           .set({
//             displayName: displayName,
//             createdAt: new Date(new Date().getTime()),
//           })
//         return
//       }),
//     ),
// )

// _exportFunction('onDeleteStripeCustomer', () =>
//   functions()
//     .auth.user()
//     .onDelete(
//       // async (user) => {
//       // 冪等性の担保(eventIdの重複対策用function)
//       triggerOnce('deleteStripeCustomerNotification', async (user, context) => {
//         // const dbRef = db
//         //   .collection(config.customersCollectionPath)
//         // const customer = (await dbRef.doc(user.uid).get()).data()
//         // if (customer) {
//         //   await stripe.customers.del(customer.customer_id)
//         //   // Delete the customers payments & payment methods in firestore.
//         //   const batch = db.batch()
//         //   const paymentsMethodsSnapshot = await dbRef
//         //     .doc(user.uid)
//         //     .collection('payment_methods')
//         //     .get()
//         //   paymentsMethodsSnapshot.forEach((snap) => batch.delete(snap.ref))
//         //   const paymentsSnapshot = await dbRef
//         //     .doc(user.uid)
//         //     .collection('payments')
//         //     .get()
//         //   paymentsSnapshot.forEach((snap) => batch.delete(snap.ref))

//         //   await batch.commit()

//         //   await dbRef.doc(user.uid).delete()
//         // }
//         await db
//           .collection(paths.usersCollectionPath)
//           .doc(user.uid)
//           // .set({ isActive: false }, { merge: true })
//           .delete()

//         console.log(user, context)

//         return
//       }),
//     ),
// )
