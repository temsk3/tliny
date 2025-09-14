import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/follow_model.dart';
import '../../../data/model/sns/post_model.dart';
import '../../../settings/routes/routes.dart';
import '../../common/loading_screen.dart';
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
              onSearch: (query) => searchNotifier.search(query),
              onClear: searchNotifier.clearSearch,
            ),
          ),
        ),
      ),
      body: searchState.when(
        data: (state) {
          if (state.query.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'ユーザーや投稿を検索してみましょう',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'ユーザー'),
                    Tab(text: '投稿'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // ユーザー検索結果
                      _buildUserResults(context, state, scrollController, searchNotifier),
                      // 投稿検索結果
                      _buildPostResults(context, state, scrollController, searchNotifier),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingScreen(),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('検索に失敗しました'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => searchNotifier.search(searchController.text),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
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
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
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
          onTap: () => _navigateToProfile(context, user.userId!),
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
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('いいね機能は準備中です')),
    );
  }

  void _handleComment(BuildContext context, Post post) {
    // TODO(dev): コメント機能の実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('コメント機能は準備中です')),
    );
  }

  void _handleShare(BuildContext context, Post post) {
    // TODO(dev): 共有機能の実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('共有機能は準備中です')),
    );
  }
}