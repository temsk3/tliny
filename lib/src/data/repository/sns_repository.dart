import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/sns/follow_model.dart';
import '../model/sns/message_model.dart';
import '../model/sns/notification_model.dart';
import '../model/sns/post_model.dart';
import 'base_repository.dart';

part 'sns_repository.g.dart';

@Riverpod(keepAlive: true)
SnsRepository snsRepository(SnsRepositoryRef ref) {
  return SnsRepository(
    ref.watch(firebaseFunctionsProvider),
    ref.watch(firebaseFirestoreProvider),
  );
}

class SnsRepository extends BaseRepository {
  SnsRepository(this._func, this._db);
  final FirebaseFunctions _func;
  final FirebaseFirestore _db;

  @override
  FirebaseFunctions getFunctions() => _func;

  // フォロー関連
  /// ユーザーをフォローする
  Future<void> followUser(String followingId) async {
    logger.d('followUser: followingId=$followingId');
    try {
      await callFunction<void>(
        'v2_sns_follow_createFollow',
        {'followingId': followingId},
        context: 'followUser',
      );
      logger.d('followUser success - followingId: $followingId');
    } on Exception catch (e, st) {
      logger.e(
        'followUserError - followingId: $followingId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// ユーザーのフォローを解除する
  Future<void> unfollowUser(String followingId) async {
    logger.d('unfollowUser: followingId=$followingId');
    try {
      await callFunction<void>(
        'v2_sns_follow_deleteFollow',
        {'followingId': followingId},
        context: 'unfollowUser',
      );
      logger.d('unfollowUser success - followingId: $followingId');
    } on Exception catch (e, st) {
      logger.e(
        'unfollowUserError - followingId: $followingId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// フォロワー一覧を取得
  Future<List<Follow>> getFollowers(String userId, {int? limit}) async {
    logger.d('getFollowers: userId=$userId, limit=$limit');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_follow_getFollowers',
        {'userId': userId, if (limit != null) 'limit': limit},
        context: 'getFollowers',
      );
      
      final followersData = response?['followers'] as List<dynamic>? ?? [];
      final followers = followersData
          .map((data) => Follow.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getFollowers success - userId: $userId, count: ${followers.length}');
      return followers;
    } on Exception catch (e, st) {
      logger.e(
        'getFollowersError - userId: $userId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// フォロー中一覧を取得
  Future<List<Follow>> getFollowing(String userId, {int? limit}) async {
    logger.d('getFollowing: userId=$userId, limit=$limit');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_follow_getFollowing',
        {'userId': userId, if (limit != null) 'limit': limit},
        context: 'getFollowing',
      );
      
      final followingData = response?['following'] as List<dynamic>? ?? [];
      final following = followingData
          .map((data) => Follow.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getFollowing success - userId: $userId, count: ${following.length}');
      return following;
    } on Exception catch (e, st) {
      logger.e(
        'getFollowingError - userId: $userId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // 投稿関連
  /// 投稿を作成する
  Future<Post> createPost({
    required String content,
    List<String>? imageUrls,
    String? eventId,
    String? productId,
    PostType? type,
  }) async {
    logger.d('createPost: content=$content, type=$type');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_post_createPost',
        {
          'content': content,
          if (imageUrls != null) 'imageUrls': imageUrls,
          if (eventId != null) 'eventId': eventId,
          if (productId != null) 'productId': productId,
          if (type != null) 'type': type.name,
        },
        context: 'createPost',
      );
      
      final post = Post.fromJson(response!);
      logger.d('createPost success - postId: ${post.id}');
      return post;
    } on Exception catch (e, st) {
      logger.e(
        'createPostError - content: $content',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// フィードを取得する
  Future<List<Post>> getFeed({int? limit, String? lastPostId}) async {
    logger.d('getFeed: limit=$limit, lastPostId=$lastPostId');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_post_getFeed',
        {
          if (limit != null) 'limit': limit,
          if (lastPostId != null) 'lastPostId': lastPostId,
        },
        context: 'getFeed',
      );
      
      final postsData = response?['posts'] as List<dynamic>? ?? [];
      final posts = postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getFeed success - count: ${posts.length}');
      return posts;
    } on Exception catch (e, st) {
      logger.e(
        'getFeedError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// 投稿にいいねする
  Future<void> likePost(String postId) async {
    logger.d('likePost: postId=$postId');
    try {
      await callFunction<void>(
        'v2_sns_post_likePost',
        {'postId': postId},
        context: 'likePost',
      );
      logger.d('likePost success - postId: $postId');
    } on Exception catch (e, st) {
      logger.e(
        'likePostError - postId: $postId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// 投稿のいいねを削除する
  Future<void> unlikePost(String postId) async {
    logger.d('unlikePost: postId=$postId');
    try {
      await callFunction<void>(
        'v2_sns_post_unlikePost',
        {'postId': postId},
        context: 'unlikePost',
      );
      logger.d('unlikePost success - postId: $postId');
    } on Exception catch (e, st) {
      logger.e(
        'unlikePostError - postId: $postId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // ダイレクトメッセージ関連
  /// メッセージを送信する
  Future<DirectMessage> sendMessage({
    required String receiverId,
    required String content,
    MessageType? type,
    List<String>? attachmentUrls,
  }) async {
    logger.d('sendMessage: receiverId=$receiverId, type=$type');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_message_sendMessage',
        {
          'receiverId': receiverId,
          'content': content,
          if (type != null) 'type': type.name,
          if (attachmentUrls != null) 'attachmentUrls': attachmentUrls,
        },
        context: 'sendMessage',
      );
      
      final message = DirectMessage.fromJson(response!);
      logger.d('sendMessage success - messageId: ${message.id}');
      return message;
    } on Exception catch (e, st) {
      logger.e(
        'sendMessageError - receiverId: $receiverId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// 会話一覧を取得する
  Future<List<Conversation>> getConversations({int? limit}) async {
    logger.d('getConversations: limit=$limit');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_message_getConversations',
        {if (limit != null) 'limit': limit},
        context: 'getConversations',
      );
      
      final conversationsData = response?['conversations'] as List<dynamic>? ?? [];
      final conversations = conversationsData
          .map((data) => Conversation.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getConversations success - count: ${conversations.length}');
      return conversations;
    } on Exception catch (e, st) {
      logger.e(
        'getConversationsError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// 会話のメッセージ一覧を取得する
  Future<List<DirectMessage>> getMessages({
    required String conversationId,
    int? limit,
    String? lastMessageId,
  }) async {
    logger.d('getMessages: conversationId=$conversationId, limit=$limit');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_message_getMessages',
        {
          'conversationId': conversationId,
          if (limit != null) 'limit': limit,
          if (lastMessageId != null) 'lastMessageId': lastMessageId,
        },
        context: 'getMessages',
      );
      
      final messagesData = response?['messages'] as List<dynamic>? ?? [];
      final messages = messagesData
          .map((data) => DirectMessage.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getMessages success - count: ${messages.length}');
      return messages;
    } on Exception catch (e, st) {
      logger.e(
        'getMessagesError - conversationId: $conversationId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // 通知関連
  /// 通知一覧を取得する
  Future<List<AppNotification>> getNotifications({
    int? limit,
    bool? unreadOnly,
  }) async {
    logger.d('getNotifications: limit=$limit, unreadOnly=$unreadOnly');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_notification_getNotifications',
        {
          if (limit != null) 'limit': limit,
          if (unreadOnly != null) 'unreadOnly': unreadOnly,
        },
        context: 'getNotifications',
      );
      
      final notificationsData = response?['notifications'] as List<dynamic>? ?? [];
      final notifications = notificationsData
          .map((data) => AppNotification.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getNotifications success - count: ${notifications.length}');
      return notifications;
    } on Exception catch (e, st) {
      logger.e(
        'getNotificationsError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// 通知を既読にする
  Future<void> markNotificationAsRead(String notificationId) async {
    logger.d('markNotificationAsRead: notificationId=$notificationId');
    try {
      await callFunction<void>(
        'v2_sns_notification_markAsRead',
        {'notificationId': notificationId},
        context: 'markNotificationAsRead',
      );
      logger.d('markNotificationAsRead success - notificationId: $notificationId');
    } on Exception catch (e, st) {
      logger.e(
        'markNotificationAsReadError - notificationId: $notificationId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // 共有関連
  /// コンテンツを共有する
  Future<ShareActivity> shareContent({
    required String contentId,
    required String contentType,
    required SharePlatform platform,
    String? customMessage,
  }) async {
    logger.d('shareContent: contentId=$contentId, platform=$platform');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_share_shareContent',
        {
          'contentId': contentId,
          'contentType': contentType,
          'platform': platform.name,
          if (customMessage != null) 'customMessage': customMessage,
        },
        context: 'shareContent',
      );
      
      final shareActivity = ShareActivity.fromJson(response!);
      logger.d('shareContent success - shareId: ${shareActivity.id}');
      return shareActivity;
    } on Exception catch (e, st) {
      logger.e(
        'shareContentError - contentId: $contentId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // プロファイル機能
  /// ユーザープロファイルを取得する
  Future<UserProfile> getProfile(String userId) async {
    logger.d('getProfile: userId=$userId');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_profile_getProfile',
        {'userId': userId},
        context: 'getProfile',
      );
      
      final profile = UserProfile.fromJson(response!['profile'] as Map<String, dynamic>);
      logger.d('getProfile success - userId: $userId');
      return profile;
    } on Exception catch (e, st) {
      logger.e(
        'getProfileError - userId: $userId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// ユーザープロファイルを更新する
  Future<UserProfile> updateProfile({
    String? displayName,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    bool? isPrivate,
  }) async {
    logger.d('updateProfile called');
    try {
      final data = <String, dynamic>{};
      if (displayName != null) data['displayName'] = displayName;
      if (bio != null) data['bio'] = bio;
      if (profileImageUrl != null) data['profileImageUrl'] = profileImageUrl;
      if (coverImageUrl != null) data['coverImageUrl'] = coverImageUrl;
      if (isPrivate != null) data['isPrivate'] = isPrivate;
      
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_profile_updateProfile',
        data,
        context: 'updateProfile',
      );
      
      final profile = UserProfile.fromJson(response!['profile'] as Map<String, dynamic>);
      logger.d('updateProfile success');
      return profile;
    } on Exception catch (e, st) {
      logger.e(
        'updateProfileError',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// ユーザーの投稿一覧を取得する
  Future<List<Post>> getUserPosts(String userId, {int? limit, String? lastPostId}) async {
    logger.d('getUserPosts: userId=$userId, limit=$limit');
    try {
      final data = <String, dynamic>{'userId': userId};
      if (limit != null) data['limit'] = limit;
      if (lastPostId != null) data['lastPostId'] = lastPostId;
      
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_profile_getUserPosts',
        data,
        context: 'getUserPosts',
      );
      
      final postsData = response?['posts'] as List<dynamic>? ?? [];
      final posts = postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getUserPosts success - userId: $userId, count: ${posts.length}');
      return posts;
    } on Exception catch (e, st) {
      logger.e(
        'getUserPostsError - userId: $userId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// フォロー状態をチェックする
  Future<Map<String, dynamic>> checkFollowStatus(String targetUserId) async {
    logger.d('checkFollowStatus: targetUserId=$targetUserId');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_profile_checkFollowStatus',
        {'targetUserId': targetUserId},
        context: 'checkFollowStatus',
      );
      
      final result = {
        'isFollowing': response?['isFollowing'] as bool? ?? false,
        'isOwnProfile': response?['isOwnProfile'] as bool? ?? false,
      };
      
      logger.d('checkFollowStatus success - targetUserId: $targetUserId');
      return result;
    } on Exception catch (e, st) {
      logger.e(
        'checkFollowStatusError - targetUserId: $targetUserId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // 検索機能
  /// ユーザーを検索する
  Future<List<UserProfile>> searchUsers(String query, {int? limit, int? offset}) async {
    logger.d('searchUsers: query=$query, limit=$limit, offset=$offset');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_search_searchUsers',
        {
          'query': query,
          if (limit != null) 'limit': limit,
          if (offset != null) 'offset': offset,
        },
        context: 'searchUsers',
      );
      
      final usersData = response?['users'] as List<dynamic>? ?? [];
      final users = usersData
          .map((data) => UserProfile.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('searchUsers success - query: $query, count: ${users.length}');
      return users;
    } on Exception catch (e, st) {
      logger.e(
        'searchUsersError - query: $query',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// 投稿を検索する
  Future<List<Post>> searchPosts(String query, {int? limit, int? offset}) async {
    logger.d('searchPosts: query=$query, limit=$limit, offset=$offset');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_search_searchPosts',
        {
          'query': query,
          if (limit != null) 'limit': limit,
          if (offset != null) 'offset': offset,
        },
        context: 'searchPosts',
      );
      
      final postsData = response?['posts'] as List<dynamic>? ?? [];
      final posts = postsData
          .map((data) => Post.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('searchPosts success - query: $query, count: ${posts.length}');
      return posts;
    } on Exception catch (e, st) {
      logger.e(
        'searchPostsError - query: $query',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  // コメント機能
  /// コメントを作成する
  Future<PostComment> createComment({
    required String postId,
    required String content,
  }) async {
    logger.d('createComment: postId=$postId');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_comment_createComment',
        {
          'postId': postId,
          'content': content,
        },
        context: 'createComment',
      );
      
      final comment = PostComment.fromJson(response!['comment'] as Map<String, dynamic>);
      logger.d('createComment success - commentId: ${comment.id}');
      return comment;
    } on Exception catch (e, st) {
      logger.e(
        'createCommentError - postId: $postId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// コメント一覧を取得する
  Future<List<PostComment>> getComments(String postId, {int? limit, String? lastCommentId}) async {
    logger.d('getComments: postId=$postId, limit=$limit');
    try {
      final response = await callFunction<Map<String, dynamic>>(
        'v2_sns_comment_getComments',
        {
          'postId': postId,
          if (limit != null) 'limit': limit,
          if (lastCommentId != null) 'lastCommentId': lastCommentId,
        },
        context: 'getComments',
      );
      
      final commentsData = response?['comments'] as List<dynamic>? ?? [];
      final comments = commentsData
          .map((data) => PostComment.fromJson(data as Map<String, dynamic>))
          .toList();
      
      logger.d('getComments success - postId: $postId, count: ${comments.length}');
      return comments;
    } on Exception catch (e, st) {
      logger.e(
        'getCommentsError - postId: $postId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// コメントを削除する
  Future<void> deleteComment(String commentId) async {
    logger.d('deleteComment: commentId=$commentId');
    try {
      await callFunction<void>(
        'v2_sns_comment_deleteComment',
        {'commentId': commentId},
        context: 'deleteComment',
      );
      logger.d('deleteComment success - commentId: $commentId');
    } on Exception catch (e, st) {
      logger.e(
        'deleteCommentError - commentId: $commentId',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}