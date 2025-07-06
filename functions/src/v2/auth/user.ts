import * as functions from 'firebase-functions/v1'
import * as admin from 'firebase-admin'
import { ErrorHandler } from '../../utils/error_handler'
import { getStripe, stripeOptions } from '../payment/utils'
import Stripe from 'stripe'
import paths from '../firestore/utils/db_paths'
import stripeErrors from '../payment/utils/stripe_error'
import { logger } from '../../utils/logger'

// Firestoreの初期化
if (!admin.apps.length) {
  admin.initializeApp()
}

const db = admin.firestore()

/**
 * 新規ユーザー作成時のトリガー
 * Firestoreにユーザードキュメントを作成し、Stripe Customerを作成する
 */
export const onUserCreatedTrigger = functions.auth
  .user()
  .onCreate(async (user) => {
    const methodName = 'onUserCreatedTrigger'

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

      // Stripe Customerを作成（既存実装に合わせる）
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
      await admin
        .auth()
        .setCustomUserClaims(user.uid, { customerId: customer.id })

      // stripe_customers collection への登録（既存実装に合わせる）
      await db.collection(paths.customersCollectionPath).doc(user.uid).set({
        customer_id: customer.id,
        setup_secret: intent.client_secret,
      })

      // 表示名の設定（既存実装に合わせる）
      let displayName: string | undefined = user.displayName
      if (!displayName || !displayName.trim()) {
        displayName = user.email?.substring(0, user.email.lastIndexOf('@'))
      } else {
        displayName = displayName.trim()
      }

      // users collection への登録（既存実装に合わせる）
      await db
        .collection(paths.usersCollectionPath)
        .doc(user.uid)
        .set({
          displayName: displayName,
          name: displayName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          photoUrl: user.photoURL,
          isActive: true,
          createdAt: new Date(new Date().getTime()),
        })

      // public_users への登録（既存実装に合わせる）
      await db
        .collection(paths.publicUsersCollectionPath)
        .doc(user.uid)
        .set({
          displayName: displayName,
          createdAt: new Date(new Date().getTime()),
        })

      logger.info(`${methodName}: ユーザー作成処理完了`, {
        uid: user.uid,
        customerId: customer.id,
        setupIntentId: intent.id,
      })
    } catch (error: any) {
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
      })
      // Authトリガーでは例外を投げない（再試行されるため）
    }
  })
