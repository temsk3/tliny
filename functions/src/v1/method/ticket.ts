import { chunk, db } from '../../utils/firebase_utils'
import paths from '../firestore/utils/db_paths'
import Document from '../firestore/utils/document'
import * as Model from '../firestore/utils/model'
// import functions from '../../utils/base_function'
// import triggerOnce from '../../utils/trigger_once'
// import { exportFunction } from '../../utils/deploy'
// import * as P from '../../utils/function_paths'

export const createTicketDocument = async (orderId: string) => {
  console.log('create ticket')
  try {
    console.log(orderId)
    // order情報の取得
    const order = await db
      .collection(paths.ordersCollectionPath)
      .doc(orderId)
      .get()
      .then((s) => new Document<Model.Order>(s))
    console.log(order)
    // order status の確認
    if (order.data.status !== 'pre') {
      console.log('check order status: ' + order.data.status)
      return
    }
    // orderの確定
    await order.ref.set({ status: 'order' }, { merge: true })

    // user 購入履歴
    // ユーザー情報の取得
    const userId = order.data.userId
    const user = await db
      .collection(paths.usersCollectionPath)
      .doc(userId)
      .get()
      .then((s) => new Document<Model.User>(s))
    await user.ref
      .collection('orders')
      .doc(orderId)
      .set({ orderDocRef: order.ref.path }, { merge: true })
    // event 販売履歴
    const eventId = order.data.eventId
    const eventDocRef = db.collection(paths.eventsCollectionPath).doc(eventId)
    await eventDocRef
      .collection('orders')
      .doc(orderId)
      .set({ orderDocRef: order.ref.path }, { merge: true })

    // 発券
    const ticketDocRef = db
      // .collection(paths.usersCollectionPath)
      // .doc(userId)
      .collection(paths.ticketsCollectionPath)
    // .doc()
    const products = order.data.snapshotProducts
    for (const chunkProduct of chunk(products, 100)) {
      const batch = db.batch()
      chunkProduct.forEach((product) => {
        // for (const product of products) {
        for (let index = 0; index < product.quantity; index++) {
          const ticketParams: Model.Ticket = {
            // 購入者
            paidUserId: product.userId,
            paidUserName: product.userName,
            purchaseTime: order.data.purchaseTime,
            // 所有者
            ownerId: product.userId,
            ownerName: product.userName,
            assignment: [
              {
                from: product.organizerId,
                to: product.userId,
                assignmentDate: order.data.purchaseTime,
              },
            ],
            // isActive: true,
            isPrinting: false,
            isUsed: false,
            uuid: null,
            pdfUuid: null,
            // 商品情報
            productDocRef: product.productDocRef,
            productId: product.productId,
            // exchangeNumber: product.exchangeNumber,
            code: product.code,
            name: product.name,
            desc: product.desc,
            price: product.price,
            pictureURL: product.pictureURL,
            expirationFrom: product.expirationFrom,
            expirationTo: product.expirationTo,
            // 登録者
            // register: product.register,
            // 開催者
            organizerDocRef: product.organizerDocRef,
            organizerId: product.organizerId,
            // イベント情報
            eventDocRef: eventDocRef,
            eventId: product.eventId,
            eventName: product.eventName,
            // expirationLink: product.expirationLink,
          }
          batch.set(ticketDocRef.doc(), ticketParams)

          // batch.create(ticketDocRef, {
          //   // 購入者
          //   paidUserId: product.userId,
          //   paidUserName: product.userName,
          //   purchaseTime: order.data.purchaseTime,
          //   // 所有者
          //   ownerId: product.userId,
          //   ownerName: product.userName,
          //   assignment: [
          //     {
          //       from: product.organizerId,
          //       to: product.userId,
          //       assignmentDate: order.data.purchaseTime,
          //     },
          //   ],
          //   isActive: true,
          //   isPrinting: false,
          //   // 商品情報
          //   productId: product.productId,
          //   exchangeNumber: product.exchangeNumber,
          //   code: product.code,
          //   name: product.name,
          //   desc: product.desc,
          //   price: product.price,
          //   pictureURL: product.pictureURL,
          //   expirationFrom: product.expirationFrom,
          //   expirationTo: product.expirationTo,
          //   // 登録者
          //   register: product.register,
          //   // 開催者
          //   organizerDocRef: product.organizerDocRef,
          //   organizerId: product.organizerId,
          //   // イベント情報
          //   eventDocRef: product.eventDocRef,
          //   eventId: product.eventId,
          //   eventName: product.eventName,
          //   expirationLink: product.expirationLink,
          // })
          console.log(index)
          console.log(ticketParams)
        }
        // }
      })
      await batch.commit()
    }

    return
  } catch (error: any) {
    console.log('========== 発券処理に失敗===============')
    console.log(error)
    console.log('=========================')
    throw new Error(error)
  }
}
