import { logger } from 'firebase-functions'
import { UserRecord } from 'firebase-functions/lib/common/providers/identity'
import * as firebaseAdmin from 'firebase-admin'

/**
 * ユーザーIDからStripe Customer IDを取得する
 * @param {string} uid ユーザーID
 * @return {Promise<string | null>} Stripe Customer ID
 */
export const getStripeCustomerId = async (
  uid: string,
): Promise<string | null> => {
  try {
    const user = await firebaseAdmin.auth().getUser(uid)
    return getStripeCustomerIdForUser(user)
  } catch (error: any) {
    logger.error('Failed to get Stripe customer ID:', { error, uid })
    return null
  }
}

/**
 * ユーザーレコードからStripe Customer IDを取得する
 * @param {UserRecord} user ユーザーレコード
 * @return {Promise<string | null>} Stripe Customer ID
 */
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
