import { FieldValue } from 'firebase-admin/firestore'
import { onCall } from '../../utils/base_function'
import { V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// コンテンツ共有
export const v2_sns_share_shareContent = onCall<{
  contentId: string
  contentType: string
  platform: string
  customMessage?: string
}>(async (request) => {
  const methodName = 'v2_sns_share_shareContent'

  try {
    V2Logger.start(methodName, request.data)

    const { contentId, contentType, platform, customMessage } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    if (!contentId) {
      throw new Error('contentId is required')
    }

    if (!contentType) {
      throw new Error('contentType is required')
    }

    if (!platform) {
      throw new Error('platform is required')
    }

    // ユーザー情報を取得
    const userDoc = await db.collection('v/1/users').doc(userId).get()
    if (!userDoc.exists) {
      throw new Error('User not found')
    }

    const userData = userDoc.data()

    // 共有対象のコンテンツを取得
    let contentData = null
    let shareUrl = ''

    if (contentType === 'event') {
      const eventDoc = await db.collection('v/1/events').doc(contentId).get()
      if (!eventDoc.exists) {
        throw new Error('Event not found')
      }
      contentData = eventDoc.data()
      shareUrl = `https://tliny.com/events/${contentId}`
    } else if (contentType === 'product') {
      const productDoc = await db
        .collection('v/1/products')
        .doc(contentId)
        .get()
      if (!productDoc.exists) {
        throw new Error('Product not found')
      }
      contentData = productDoc.data()
      shareUrl = `https://tliny.com/products/${contentId}`
    } else if (contentType === 'post') {
      const postDoc = await db.collection('v/1/posts').doc(contentId).get()
      if (!postDoc.exists) {
        throw new Error('Post not found')
      }
      contentData = postDoc.data()
      shareUrl = `https://tliny.com/posts/${contentId}`
    } else {
      throw new Error('Invalid content type')
    }

    // 共有アクティビティを作成
    const shareData = {
      userId,
      userName: userData?.displayName || userData?.name || 'Unknown User',
      userPhotoUrl: userData?.photoUrl || null,
      contentId,
      contentType,
      platform,
      sharedUrl: shareUrl,
      customMessage: customMessage || null,
      contentTitle:
        contentData?.name || contentData?.title || 'Unknown Content',
      createdAt: FieldValue.serverTimestamp(),
    }

    const shareRef = await db.collection('v/1/share_activities').add(shareData)

    // コンテンツの共有数を更新（該当するコレクションがある場合）
    if (contentType === 'post') {
      await db
        .collection('v/1/posts')
        .doc(contentId)
        .update({
          sharesCount: FieldValue.increment(1),
          updatedAt: FieldValue.serverTimestamp(),
        })
    }

    const createdShare = {
      id: shareRef.id,
      ...shareData,
    }

    V2Logger.success(methodName, {
      shareId: shareRef.id,
      userId,
      contentId,
      platform,
    })
    return createdShare
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// 共有可能なURLを生成
export const v2_sns_share_generateShareUrl = onCall<{
  contentId: string
  contentType: string
  platform: string
}>(async (request) => {
  const methodName = 'v2_sns_share_generateShareUrl'

  try {
    V2Logger.start(methodName, request.data)

    const { contentId, contentType, platform } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    if (!contentId) {
      throw new Error('contentId is required')
    }

    if (!contentType) {
      throw new Error('contentType is required')
    }

    // コンテンツの存在確認と情報取得
    let contentData = null
    let baseUrl = ''

    if (contentType === 'event') {
      const eventDoc = await db.collection('v/1/events').doc(contentId).get()
      if (!eventDoc.exists) {
        throw new Error('Event not found')
      }
      contentData = eventDoc.data()
      baseUrl = `https://tliny.com/events/${contentId}`
    } else if (contentType === 'product') {
      const productDoc = await db
        .collection('v/1/products')
        .doc(contentId)
        .get()
      if (!productDoc.exists) {
        throw new Error('Product not found')
      }
      contentData = productDoc.data()
      baseUrl = `https://tliny.com/products/${contentId}`
    } else if (contentType === 'post') {
      const postDoc = await db.collection('v/1/posts').doc(contentId).get()
      if (!postDoc.exists) {
        throw new Error('Post not found')
      }
      contentData = postDoc.data()
      baseUrl = `https://tliny.com/posts/${contentId}`
    } else {
      throw new Error('Invalid content type')
    }

    // プラットフォーム固有のURL生成
    let shareUrl = baseUrl
    const title = contentData?.name || contentData?.title || 'TLINY'
    const description =
      contentData?.description ||
      contentData?.content ||
      'Check this out on TLINY!'

    if (platform === 'twitter') {
      const encodedTitle = encodeURIComponent(title)
      const encodedUrl = encodeURIComponent(baseUrl)
      shareUrl = `https://twitter.com/intent/tweet?text=${encodedTitle}&url=${encodedUrl}&hashtags=TLINY`
    } else if (platform === 'facebook') {
      const encodedUrl = encodeURIComponent(baseUrl)
      shareUrl = `https://www.facebook.com/sharer/sharer.php?u=${encodedUrl}`
    } else if (platform === 'line') {
      const encodedMessage = encodeURIComponent(`${title} ${baseUrl}`)
      shareUrl = `https://social-plugins.line.me/lineit/share?url=${encodedMessage}`
    }

    const result = {
      shareUrl,
      baseUrl,
      title,
      description,
      platform,
      contentType,
      contentId,
    }

    V2Logger.success(methodName, { userId, contentId, platform })
    return result
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// ユーザーの共有履歴を取得
export const v2_sns_share_getUserShares = onCall<{
  limit?: number
  targetUserId?: string
}>(async (request) => {
  const methodName = 'v2_sns_share_getUserShares'

  try {
    V2Logger.start(methodName, request.data)

    const { limit = 20, targetUserId } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    // 対象ユーザーID（指定されない場合は自分）
    const queryUserId = targetUserId || userId

    const sharesQuery = await db
      .collection('v/1/share_activities')
      .where('userId', '==', queryUserId)
      .orderBy('createdAt', 'desc')
      .limit(limit)
      .get()

    const shares = sharesQuery.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }))

    V2Logger.success(methodName, {
      userId,
      targetUserId: queryUserId,
      count: shares.length,
    })
    return { shares }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})
