import { FieldValue } from 'firebase-admin/firestore'
import { onCall } from '../../utils/base_function'
import { V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// コメント作成
export const v2_sns_comment_createComment = onCall(
  async (request: {
    data: { postId: string; content: string }
    auth?: { uid?: string }
  }) => {
    const methodName = 'v2_sns_comment_createComment'

    try {
      V2Logger.start(methodName, request.data)

      const { postId, content } = request.data
      const userId = request.auth?.uid

      if (!userId) {
        throw new Error('Authentication required')
      }

      if (!postId) {
        throw new Error('postId is required')
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

      // 投稿の存在確認
      const postDoc = await db.collection('v/1/posts').doc(postId).get()
      if (!postDoc.exists) {
        throw new Error('Post not found')
      }

      await db
        .runTransaction(async (transaction) => {
          // コメントを作成
          const commentRef = db.collection('v/1/post_comments').doc()
          const commentData = {
            postId,
            userId,
            userName: userData?.name || 'Unknown User',
            userPhotoUrl: userData?.photoURL || null,
            content: content.trim(),
            createdAt: FieldValue.serverTimestamp(),
            updatedAt: FieldValue.serverTimestamp(),
            deletedAt: null,
          }

          transaction.set(commentRef, commentData)

          // 投稿のコメント数を増加
          const postRef = db.collection('v/1/posts').doc(postId)
          transaction.update(postRef, {
            commentsCount: FieldValue.increment(1),
            updatedAt: FieldValue.serverTimestamp(),
          })

          return {
            id: commentRef.id,
            ...commentData,
            createdAt: new Date(),
            updatedAt: new Date(),
          }
        })
        .then((comment) => {
          V2Logger.success(methodName, { postId, commentId: comment.id })
          return { comment }
        })
    } catch (error: any) {
      V2Logger.error(methodName, error, request.data)
      const appEx = ErrorHandler.convertToAppException(error, methodName)
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)

// コメント一覧取得
export const v2_sns_comment_getComments = onCall(
  async (request: {
    data: { postId: string; limit?: number; lastCommentId?: string }
    auth?: { uid?: string }
  }) => {
    const methodName = 'v2_sns_comment_getComments'

    try {
      V2Logger.start(methodName, request.data)

      const { postId, limit = 20, lastCommentId } = request.data

      if (!postId) {
        throw new Error('postId is required')
      }

      let query = db
        .collection('v/1/post_comments')
        .where('postId', '==', postId)
        .where('deletedAt', '==', null)
        .orderBy('createdAt', 'desc')
        .limit(limit)

      // ページネーション対応
      if (lastCommentId) {
        const lastCommentDoc = await db
          .collection('v/1/post_comments')
          .doc(lastCommentId)
          .get()
        if (lastCommentDoc.exists) {
          query = query.startAfter(lastCommentDoc)
        }
      }

      const commentsSnapshot = await query.get()
      const comments = commentsSnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }))

      V2Logger.success(methodName, { postId, count: comments.length })
      return { comments }
    } catch (error: any) {
      V2Logger.error(methodName, error, request.data)
      const appEx = ErrorHandler.convertToAppException(error, methodName)
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)

// コメント削除
export const v2_sns_comment_deleteComment = onCall(
  async (request: { data: { commentId: string }; auth?: { uid?: string } }) => {
    const methodName = 'v2_sns_comment_deleteComment'

    try {
      V2Logger.start(methodName, request.data)

      const { commentId } = request.data
      const userId = request.auth?.uid

      if (!userId) {
        throw new Error('Authentication required')
      }

      if (!commentId) {
        throw new Error('commentId is required')
      }

      const commentDoc = await db
        .collection('v/1/post_comments')
        .doc(commentId)
        .get()
      if (!commentDoc.exists) {
        throw new Error('Comment not found')
      }

      const commentData = commentDoc.data()

      // コメント作成者または管理者のみ削除可能
      if (commentData?.userId !== userId) {
        throw new Error('Permission denied')
      }

      await db.runTransaction(async (transaction) => {
        // コメントを論理削除
        transaction.update(commentDoc.ref, {
          deletedAt: FieldValue.serverTimestamp(),
          updatedAt: FieldValue.serverTimestamp(),
        })

        // 投稿のコメント数を減少
        const postRef = db.collection('v/1/posts').doc(commentData.postId)
        transaction.update(postRef, {
          commentsCount: FieldValue.increment(-1),
          updatedAt: FieldValue.serverTimestamp(),
        })
      })

      V2Logger.success(methodName, { commentId })
      return { success: true }
    } catch (error: any) {
      V2Logger.error(methodName, error, request.data)
      const appEx = ErrorHandler.convertToAppException(error, methodName)
      throw ErrorHandler.convertToHttpsError(appEx)
    }
  },
)
