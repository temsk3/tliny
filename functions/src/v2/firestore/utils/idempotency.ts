import * as crypto from 'crypto'
import { db } from '../../../utils/firebase_utils'
import { logger } from '../../../utils/logger'

/**
 * ビジネス一意キーを生成する
 * @param {string} prefix - キーのプレフィックス
 * @param {...(string | number | boolean | undefined)[]} params - 一意性を保証するパラメータ
 * @return {string} ハッシュ化された一意キー
 */
export const generateBusinessKey = (
  prefix: string,
  ...params: (string | number | boolean | undefined)[]
): string => {
  const keySource = params
    .filter((param) => param !== undefined)
    .map((param) => String(param))
    .join('_')

  const hash = crypto
    .createHash('sha256')
    .update(`${prefix}_${keySource}`)
    .digest('hex')
  return `${prefix}_${hash.substring(0, 16)}` // 16文字に制限してFirestoreドキュメントIDとして使用可能にする
}

/**
 * 注文のビジネス一意キーを生成
 * @param {string} userId - ユーザーID
 * @param {string} eventId - イベントID
 * @param {number} purchaseTime - 購入時刻（タイムスタンプ）
 * @return {string} 注文の一意キー
 */
export const generateOrderKey = (
  userId: string,
  eventId: string,
  purchaseTime: number,
): string => {
  return generateBusinessKey('order', userId, eventId, purchaseTime)
}

/**
 * チケットのビジネス一意キーを生成
 * @param {string} orderId - 注文ID
 * @param {string} productId - 商品ID
 * @param {number} index - 同一商品内でのインデックス
 * @return {string} チケットの一意キー
 */
export const generateTicketKey = (
  orderId: string,
  productId: string,
  index: number,
): string => {
  return generateBusinessKey('ticket', orderId, productId, index)
}

/**
 * カートアイテムのビジネス一意キーを生成
 * @param {string} userId - ユーザーID
 * @param {string} productId - 商品ID
 * @param {string} eventId - イベントID
 * @return {string} カートアイテムの一意キー
 */
export const generateCartItemKey = (
  userId: string,
  productId: string,
  eventId: string,
): string => {
  return generateBusinessKey('cart', userId, productId, eventId)
}

/**
 * 既存ドキュメントの存在チェック（冪等性保証）
 * @param {string} collectionPath - コレクションパス
 * @param {string} docId - ドキュメントID
 * @return {Promise<boolean>} 存在する場合はtrue
 */
export const checkDocumentExists = async (
  collectionPath: string,
  docId: string,
): Promise<boolean> => {
  try {
    const doc = await db.collection(collectionPath).doc(docId).get()
    return doc.exists
  } catch (error) {
    logger.error('Error checking document existence', {
      collectionPath,
      docId,
      error: error instanceof Error ? error.message : String(error),
    })
    throw error
  }
}

/**
 * 既存ドキュメントの存在チェック（クエリベース）
 * @param {string} collectionPath - コレクションパス
 * @param {string} field - フィールド名
 * @param {string} value - フィールド値
 * @return {Promise<boolean>} 存在する場合はtrue
 */
export const checkDocumentExistsByQuery = async (
  collectionPath: string,
  field: string,
  value: string,
): Promise<boolean> => {
  try {
    const query = await db
      .collection(collectionPath)
      .where(field, '==', value)
      .limit(1)
      .get()

    return !query.empty
  } catch (error) {
    logger.error('Error checking document existence by query', {
      collectionPath,
      field,
      value,
      error: error instanceof Error ? error.message : String(error),
    })
    throw error
  }
}

/**
 * 冪等性を保証してドキュメントを作成
 * @param {string} collectionPath - コレクションパス
 * @param {string} docId - ドキュメントID
 * @param {any} data - 作成するデータ
 * @param {boolean} merge - マージオプション
 * @return {Promise<FirebaseFirestore.DocumentReference>} 作成されたドキュメントの参照
 */
export const createDocumentWithIdempotency = async (
  collectionPath: string,
  docId: string,
  data: any,
  merge = false,
): Promise<FirebaseFirestore.DocumentReference> => {
  try {
    // 既存チェック
    const exists = await checkDocumentExists(collectionPath, docId)
    if (exists) {
      logger.info('Document already exists, skipping creation', {
        collectionPath,
        docId,
      })
      return db.collection(collectionPath).doc(docId)
    }

    // 新規作成
    const docRef = db.collection(collectionPath).doc(docId)
    await docRef.set(data, { merge })

    logger.info('Document created successfully', {
      collectionPath,
      docId,
    })

    return docRef
  } catch (error) {
    logger.error('Error creating document with idempotency', {
      collectionPath,
      docId,
      error: error instanceof Error ? error.message : String(error),
    })
    throw error
  }
}

/**
 * トランザクション内で冪等性を保証してドキュメントを作成
 * @param {FirebaseFirestore.Transaction} transaction - Firestoreトランザクション
 * @param {string} collectionPath - コレクションパス
 * @param {string} docId - ドキュメントID
 * @param {any} data - 作成するデータ
 * @param {boolean} merge - マージオプション
 * @return {Promise<FirebaseFirestore.DocumentReference>} 作成されたドキュメントの参照
 */
export const createDocumentInTransaction = async (
  transaction: FirebaseFirestore.Transaction,
  collectionPath: string,
  docId: string,
  data: any,
  merge = false,
): Promise<FirebaseFirestore.DocumentReference> => {
  const docRef = db.collection(collectionPath).doc(docId)

  // トランザクション内で既存チェック
  const doc = await transaction.get(docRef)
  if (doc.exists) {
    logger.info('Document already exists in transaction, skipping creation', {
      collectionPath,
      docId,
    })
    return docRef
  }

  // トランザクション内で新規作成
  transaction.set(docRef, data, { merge })

  logger.info('Document creation scheduled in transaction', {
    collectionPath,
    docId,
  })

  return docRef
}
