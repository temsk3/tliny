import * as admin from 'firebase-admin'
import { CallableRequest, HttpsError } from 'firebase-functions/v2/https'
import { UserRecord } from 'firebase-functions/lib/common/providers/identity'
import { chunk } from 'lodash'

// Initialize Firebase Admin
if (!admin.apps.length) {
  admin.initializeApp()
}

export const db = admin.firestore()
export { chunk }

export function checkAuth(request: CallableRequest<any>) {
  // 認証済みユーザーかどうかチェックする
  if (!request.auth || !request.auth.uid) {
    throw new HttpsError('unauthenticated', 'User is not authenticated.')
  }
  return request
}

export function getRequestingUserId(request: CallableRequest<any>) {
  if (request.auth === undefined) {
    throw new Error('User is undefined.')
  }
  return request.auth.uid
}

export async function getUserRecord(userId: string): Promise<UserRecord> {
  const userRecord = await admin.auth().getUser(userId)
  return userRecord
}

export async function getUserEmail(
  userId: string,
): Promise<string | undefined> {
  const userRecord = await getUserRecord(userId)
  return userRecord.email
}

//
export async function getStripeCustomerId(
  userId: string,
): Promise<string | null> {
  const user = await admin.auth().getUser(userId)
  return getStripeCustomerIdForUser(user)
}

export async function getStripeCustomerIdForUser(
  user: UserRecord,
): Promise<string | null> {
  if (
    user.customClaims &&
    Object.hasOwnProperty.call(user.customClaims, 'customerId')
  ) {
    return (user.customClaims as any).customerId
  } else {
    console.error(
      Error(`Missing customClaims.customerID for user: ${user.uid}`),
    )
    return null
  }
}

//
export async function getStripeConnectAccountId(
  userId: string,
): Promise<string | null> {
  // まずFirestoreから取得を試行
  try {
    const accountDoc = await db
      .collection('v/1/stripe_connect_accounts')
      .doc(userId)
      .get()
    if (accountDoc.exists) {
      const accountData = accountDoc.data()
      const accountId = accountData?.account_id || null
      if (accountId) {
        return accountId
      }
    }
  } catch (error) {
    console.error('Failed to get account from Firestore:', error)
  }

  // Firestoreにない場合はカスタムクレームから取得（後方互換性）
  const user = await admin.auth().getUser(userId)
  return getStripeConnectAccountIdForUser(user)
}

export async function getStripeConnectAccountIdForUser(
  user: UserRecord,
): Promise<string | null> {
  if (
    user.customClaims &&
    Object.hasOwnProperty.call(user.customClaims, 'accountId')
  ) {
    return (user.customClaims as any).accountId
  } else {
    console.error(Error(`Missing customClaims.accountId for user: ${user.uid}`))
    return null
  }
}
