import * as firebaseAdmin from 'firebase-admin'
import * as functions from 'firebase-functions'
import { HttpsFunction } from 'firebase-functions'
// import Stripe from 'stripe'
import { onCall } from '../../../utils/base_function'
import { exportFunction } from '../../../utils/deploy'
import {
  chunk,
  db,
  getRequestingUserId,
  getStripeConnectAccountId,
  getStripeCustomerId,
} from '../../../utils/firebase_utils'
import * as P from '../../../utils/function_paths'
import {
  currency,
  // stripe,
  // stripeOptions,
} from '../../stripe/utils/stripe_config'
// import stripeErrors from '../../stripe/utils/stripe_error'
import paths from '../../firestore/utils/db_paths'
import Document from '../../firestore/utils/document'
import * as Model from '../../firestore/utils/model'

const _exportFunction = (name: string, f: () => HttpsFunction) =>
  exportFunction([P.v1, P.firestore, 'order', name], exports, f)

_exportFunction('onCreatePreOrder', () =>
  onCall(async (data, context) => {
    try {
      // 支払い方法
      // const paymentMethodId = data.paymentMethodId
      // イベント
      const eventId = data.eventId

      // 販売者のStripeConnectAccountIdを確認
      const event = await db
        .collection(paths.eventsCollectionPath)
        .doc(eventId)
        .get()
        .then((s) => new Document<Model.Event>(s))
      const account = event.data.organizerId
      const accountId = await getStripeConnectAccountId(account)
      if (accountId === null) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ConnectAccount ID'
        )
      }

      // 認証済みユーザーか確認
      if (!context.auth || !context.auth.uid) {
        throw new functions.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
        )
      }

      // ユーザー情報の取得
      const userId: string = getRequestingUserId(context)
      const user = await db
        .collection(paths.usersCollectionPath)
        .doc(userId)
        .get()
        .then((s) => new Document<Model.User>(s))

      // ユーザーのstripe customer情報を取得
      const customerId = await getStripeCustomerId(userId)
      if (customerId === null) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'User has no Stripe ID'
        )
      }

      // ユーザーのサブコレクション`cart_items`から指定イベントの一覧を取得する
      const cartItems = await user.ref
        .collection(paths.cartCollectionPath)
        .where('eventId', '==', eventId)
        .get()
        .then((s) => s.docs.map((d) => new Document<Model.CartItem>(d)))

      // カートが空でないことを確認する
      if (cartItems.length === 0) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'Cart items must be one or more items.'
        )
      }
      // line_items
      const lineItems: Model.LineItem[] = []
      // 合計金額
      // const sumAmount: number[] = []
      // トランザクションを利用して、カートにいれた商品の在庫があり購入可能かを確認する
      await db.runTransaction(async (transaction) => {
        const promises = <any>[]
        for (const cartItem of cartItems) {
          promises.push(
            transaction
              .get(cartItem.data.productDocRef)
              .then((s) => new Document<Model.Product>(s))
              .then((product) => {
                if (cartItem.data.quantity <= product.data.stock) {
                  // 購入できるのが確認できたら、`Product`の在庫を減らす
                  transaction.update(product.ref, {
                    stock: product.data.stock - cartItem.data.quantity,
                  })
                  //
                  // sumAmount.push(cartItem.data.quantity * product.data.price)
                  //
                  const productData: Model.ProductData = {
                    name: product.data.name,
                    description: product.data.desc,
                    images: product.data.pictureURL,
                    meta_data: { product_id: product.data.id },
                  }
                  const priceData: Model.PriceData = {
                    unit_amount: product.data.price,
                    currency: currency,
                    product_data: productData,
                  }
                  const lineItem: Model.LineItem = {
                    price_data: priceData,
                    quantity: cartItem.data.quantity,
                  }
                  lineItems.push(lineItem)
                } else {
                  throw new functions.https.HttpsError(
                    'failed-precondition',
                    'There is less stock than the quantity to buy'
                  )
                }
              })
          )
        }
        return Promise.all(promises)
      })

      // 決済処理を記述する
      // const amount = sumAmount.reduce(function (a, x) {
      //   return a + x
      // }, 0)

      // orderIdを事前に取得し'transfer_group'に流用
      const orderRef = db.collection(paths.ordersCollectionPath).doc()
      const orderId = orderRef.id

      // const params: Stripe.PaymentIntentCreateParams = {
      //   amount: amount,
      //   currency: data.currency,
      //   payment_method: paymentMethodId,
      //   off_session: true,
      //   customer: customerId,
      //   receipt_email: user.data.email,
      //   transfer_group: orderId,
      //   on_behalf_of: accountId,
      //   confirm: true,
      //   metadata: { order_id: orderId, account_id: accountId },
      // }

      // const paymentIntentId = await stripe.paymentIntents
      //   .create(params, stripeOptions)
      //   .then(
      //     (result: Stripe.Response<Stripe.PaymentIntent>) => result.id,
      //     async (error: any) => {
      //       /**
      //        * PaymentIntentの作成などに失敗した場合、
      //        * 確保した在庫を解放する
      //        **/
      //       await db.runTransaction(async (transaction) => {
      //         const promises = []
      //         for (const cartItem of cartItems) {
      //           promises.push(
      //             transaction
      //               .get(cartItem.data.productDocRef)
      //               .then((s) => new Document<Model.Product>(s))
      //               .then((product) => {
      //                 // `Product`の在庫を増やす
      //                 transaction.update(product.ref, {
      //                   stock: product.data.stock + cartItem.data.quantity,
      //                 })
      //               })
      //           )
      //         }
      //         return Promise.all(promises)
      //       })

      //       stripeErrors(error)

      //       throw new functions.https.HttpsError(
      //         'failed-precondition',
      //         'Settlement process failed'
      //       )
      //     }
      //   )

      const products = await Promise.all(
        cartItems.map((c) =>
          c.data.productDocRef.get().then((s) => new Document<Model.Product>(s))
        )
      )

      // 注文情報を作成する
      // 購入日時と、購入した時点での商品の情報を配列として持たせる
      const order: Model.Order = {
        status: Model.OrderStatus.pre,
        userId: userId,
        // paymentIntentId: paymentIntentId,
        eventId: eventId,
        purchaseTime: firebaseAdmin.firestore.Timestamp.now(),
        createdAt: firebaseAdmin.firestore.Timestamp.now(),
        snapshotProducts: products.map((product) => {
          const quantity = cartItems.find(
            (c) => c.data.productDocRef.path === product.ref.path
          )?.data.quantity
          if (quantity === undefined) {
            throw new Error('Product not found!')
          }
          return {
            // cart情報
            productDocRef: product.ref,
            quantity: quantity,
            // 購入者
            userId: userId,
            userName: user.data.displayName,
            // 商品情報
            productId: product.ref.id,
            exchangeNumber: product.data.exchangeNumber,
            code: product.data.code,
            name: product.data.name,
            desc: product.data.desc,
            price: product.data.price,
            pictureURL: product.data.pictureURL,
            expirationFrom: product.data.expirationFrom,
            expirationTo: product.data.expirationTo,
            // 登録者
            register: product.data.register,
            // 開催者
            organizerDocRef: product.data.organizerDocRef,
            organizerId: product.data.organizerId,
            // イベント情報
            eventDocRef: product.data.eventDocRef,
            eventId: product.data.eventId,
            eventName: product.data.eventName,
            expirationLink: product.data.expirationLink,
            // Stripe
            priceId: product.data.priceId,
          }
        }),
      }
      await orderRef.set(order, { merge: true })
      // カートの中身を削除
      await Promise.all(cartItems.map((cartItem) => cartItem.ref.delete()))

      return {
        orderID: orderId,
        // paymentIntentId: paymentIntentId,
        lineItems: lineItems,
      }
    } catch (error: any) {
      console.log(error)
      throw new Error(error)
    }
  })
)

