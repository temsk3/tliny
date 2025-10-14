import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/post_model.dart';
import '../../../settings/routes/routes.dart';
import '../feed/widget/post_card.dart';
import 'search_view_model.dart';
import 'widget/search_bar_widget.dart';
import 'widget/user_search_card.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchViewModelProvider);
    final searchNotifier = ref.read(searchViewModelProvider.notifier);
    final searchController = useTextEditingController();
    final scrollController = useScrollController();
    final focusNode = useFocusNode();

    // スクロール監視でページネーション
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8) {
          searchNotifier.loadMoreResults();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('検索'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SearchBarWidget(
              controller: searchController,
              focusNode: focusNode,
              onSearch: searchNotifier.search,
              onClear: searchNotifier.clearSearch,
            ),
          ),
        ),
      ),
      body: _buildSearchResults(
        context,
        searchState,
        scrollController,
        searchNotifier,
      ),
    );
  }

  Widget _buildSearchResults(
    BuildContext context,
    SearchState searchState,
    ScrollController scrollController,
    SearchViewModel searchNotifier,
  ) {
    // 検索クエリが空の場合は初期状態を表示
    if (searchState.query.isEmpty) {
      return const Center(
        child: Text(
          '検索キーワードを入力してください',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    // 検索中の場合
    if (searchNotifier.isLoading &&
        searchState.users.isEmpty &&
        searchState.posts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // 検索結果がない場合
    if (searchState.users.isEmpty &&
        searchState.posts.isEmpty &&
        !searchNotifier.isLoading) {
      return const Center(
        child: Text(
          '検索結果が見つかりませんでした',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // タブでユーザーと投稿を切り替え
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(tabs: [Tab(text: 'ユーザー'), Tab(text: '投稿')]),
          Expanded(
            child: TabBarView(
              children: [
                _buildUserResults(
                  context,
                  searchState,
                  scrollController,
                  searchNotifier,
                ),
                _buildPostResults(
                  context,
                  searchState,
                  scrollController,
                  searchNotifier,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserResults(
    BuildContext context,
    SearchState state,
    ScrollController scrollController,
    SearchViewModel notifier,
  ) {
    if (state.users.isEmpty && !notifier.isLoading) {
      return const Center(
        child: Text(
          'ユーザーが見つかりませんでした',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: state.users.length + (notifier.hasMoreUsers ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.users.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final user = state.users[index];
        return UserSearchCard(
          user: user,
          onTap: () => _navigateToProfile(context, user.userId),
        );
      },
    );
  }

  Widget _buildPostResults(
    BuildContext context,
    SearchState state,
    ScrollController scrollController,
    SearchViewModel notifier,
  ) {
    if (state.posts.isEmpty && !notifier.isLoading) {
      return const Center(
        child: Text(
          '投稿が見つかりませんでした',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: state.posts.length + (notifier.hasMorePosts ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.posts.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final post = state.posts[index];
        return PostCard(
          post: post,
          onLike: () => _handleLike(context, post),
          onComment: () => _handleComment(context, post),
          onShare: () => _handleShare(context, post),
        );
      },
    );
  }

  void _navigateToProfile(BuildContext context, String userId) {
    SnsProfileRoute(userId: userId).go(context);
  }

  void _handleLike(BuildContext context, Post post) {
    // TODO(dev): いいね機能の実装
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('いいね機能は準備中です')));
  }

  void _handleComment(BuildContext context, Post post) {
    // TODO(dev): コメント機能の実装
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('コメント機能は準備中です')));
  }

  void _handleShare(BuildContext context, Post post) {
    // TODO(dev): 共有機能の実装
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('共有機能は準備中です')));
  }
}
