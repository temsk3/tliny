import { db } from '../../../utils/firebase_utils'
import { logger } from '../../../utils/logger'
import { ErrorHandler } from '../../../utils/error_handler'

/**
 * アカウント情報を更新する
 * @param {string} uid - ユーザーID
 * @param {string} accountId - アカウントID
 * @param {string} status - Stripeステータス
 * @param {boolean} chargesEnabled - 決済有効フラグ
 */
export const updateAccountStatus = async (
  uid: string | undefined,
  accountId: string,
  status: string,
  chargesEnabled: boolean,
): Promise<void> => {
  try {
    if (!uid) {
      logger.warn('UID not provided for account status update', { accountId })
      return
    }

    await db.collection('v/1/stripe_connect_accounts').doc(uid).update({
      status: status,
      chargesEnabled: chargesEnabled,
      updatedAt: new Date(),
    })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'account.service.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'account.service.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * アカウント情報を取得する
 * @param {string} uid - ユーザーID
 * @return {Promise<any>} アカウント情報
 */
export const getAccountByUid = async (uid: string): Promise<any> => {
  try {
    const accountDoc = await db
      .collection('v/1/stripe_connect_accounts')
      .doc(uid)
      .get()
    if (!accountDoc.exists) {
      throw new Error(`Account not found: ${uid}`)
    }

    const accountData = accountDoc.data()
    return accountData
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'account.service.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'account.service.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * アカウント情報を更新する
 * @param {string} uid - ユーザーID
 * @param {any} updateData - 更新データ
 */
export const updateAccount = async (
  uid: string,
  updateData: any,
): Promise<void> => {
  try {
    await db
      .collection('v/1/stripe_connect_accounts')
      .doc(uid)
      .update({
        ...updateData,
        updatedAt: new Date(),
      })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'account.service.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'account.service.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * アカウントを削除する
 * @param {string} uid - ユーザーID
 */
export const deleteAccount = async (uid: string): Promise<void> => {
  try {
    await db.collection('v/1/stripe_connect_accounts').doc(uid).delete()
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'account.service.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'account.service.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * アカウントを作成する
 * @param {string} uid - ユーザーID
 * @param {any} accountData - アカウントデータ
 */
export const createAccount = async (
  uid: string,
  accountData: any,
): Promise<void> => {
  try {
    await db
      .collection('v/1/stripe_connect_accounts')
      .doc(uid)
      .set({
        ...accountData,
        createdAt: new Date(),
        updatedAt: new Date(),
      })
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'account.service.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'account.service.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}

/**
 * StripeアカウントIDの取得
 * @param {string} uid - ユーザーID
 * @return {Promise<string | null>} StripeアカウントID
 */
export const getStripeAccountId = async (
  uid: string,
): Promise<string | null> => {
  try {
    const accountDoc = await db
      .collection('v/1/stripe_connect_accounts')
      .doc(uid)
      .get()
    if (!accountDoc.exists) {
      logger.warn('Account not found', { uid })
      return null
    }

    const accountData = accountDoc.data()
    const accountId = accountData?.account_id || null

    return accountId
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'account.service.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'account.service.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}
