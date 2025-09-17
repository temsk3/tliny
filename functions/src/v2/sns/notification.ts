import { FieldValue } from 'firebase-admin/firestore'
import { onCall } from '../../utils/base_function'
import { V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// 通知一覧取得
export const v2_sns_notification_getNotifications = onCall<{
  limit?: number
  unreadOnly?: boolean
}>(async (request) => {
  const methodName = 'v2_sns_notification_getNotifications'

  try {
    V2Logger.start(methodName, request.data)

    const { limit = 20, unreadOnly = false } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    let notificationsQuery = db
      .collection('v/1/notifications')
      .where('userId', '==', userId)

    if (unreadOnly) {
      notificationsQuery = notificationsQuery.where('isRead', '==', false)
    }

    const notificationsSnapshot = await notificationsQuery
      .orderBy('createdAt', 'desc')
      .limit(limit)
      .get()

    const notifications = notificationsSnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    }))

    V2Logger.success(methodName, { userId, count: notifications.length })
    return { notifications }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// 通知を既読にする
export const v2_sns_notification_markAsRead = onCall<{
  notificationId: string
}>(async (request) => {
  const methodName = 'v2_sns_notification_markAsRead'

  try {
    V2Logger.start(methodName, request.data)

    const { notificationId } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    if (!notificationId) {
      throw new Error('notificationId is required')
    }

    const notificationRef = db
      .collection('v/1/notifications')
      .doc(notificationId)
    const notificationDoc = await notificationRef.get()

    if (!notificationDoc.exists) {
      throw new Error('Notification not found')
    }

    const notificationData = notificationDoc.data()

    // 通知の所有者であることを確認
    if (notificationData?.userId !== userId) {
      throw new Error('Access denied to this notification')
    }

    // 既読にする
    await notificationRef.update({
      isRead: true,
      readAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    })

    V2Logger.success(methodName, { notificationId, userId })
    return { success: true }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// 通知を作成するヘルパー関数（他の機能から呼び出される）
export const createNotification = async (data: {
  userId: string
  title: string
  message: string
  type: string
  actionUserId?: string
  actionUserName?: string
  actionUserPhotoUrl?: string
  targetId?: string
  targetType?: string
  metadata?: Record<string, any>
}) => {
  const methodName = 'createNotification'

  try {
    V2Logger.start(methodName, data)

    const notificationData = {
      ...data,
      isRead: false,
      createdAt: FieldValue.serverTimestamp(),
      updatedAt: FieldValue.serverTimestamp(),
    }

    const notificationRef = await db
      .collection('v/1/notifications')
      .add(notificationData)

    V2Logger.success(methodName, {
      notificationId: notificationRef.id,
      userId: data.userId,
    })

    return {
      id: notificationRef.id,
      ...notificationData,
    }
  } catch (error: any) {
    V2Logger.error(methodName, error, data)
    throw error
  }
}

// 全通知を既読にする
export const v2_sns_notification_markAllAsRead = onCall<{}>(async (request) => {
  const methodName = 'v2_sns_notification_markAllAsRead'

  try {
    V2Logger.start(methodName, request.data)

    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    // 未読通知を取得
    const unreadQuery = await db
      .collection('v/1/notifications')
      .where('userId', '==', userId)
      .where('isRead', '==', false)
      .get()

    if (unreadQuery.empty) {
      V2Logger.success(methodName, { userId, count: 0 })
      return { success: true, count: 0 }
    }

    // バッチで一括更新
    const batch = db.batch()
    const timestamp = FieldValue.serverTimestamp()

    unreadQuery.docs.forEach((doc) => {
      batch.update(doc.ref, {
        isRead: true,
        readAt: timestamp,
        updatedAt: timestamp,
      })
    })

    await batch.commit()

    V2Logger.success(methodName, { userId, count: unreadQuery.size })
    return { success: true, count: unreadQuery.size }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})
