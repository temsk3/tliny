import { onCall } from '../../utils/base_function'
import { logger, V2Logger } from '../../utils/logger'
import { db } from '../../utils/firebase_utils'
import { ErrorHandler } from '../../utils/error_handler'

// ユーザー検索
export const v2_sns_search_searchUsers = onCall(async (request) => {
  const methodName = 'v2_sns_search_searchUsers'
  
  try {
    V2Logger.start(methodName, request.data)
    
    const { query, limit = 20, offset = 0 } = request.data
    
    if (!query || query.trim().length === 0) {
      throw new Error('Query is required')
    }
    
    const searchQuery = query.trim().toLowerCase()
    
    // displayNameで検索（部分一致）
    const usersQuery = await db
      .collection('v/1/user_profiles')
      .where('deletedAt', '==', null)
      .orderBy('displayName')
      .startAt(searchQuery)
      .endAt(searchQuery + '\uf8ff')
      .limit(limit + offset)
      .get()
    
    // オフセット処理
    const allUsers = usersQuery.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }))
    
    const users = allUsers.slice(offset, offset + limit)
    
    V2Logger.success(methodName, { query, count: users.length })
    return { users }
    
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// 投稿検索
export const v2_sns_search_searchPosts = onCall(async (request) => {
  const methodName = 'v2_sns_search_searchPosts'
  
  try {
    V2Logger.start(methodName, request.data)
    
    const { query, limit = 20, offset = 0 } = request.data
    
    if (!query || query.trim().length === 0) {
      throw new Error('Query is required')
    }
    
    const searchQuery = query.trim().toLowerCase()
    
    // contentで検索（部分一致）
    // Firestoreの制限により、完全な全文検索ではなく、contentの開始文字での検索
    const postsQuery = await db
      .collection('v/1/posts')
      .where('deletedAt', '==', null)
      .orderBy('content')
      .startAt(searchQuery)
      .endAt(searchQuery + '\uf8ff')
      .limit(limit + offset)
      .get()
    
    // オフセット処理
    const allPosts = postsQuery.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }))
    
    const posts = allPosts.slice(offset, offset + limit)
    
    V2Logger.success(methodName, { query, count: posts.length })
    return { posts }
    
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})

// 統合検索（ユーザーと投稿を同時に検索）
export const v2_sns_search_searchAll = onCall(async (request) => {
  const methodName = 'v2_sns_search_searchAll'
  
  try {
    V2Logger.start(methodName, request.data)
    
    const { query, userLimit = 10, postLimit = 10 } = request.data
    
    if (!query || query.trim().length === 0) {
      throw new Error('Query is required')
    }
    
    const searchQuery = query.trim().toLowerCase()
    
    // ユーザーと投稿を並行して検索
    const [usersSnapshot, postsSnapshot] = await Promise.all([
      db
        .collection('v/1/user_profiles')
        .where('deletedAt', '==', null)
        .orderBy('displayName')
        .startAt(searchQuery)
        .endAt(searchQuery + '\uf8ff')
        .limit(userLimit)
        .get(),
      db
        .collection('v/1/posts')
        .where('deletedAt', '==', null)
        .orderBy('content')
        .startAt(searchQuery)
        .endAt(searchQuery + '\uf8ff')
        .limit(postLimit)
        .get()
    ])
    
    const users = usersSnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }))
    
    const posts = postsSnapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    }))
    
    V2Logger.success(methodName, { 
      query, 
      userCount: users.length, 
      postCount: posts.length 
    })
    return { users, posts }
    
  } catch (error: any) {
    V2Logger.error(methodName, error, request.data)
    const appEx = ErrorHandler.convertToAppException(error, methodName)
    throw ErrorHandler.convertToHttpsError(appEx)
  }
})