import * as functions from 'firebase-functions/v1'
import * as admin from 'firebase-admin'
import { ErrorHandler } from '../../utils/error_handler'
import { getStripe, stripeOptions } from '../payment/utils'
import Stripe from 'stripe'
import paths from '../firestore/utils/db_paths'
import stripeErrors from '../payment/utils/stripe_error'
import { logger } from '../../utils/logger'
import { defineSecret } from 'firebase-functions/params'
import { onCall } from '../../utils/base_function'
import { getRequestingUserId } from '../../utils/firebase_utils'

// Firebase Functionsのシークレット定義
const stripeSecret = defineSecret('STRIPE_SECRET')

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
    secrets: [stripeSecret],
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

/**
 * 個別ユーザーのStripe Customer修復機能
 * 指定されたユーザーのStripe Customerが正しく設定されていない場合、再設定する
 */
export const repairUserStripeCustomer = onCall<{ uid?: string }>(
  async (request) => {
    const methodName = 'repairUserStripeCustomer'
    const startTime = Date.now()

    try {
      // 認証チェック
      const uid = getRequestingUserId(request)
      if (!uid) {
        throw new Error('認証が必要です')
      }

      // 管理者権限チェック（オプション）
      const user = await admin.auth().getUser(uid)
      const isAdmin =
        user.customClaims?.role === 'admin' ||
        user.customClaims?.isAdmin === true

      // 修復対象のUIDを取得（管理者の場合は指定されたUID、そうでなければ自分のUID）
      const targetUid = isAdmin ? request.data.uid : uid

      if (!targetUid) {
        throw new Error('修復対象のユーザーIDが指定されていません')
      }

      logger.info(`${methodName}: 修復処理開始`, {
        requestUid: uid,
        targetUid: targetUid,
        isAdmin: isAdmin,
      })

      // 1. ユーザーの状態確認
      const targetUser = await admin.auth().getUser(targetUid)
      const existingCustomerId = targetUser.customClaims?.customerId

      // 2. Firestoreの状態確認
      const userDoc = await db
        .collection(paths.usersCollectionPath)
        .doc(targetUid)
        .get()
      if (!userDoc.exists) {
        throw new Error(`ユーザー ${targetUid} が存在しません`)
      }

      const customerDoc = await db
        .collection(paths.customersCollectionPath)
        .doc(targetUid)
        .get()
      const hasCustomerDoc = customerDoc.exists

      logger.info(`${methodName}: ユーザー状態確認`, {
        targetUid: targetUid,
        hasCustomClaimsCustomerId: !!existingCustomerId,
        existingCustomerId: existingCustomerId,
        hasCustomerDoc: hasCustomerDoc,
      })

      // 3. 修復が必要かどうか判定
      const needsRepair = !existingCustomerId || !hasCustomerDoc

      if (!needsRepair) {
        logger.info(`${methodName}: 修復不要 - 既に正しく設定されています`, {
          targetUid: targetUid,
          customerId: existingCustomerId,
        })
        return {
          success: true,
          message: '修復不要 - 既に正しく設定されています',
          customerId: existingCustomerId,
          repaired: false,
        }
      }

      // 4. Stripe Customerの作成/取得
      let customerId = existingCustomerId
      let setupSecret: string | null = null

      if (!customerId) {
        // 新しいStripe Customerを作成
        logger.info(`${methodName}: 新規Stripe Customer作成開始`, {
          targetUid: targetUid,
          email: targetUser.email,
          displayName: targetUser.displayName,
        })

        const userData = userDoc.data()
        const customer = await getStripe()
          .customers.create(
            {
              name: targetUser.displayName || userData?.displayName,
              email: targetUser.email,
              phone: targetUser.phoneNumber,
              metadata: { uid: targetUid },
            },
            stripeOptions,
          )
          .then(
            (result: Stripe.Response<Stripe.Customer>) => {
              logger.info(`${methodName}: Stripe Customer作成成功`, {
                targetUid: targetUid,
                customerId: result.id,
              })
              return result
            },
            (error: any) => {
              stripeErrors(error)
              throw new Error(error)
            },
          )

        customerId = customer.id

        // SetupIntent作成
        const intent = await getStripe()
          .setupIntents.create(
            {
              customer: customerId,
            },
            stripeOptions,
          )
          .then(
            (result: Stripe.Response<Stripe.SetupIntent>) => {
              logger.info(`${methodName}: SetupIntent作成成功`, {
                targetUid: targetUid,
                setupIntentId: result.id,
              })
              return result
            },
            (error: any) => {
              stripeErrors(error)
              throw new Error(error)
            },
          )

        setupSecret = intent.client_secret
      } else {
        // 既存のCustomer IDがある場合は、Stripeから情報を取得
        logger.info(`${methodName}: 既存Stripe Customer確認`, {
          targetUid: targetUid,
          customerId: customerId,
        })

        try {
          const customer = await getStripe().customers.retrieve(
            customerId,
            stripeOptions,
          )
          if (customer.deleted) {
            throw new Error('Stripe Customerが削除されています')
          }
          logger.info(`${methodName}: 既存Stripe Customer確認成功`, {
            targetUid: targetUid,
            customerId: customerId,
          })
        } catch (error: any) {
          logger.warn(
            `${methodName}: 既存Stripe Customerが無効です。新規作成します`,
            {
              targetUid: targetUid,
              customerId: customerId,
              error: error.message,
            },
          )

          // 無効なCustomer IDの場合は新規作成
          const userData = userDoc.data()
          const customer = await getStripe()
            .customers.create(
              {
                name: targetUser.displayName || userData?.displayName,
                email: targetUser.email,
                phone: targetUser.phoneNumber,
                metadata: { uid: targetUid },
              },
              stripeOptions,
            )
            .then(
              (result: Stripe.Response<Stripe.Customer>) => {
                logger.info(`${methodName}: 新規Stripe Customer作成成功`, {
                  targetUid: targetUid,
                  customerId: result.id,
                })
                return result
              },
              (error: any) => {
                stripeErrors(error)
                throw new Error(error)
              },
            )

          customerId = customer.id

          // SetupIntent作成
          const intent = await getStripe()
            .setupIntents.create(
              {
                customer: customerId,
              },
              stripeOptions,
            )
            .then(
              (result: Stripe.Response<Stripe.SetupIntent>) => {
                logger.info(`${methodName}: SetupIntent作成成功`, {
                  targetUid: targetUid,
                  setupIntentId: result.id,
                })
                return result
              },
              (error: any) => {
                stripeErrors(error)
                throw new Error(error)
              },
            )

          setupSecret = intent.client_secret
        }
      }

      // 5. カスタムクレームの更新
      logger.info(`${methodName}: Custom Claims更新開始`, {
        targetUid: targetUid,
        customerId: customerId,
      })

      await admin
        .auth()
        .setCustomUserClaims(targetUid, { customerId: customerId })

      logger.info(`${methodName}: Custom Claims更新完了`, {
        targetUid: targetUid,
        customerId: customerId,
      })

      // 6. Firestoreの更新
      if (!hasCustomerDoc || setupSecret) {
        logger.info(`${methodName}: stripe_customers collection更新開始`, {
          targetUid: targetUid,
          path: paths.customersCollectionPath,
        })

        const customerData = {
          customer_id: customerId,
          ...(setupSecret && { setup_secret: setupSecret }),
          updatedAt: new Date(),
          ...(setupSecret && { createdAt: new Date() }),
        }

        try {
          await db
            .collection(paths.customersCollectionPath)
            .doc(targetUid)
            .set(customerData, { merge: true })

          logger.info(`${methodName}: stripe_customers collection更新完了`, {
            targetUid: targetUid,
            data: customerData,
          })
        } catch (firestoreError: any) {
          logger.error(`${methodName}: stripe_customers collection更新失敗`, {
            targetUid: targetUid,
            path: paths.customersCollectionPath,
            error: firestoreError.message,
            code: firestoreError.code,
            stack: firestoreError.stack,
          })
          throw firestoreError
        }
      }

      const duration = Date.now() - startTime
      logger.info(`${methodName}: 修復処理完了`, {
        targetUid: targetUid,
        customerId: customerId,
        duration: `${duration}ms`,
      })

      return {
        success: true,
        message: 'Stripe Customer修復が完了しました',
        customerId: customerId,
        repaired: true,
        duration: `${duration}ms`,
      }
    } catch (error: any) {
      const duration = Date.now() - startTime
      ErrorHandler.logError(
        error,
        error instanceof Error ? error.stack : undefined,
        'auth/user.ts',
      )
      const appEx = ErrorHandler.convertToAppException(error, 'auth/user.ts')
      logger.error(`${methodName}: エラーが発生しました`, {
        error: appEx.message,
        stack: error instanceof Error ? error.stack : undefined,
        duration: `${duration}ms`,
      })
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)

/**
 * 管理者権限を設定する関数（開発用）
 * 注意: 本番環境では適切な認証・認可を実装してください
 */
export const setAdminRole = onCall<{ uid: string; isAdmin: boolean }>(
  async (request) => {
    const methodName = 'setAdminRole'

    try {
      // 認証チェック
      const uid = getRequestingUserId(request)
      if (!uid) {
        throw new Error('認証が必要です')
      }

      const { uid: targetUid, isAdmin } = request.data

      if (!targetUid) {
        throw new Error('対象ユーザーIDが指定されていません')
      }

      logger.info(`${methodName}: 管理者権限設定開始`, {
        requestUid: uid,
        targetUid: targetUid,
        isAdmin: isAdmin,
      })

      // 対象ユーザーの現在のカスタムクレームを取得
      const targetUser = await admin.auth().getUser(targetUid)
      const currentClaims = targetUser.customClaims || {}

      // 管理者権限を更新
      const updatedClaims = {
        ...currentClaims,
        isAdmin: isAdmin,
        role: isAdmin ? 'admin' : undefined,
      }

      // カスタムクレームを更新
      await admin.auth().setCustomUserClaims(targetUid, updatedClaims)

      logger.info(`${methodName}: 管理者権限設定完了`, {
        targetUid: targetUid,
        isAdmin: isAdmin,
      })

      return {
        success: true,
        message: `管理者権限を${isAdmin ? '設定' : '解除'}しました`,
        targetUid: targetUid,
        isAdmin: isAdmin,
      }
    } catch (error: any) {
      ErrorHandler.logError(
        error,
        error instanceof Error ? error.stack : undefined,
        'auth/user.ts',
      )
      const appEx = ErrorHandler.convertToAppException(error, 'auth/user.ts')
      logger.error(`${methodName}: エラーが発生しました`, {
        error: appEx.message,
        stack: error instanceof Error ? error.stack : undefined,
      })
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)