export const cancelOrder = async (orderId: string) => {
  try {
    // order情報の取得
    const order = await db
      .collection(paths.ordersCollectionPath)
      .doc(orderId)
      .get()
      .then((s) => new Document<Model.Order>(s))
    if (order.data.status !== Model.OrderStatus.pre) {
      throw new Error('already confirmed')
    }
    // orderの確定
    await order.ref.set(
      { status: 'cancel', cancelAt: firebaseAdmin.firestore.Timestamp.now() },
      { merge: true }
    )

    // 在庫の差し戻し
    const orderItems = order.data.snapshotProducts
    await db.runTransaction(async (transaction) => {
      const promises = []
      for (const orderItem of orderItems) {
        promises.push(
          transaction
            .get(orderItem.productDocRef)
            .then((s) => new Document<Model.Product>(s))
            .then((product) => {
              // `Product`の在庫を増やす
              transaction.update(product.ref, {
                stock: product.data.stock + orderItem.quantity,
              })
            })
        )
      }
      return Promise.all(promises)
    })

    // ユーザーの取得
    const userId = order.data.userId
    // カートに差し戻し
    sendBackCartItem(userId, orderItems)

    return
  } catch (error: any) {
    console.log(error)
    throw new Error(error)
  }
}

export const sendBackCartItem = async (
  userId: string,
  orderItems: Model.SnapshotProduct[]
) => {
  try {
    // ユーザーのサブコレクション`cart_items`のドキュメントレファレンスを取得する
    const cartDocRef = db
      .collection(paths.usersCollectionPath)
      .doc(userId)
      .collection(paths.cartCollectionPath)
      .doc()
    // カートに差し戻し
    for (const chunkedOrderItems of chunk(orderItems, 100)) {
      const batch = db.batch()
      chunkedOrderItems.forEach((orderItem) =>
        batch.create(cartDocRef, {
          productDocRef: orderItem.productDocRef,
          quantity: orderItem.quantity,
        })
      )
      await batch.commit()
    }
  } catch (error: any) {
    console.log(error)
    throw new Error(error)
  }
}
