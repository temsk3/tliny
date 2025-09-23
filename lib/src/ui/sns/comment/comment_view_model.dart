import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/sns/post_model.dart';
import '../../../data/repository/sns_repository.dart';
import '../../../utils/logger.dart';

part 'comment_view_model.g.dart';

@riverpod
class CommentViewModel extends _$CommentViewModel {
  bool _hasMore = true;
  bool _isLoading = false;

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  @override
  FutureOr<List<PostComment>> build(String postId) {
    logger.d('CommentViewModel.build() called with postId: $postId');
    return loadComments(postId);
  }

  Future<List<PostComment>> loadComments(
    String postId, {
    bool refresh = false,
  }) async {
    if (_isLoading) return state.value ?? [];

    try {
      _isLoading = true;

      if (refresh) {
        _hasMore = true;
      }

      final snsRepository = ref.read(snsRepositoryProvider);
      final comments = await snsRepository.getComments(postId, limit: 20);

      _hasMore = comments.length >= 20;

      logger.d('loadComments success: ${comments.length} comments loaded');
      return comments;
    } catch (e, st) {
      logger.e('loadComments error: $e', error: e, stackTrace: st);
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshComments(String postId) async {
    try {
      final comments = await loadComments(postId, refresh: true);
      state = AsyncValue.data(comments);
    } catch (e, st) {
      logger.e('refreshComments error: $e', error: e, stackTrace: st);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMoreComments(String postId) async {
    if (_isLoading || !_hasMore) return;

    final currentComments = state.value ?? [];
    if (currentComments.isEmpty) return;

    try {
      _isLoading = true;

      final snsRepository = ref.read(snsRepositoryProvider);
      final lastCommentId = currentComments.last.id;

      final newComments = await snsRepository.getComments(
        postId,
        limit: 20,
        lastCommentId: lastCommentId,
      );

      _hasMore = newComments.length >= 20;

      final updatedComments = [...currentComments, ...newComments];
      state = AsyncValue.data(updatedComments);

      logger.d(
        'loadMoreComments success: ${newComments.length} new comments loaded',
      );
    } catch (e, st) {
      logger.e('loadMoreComments error: $e', error: e, stackTrace: st);
      // エラー時は既存の状態を保持
    } finally {
      _isLoading = false;
    }
  }

  Future<void> createComment(String postId, String content) async {
    if (content.trim().isEmpty) return;

    try {
      final snsRepository = ref.read(snsRepositoryProvider);

      final newComment = await snsRepository.createComment(
        postId: postId,
        content: content.trim(),
      );

      // 新しいコメントを既存のリストの先頭に追加（最新順）
      final currentComments = state.value ?? [];
      final updatedComments = [newComment, ...currentComments];
      state = AsyncValue.data(updatedComments);

      logger.d('createComment success: ${newComment.id}');
    } catch (e, st) {
      logger.e('createComment error: $e', error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      final snsRepository = ref.read(snsRepositoryProvider);
      await snsRepository.deleteComment(commentId);

      // コメントをリストから削除
      final currentComments = state.value ?? [];
      final updatedComments = currentComments
          .where((PostComment c) => c.id != commentId)
          .toList();
      state = AsyncValue.data(updatedComments);

      logger.d('deleteComment success: $commentId');
    } catch (e, st) {
      logger.e('deleteComment error: $e', error: e, stackTrace: st);
      rethrow;
    }
  }
}
