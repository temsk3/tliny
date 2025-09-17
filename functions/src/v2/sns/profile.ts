import { FieldValue } from 'firebase-admin/firestore'
import { onCall } from '../../utils/base_function'
import { V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// プロファイル取得
export const v2_sns_profile_getProfile = onCall(async (request) => {
  const methodName = 'v2_sns_profile_getProfile'

  try {
    V2Logger.start(methodName, request.data)

    const { userId } = request.data

    if (!userId) {
      throw new Error('userId is required')
    }

    // プロファイル情報を取得
    const profileDoc = await db
      .collection('v/1/user_profiles')
      .doc(userId)
      .get()

    if (!profileDoc.exists) {
      // プロファイルが存在しない場合は基本情報で作成
      const userDoc = await db.collection('v/1/users').doc(userId).get()
      if (!userDoc.exists) {
        throw new Error('User not found')
      }

      const userData = userDoc.data()
      const defaultProfile = {
        userId,
        displayName: userData?.name || 'Unknown User',
        bio: '',
        profileImageUrl: userData?.photoURL || null,
        coverImageUrl: null,
        followersCount: 0,
        followingCount: 0,
        postsCount: 0,
        isPrivate: false,
        createdAt: FieldValue.serverTimestamp(),
        updatedAt: FieldValue.serverTimestamp(),
      }

      await db.collection('v/1/user_profiles').doc(userId).set(defaultProfile)

      V2Logger.success(methodName, { userId, created: true })
      return {
        profile: {
          id: userId,
          ...defaultProfile,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      }
    }

    const profile = {
      id: profileDoc.id,
      ...profileDoc.data(),
    }

    V2Logger.success(methodName, { userId })
    return { profile }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// プロファイル更新
export const v2_sns_profile_updateProfile = onCall(async (request) => {
  const methodName = 'v2_sns_profile_updateProfile'

  try {
    V2Logger.start(methodName, request.data)

    const { displayName, bio, profileImageUrl, coverImageUrl, isPrivate } =
      request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    // 更新可能なフィールドのみを抽出
    const updateData: any = {
      updatedAt: FieldValue.serverTimestamp(),
    }

    if (displayName !== undefined) updateData.displayName = displayName
    if (bio !== undefined) updateData.bio = bio
    if (profileImageUrl !== undefined)
      updateData.profileImageUrl = profileImageUrl
    if (coverImageUrl !== undefined) updateData.coverImageUrl = coverImageUrl
    if (isPrivate !== undefined) updateData.isPrivate = isPrivate

    // プロファイルを更新
    await db.collection('v/1/user_profiles').doc(userId).update(updateData)

    // 更新後のプロファイルを取得
    const updatedProfile = await db
      .collection('v/1/user_profiles')
      .doc(userId)
      .get()
    const profile = {
      id: updatedProfile.id,
      ...updatedProfile.data(),
    }

    V2Logger.success(methodName, {
      userId,
      fieldsUpdated: Object.keys(updateData),
    })
    return { profile }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// ユーザーの投稿一覧取得
export const v2_sns_profile_getUserPosts = onCall(async (request) => {
  const methodName = 'v2_sns_profile_getUserPosts'

  try {
    V2Logger.start(methodName, request.data)

    const { userId, limit = 20, lastPostId } = request.data

    if (!userId) {
      throw new Error('userId is required')
    }

    let query = db
      .collection('v/1/posts')
      .where('userId', '==', userId)
      .where('deletedAt', '==', null)
      .orderBy('createdAt', 'desc')
      .limit(limit)

    // ページネーション対応
    if (lastPostId) {
      const lastPostDoc = await db.collection('v/1/posts').doc(lastPostId).get()
      if (lastPostDoc.exists) {
        query = query.startAfter(lastPostDoc)
      }
    }

    const postsSnapshot = await query.get()
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

// フォロー状態チェック
export const v2_sns_profile_checkFollowStatus = onCall(async (request) => {
  const methodName = 'v2_sns_profile_checkFollowStatus'

  try {
    V2Logger.start(methodName, request.data)

    const { targetUserId } = request.data
    const currentUserId = request.auth?.uid

    if (!currentUserId) {
      throw new Error('Authentication required')
    }

    if (!targetUserId) {
      throw new Error('targetUserId is required')
    }

    if (currentUserId === targetUserId) {
      V2Logger.success(methodName, { isOwnProfile: true })
      return { isFollowing: false, isOwnProfile: true }
    }

    // フォロー関係をチェック
    const followQuery = await db
      .collection('v/1/follows')
      .where('followerId', '==', currentUserId)
      .where('followingId', '==', targetUserId)
      .where('status', '==', 'accepted')
      .limit(1)
      .get()

    const isFollowing = !followQuery.empty

    V2Logger.success(methodName, { currentUserId, targetUserId, isFollowing })
    return { isFollowing, isOwnProfile: false }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})
