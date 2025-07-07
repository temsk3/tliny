import {
  db,
  getStripeConnectAccountId,
  getStripeCustomerId,
} from '../../../utils/firebase_utils'
import { HttpsError } from 'firebase-functions/v2/https'
import Stripe from 'stripe'
import { logger } from 'firebase-functions'
import { currency } from '../../payment/utils'
import paths from '../../firestore/utils/db_paths'
import * as Model from '../../firestore/utils/model'
import { ErrorHandler } from '../../../utils/error_handler'
import { Timestamp, DocumentSnapshot } from 'firebase-admin/firestore'
import {
  generateOrderKey,
  generateCartItemKey,
  createDocumentWithIdempotency,
  checkDocumentExistsByQuery,
} from '../../firestore/utils/idempotency'
import * as admin from 'firebase-admin'

/**
 * プレオーダーを作成する
 * @param {string} userId - ユーザーID
 * @param {string} eventId - イベントID
 * @return {Promise<{orderID: string, lineItems: Stripe.Checkout.SessionCreateParams.LineItem[], accountId: string, subtotal: number}>} オーダー情報
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
  logger.info('Creating pre-order', { userId, eventId })

  try {
    // ユーザー情報の取得
    const userDoc = await db
      .collection(paths.usersCollectionPath)
      .doc(userId)
      .get()

    if (!userDoc.exists) {
      throw new HttpsError('not-found', `User ${userId} not found`)
    }

    // イベント情報の取得
    const eventDoc = await db
      .collection(paths.eventsCollectionPath)
      .doc(eventId)
      .get()

    if (!eventDoc.exists) {
      throw new HttpsError('not-found', `Event ${eventId} not found`)
    }

    // 販売者のStripeConnectAccountIdを確認
    const event = eventDoc.data() as Model.Event
    const account = event.organizerId

    const accountId = await getStripeConnectAccountId(account)
    if (accountId === null) {
      throw new HttpsError(
        'failed-precondition',
        'User has no Stripe ConnectAccount ID',
      )
    }

    // ユーザー情報の取得
    const user = userDoc.data() as Model.User

    // ユーザーのstripe customer情報を取得
    const customerId = await getStripeCustomerId(userId)
    if (customerId === null) {
      throw new HttpsError('failed-precondition', 'User has no Stripe ID')
    }

    // ユーザーのサブコレクション`cart_items`から指定イベントの一覧を取得する
    let cartItems: any[] = []
    try {
      const cartItemsSnapshot = await db
        .collection(paths.usersCollectionPath)
        .doc(userId)
        .collection(paths.cartCollectionPath)
        .where('programId', '==', eventId)
        .get()
      cartItems = cartItemsSnapshot.docs.map((doc) => ({
        ...doc.data(),
        ref: doc.ref,
      }))
    } catch (err: any) {
      logger.error('Error fetching cartItems', {
        error:
          err && typeof err === 'object' && 'message' in err
            ? err.message
            : err,
      })
      throw err
    }

    if (cartItems.length === 0) {
      throw new HttpsError('failed-precondition', 'No items in cart')
    }

    // LineItemsとsubtotalの初期化
    const lineItems: Stripe.Checkout.SessionCreateParams.LineItem[] = []
    let subtotal = 0

    // トランザクションを利用して、カートにいれた商品の在庫があり購入可能かを確認する
    await db.runTransaction(async (transaction) => {
      const promises: Promise<void>[] = []
      for (const cartItem of cartItems) {
        promises.push(
          (async () => {
            const productDoc = (await transaction.get(
              cartItem.productDocRef,
            )) as unknown as DocumentSnapshot
            if (!productDoc.exists) {
              throw new Error('Product not found!')
            }

            const product = productDoc.data() as Model.Product
            if (cartItem.quantity <= product.stock) {
              // 購入できるのが確認できたら、`Product`の在庫を減らす
              transaction.update(productDoc.ref, {
                stock: product.stock - cartItem.quantity,
              })
              // Stripe最新API仕様に合わせてlineItemsを生成
              const lineItem = {
                price_data: {
                  currency: currency,
                  product_data: {
                    name: product.name,
                    description: product.desc,
                    images: product.pictureURL, // 商品写真を追加
                  },
                  unit_amount: product.price,
                },
                quantity: cartItem.quantity,
              }

              // デバッグログ: lineItemの詳細を出力
              logger.info('Creating line item with images', {
                productName: product.name,
                productImages: product.pictureURL,
                lineItemImages: lineItem.price_data.product_data.images,
                lineItem: JSON.stringify(lineItem),
              })

              lineItems.push(lineItem as any)
              subtotal += product.price * cartItem.quantity
            } else {
              throw new HttpsError(
                'failed-precondition',
                'There is less stock than the quantity to buy',
              )
            }
          })(),
        )
      }
      return Promise.all(promises)
    })

    // 注文情報の作成
    const now = Timestamp.now()

    const products = await Promise.all(
      cartItems.map((c: any) => {
        let docRef: admin.firestore.DocumentReference
        if (typeof c.productDocRef === 'string') {
          docRef = db.doc(c.productDocRef)
        } else {
          docRef = c.productDocRef
        }
        return docRef
          .get()
          .then((doc: admin.firestore.DocumentSnapshot) => {
            return doc.data() as Model.Product
          })
          .catch((err: any) => {
            logger.error('Error retrieving product document', {
              productId: c.productId,
              productDocRef: docRef.path,
              error:
                err && typeof err === 'object' && 'message' in err
                  ? err.message
                  : err,
            })
            throw err
          })
      }),
    )

    // 購入日時と、購入した時点での商品の情報を配列として持たせる
    const order: Model.Order = {
      status: Model.OrderStatus.pre,
      userId: userId,
      eventId: eventId,
      purchaseTime: now,
      createdAt: now,
      snapshotProducts: products.map((product, index) => {
        const cartItem = cartItems[index]
        const quantity = cartItem.quantity
        const productId = cartItem.productDocRef.id

        return {
          // cart情報
          productDocRef: db.collection('v/1/products').doc(productId),
          quantity: quantity,
          // 購入者
          userId: userId,
          userName: user.displayName,
          // 商品情報
          productId: productId,
          exchangeNumber: product.exchangeNumber,
          code: product.code,
          name: product.name,
          desc: product.desc,
          price: product.price,
          pictureURL: product.pictureURL,
          expirationFrom: product.expirationFrom,
          expirationTo: product.expirationTo,
          // 登録者
          register: product.register,
          // 開催者
          organizerDocRef: product.organizerDocRef,
          organizerId: product.organizerId,
          // イベント情報
          eventDocRef: product.eventDocRef,
          eventId: product.eventId,
          eventName: product.eventName,
          expirationLink: product.expirationLink,
          // Stripe
          priceId: product.priceId,
        }
      }),
    }

    // ビジネス一意キーで注文IDを生成
    const purchaseTimeMillis = now.toMillis()
    const orderId = generateOrderKey(userId, eventId, purchaseTimeMillis)

    // 冪等性を保証して注文ドキュメントを作成
    await createDocumentWithIdempotency(
      paths.ordersCollectionPath,
      orderId,
      order,
      true,
    )

    // カートの中身を削除
    await Promise.all(cartItems.map((cartItem) => cartItem.ref.delete()))

    logger.info('Pre-order created successfully', {
      orderId,
      lineItemsCount: lineItems.length,
      accountId,
      subtotal,
    })

    return {
      orderID: orderId,
      lineItems: lineItems,
      accountId: accountId,
      subtotal: subtotal,
    }
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * 注文をキャンセルする
 * @param {string} orderId - キャンセルする注文のID
 * @return {Promise<void>} キャンセル完了
 */
