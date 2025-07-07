import * as functions from 'firebase-functions/v1'
import * as admin from 'firebase-admin'
import { ErrorHandler } from '../../utils/error_handler'
import { getStripe, stripeOptions } from '../payment/utils'
import Stripe from 'stripe'
import paths from '../firestore/utils/db_paths'
import stripeErrors from '../payment/utils/stripe_error'
import { logger } from '../../utils/logger'
import { defineSecret } from 'firebase-functions/params'

// Firebase Functionsのシークレット定義
const stripeDevSk = defineSecret('STRIPE_DEV_SK')

// Firestoreの初期化
if (!admin.apps.length) {
  admin.initializeApp()
}

const db = admin.firestore()

/**
 * 新規ユーザー作成時のトリガー
 * Firestoreにユーザードキュメントを作成し、Stripe Customerを作成する
 */
export const onUserCreatedTrigger = functions
  .runWith({
    secrets: [stripeDevSk],
  })
  .auth.user()
  .onCreate(async (user) => {
    const methodName = 'onUserCreatedTrigger'
    const startTime = Date.now()

    try {
      logger.info(`${methodName}: 新規ユーザー作成を検知`, {
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
      })

      // 冪等性チェック（既存実装に合わせる）
      if (
        user.customClaims &&
        Object.hasOwnProperty.call(user.customClaims, 'customerId')
      ) {
        logger.info(
          `${methodName}: ユーザーは既にStripe Customerに接続されています`,
          {
            uid: user.uid,
            customerId: user.customClaims.customerId,
          },
        )
        return
      }

      // 表示名の設定（既存実装に合わせる）
      let displayName: string | undefined = user.displayName
      if (!displayName || !displayName.trim()) {
        displayName = user.email?.substring(0, user.email.lastIndexOf('@'))
      } else {
        displayName = displayName.trim()
      }

      // users collection への登録を最初に行う（Flutter側のモデルに合わせる）
      logger.info(`${methodName}: users collection への書き込み開始`, {
        uid: user.uid,
        path: paths.usersCollectionPath,
      })

      const userData = {
        displayName: displayName,
        name: displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL,
        createdAt: new Date(),
        updatedAt: new Date(),
      }

      try {
        await db
          .collection(paths.usersCollectionPath)
          .doc(user.uid)
          .set(userData)

        logger.info(`${methodName}: users collection への書き込み完了`, {
          uid: user.uid,
          data: userData,
        })
      } catch (firestoreError: any) {
        logger.error(`${methodName}: users collection への書き込み失敗`, {
          uid: user.uid,
          path: paths.usersCollectionPath,
          error: firestoreError.message,
          code: firestoreError.code,
          stack: firestoreError.stack,
        })
        throw firestoreError
      }

      // public_users への登録
      logger.info(`${methodName}: public_users collection への書き込み開始`, {
        uid: user.uid,
        path: paths.publicUsersCollectionPath,
      })

      const publicUserData = {
        displayName: displayName,
        profileImageURL: user.photoURL,
        createdAt: new Date(),
        updatedAt: new Date(),
      }

      try {
        await db
          .collection(paths.publicUsersCollectionPath)
          .doc(user.uid)
          .set(publicUserData)

        logger.info(`${methodName}: public_users collection への書き込み完了`, {
          uid: user.uid,
          data: publicUserData,
        })
      } catch (firestoreError: any) {
        logger.error(
          `${methodName}: public_users collection への書き込み失敗`,
          {
            uid: user.uid,
            path: paths.publicUsersCollectionPath,
            error: firestoreError.message,
            code: firestoreError.code,
            stack: firestoreError.stack,
          },
        )
        throw firestoreError
      }

      // Stripe Customerを作成（既存実装に合わせる）
      logger.info(`${methodName}: Stripe Customer作成開始`, {
        uid: user.uid,
      })

      const customer = await getStripe()
        .customers.create(
          {
            name: user.displayName,
            email: user.email,
            phone: user.phoneNumber,
            metadata: { uid: user.uid },
          },
          stripeOptions,
        )
        .then(
          (result: Stripe.Response<Stripe.Customer>) => {
            logger.info(`${methodName}: Stripe Customer作成成功`, {
              uid: user.uid,
              customerId: result.id,
            })
            return result
          },
          (error: any) => {
            stripeErrors(error)
            throw new Error(error)
          },
        )

      // SetupIntent作成（既存実装に合わせる）
      logger.info(`${methodName}: SetupIntent作成開始`, {
        uid: user.uid,
        customerId: customer.id,
      })

      const intent = await getStripe()
        .setupIntents.create(
          {
            customer: customer.id,
          },
          stripeOptions,
        )
        .then(
          (result: Stripe.Response<Stripe.SetupIntent>) => {
            logger.info(`${methodName}: SetupIntent作成成功`, {
              uid: user.uid,
              setupIntentId: result.id,
            })
            return result
          },
          (error: any) => {
            stripeErrors(error)
            throw new Error(error)
          },
        )

      // Authenticationの認証で利用するユーザー属性に独自の情報(stripe)を追加（既存実装に合わせる）
      logger.info(`${methodName}: Custom Claims設定開始`, {
        uid: user.uid,
        customerId: customer.id,
      })

      await admin
        .auth()
        .setCustomUserClaims(user.uid, { customerId: customer.id })

      logger.info(`${methodName}: Custom Claims設定完了`, {
        uid: user.uid,
        customerId: customer.id,
      })

      // stripe_customers collection への登録（既存実装に合わせる）
      logger.info(
        `${methodName}: stripe_customers collection への書き込み開始`,
        {
          uid: user.uid,
          path: paths.customersCollectionPath,
        },
      )

      const customerData = {
        customer_id: customer.id,
        setup_secret: intent.client_secret,
        createdAt: new Date(),
        updatedAt: new Date(),
      }

      try {
        await db
          .collection(paths.customersCollectionPath)
          .doc(user.uid)
          .set(customerData)

        logger.info(
          `${methodName}: stripe_customers collection への書き込み完了`,
          {
            uid: user.uid,
            data: customerData,
          },
        )
      } catch (firestoreError: any) {
        logger.error(
          `${methodName}: stripe_customers collection への書き込み失敗`,
          {
            uid: user.uid,
            path: paths.customersCollectionPath,
            error: firestoreError.message,
            code: firestoreError.code,
            stack: firestoreError.stack,
          },
        )
        throw firestoreError
      }

      const duration = Date.now() - startTime
      logger.info(`${methodName}: ユーザー作成処理完了`, {
        uid: user.uid,
        customerId: customer.id,
        setupIntentId: intent.id,
        duration: `${duration}ms`,
      })
    } catch (error: any) {
      const duration = Date.now() - startTime
      ErrorHandler.logError(
        error,
        error instanceof Error ? error.stack : undefined,
        'auth/user.ts',
      )
      const appEx = ErrorHandler.convertToAppException(error, 'auth/user.ts')
      logger.error(`${methodName}: エラーが発生しました`, {
        uid: user.uid,
        error: appEx.message,
        stack: error instanceof Error ? error.stack : undefined,
        duration: `${duration}ms`,
      })
      // Authトリガーでは例外を投げない（再試行されるため）
    }
  })
