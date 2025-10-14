import { FieldValue } from 'firebase-admin/firestore'
import { onCall } from '../../utils/base_function'
import { V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// 投稿作成
export const v2_sns_post_createPost = onCall<{
  content: string
  imageUrls?: string[]
  eventId?: string
  productId?: string
  type?: string
}>(async (request) => {
  const methodName = 'v2_sns_post_createPost'

  try {
    V2Logger.start(methodName, request.data)

    const {
      content,
      imageUrls,
      eventId,
      productId,
      type = 'text',
    } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    if (!content || content.trim().length === 0) {
      throw new Error('Content is required')
    }

    // ユーザー情報を取得
    const userDoc = await db.collection('v/1/users').doc(userId).get()
    if (!userDoc.exists) {
      throw new Error('User not found')
    }

    const userData = userDoc.data()

    // 投稿データを作成
    const postData = {
      userId,
      userName: userData?.displayName || userData?.name || 'Unknown User',
      userPhotoUrl: userData?.photoUrl || null,
      content: content.trim(),
      imageUrls: imageUrls || [],
      eventId: eventId || null,
      productId: productId || null,
      type,
      likesCount: 0,
      commentsCount: 0,
      sharesCount: 0,
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    }

    // 投稿を作成
    const postRef = await db.collection('v/1/posts').add(postData)

    // ユーザープロフィールの投稿数を更新
    await db
      .collection('v/1/user_profiles')
      .doc(userId)
      .update({
        postsCount: FieldValue.increment(1),
        updatedAt: FieldValue.serverTimestamp(),
      })

    const createdPost = {
      id: postRef.id,
      ...postData,
    }

    V2Logger.success(methodName, { postId: postRef.id, userId })
    return createdPost
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// フィード取得
export const v2_sns_post_getFeed = onCall<{
  limit?: number
  lastPostId?: string
}>(async (request) => {
  const methodName = 'v2_sns_post_getFeed'

  try {
    V2Logger.start(methodName, request.data)

    const { limit = 20, lastPostId } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    // フォロー中のユーザーIDを取得
    const followingQuery = await db
      .collection('v/1/follows')
      .where('followerId', '==', userId)
      .where('status', '==', 'accepted')
      .get()

    const followingUserIds = followingQuery.docs.map(
      (doc) => doc.data().followingId,
    )
    followingUserIds.push(userId) // 自分の投稿も含める

    // 投稿を取得
    let postsQuery = db
      .collection('v/1/posts')
      .where('userId', 'in', followingUserIds)
      .orderBy('createdAt', 'desc')
      .limit(limit)

    if (lastPostId) {
      const lastPostDoc = await db.collection('v/1/posts').doc(lastPostId).get()
      if (lastPostDoc.exists) {
        postsQuery = postsQuery.startAfter(lastPostDoc)
      }
    }

    const postsSnapshot = await postsQuery.get()
    const posts = postsSnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }))

    V2Logger.success(methodName, { userId, count: posts.length })
    return { posts }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// いいね追加
export const v2_sns_post_likePost = onCall<{ postId: string }>(
  async (request) => {
    const methodName = 'v2_sns_post_likePost'

    try {
      V2Logger.start(methodName, request.data)

      const { postId } = request.data
      const userId = request.auth?.uid

      if (!userId) {
        throw new Error('Authentication required')
      }

      if (!postId) {
        throw new Error('postId is required')
      }

      // ユーザー情報を取得
      const userDoc = await db.collection('v/1/users').doc(userId).get()
      if (!userDoc.exists) {
        throw new Error('User not found')
      }

      const userData = userDoc.data()

      await db.runTransaction(async (transaction) => {
        // 既存のいいねをチェック
        const existingLikeQuery = await db
          .collection('v/1/post_likes')
          .where('postId', '==', postId)
          .where('userId', '==', userId)
          .limit(1)
          .get()

        if (!existingLikeQuery.empty) {
          throw new Error('Already liked this post')
        }

        // いいねを作成
        const likeData = {
          postId,
          userId,
          userName: userData?.displayName || userData?.name || 'Unknown User',
          createdAt: FieldValue.serverTimestamp(),
        }

        const likeRef = db.collection('v/1/post_likes').doc()
        transaction.set(likeRef, likeData)

        // 投稿のいいね数を更新
        const postRef = db.collection('v/1/posts').doc(postId)
        transaction.update(postRef, {
          likesCount: FieldValue.increment(1),
          updatedAt: FieldValue.serverTimestamp(),
        })
      })

      V2Logger.success(methodName, { postId, userId })
      return { success: true }
    } catch (error: any) {
      V2Logger.error(methodName, error, request.data)
      const appEx = ErrorHandler.convertToAppException(error, methodName)
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)

// いいね削除
export const v2_sns_post_unlikePost = onCall<{ postId: string }>(
  async (request) => {
    const methodName = 'v2_sns_post_unlikePost'

    try {
      V2Logger.start(methodName, request.data)

      const { postId } = request.data
      const userId = request.auth?.uid

      if (!userId) {
        throw new Error('Authentication required')
      }

      if (!postId) {
        throw new Error('postId is required')
      }

      await db.runTransaction(async (transaction) => {
        // 既存のいいねを取得
        const likeQuery = await db
          .collection('v/1/post_likes')
          .where('postId', '==', postId)
          .where('userId', '==', userId)
          .limit(1)
          .get()

        if (likeQuery.empty) {
          throw new Error('Like not found')
        }

        // いいねを削除
        const likeDoc = likeQuery.docs[0]
        transaction.delete(likeDoc.ref)

        // 投稿のいいね数を更新
        const postRef = db.collection('v/1/posts').doc(postId)
        transaction.update(postRef, {
          likesCount: FieldValue.increment(-1),
          updatedAt: FieldValue.serverTimestamp(),
        })
      })

      V2Logger.success(methodName, { postId, userId })
      return { success: true }
    } catch (error: any) {
      V2Logger.error(methodName, error, request.data)
      const appEx = ErrorHandler.convertToAppException(error, methodName)
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)
