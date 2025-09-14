import * as functions from 'firebase-functions/v2'
import * as admin from 'firebase-admin'
import * as crypto from 'crypto'

/**
 * Generate unique secret URL for secret events
 */
function generateSecretUrl(programId: string): string {
  const randomString = crypto.randomBytes(16).toString('hex')
  return `${programId}-${randomString}`
}

/**
 * Programドキュメント作成時のトリガー
 * シークレットイベントの場合、専用URLを生成
 */
export const onProgramCreated = functions.firestore.onDocumentCreated(
  {
    document: 'programs/{programId}',
    region: 'asia-northeast1',
  },
  async (event) => {
    const snapshot = event.data
    if (!snapshot) {
      console.log('No data associated with the event')
      return
    }

    const data = snapshot.data()
    const programId = event.params.programId

    // シークレットイベントの場合、専用URLを生成
    if (data.isSecret === true && !data.secretUrl) {
      const secretUrl = generateSecretUrl(programId)

      try {
        await snapshot.ref.update({
          secretUrl: secretUrl,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        })

        console.log(`Secret URL generated for program ${programId}: ${secretUrl}`)
      } catch (error) {
        console.error(`Failed to update secret URL for program ${programId}:`, error)
      }
    }
  }
)

/**
 * Programドキュメント更新時のトリガー
 * シークレット設定が変更された場合の処理
 */
export const onProgramUpdated = functions.firestore.onDocumentUpdated(
  {
    document: 'programs/{programId}',
    region: 'asia-northeast1',
  },
  async (event) => {
    const beforeData = event.data?.before.data()
    const afterData = event.data?.after.data()

    if (!beforeData || !afterData) {
      console.log('No data associated with the event')
      return
    }

    const programId = event.params.programId

    // シークレット設定がONになった場合
    if (beforeData.isSecret === false && afterData.isSecret === true && !afterData.secretUrl) {
      const secretUrl = generateSecretUrl(programId)

      try {
        await event.data.after.ref.update({
          secretUrl: secretUrl,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        })

        console.log(`Secret URL generated for program ${programId}: ${secretUrl}`)
      } catch (error) {
        console.error(`Failed to update secret URL for program ${programId}:`, error)
      }
    }

    // シークレット設定がOFFになった場合
    if (beforeData.isSecret === true && afterData.isSecret === false) {
      try {
        await event.data.after.ref.update({
          secretUrl: admin.firestore.FieldValue.delete(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        })

        console.log(`Secret URL removed for program ${programId}`)
      } catch (error) {
        console.error(`Failed to remove secret URL for program ${programId}:`, error)
      }
    }
  }
)