import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/sns/follow_model.dart';
import '../../../data/model/sns/post_model.dart';
import '../../../data/repository/sns_repository.dart';
import '../../../utils/logger.dart';

part 'search_view_model.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  bool _hasMoreUsers = false;
  bool _hasMorePosts = false;
  bool _isLoading = false;
  String _currentQuery = '';

  bool get hasMoreUsers => _hasMoreUsers;
  bool get hasMorePosts => _hasMorePosts;
  bool get isLoading => _isLoading;

  @override
  SearchState build() {
    logger.d('SearchViewModel.build() called');
    return const SearchState();
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = const SearchState();
      return;
    }

    if (_isLoading) return;

    try {
      _isLoading = true;
      _currentQuery = query.trim();

      logger.d('search called with query: $_currentQuery');

      final snsRepository = ref.read(snsRepositoryProvider);

      // ユーザーと投稿を並行して検索
      final results = await Future.wait<dynamic>([
        snsRepository.searchUsers(_currentQuery, limit: 20),
        snsRepository.searchPosts(_currentQuery, limit: 20),
      ]);

      final users = results[0] as List<UserProfile>;
      final posts = results[1] as List<Post>;

      _hasMoreUsers = users.length >= 20;
      _hasMorePosts = posts.length >= 20;

      state = SearchState(query: _currentQuery, users: users, posts: posts);

      logger.d('search success: ${users.length} users, ${posts.length} posts');
    } catch (e, st) {
      logger.e('search error: $e', error: e, stackTrace: st);
      // エラー時は現在の状態を維持
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMoreResults() async {
    if (_isLoading || _currentQuery.isEmpty) return;

    final currentState = state;

    try {
      _isLoading = true;

      final snsRepository = ref.read(snsRepositoryProvider);
      List<UserProfile> newUsers = [];
      List<Post> newPosts = [];

      // より多くのユーザーがある場合のみ取得
      if (_hasMoreUsers) {
        newUsers = await snsRepository.searchUsers(
          _currentQuery,
          limit: 20,
          offset: currentState.users.length,
        );
        _hasMoreUsers = newUsers.length >= 20;
      }

      // より多くの投稿がある場合のみ取得
      if (_hasMorePosts) {
        newPosts = await snsRepository.searchPosts(
          _currentQuery,
          limit: 20,
          offset: currentState.posts.length,
        );
        _hasMorePosts = newPosts.length >= 20;
      }

      final updatedUsers = [...currentState.users, ...newUsers];
      final updatedPosts = [...currentState.posts, ...newPosts];

      state = currentState.copyWith(users: updatedUsers, posts: updatedPosts);

      logger.d(
        'loadMoreResults success: ${newUsers.length} new users, ${newPosts.length} new posts',
      );
    } catch (e, st) {
      logger.e('loadMoreResults error: $e', error: e, stackTrace: st);
      // エラー時は既存の状態を保持
    } finally {
      _isLoading = false;
    }
  }

  void clearSearch() {
    _currentQuery = '';
    _hasMoreUsers = false;
    _hasMorePosts = false;
    state = const SearchState();
    logger.d('clearSearch called');
  }
}

class SearchState {
  const SearchState({
    this.query = '',
    this.users = const [],
    this.posts = const [],
  });

  final String query;
  final List<UserProfile> users;
  final List<Post> posts;

  SearchState copyWith({
    String? query,
    List<UserProfile>? users,
    List<Post>? posts,
  }) {
    return SearchState(
      query: query ?? this.query,
      users: users ?? this.users,
      posts: posts ?? this.posts,
    );
  }
}
