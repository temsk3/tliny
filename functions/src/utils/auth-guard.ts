import { HttpsError, Request } from 'firebase-functions/v2/https'

/**
 * 認証チェックの共通ユーティリティ
 * @param request - Cloud Functions リクエスト
 * @return 認証済みユーザーのUID
 * @throws HttpsError 認証されていない場合
 */
export const requireAuth = (request: Request): string => {
  if (!request.auth || !request.auth.uid) {
    throw new HttpsError('unauthenticated', 'User is not authenticated.')
  }
  return request.auth.uid
}
