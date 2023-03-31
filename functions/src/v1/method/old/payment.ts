import * as firebaseAdmin from 'firebase-admin'
import * as f from 'firebase-functions'
// import { Stripe } from 'stripe'

import { exportFunction } from '../../../utils/deploy'
import * as P from '../../../utils/function_paths'
import { onCall } from '../../../utils/base_function'

import Document from '../../firestore/utils/document'
import * as Model from '../../firestore/utils/model'
import paths from '../../firestore/utils/db_paths'
import { HttpsFunction } from 'firebase-functions'
// import authCheck from '../../utils/auth_check'

import { stripe, stripeOptions } from '../../stripe/utils/stripe_config'
import stripeErrors from '../../stripe/utils/stripe_error'
import { db } from '../../../utils/firebase_utils'
import Stripe from 'stripe'

const _exportFunction = (name: string, f: () => HttpsFunction) =>
  exportFunction([P.v1, P.method, 'payment', name], exports, f)

_exportFunction('onCreate', () =>
  onCall(async (data, context) => {
    try {
      // 認証済みユーザーかどうかチェックする
      // context = authCheck(context)
      if (!context.auth || !context.auth.uid) {
        throw new f.https.HttpsError(
          'unauthenticated',
          'User is not authenticated.'
        )
      }
      const userId: string = context.auth.uid
      // ユーザー情報の取得
      const user = await db
        .collection(paths.usersCollectionPath)
        .doc(userId)
        .get()
        .then((s) => new Document<Model.User>(s))
      // ユーザーのstripe情報を取得
      const stripeUser = await db
        .collection(paths.customersCollectionPath)
        .doc(userId)
        .get()
        .then((s) => new Document<Model.Customer>(s))

      // イベントごとに精算
      const eventId = data.eventId
      // ユーザーのサブコレクション`cart_items`の一覧を取得する
      const cartItems = await user.ref
        .collection(paths.cartCollectionPath)
        .where('eventId', '==', eventId)
        .get()
        .then((s) => s.docs.map((d) => new Document<Model.CartItem>(d)))

      // カートが空でないことを確認する
      if (cartItems.length === 0) {
        throw new f.https.HttpsError(
          'failed-precondition',
          'Cart items must be one or more items.'
        )
      }
      // line_items
      // const lineItems: Model.LineItem[] = []
      // 合計金額
      const sumAmount: number[] = []
      // トランザクションを利用して、カートにいれた商品の在庫があり購入可能かを確認する
      await db.runTransaction(async (transaction) => {
        const promises = []
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
                  sumAmount.push(cartItem.data.quantity * product.data.price)
                  //
                  // const lineItem: Model.LineItem = {
                  //   price: product.data.priceId,
                  //   quantity: cartItem.data.quantity,
                  // }
                  // lineItems.push(lineItem)
                } else {
                  throw new f.https.HttpsError(
                    'failed-precondition',
                    'There is less stock than the quantity to buy'
                  )
                }
              })
          )
        }
        return Promise.all(promises)
      })

      // orderIdを事前に取得し'transfer_group'に流用
      const orderRef = db.collection(paths.ordersCollectionPath).doc()
      await orderRef.create({ status: 'pre' })
      const orderId = orderRef.id

      // 決済処理を記述する
      const amount = sumAmount.reduce(function (a, x) {
        return a + x
      }, 0)
      // const sum = data.sum
      // const fee = Math.ceil(sum * 0.05)
      const paymentMethodId = data.paymentMethodId //
      const docSnapshot = await db
        .collection(paths.eventsCollectionPath)
        .doc(eventId)
        .get()
      const eventData = docSnapshot.data()
      if (eventData === undefined) {
        throw new Error('Event not found!')
      }
      const accountId = eventData.accountId

      /**
       * PaymentIntentを作成する。
       * payment_method_optionsを使って、支払い期限や明細表示などをカスタムする。
       */
      const params: Stripe.PaymentIntentCreateParams = {
        amount: amount,
        currency: data.currency,
        // payment_method_types: ['card'],
        payment_method: paymentMethodId,
        off_session: true,
        customer: stripeUser.data.customer_id,
        receipt_email: user.data.email,
        transfer_group: orderId,

        // application_fee_amount: fee,
        on_behalf_of: accountId,
        // transfer_data: {
        //   destination: accountId,
        // },
        confirm: true,
        metadata: { order_id: orderId, account_id: accountId },
      }

      const paymentIntentId = await stripe.paymentIntents
        .create(params, stripeOptions)
        .then(
          (result: Stripe.Response<Stripe.PaymentIntent>) => result.id,
          async (error: any) => {
            /**
             * PaymentIntentの作成などに失敗した場合、
             * 確保した在庫を解放する
             **/
            await db.runTransaction(async (transaction) => {
              const promises = []
              for (const cartItem of cartItems) {
                promises.push(
                  transaction
                    .get(cartItem.data.productDocRef)
                    .then((s) => new Document<Model.Product>(s))
                    .then((product) => {
                      // `Product`の在庫を増やす
                      transaction.update(product.ref, {
                        stock: product.data.stock + cartItem.data.quantity,
                      })
                    })
                )
              }
              return Promise.all(promises)
            })

            stripeErrors(error)

            throw new f.https.HttpsError(
              'failed-precondition',
              'Settlement process failed'
            )
          }
        )
      // const chargeId = paymentIntent.latest_charge
      // if (chargeId === undefined || chargeId === null) {
      //   throw new f.https.HttpsError(
      //     'failed-precondition',
      //     'Deposit process failed'
      //   )
      // }
      // const transfer = await stripe.transfers
      //   .create({
      //     amount: sum - fee,
      //     currency: 'jpy',
      //     source_transaction: chargeId as string,
      //     destination: accountId,
      //     transfer_group: orderId,
      //   })
      //   .then(
      //     (result) => result,
      //     (error) => {
      //       stripeErrors(error)

      //       throw new f.https.HttpsError(
      //         'failed-precondition',
      //         'Deposit process failed'
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
        paymentIntentId: paymentIntentId,
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
      // const orderRef = user.ref.collection().doc()
      // const orderRef = db
      //   .collection(paths.ordersCollectionPath)
      //   .doc()
      await orderRef.set(order, { merge: true })
      await Promise.all(cartItems.map((cartItem) => cartItem.ref.delete()))
      // // user 購入履歴
      // await user.ref
      //   .collection('orders')
      //   .doc(orderId)
      //   .set({ orderDocRef: orderRef.path }, { merge: true })
      // // event 販売履歴
      // await db
      //   .collection(paths.eventsCollectionPath)
      //   .doc(eventId)
      //   .collection('orders')
      //   .doc(orderId)
      //   .set({ orderDocRef: orderRef.path }, { merge: true })
      return {
        orderID: orderId,
        paymentIntentId: paymentIntentId,
        // lineItems: lineItems,
      }
    } catch (error: any) {
      console.log(error)
      throw new Error(error)
    }
  })
)
