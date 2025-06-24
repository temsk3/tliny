// import * as firebaseAdmin from 'firebase-admin'
import * as functions from 'firebase-functions'
import { Timestamp } from 'firebase-admin/firestore'
import Stripe from 'stripe'
import {
  chunk,
  db,
  getStripeConnectAccountId,
  getStripeCustomerId,
} from '../../utils/firebase_utils'
import { currency } from '../stripe/utils/stripe_config'
import paths from '../firestore/utils/db_paths'
import Document from '../firestore/utils/document'
import * as Model from '../firestore/utils/model'

/**
 * プレオーダーを作成する
 * @param {string}userId - ユーザーID
 * @param {string}eventId - イベントID
 * @return {Map}オーダーID、ラインアイテム、アカウントID、小計
 */
export const createPreOrder = async (
  userId: string,
  eventId: string,
): Promise<{
  orderID: string
  lineItems: Stripe.Checkout.SessionCreateParams.LineItem[]
  accountId: string
  subtotal: number
}> => {
  console.log('Checkout Pre order')
  try {
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
        'User has no Stripe ConnectAccount ID',
      )
    }

    // // ユーザー情報の取得
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
        'User has no Stripe ID',
      )
    }

    // ユーザーのサブコレクション`cart_items`から指定イベントの一覧を取得する
    const cartItems = await user.ref
      .collection(paths.cartCollectionPath)
      .where('programId', '==', eventId)
      .get()
      .then((s) => s.docs.map((d) => new Document<Model.CartItem>(d)))
    // console.log(cartItems)

    // カートが空でないことを確認する
    if (cartItems.length === 0) {
      throw new functions.https.HttpsError(
        'failed-precondition',
        'Cart items must be one or more items.',
      )
    }
    // line_items
    const lineItems: Stripe.Checkout.SessionCreateParams.LineItem[] = []
    let subtotal = 0
    // トランザクションを利用して、カートにいれた商品の在庫があり購入可能かを確認する
    await db.runTransaction(async (transaction) => {
      const promises: Promise<void>[] = []
      for (const cartItem of cartItems) {
        // console.log(cartItem)
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
                // LineItemsの作成
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
                subtotal = +product.data.price * cartItem.data.quantity
              } else {
                throw new functions.https.HttpsError(
                  'failed-precondition',
                  'There is less stock than the quantity to buy',
                )
              }
            }),
        )
      }
      return Promise.all(promises)
    })

    // 注文情報の作成
    const now = Timestamp.now()
    const products = await Promise.all(
      cartItems.map((c) =>
        c.data.productDocRef.get().then((s) => new Document<Model.Product>(s)),
      ),
    )

    // 購入日時と、購入した時点での商品の情報を配列として持たせる
    const order: Model.Order = {
      status: Model.OrderStatus.pre,
      userId: userId,
      // paymentIntentId: paymentIntentId,
      eventId: eventId,
      // purchaseTime: firebaseAdmin.firestore.Timestamp.now(),
      // createdAt: firebaseAdmin.firestore.Timestamp.now(),
      purchaseTime: now,
      createdAt: now,
      snapshotProducts: products.map((product) => {
        const quantity = cartItems.find(
          (c) => c.data.productDocRef.path === product.ref.path,
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
    // orderIdを'transfer_group'に流用
    const orderRef = db.collection(paths.ordersCollectionPath).doc()
    const orderId = orderRef.id
    await orderRef.set(order, { merge: true })
    // カートの中身を削除
    await Promise.all(cartItems.map((cartItem) => cartItem.ref.delete()))

    console.log('order===================================')
    console.log(orderId)
    console.log('lineItem================================')
    console.log(lineItems)
    console.log('accountId===============================')
    console.log(accountId)
    console.log('subtotal===============================')
    console.log(subtotal)
    return {
      orderID: orderId,
      lineItems: lineItems,
      accountId: accountId,
      subtotal: subtotal,
    }
  } catch (error: any) {
    console.log('========== プレオーダー処理に失敗===============')
    console.log(error)
    console.log('=========================')
    throw new Error(error)
  }
}

/**
 * 注文をキャンセルする
 * @param {string}orderId - キャンセルする注文のID
 */
export const cancelOrder = async (orderId: string) => {
  console.log('cancel order')
  try {
    console.log(orderId)
    // order情報の取得
    const order = await db
      .collection(paths.ordersCollectionPath)
      .doc(orderId)
      .get()
      .then((s) => new Document<Model.Order>(s))
    if (order.data.status === Model.OrderStatus.order) {
      throw new Error('already confirmed')
    } else if (order.data.status === Model.OrderStatus.cancel) {
      throw new Error('already canceled')
    }
    // orderの確定
    await order.ref.set(
      { status: 'cancel', cancelAt: Timestamp.now() },
      { merge: true },
    )

    // 在庫の差し戻し
    const orderItems = order.data.snapshotProducts
    await db.runTransaction(async (transaction) => {
      const promises: Promise<void>[] = []
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
            }),
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
    console.log('========== キャンセル処理に失敗===============')
    console.log(error)
    console.log('=========================')
    throw new Error(error)
  }
}

/**
 * カートに商品を戻す
 * @param {string}userId - ユーザーID
 * @param {Model.SnapshotProduct[]}orderItems - 戻す商品情報
 */
export const sendBackCartItem = async (
  userId: string,
  orderItems: Model.SnapshotProduct[],
): Promise<void> => {
  console.log('send back cart item')
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
          programId: orderItem.eventId,
          productId: orderItem.productId,
        }),
      )
      await batch.commit()
    }
  } catch (error: any) {
    console.log('========== カート差し戻し処理に失敗===============')
    console.log(error)
    console.log('=========================')
    throw new Error(error)
  }
}
