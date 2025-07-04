import { db } from '../../../utils/firebase_utils'
import { logger } from '../../../utils/logger'
import { ErrorHandler } from '../../../utils/error_handler'

/**
 * アカウント情報を更新する
 * @param {string} uid - ユーザーID
 * @param {string} accountId - アカウントID
 * @param {string} stripeStatus - Stripeステータス
 * @param {boolean} chargesEnabled - 決済有効フラグ
 */
export const updateAccountStatus = async (
  uid: string | undefined,
  accountId: string,
  stripeStatus: string,
  chargesEnabled: boolean,
): Promise<void> => {
  logger.info('Updating account status', {
    uid,
    accountId,
    stripeStatus,
    chargesEnabled,
  })

  try {
    if (!uid) {
      logger.warn('UID not provided for account status update', { accountId })
      return
    }

    await db.collection('v/1/stripe_connect_accounts').doc(uid).update({
      stripeStatus: stripeStatus,
      chargesEnabled: chargesEnabled,
      updatedAt: new Date(),
    })

    logger.info('Account status updated successfully', {
      uid: uid,
      accountId: accountId,
      stripeStatus: stripeStatus,
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
  logger.info('Getting account', { uid })

  try {
    const accountDoc = await db
      .collection('v/1/stripe_connect_accounts')
      .doc(uid)
      .get()
    if (!accountDoc.exists) {
      throw new Error(`Account not found: ${uid}`)
    }

    const accountData = accountDoc.data()
    logger.info('Account retrieved successfully', { uid })
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
  logger.info('Updating account', { uid })

  try {
    await db
      .collection('v/1/stripe_connect_accounts')
      .doc(uid)
      .update({
        ...updateData,
        updatedAt: new Date(),
      })
    logger.info('Account updated successfully', { uid })
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
  logger.info('Deleting account', { uid })

  try {
    await db.collection('v/1/stripe_connect_accounts').doc(uid).delete()
    logger.info('Account deleted successfully', { uid })
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
  logger.info('Creating account', { uid })

  try {
    await db
      .collection('v/1/stripe_connect_accounts')
      .doc(uid)
      .set({
        ...accountData,
        createdAt: new Date(),
        updatedAt: new Date(),
      })
    logger.info('Account created successfully', { uid })
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
  logger.info('Getting Stripe account ID', { uid })

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
    const stripeAccountId = accountData?.stripeAccountId || null

    logger.info('Stripe account ID retrieved', { uid, stripeAccountId })
    return stripeAccountId
  } catch (error: any) {
    ErrorHandler.logError(error, error.stack, 'account.service.ts')
    const appEx = ErrorHandler.convertToAppException(
      error,
      'account.service.ts',
    )
    throw ErrorHandler.convertToHttpsError(appEx)
  }
}
