import { FieldValue } from 'firebase-admin/firestore'
import { onCall } from '../../utils/base_function'
import { V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// フォロー作成
export const v2_sns_follow_createFollow = onCall(async (request) => {
  const methodName = 'v2_sns_follow_createFollow'

  try {
    V2Logger.start(methodName, request.data)

    const { followingId } = request.data
    const followerId = request.auth?.uid

    if (!followerId) {
      throw new Error('Authentication required')
    }

    if (!followingId) {
      throw new Error('followingId is required')
    }

    if (followerId === followingId) {
      throw new Error('Cannot follow yourself')
    }

    // フォロー関係をFirestoreに作成
    const followDoc = {
      followerId,
      followingId,
      status: 'accepted',
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    }

    await db.runTransaction(async (transaction) => {
      // 既存のフォロー関係をチェック
      const existingFollowQuery = await db
        .collection('v/1/follows')
        .where('followerId', '==', followerId)
        .where('followingId', '==', followingId)
        .limit(1)
        .get()

      if (!existingFollowQuery.empty) {
        throw new Error('Already following this user')
      }

      // フォロー関係を作成
      const followRef = db.collection('v/1/follows').doc()
      transaction.set(followRef, followDoc)

      // フォロワー数とフォロー数を更新
      const followerProfileRef = db
        .collection('v/1/user_profiles')
        .doc(followerId)
      const followingProfileRef = db
        .collection('v/1/user_profiles')
        .doc(followingId)

      transaction.update(followerProfileRef, {
        followingCount: FieldValue.increment(1),
        updatedAt: FieldValue.serverTimestamp(),
      })

      transaction.update(followingProfileRef, {
        followersCount: FieldValue.increment(1),
        updatedAt: FieldValue.serverTimestamp(),
      })
    })

    V2Logger.success(methodName, { followerId, followingId })
    return { success: true }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// フォロー削除
export const v2_sns_follow_deleteFollow = onCall(async (request) => {
  const methodName = 'v2_sns_follow_deleteFollow'

  try {
    V2Logger.start(methodName, request.data)

    const { followingId } = request.data
    const followerId = request.auth?.uid

    if (!followerId) {
      throw new Error('Authentication required')
    }

    if (!followingId) {
      throw new Error('followingId is required')
    }

    await db.runTransaction(async (transaction) => {
      // 既存のフォロー関係を取得
      const followQuery = await db
        .collection('v/1/follows')
        .where('followerId', '==', followerId)
        .where('followingId', '==', followingId)
        .limit(1)
        .get()

      if (followQuery.empty) {
        throw new Error('Follow relationship not found')
      }

      // フォロー関係を削除
      const followDoc = followQuery.docs[0]
      transaction.delete(followDoc.ref)

      // フォロワー数とフォロー数を更新
      const followerProfileRef = db
        .collection('v/1/user_profiles')
        .doc(followerId)
      const followingProfileRef = db
        .collection('v/1/user_profiles')
        .doc(followingId)

      transaction.update(followerProfileRef, {
        followingCount: FieldValue.increment(-1),
        updatedAt: FieldValue.serverTimestamp(),
      })

      transaction.update(followingProfileRef, {
        followersCount: FieldValue.increment(-1),
        updatedAt: FieldValue.serverTimestamp(),
      })
    })

    V2Logger.success(methodName, { followerId, followingId })
    return { success: true }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// フォロワー一覧取得
export const v2_sns_follow_getFollowers = onCall(async (request) => {
  const methodName = 'v2_sns_follow_getFollowers'

  try {
    V2Logger.start(methodName, request.data)

    const { userId, limit = 20 } = request.data

    if (!userId) {
      throw new Error('userId is required')
    }

    const followersQuery = await db
      .collection('v/1/follows')
      .where('followingId', '==', userId)
      .where('status', '==', 'accepted')
      .orderBy('createdAt', 'desc')
      .limit(limit)
      .get()

    const followers = followersQuery.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }))

    V2Logger.success(methodName, { userId, count: followers.length })
    return { followers }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// フォロー中一覧取得
export const v2_sns_follow_getFollowing = onCall(async (request) => {
  const methodName = 'v2_sns_follow_getFollowing'

  try {
    V2Logger.start(methodName, request.data)

    const { userId, limit = 20 } = request.data

    if (!userId) {
      throw new Error('userId is required')
    }

    const followingQuery = await db
      .collection('v/1/follows')
      .where('followerId', '==', userId)
      .where('status', '==', 'accepted')
      .orderBy('createdAt', 'desc')
      .limit(limit)
      .get()

    const following = followingQuery.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }))

    V2Logger.success(methodName, { userId, count: following.length })
    return { following }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})
