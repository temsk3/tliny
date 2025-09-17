import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/sns/post_model.dart';
import '../../../data/repository/sns_repository.dart';
import '../../../utils/logger.dart';

part 'sns_feed_view_model.g.dart';

@riverpod
class SnsFeedViewModel extends _$SnsFeedViewModel {
  List<Post> _posts = [];
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _lastPostId;

  @override
  FutureOr<List<Post>> build() async {
    return await _loadFeed();
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<List<Post>> _loadFeed({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        _posts.clear();
        _lastPostId = null;
        _hasMore = true;
      }

      final newPosts = await ref
          .read(snsRepositoryProvider)
          .getFeed(limit: 20, lastPostId: _lastPostId);

      if (newPosts.isEmpty) {
        _hasMore = false;
      } else {
        if (isRefresh) {
          _posts = newPosts;
        } else {
          _posts.addAll(newPosts);
        }
        _lastPostId = newPosts.last.id;
      }

      return _posts;
    } catch (error, stackTrace) {
      logger.e(
        'Failed to load feed',
        time: DateTime.now(),
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> refreshFeed() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadFeed(isRefresh: true));
  }

  Future<void> loadMorePosts() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    try {
      await _loadFeed();
      state = AsyncData(_posts);
    } catch (error) {
      logger.e('Failed to load more posts', time: DateTime.now(), error: error);
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> toggleLike(String postId) async {
    try {
      // 楽観的更新
      final postIndex = _posts.indexWhere((post) => post.id == postId);
      if (postIndex == -1) return;

      final post = _posts[postIndex];
      final isCurrentlyLiked = post.likesCount != null && post.likesCount! > 0;

      // UI を先に更新
      _posts[postIndex] = post.copyWith(
        likesCount:
            isCurrentlyLiked
                ? (post.likesCount! - 1)
                : (post.likesCount ?? 0) + 1,
      );
      state = AsyncData(_posts);

      // サーバーに送信
      if (isCurrentlyLiked) {
        await ref.read(snsRepositoryProvider).unlikePost(postId);
      } else {
        await ref.read(snsRepositoryProvider).likePost(postId);
      }
    } catch (error) {
      logger.e('Failed to toggle like', time: DateTime.now(), error: error);
      // エラー時は元に戻す
      await refreshFeed();
    }
  }

  Future<void> createPost({
    required String content,
    List<String>? imageUrls,
    String? eventId,
    String? productId,
    PostType? type,
  }) async {
    try {
      final newPost = await ref
          .read(snsRepositoryProvider)
          .createPost(
            content: content,
            imageUrls: imageUrls,
            eventId: eventId,
            productId: productId,
            type: type,
          );

      // 新しい投稿を先頭に追加
      _posts.insert(0, newPost);
      state = AsyncData(_posts);
    } catch (error) {
      logger.e('Failed to create post', time: DateTime.now(), error: error);
      rethrow;
    }
  }
}
