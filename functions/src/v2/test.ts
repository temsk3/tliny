import { onCall } from '../utils/base_function'
import { onRequest } from 'firebase-functions/v2/https'
import * as admin from 'firebase-admin'
import { logger } from '../utils/logger'
import { getStripe, stripeOptions } from './payment/utils'
import { defineSecret } from 'firebase-functions/params'

// Firebase Functionsのシークレット定義
const stripeSecret = defineSecret('STRIPE_SECRET')

// Firebase Admin初期化
if (!admin.apps.length) {
  admin.initializeApp()
}

const db = admin.firestore()

// テスト用の簡単な関数
const testFunction = onCall(async (request) => {
  console.log('Test function called with data:', request.data)
  return {
    message: 'Test function executed successfully',
    timestamp: new Date().toISOString(),
    data: request.data,
  }
})

// 認証不要のHTTP関数（テスト用）
const testHttpFunction = onRequest(async (request, response) => {
  console.log('Test HTTP function called')

  // CORS設定
  response.set('Access-Control-Allow-Origin', '*')
  response.set('Access-Control-Allow-Methods', 'GET, POST')
  response.set('Access-Control-Allow-Headers', 'Content-Type')

  if (request.method === 'OPTIONS') {
    response.status(204).send('')
    return
  }

  response.json({
    message: 'Test HTTP function executed successfully',
    timestamp: new Date().toISOString(),
    method: request.method,
    data: request.body,
  })
})

/**
 * テスト用: 問題のあるユーザーを修復するHTTP関数
 * 注意: 本番環境では使用しないでください
 * curl -X POST "https://testrepairbrokenusers-dhje5kbrsa-uc.a.run.app" -H "Content-Type: application/json" -d '{"uid": "ここに"}'
 */
export const testRepairBrokenUsers = onRequest(
  {
    secrets: [stripeSecret],
  },
  async (request, response) => {
    const methodName = 'testRepairBrokenUsers'

    try {
      // CORS設定
      response.set('Access-Control-Allow-Origin', '*')
      response.set('Access-Control-Allow-Methods', 'GET, POST')
      response.set('Access-Control-Allow-Headers', 'Content-Type')

      if (request.method === 'OPTIONS') {
        response.status(204).send('')
        return
      }

      // ユーザーIDの取得
      let targetUsers: string[] = []

      if (request.method === 'POST' && request.body) {
        // POSTリクエストでユーザーIDを指定
        const { uid, uids } = request.body

        if (uid) {
          // 単一ユーザーID
          targetUsers = [uid]
        } else if (uids && Array.isArray(uids)) {
          // 複数ユーザーID
          targetUsers = uids
        } else {
          response.status(400).json({
            success: false,
            error: 'POSTリクエストには uid または uids が必要です',
            example: {
              single: { uid: 'user_id_here' },
              multiple: { uids: ['user_id_1', 'user_id_2'] },
            },
          })
          return
        }
      } else {
        // GETリクエストの場合は既存のユーザーリストを使用
        targetUsers = [
          'GCwiGHPGcqPcjvszdn4x79zITDo2', // temsk3@icloud.com
          'YhGZvpsWcMgxgbj746pQIV6FLLI2', // test@gmail.com
          '98nAd1mPm4dBfpSb6WbmBUbH55o2',
          '3bMapHYtVFNFF2UeUIgdDyrV4AH2',
          'UielNxoODPVGigk1gC3gtIetz6p2',
          'cte8HA0b3TYBP1BitwrozrqpVJm1',
          'yvh85qHWVIOgpVC9NVfJclkiWxh2',
          'sFFzc3NG0jQXsCPIrwe928HD6li2',
          '5vVgDNXR3rYqOgfoQnCKLBoShqN2',
        ]
      }

      const results = []

      for (const uid of targetUsers) {
        try {
          logger.info(`${methodName}: ユーザー修復開始`, { uid })

          // ユーザーの状態確認
          const user = await admin.auth().getUser(uid)
          const existingCustomerId = user.customClaims?.customerId

          // Firestoreの状態確認
          const userDoc = await db.collection('v/1/users').doc(uid).get()
          if (!userDoc.exists) {
            results.push({
              uid,
              success: false,
              error: 'User not found in Firestore',
            })
            continue
          }

          const customerDoc = await db
            .collection('v/1/stripe_customers')
            .doc(uid)
            .get()
          const hasCustomerDoc = customerDoc.exists

          logger.info(`${methodName}: ユーザー状態確認`, {
            uid,
            hasCustomClaimsCustomerId: !!existingCustomerId,
            existingCustomerId,
            hasCustomerDoc,
          })

          // 修復が必要かどうか判定
          const needsRepair = !existingCustomerId || !hasCustomerDoc

          if (!needsRepair) {
            results.push({
              uid,
              success: true,
              message: 'Already properly configured',
              customerId: existingCustomerId,
              repaired: false,
            })
            continue
          }

          // Stripe Customerの作成
          const userData = userDoc.data()
          const customer = await getStripe().customers.create(
            {
              name: user.displayName || userData?.displayName,
              email: user.email,
              phone: user.phoneNumber,
              metadata: { uid },
            },
            stripeOptions,
          )

          const customerId = customer.id

          // SetupIntent作成
          const intent = await getStripe().setupIntents.create(
            {
              customer: customerId,
            },
            stripeOptions,
          )

          // カスタムクレームの更新
          await admin.auth().setCustomUserClaims(uid, { customerId })

          // Firestoreの更新
          const customerData = {
            customer_id: customerId,
            setup_secret: intent.client_secret,
            createdAt: new Date(),
            updatedAt: new Date(),
          }

          await db.collection('v/1/stripe_customers').doc(uid).set(customerData)

          logger.info(`${methodName}: ユーザー修復完了`, { uid, customerId })

          results.push({
            uid,
            success: true,
            message: 'Stripe Customer repaired successfully',
            customerId,
            repaired: true,
          })
        } catch (error: any) {
          logger.error(`${methodName}: ユーザー修復失敗`, {
            uid,
            error: error.message,
          })
          results.push({
            uid,
            success: false,
            error: error.message,
          })
        }
      }

      response.status(200).json({
        success: true,
        message: 'Repair test completed',
        results,
      })
    } catch (error: any) {
      logger.error(`${methodName}: エラーが発生しました`, {
        error: error.message,
      })
      response.status(500).json({
        success: false,
        error: error.message,
      })
    }
  },
)

export {
  testFunction as 'v2_test_function',
  testHttpFunction as 'v2_test_http_function',
}
