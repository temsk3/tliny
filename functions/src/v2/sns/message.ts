import { FieldValue } from 'firebase-admin/firestore'
import { onCall } from '../../utils/base_function'
import { V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// メッセージ送信
export const v2_sns_message_sendMessage = onCall<{
  receiverId: string
  content: string
  type?: string
  attachmentUrls?: string[]
}>(async (request) => {
  const methodName = 'v2_sns_message_sendMessage'

  try {
    V2Logger.start(methodName, request.data)

    const { receiverId, content, type = 'text', attachmentUrls } = request.data
    const senderId = request.auth?.uid

    if (!senderId) {
      throw new Error('Authentication required')
    }

    if (!receiverId) {
      throw new Error('receiverId is required')
    }

    if (!content || content.trim().length === 0) {
      throw new Error('Content is required')
    }

    if (senderId === receiverId) {
      throw new Error('Cannot send message to yourself')
    }

    // ユーザー情報を取得
    const [senderDoc, receiverDoc] = await Promise.all([
      db.collection('v/1/users').doc(senderId).get(),
      db.collection('v/1/users').doc(receiverId).get(),
    ])

    if (!senderDoc.exists || !receiverDoc.exists) {
      throw new Error('User not found')
    }

    const senderData = senderDoc.data()
    const receiverData = receiverDoc.data()

    // 会話IDを作成（ソートされたユーザーIDの組み合わせ）
    const conversationId = [senderId, receiverId].sort().join('_')

    let messageRef: any

    await db.runTransaction(async (transaction) => {
      // 会話の存在をチェック
      const conversationRef = db
        .collection('v/1/conversations')
        .doc(conversationId)
      const conversationDoc = await transaction.get(conversationRef)

      // メッセージデータを作成
      const messageData = {
        conversationId,
        senderId,
        senderName:
          senderData?.displayName || senderData?.name || 'Unknown User',
        senderPhotoUrl: senderData?.photoUrl || null,
        receiverId,
        receiverName:
          receiverData?.displayName || receiverData?.name || 'Unknown User',
        receiverPhotoUrl: receiverData?.photoUrl || null,
        content: content.trim(),
        type,
        attachmentUrls: attachmentUrls || [],
        isRead: false,
        createdAt: FieldValue.serverTimestamp(),
        updatedAt: FieldValue.serverTimestamp(),
      }

      // メッセージを作成
      messageRef = db.collection('v/1/direct_messages').doc()
      transaction.set(messageRef, messageData)

      // 会話を作成または更新
      if (!conversationDoc.exists) {
        const conversationData = {
          participantIds: [senderId, receiverId],
          participantNames: [
            senderData?.displayName || senderData?.name || 'Unknown User',
            receiverData?.displayName || receiverData?.name || 'Unknown User',
          ],
          participantPhotoUrls: [
            senderData?.photoUrl || null,
            receiverData?.photoUrl || null,
          ],
          lastMessageContent: content.trim(),
          lastMessageSenderId: senderId,
          lastMessageAt: FieldValue.serverTimestamp(),
          unreadCounts: {
            [senderId]: 0,
            [receiverId]: 1,
          },
          createdAt: FieldValue.serverTimestamp(),
          updatedAt: FieldValue.serverTimestamp(),
        }
        transaction.set(conversationRef, conversationData)
      } else {
        const currentData = conversationDoc.data()
        const currentUnreadCounts = currentData?.unreadCounts || {}

        transaction.update(conversationRef, {
          lastMessageContent: content.trim(),
          lastMessageSenderId: senderId,
          lastMessageAt: FieldValue.serverTimestamp(),
          unreadCounts: {
            ...currentUnreadCounts,
            [receiverId]: (currentUnreadCounts[receiverId] || 0) + 1,
          },
          updatedAt: FieldValue.serverTimestamp(),
        })
      }
    })

    const createdMessage = {
      id: messageRef.id,
      conversationId,
      senderId,
      senderName: senderData?.displayName || senderData?.name || 'Unknown User',
      senderPhotoUrl: senderData?.photoUrl || null,
      receiverId,
      receiverName:
        receiverData?.displayName || receiverData?.name || 'Unknown User',
      receiverPhotoUrl: receiverData?.photoUrl || null,
      content: content.trim(),
      type,
      attachmentUrls: attachmentUrls || [],
      isRead: false,
    }

    V2Logger.success(methodName, {
      messageId: messageRef.id,
      senderId,
      receiverId,
    })
    return createdMessage
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// 会話一覧取得
export const v2_sns_message_getConversations = onCall<{ limit?: number }>(
  async (request) => {
    const methodName = 'v2_sns_message_getConversations'

    try {
      V2Logger.start(methodName, request.data)

      const { limit = 20 } = request.data
      const userId = request.auth?.uid

      if (!userId) {
        throw new Error('Authentication required')
      }

      const conversationsQuery = await db
        .collection('v/1/conversations')
        .where('participantIds', 'array-contains', userId)
        .orderBy('lastMessageAt', 'desc')
        .limit(limit)
        .get()

      const conversations = conversationsQuery.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }))

      V2Logger.success(methodName, { userId, count: conversations.length })
      return { conversations }
    } catch (error: any) {
      V2Logger.error(methodName, error, request.data)
      const appEx = ErrorHandler.convertToAppException(error, methodName)
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)

// メッセージ一覧取得
export const v2_sns_message_getMessages = onCall<{
  conversationId: string
  limit?: number
  lastMessageId?: string
}>(async (request) => {
  const methodName = 'v2_sns_message_getMessages'

  try {
    V2Logger.start(methodName, request.data)

    const { conversationId, limit = 50, lastMessageId } = request.data
    const userId = request.auth?.uid

    if (!userId) {
      throw new Error('Authentication required')
    }

    if (!conversationId) {
      throw new Error('conversationId is required')
    }

    // 会話の参加者であることを確認
    const conversationDoc = await db
      .collection('v/1/conversations')
      .doc(conversationId)
      .get()

    if (!conversationDoc.exists) {
      throw new Error('Conversation not found')
    }

    const conversationData = conversationDoc.data()
    if (!conversationData?.participantIds?.includes(userId)) {
      throw new Error('Access denied to this conversation')
    }

    // メッセージを取得
    let messagesQuery = db
      .collection('v/1/direct_messages')
      .where('conversationId', '==', conversationId)
      .orderBy('createdAt', 'desc')
      .limit(limit)

    if (lastMessageId) {
      const lastMessageDoc = await db
        .collection('v/1/direct_messages')
        .doc(lastMessageId)
        .get()
      if (lastMessageDoc.exists) {
        messagesQuery = messagesQuery.startAfter(lastMessageDoc)
      }
    }

    const messagesSnapshot = await messagesQuery.get()
    const messages = messagesSnapshot.docs.map((doc) => ({
      id: doc.id,
      ...doc.data(),
    })) as Array<{
      id: string
      receiverId: string
      isRead: boolean
      [key: string]: any
    }>

    // 未読メッセージを既読にする
    const unreadMessages = messages.filter(
      (msg) => msg.receiverId === userId && !msg.isRead,
    )

    if (unreadMessages.length > 0) {
      const batch = db.batch()

      unreadMessages.forEach((msg) => {
        const msgRef = db.collection('v/1/direct_messages').doc(msg.id)
        batch.update(msgRef, {
          isRead: true,
          readAt: FieldValue.serverTimestamp(),
        })
      })

      // 会話の未読数も更新
      const currentUnreadCounts = conversationData.unreadCounts || {}
      batch.update(conversationDoc.ref, {
        unreadCounts: {
          ...currentUnreadCounts,
          [userId]: 0,
        },
      })

      await batch.commit()
    }

    V2Logger.success(methodName, { conversationId, count: messages.length })
    return { messages }
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})
