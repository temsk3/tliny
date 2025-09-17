import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/message_model.dart';
import '../../../settings/routes/routes.dart';
import '../../common/loading_screen.dart';
import 'sns_messages_view_model.dart';
import 'widget/conversation_card.dart';

class SnsMessagesPage extends HookConsumerWidget {
  const SnsMessagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesState = ref.watch(snsMessagesViewModelProvider);
    final messagesNotifier = ref.read(snsMessagesViewModelProvider.notifier);
    final scrollController = useScrollController();

    // スクロール監視でページネーション（将来の拡張用）
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8) {
          // TODO: loadMoreConversations実装
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('メッセージ'),
        actions: [
          // 新規メッセージボタン（将来の拡張用）
          // IconButton(
          //   icon: const Icon(Icons.edit),
          //   onPressed: () => _showNewMessageDialog(context),
          // ),
        ],
      ),
      body: messagesState.when(
        data:
            (conversations) => RefreshIndicator(
              onRefresh: messagesNotifier.refreshConversations,
              child:
                  conversations.isEmpty
                      ? const Center(
                        child: Text(
                          'メッセージはありません',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        controller: scrollController,
                        itemCount: conversations.length,
                        itemBuilder: (context, index) {
                          final conversation = conversations[index];
                          return ConversationCard(
                            conversation: conversation,
                            onTap: () => _navigateToChat(context, conversation),
                          );
                        },
                      ),
            ),
        loading: () => const LoadingScreen(),
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('メッセージの読み込みに失敗しました'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: messagesNotifier.refreshConversations,
                    child: const Text('再試行'),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  void _navigateToChat(BuildContext context, Conversation conversation) {
    // 現在のユーザーIDを取得（仮の実装）
    const currentUserId = 'current_user_id'; // TODO(dev): 実際のユーザーIDを取得

    // 相手のユーザー情報を取得
    final otherUserIndex =
        conversation.participantIds[0] == currentUserId ? 1 : 0;
    final otherUserId = conversation.participantIds[otherUserIndex];
    final otherUserName =
        conversation.participantNames.isNotEmpty
            ? conversation.participantNames[otherUserIndex]
            : 'Unknown User';
    final otherUserPhotoUrl =
        conversation.participantPhotoUrls?.isNotEmpty == true
            ? conversation.participantPhotoUrls![otherUserIndex]
            : null;

    // 型安全な遷移
    SnsChatRoute(
      conversationId: conversation.id!,
      otherUserId: otherUserId,
      otherUserName: otherUserName,
      otherUserPhotoUrl: otherUserPhotoUrl,
    ).go(context);
  }
}
