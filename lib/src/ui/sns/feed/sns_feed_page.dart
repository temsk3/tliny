import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/post_model.dart';
import '../../common/loading_screen.dart';
import 'sns_feed_view_model.dart';
import 'widget/create_post_dialog.dart';
import 'widget/post_card.dart';

class SnsFeedPage extends HookConsumerWidget {
  const SnsFeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(snsFeedViewModelProvider);
    final feedNotifier = ref.read(snsFeedViewModelProvider.notifier);
    final scrollController = useScrollController();

    // スクロール監視でページネーション
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8) {
          feedNotifier.loadMorePosts();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    // 初回データ読み込み
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        feedNotifier.refreshFeed();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('フィード'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/sns/search'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => context.push('/sns/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () => context.push('/sns/messages'),
          ),
        ],
      ),
      body: feedState.when(
        data: (posts) => RefreshIndicator(
          onRefresh: feedNotifier.refreshFeed,
          child: posts.isEmpty
              ? const Center(
                  child: Text(
                    'まだ投稿がありません\\n最初の投稿をしてみましょう！',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: posts.length + (feedNotifier.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == posts.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    final post = posts[index];
                    return PostCard(
                      post: post,
                      onLike: () => feedNotifier.toggleLike(post.id!),
                      onComment: () => _showComments(context, post),
                      onShare: () => _showShareOptions(context, post),
                    );
                  },
                ),
        ),
        loading: () => const LoadingScreen(),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('エラーが発生しました'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: feedNotifier.refreshFeed,
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const CreatePostDialog(),
    );
  }

  void _showComments(BuildContext context, Post post) {
    // TODO(dev): コメント画面への遷移
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('コメント機能は準備中です')),
    );
  }

  void _showShareOptions(BuildContext context, Post post) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('システム共有'),
              onTap: () {
                Navigator.pop(context);
                // TODO(dev): システム共有の実装
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('リンクをコピー'),
              onTap: () {
                Navigator.pop(context);
                // TODO(dev): リンクコピーの実装
              },
            ),
          ],
        ),
      ),
    );
  }
}