export const cancelOrder = async (orderId: string): Promise<void> => {
  logger.info('Canceling order', { orderId })

  try {
    // order情報の取得
    const orderDoc = await db
      .collection(paths.ordersCollectionPath)
      .doc(orderId)
      .get()
    if (!orderDoc.exists) {
      throw new HttpsError('not-found', 'Order not found')
    }

    const orderData = orderDoc.data()
    if (orderData?.status === Model.OrderStatus.order) {
      throw new Error('Order is already confirmed and cannot be canceled')
    } else if (orderData?.status === Model.OrderStatus.cancel) {
      // 既にキャンセル済みの場合は成功として扱う
      logger.info('Order is already canceled', { orderId })
      return
    }

    // orderの確定
    await orderDoc.ref.set(
      { status: Model.OrderStatus.cancel, cancelAt: Timestamp.now() },
      { merge: true },
    )

    // 在庫の差し戻し
    const orderItems = orderData?.snapshotProducts || []
    await db.runTransaction(async (transaction) => {
      const promises: Promise<void>[] = []
      for (const orderItem of orderItems) {
        promises.push(
          (async () => {
            const productDoc = (await transaction.get(
              orderItem.productDocRef,
            )) as unknown as admin.firestore.DocumentSnapshot
            if (!productDoc.exists) {
              throw new Error('Product not found')
            }
            const productData = productDoc.data()
            // `Product`の在庫を増やす
            transaction.update(productDoc.ref, {
              stock: productData?.stock + orderItem.quantity,
            })
          })(),
        )
      }
      return Promise.all(promises)
    })

    // ユーザーの取得
    const userId = orderData?.userId
    if (userId) {
      // カートに差し戻し
      await sendBackCartItem(userId, orderItems)
    }

    logger.info('Order canceled successfully', { orderId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * カートに商品を戻す
 * @param {string} userId - ユーザーID
 * @param {SnapshotProduct[]} orderItems - 戻す商品情報
 * @return {Promise<void>} 戻し完了
 */
export const sendBackCartItem = async (
  userId: string,
  orderItems: Model.SnapshotProduct[],
): Promise<void> => {
  logger.info('Sending items back to cart', {
    userId,
    itemsCount: orderItems.length,
  })

  try {
    // カートに差し戻し（ビジネス一意キーで冪等性を保証）
    for (const orderItem of orderItems) {
      const cartItemId = generateCartItemKey(
        userId,
        orderItem.productId,
        orderItem.eventId,
      )

      // 既存のカートアイテムがあるかチェック
      const exists = await checkDocumentExistsByQuery(
        `${paths.usersCollectionPath}/${userId}${paths.cartCollectionPath}`,
        'productId',
        orderItem.productId,
      )

      if (!exists) {
        await createDocumentWithIdempotency(
          `${paths.usersCollectionPath}/${userId}${paths.cartCollectionPath}`,
          cartItemId,
          {
            productDocRef: orderItem.productDocRef,
            quantity: orderItem.quantity,
            programId: orderItem.eventId,
            productId: orderItem.productId,
          },
        )
      }
    }

    logger.info('Items sent back to cart successfully', { userId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * 注文の取得
 * @param {string} orderId - 注文ID
 * @return {Promise<any>} 注文情報
 */
export const getOrder = async (orderId: string): Promise<any> => {
  try {
    const orderDoc = await db.collection('v/1/orders').doc(orderId).get()
    if (!orderDoc.exists) {
      throw new Error(`Order not found: ${orderId}`)
    }
    return orderDoc.data()
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * 注文の更新
 * @param {string} orderId - 注文ID
 * @param {any} updateData - 更新データ
 * @return {Promise<void>} 更新完了
 */
export const updateOrder = async (
  orderId: string,
  updateData: any,
): Promise<void> => {
  try {
    await db
      .collection('v/1/orders')
      .doc(orderId)
      .update({
        ...updateData,
        updatedAt: new Date(),
      })
    logger.info('Order updated successfully', { orderId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * 注文の削除
 * @param {string} orderId - 注文ID
 * @return {Promise<void>} 削除完了
 */
export const deleteOrder = async (orderId: string): Promise<void> => {
  try {
    await db.collection('v/1/orders').doc(orderId).delete()
    logger.info('Order deleted successfully', { orderId })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * カートアイテムのデバッグ情報を取得する
 * @param {string} userId - ユーザーID
 * @param {string} eventId - イベントID（オプション）
 * @return {Promise<any>} カートアイテムの情報
 */
export const getCartItemsDebug = async (
  userId: string,
  eventId?: string,
): Promise<any> => {
  try {
    let query: any = db
      .collection(paths.usersCollectionPath)
      .doc(userId)
      .collection(paths.cartCollectionPath)

    if (eventId) {
      query = query.where('programId', '==', eventId)
    }

    const cartItemsSnapshot = await query.get()
    const cartItems = cartItemsSnapshot.docs.map((doc: any) => ({
      id: doc.id,
      ...doc.data(),
    })) as (Model.CartItem & { id: string })[]

    return {
      userId,
      eventId,
      totalItems: cartItems.length,
      items: cartItems.map((item) => ({
        id: item.id,
        programId: item.programId,
        productId: item.productId,
        quantity: item.quantity,
        productDocRef: item.productDocRef.path,
      })),
    }
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * 商品の存在確認とデバッグ情報を取得する
 * @param {string} productId - 商品ID
 * @return {Promise<any>} 商品情報とデバッグ情報
 */
export const getProductDebug = async (productId: string): Promise<any> => {
  try {
    // v/1/productsコレクションから商品を取得
    const productDoc = await db.collection('v/1/products').doc(productId).get()

    if (!productDoc.exists) {
      // 商品が見つからない場合、他のコレクションも確認
      const alternativePaths = [
        `v/1/products/${productId}`,
        `products/${productId}`,
        `v/2/products/${productId}`,
      ]

      const alternativeResults = await Promise.all(
        alternativePaths.map(async (path) => {
          try {
            const doc = await db.doc(path).get()
            return {
              path,
              exists: doc.exists,
              data: doc.exists ? doc.data() : null,
            }
          } catch (error: any) {
            return { path, exists: false, error: error.message }
          }
        }),
      )

      return {
        productId,
        exists: false,
        checkedPaths: alternativePaths,
        alternativeResults,
      }
    }

    return {
      productId,
      exists: true,
      data: productDoc.data(),
      path: productDoc.ref.path,
    }
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'order.service.ts')
    const appEx = ErrorHandler.convertToAppException(error, 'order.service.ts')
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}
