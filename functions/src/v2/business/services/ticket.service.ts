import { db } from '../../../utils/firebase_utils'
import { logger, V2Logger } from '../../../utils/logger'
import { ErrorHandler } from '../../../utils/error_handler'
import { generateTicketKey } from '../../firestore/utils/idempotency'
import * as FirebaseFirestore from 'firebase-admin/firestore'

/**
 * チケットドキュメントの作成（v1のcreateTicketDocumentを移行）
 * @param {string} orderId - 注文ID
 * @return {Promise<void>} 作成完了
 */
export const createTicketDocument = async (orderId: string): Promise<void> => {
  const methodName = 'createTicketDocument'

  try {
    V2Logger.start(methodName, { orderId })

    // 冪等性保証: 既存のチケットをチェック
    const existingTicketsQuery = await db
      .collection('v/1/tickets')
      .where('orderId', '==', orderId)
      .limit(1)
      .get()

    if (!existingTicketsQuery.empty) {
      V2Logger.warn(
        methodName,
        'Tickets already exist for order, skipping creation',
        {
          orderId,
          existingTicketsCount: existingTicketsQuery.size,
        },
      )
      return
    }

    // 注文情報を取得
    const orderDoc = await db.collection('v/1/orders').doc(orderId).get()
    if (!orderDoc.exists) {
      throw new Error(`Order not found: ${orderId}`)
    }

    const orderData = orderDoc.data()
    if (!orderData) {
      throw new Error(`Order data not found: ${orderId}`)
    }

    // 注文ステータスの確認
    if (orderData.status !== 'pre') {
      V2Logger.warn(
        methodName,
        'Order status is not pre, skipping ticket creation',
        {
          orderId,
          status: orderData.status,
        },
      )
      return
    }

    // 注文の確定（orderステータスに更新）
    await orderDoc.ref.set({ status: 'order' }, { merge: true })

    // 決済完了の確認（paymentIntentIdが存在する場合はpaidステータスに更新）
    if (orderData.paymentIntentId) {
      await orderDoc.ref.set({ status: 'paid' }, { merge: true })
      logger.info('Order status updated to paid', {
        orderId,
        paymentIntentId: orderData.paymentIntentId,
      })
    }

    // ユーザー購入履歴の更新
    const userId = orderData.userId
    const userDoc = await db.collection('v/1/users').doc(userId).get()
    if (userDoc.exists) {
      await userDoc.ref
        .collection('orders')
        .doc(orderId)
        .set({ orderDocRef: orderDoc.ref.path }, { merge: true })
    }

    // イベント販売履歴の更新
    const eventId = orderData.eventId
    const eventDocRef = db.collection('v/1/events').doc(eventId)
    await eventDocRef
      .collection('orders')
      .doc(orderId)
      .set({ orderDocRef: orderDoc.ref.path }, { merge: true })

    // チケット発券（ビジネス一意キーで冪等性を保証）
    const products = orderData.snapshotProducts

    // トランザクション内でチケット作成
    await V2Logger.measure(
      'createTicketsTransaction',
      async () => {
        return await db.runTransaction(async (transaction) => {
          // 最初にすべてのチケットの存在チェックを実行
          const ticketChecks: Promise<FirebaseFirestore.DocumentSnapshot>[] = []
          const ticketParams: any[] = []

          for (const product of products) {
            for (let index = 0; index < product.quantity; index++) {
              const ticketId = generateTicketKey(
                orderId,
                product.productId,
                index,
              )

              const params = {
                // 購入者
                paidUserId: product.userId,
                paidUserName: product.userName,
                purchaseTime: orderData.purchaseTime,
                // 所有者
                ownerId: product.userId,
                ownerName: product.userName,
                assignment: [
                  {
                    from: product.organizerId,
                    to: product.userId,
                    assignmentDate: orderData.purchaseTime,
                  },
                ],
                isPrinting: false,
                isUsed: false,
                uuid: null,
                pdfUuid: null,
                // 商品情報
                productDocRef: db
                  .collection('v/1/products')
                  .doc(product.productId),
                productId: product.productId,
                code: product.code,
                name: product.name,
                desc: product.desc,
                price: product.price,
                pictureURL: product.pictureURL,
                expirationFrom: product.expirationFrom,
                expirationTo: product.expirationTo,
                // 開催者
                organizerDocRef: product.organizerDocRef,
                organizerId: product.organizerId,
                // イベント情報
                eventDocRef: eventDocRef,
                eventId: product.eventId,
                eventName: product.eventName,
                // 注文情報
                orderId: orderId,
              }

              // チケットの存在チェックを追加
              const ticketRef = db.collection('v/1/tickets').doc(ticketId)
              ticketChecks.push(transaction.get(ticketRef))
              ticketParams.push({ ticketId, params })
            }
          }

          // すべての読み取り操作を実行
          const ticketSnapshots = await Promise.all(ticketChecks)

          // 存在しないチケットのみ作成
          for (let i = 0; i < ticketSnapshots.length; i++) {
            const snapshot = ticketSnapshots[i]
            const { ticketId, params } = ticketParams[i]

            if (!snapshot.exists) {
              transaction.set(
                db.collection('v/1/tickets').doc(ticketId),
                params,
              )
            }
          }
        })
      },
      { orderId, productsCount: products.length },
    )

    V2Logger.success(methodName, { orderId })
  } catch (error: any) {
    V2Logger.error(methodName, error, { orderId })
    ErrorHandler.logError(error, error.stack, 'ticket.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'ticket.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * チケットの取得
 * @param {string} ticketId - チケットID
 * @return {Promise<any>} チケット情報
 */
export const getTicket = async (ticketId: string): Promise<any> => {
  logger.info('Getting ticket', { ticketId })

  try {
    const ticketDoc = await db.collection('v/1/tickets').doc(ticketId).get()
    if (!ticketDoc.exists) {
      throw new Error(`Ticket not found: ${ticketId}`)
    }

    const ticketData = ticketDoc.data()
    logger.info('Ticket retrieved successfully', { ticketId })
    return ticketData
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'ticket.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'ticket.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * チケットの更新
 * @param {string} ticketId - チケットID
 * @param {any} updateData - 更新データ
 * @return {Promise<void>} 更新完了
 */
export const updateTicket = async (
  ticketId: string,
  updateData: any,
): Promise<void> => {
  logger.info('Updating ticket', { ticketId })

  try {
    await db
      .collection('v/1/tickets')
      .doc(ticketId)
      .update({
        ...updateData,
        updatedAt: new Date(),
      })
    logger.info('Ticket updated successfully', { ticketId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'ticket.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'ticket.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * チケットの削除
 * @param {string} ticketId - チケットID
 * @return {Promise<void>} 削除完了
 */
export const deleteTicket = async (ticketId: string): Promise<void> => {
  logger.info('Deleting ticket', { ticketId })

  try {
    await db.collection('v/1/tickets').doc(ticketId).delete()
    logger.info('Ticket deleted successfully', { ticketId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'ticket.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'ticket.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * ユーザーのチケット一覧を取得
 * @param {string} userId - ユーザーID
 * @return {Promise<any[]>} チケット一覧
 */
export const getUserTickets = async (userId: string): Promise<any[]> => {
  logger.info('Getting user tickets', { userId })

  try {
    const ticketsSnapshot = await db
      .collection('v/1/tickets')
      .where('userId', '==', userId)
      .get()

    const tickets = ticketsSnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }))

    logger.info('User tickets retrieved successfully', {
      userId,
      count: tickets.length,
    })
    return tickets
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'ticket.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'ticket.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}
