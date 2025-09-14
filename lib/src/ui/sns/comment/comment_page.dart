import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/post_model.dart';
import '../../common/loading_screen.dart';
import 'comment_view_model.dart';
import 'widget/comment_card.dart';
import 'widget/comment_input.dart';

class CommentPage extends HookConsumerWidget {
  const CommentPage({super.key, required this.post});
  
  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentsState = ref.watch(commentViewModelProvider(post.id!));
    final commentsNotifier = ref.read(commentViewModelProvider(post.id!).notifier);
    final scrollController = useScrollController();
    final commentController = useTextEditingController();
    final focusNode = useFocusNode();

    // スクロール監視でページネーション
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8) {
          commentsNotifier.loadMoreComments(post.id!);
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('コメント'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => commentsNotifier.refreshComments(post.id!),
          ),
        ],
      ),
      body: Column(
        children: [
          // 投稿情報
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: post.userPhotoUrl != null
                      ? NetworkImage(post.userPhotoUrl!)
                      : null,
                  child: post.userPhotoUrl == null
                      ? Text(
                          post.userName.isNotEmpty 
                              ? post.userName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        post.content,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // コメント一覧
          Expanded(
            child: commentsState.when(
              data: (comments) => comments.isEmpty
                  ? const Center(
                      child: Text(
                        'まだコメントがありません\n最初のコメントを投稿してみましょう',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: comments.length + (commentsNotifier.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == comments.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final comment = comments[index];
                        return CommentCard(
                          comment: comment,
                          onDelete: comment.userId == 'current_user_id' // TODO(dev): 実際のユーザーIDと比較
                              ? () => _handleDeleteComment(context, commentsNotifier, comment.id!)
                              : null,
                        );
                      },
                    ),
              loading: () => const LoadingScreen(),
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('コメントの読み込みに失敗しました'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => commentsNotifier.refreshComments(post.id!),
                      child: const Text('再試行'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // コメント入力
          CommentInput(
            controller: commentController,
            focusNode: focusNode,
            onSubmit: (content) => _handleSubmitComment(
              context,
              commentsNotifier,
              commentController,
              content,
              post.id!,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitComment(
    BuildContext context,
    CommentViewModel notifier,
    TextEditingController controller,
    String content,
    String postId,
  ) async {
    try {
      await notifier.createComment(postId, content);
      controller.clear();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('コメントの投稿に失敗しました: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleDeleteComment(
    BuildContext context,
    CommentViewModel notifier,
    String commentId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('コメントを削除'),
        content: const Text('このコメントを削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await notifier.deleteComment(commentId);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('コメントを削除しました')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('削除に失敗しました: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}