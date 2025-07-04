import { db } from './firebase_utils'
import { HttpsError, Request } from 'firebase-functions/v2/https'

/**
 * タイムスタンプを追加する
 * @param data データオブジェクト
 * @return タイムスタンプが追加されたデータ
 */
export const addTimestamps = (data: Record<string, unknown>) => ({
  ...data,
  createdAt: new Date(),
  updatedAt: new Date(),
})

/**
 * 更新タイムスタンプを追加する
 * @param data データオブジェクト
 * @return 更新タイムスタンプが追加されたデータ
 */
export const addUpdateTimestamp = (data: Record<string, unknown>) => ({
  ...data,
  updatedAt: new Date(),
})

/**
 * エンティティの存在を確認する
 * @param collectionName コレクション名
 * @param id ドキュメントID
 * @param entityName エンティティ名
 * @return ドキュメントスナップショット
 */
export const validateEntityExists = async (
  collectionName: string,
  id: string,
  entityName: string,
) => {
  const doc = await db.collection(collectionName).doc(id).get()
  if (!doc.exists) {
    throw new HttpsError('not-found', `${entityName} not found`)
  }
  return doc
}

/**
 * 認証チェックを行う
 * @param request リクエストオブジェクト
 * @return ユーザーID
 */
export const checkAuthAndGetUserId = (request: Request): string => {
  if (!request.auth) {
    throw new HttpsError('unauthenticated', 'User must be authenticated')
  }
  return request.auth.uid
}

/**
 * データの存在チェックを行う
 * @param data チェックするデータ
 * @param fieldName フィールド名
 * @param entityName エンティティ名
 */
export const validateRequiredField = (
  data: Record<string, unknown>,
  fieldName: string,
  entityName: string,
) => {
  if (!data || !data[fieldName]) {
    throw new HttpsError(
      'invalid-argument',
      `${fieldName} is required for ${entityName}`,
    )
  }
}
