import { db } from './firebase_utils'
import { HttpsError, Request } from 'firebase-functions/v2/https'

/**
 * 共通のCRUD操作を行うベースクラス
 */
export abstract class BaseCrudController {
  protected abstract collectionName: string
  protected abstract entityName: string

  /**
   * エンティティを作成する
   * @param request リクエストデータ
   * @return 作成されたエンティティのID
   */
  public async create(request: Request): Promise<{ [key: string]: string }> {
    const data = request.data
    const ref = db.collection(this.collectionName).doc()
    const id = ref.id

    await ref.set({
      ...data,
      createdAt: new Date(),
      updatedAt: new Date(),
    })

    return { [`${this.entityName}Id`]: id }
  }

  /**
   * エンティティを取得する
   * @param request リクエストデータ
   * @return エンティティデータ
   */
  public async retrieve(request: Request): Promise<Record<string, unknown>> {
    const id = request.data.id
    if (!id) {
      throw new HttpsError('invalid-argument', 'ID is required')
    }

    const doc = await db.collection(this.collectionName).doc(id).get()
    if (!doc.exists) {
      throw new HttpsError('not-found', `${this.entityName} not found`)
    }

    return { id: doc.id, ...doc.data() }
  }

  /**
   * エンティティを更新する
   * @param request リクエストデータ
   * @return Promise<void>
   */
  public async update(request: Request): Promise<void> {
    const id = request.data.id
    const data = request.data

    if (!id) {
      throw new HttpsError('invalid-argument', 'ID is required')
    }

    await db
      .collection(this.collectionName)
      .doc(id)
      .update({
        ...data,
        updatedAt: new Date(),
      })
  }

  /**
   * エンティティを削除する
   * @param request リクエストデータ
   * @return Promise<void>
   */
  public async delete(request: Request): Promise<void> {
    const id = request.data.id
    if (!id) {
      throw new HttpsError('invalid-argument', 'ID is required')
    }

    await db.collection(this.collectionName).doc(id).delete()
  }
}
