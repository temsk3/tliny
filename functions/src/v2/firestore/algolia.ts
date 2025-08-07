import * as functions from 'firebase-functions'
import algoliasearch from 'algoliasearch'
import { defineString } from 'firebase-functions/params'

import { logger } from '../../utils/logger'
import * as model from '../../firestore/utils/model'

// Algoliaの環境変数を取得
const appID = defineString('ALGOLIA_APP_ID')
const apiKey = defineString('ALGOLIA_API_KEY')
const indexName = defineString('ALGOLIA_INDEX_NAME')

// Algoliaクライアントを初期化
const client = algoliasearch(appID.value(), apiKey.value())
const index = client.initIndex(indexName.value())

/**
 * Firestoreの`products`コレクションの書き込みを監視し、
 * Algoliaのインデックスと同期するCloud Function
 */
const onProductWritten = functions
  .region('asia-northeast1')
  .firestore.document('v/1/products/{productId}')
  .onWrite(async (change, context) => {
    const { productId } = context.params
    logger.info(`Algolia sync triggered for product: ${productId}`)

    // ドキュメントが削除された（またはisActive: falseになった）場合
    const isDeleted = !change.after.exists || !change.after.data()?.isActive
    if (isDeleted) {
      try {
        await index.deleteObject(productId)
        logger.info(`Successfully deleted product from Algolia: ${productId}`)
      } catch (error) {
        logger.error(
          `Error deleting product from Algolia: ${productId}`,
          error,
        )
      }
      return
    }

    // ドキュメントが作成または更新された場合
    const productData = change.after.data() as model.Product
    if (!productData) {
      logger.warn(`Product data is null for ${productId}. Skipping sync.`)
      return
    }

    // Algoliaに保存するレコードを作成
    // 必要なフィールドのみを抽出
    const record = {
      objectID: productId,
      name: productData.name,
      desc: productData.desc,
      price: productData.price,
      pictureURL: productData.pictureURL,
      genre: productData.genre,
      eventId: productData.eventId,
      eventName: productData.eventName,
      organizerId: productData.organizerId,
    }

    try {
      await index.saveObject(record)
      logger.info(`Successfully saved product to Algolia: ${productId}`)
    } catch (error) {
      logger.error(`Error saving product to Algolia: ${productId}`, error)
    }
  })

export { onProductWritten as 'v2_firestore_onProductWritten' }
