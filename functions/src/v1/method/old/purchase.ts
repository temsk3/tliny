// import * as firebaseAdmin from 'firebase-admin'
// import * as functions from 'firebase-functions'

// import { exportFunction } from '../../utils/deploy'
// import * as P from '../../utils/function_paths'

// import Document from './document'
// import * as Model from './model'

// const _exportFunction = (name: string, f: () => any) =>
//   exportFunction([P.v1, P.stripe, 'purchase', name], exports, f)

// const fucRegion = functions.region('asia-northeast1')
// // const db = firebaseAdmin.firestore();

// _exportFunction('purchase', () =>
//   fucRegion
//     .runWith({ memory: '1GB', timeoutSeconds: 240 })
//     .https.onCall(async (data, context) => {
//       try {
//         // 認証済みユーザーかどうかチェックする
//         if (!context.auth || !context.auth.uid) {
//           throw new functions.https.HttpsError(
//             'unauthenticated',
//             'User is not authenticated.'
//           )
//         }
//         const userId: string = context.auth.uid
//         // ユーザーの取得
//         const user = await firebaseAdmin
//           .firestore()
//           .collection('/v/1/users')
//           .doc(userId)
//           .get()
//           .then((s) => new Document<Model.User>(s))

//         // ユーザーのサブコレクション`cart_items`の一覧を取得する
//         const cartItems = await user.ref
//           .collection('cart_items')
//           .get()
//           .then((s) => s.docs.map((d) => new Document<Model.CartItem>(d)))

//         // カートが空でないことを確認する
//         if (cartItems.length === 0) {
//           throw new functions.https.HttpsError(
//             'failed-precondition',
//             'Cart items must be one or more items.'
//           )
//         }

//         // トランザクションを利用して、カートにいれた商品の在庫があり購入可能かを確認する
//         await firebaseAdmin.firestore().runTransaction(async (transaction) => {
//           const promises = []
//           for (const cartItem of cartItems) {
//             promises.push(
//               transaction
//                 .get(cartItem.data.product)
//                 .then((s) => new Document<Model.Product>(s))
//                 .then((product) => {
//                   if (cartItem.data.quantity <= product.data.stock) {
//                     // 購入できるのが確認できたら、`Product`の在庫を減らす
//                     transaction.update(product.ref, {
//                       stock: product.data.stock - cartItem.data.quantity,
//                     })
//                   } else {
//                     throw new functions.https.HttpsError(
//                       'failed-precondition',
//                       'There is less stock than the quantity to buy'
//                     )
//                   }
//                 })
//             )
//           }
//           return Promise.all(promises)
//         })

//         // 決済処理を記述する

//         const products = await Promise.all(
//           cartItems.map((c) =>
//             c.data.product.get().then((s) => new Document<Model.Product>(s))
//           )
//         )
//         // 注文情報を作成する
//         // 購入日時と、購入した時点での商品の情報を配列として持たせる
//         const order: Model.Order = {
//           purchaseTime: firebaseAdmin.firestore.Timestamp.now(),
//           createdAt: firebaseAdmin.firestore.Timestamp.now(),
//           snapshotProducts: products.map((product) => {
//             return {
//               // id: product.ref.id,
//               // name: product.data.name,
//               // desc: product.data.desc,
//               // price: product.data.price,
//               // owner: product.data.owner,
//               // imageURL: product.data.imageURL,
//               userId: userId,
//               customerId: user.data.customerId,
//               userName: user.data.displayName,
//               organizer: product.data.organizer,
//               bazaarId: product.data.bazaarId,
//               bazaarName: product.data.bazaarName,
//               register: product.data.register,
//               exchangeNumber: product.data.exchangeNumber,
//               productId: product.ref.id,
//               code: product.data.code,
//               name: product.data.name,
//               desc: product.data.desc,
//               price: product.data.price,
//               numberOfUse: cartItems.find(
//                 (c) => c.data.product.path === product.ref.path
//               )!.data.quantity,
//               quantity: cartItems.find(
//                 (c) => c.data.product.path === product.ref.path
//               )!.data.quantity,
//               sum:
//                 cartItems.find((c) => c.data.product.path === product.ref.path)!
//                   .data.quantity * product.data.price,
//               picture1URL: product.data.picture1URL,
//               expirationFrom: product.data.expirationFrom,
//               expirationTo: product.data.expirationTo,
//               isActive: true,
//             }
//           }),
//         }
//         const orderRef = user.ref.collection('orders').doc()
//         // const orderRef = firebaseAdmin.firestore().collection("orders").doc();
//         await orderRef.create(order)
//         await Promise.all(cartItems.map((cartItem) => cartItem.ref.delete()))
//         return { orderID: orderRef.id }
//       } catch (error) {
//         console.log(error)
//         throw error
//       }
//     })
// )
