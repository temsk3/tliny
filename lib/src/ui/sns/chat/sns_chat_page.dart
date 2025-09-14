import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/message_model.dart';
import '../../common/loading_screen.dart';
import 'sns_chat_view_model.dart';
import 'widget/message_bubble.dart';

class SnsChatPage extends HookConsumerWidget {
  const SnsChatPage({
    super.key,
    required this.conversationId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserPhotoUrl,
  });

  final String conversationId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserPhotoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(snsChatViewModelProvider(conversationId));
    final chatNotifier = ref.read(snsChatViewModelProvider(conversationId).notifier);
    final messageController = useTextEditingController();
    final scrollController = useScrollController();
    final focusNode = useFocusNode();

    // 新しいメッセージが追加されたら最下部にスクロール
    useEffect(() {
      chatState.whenData((messages) {
        if (messages.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
          });
        }
      });
      return null;
    }, [chatState]);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: otherUserPhotoUrl != null
                  ? NetworkImage(otherUserPhotoUrl!)
                  : null,
              child: otherUserPhotoUrl == null
                  ? Text(
                      otherUserName.isNotEmpty 
                          ? otherUserName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(fontSize: 14),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(otherUserName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatState.when(
              data: (messages) => messages.isEmpty
                  ? const Center(
                      child: Text(
                        'メッセージがありません\n最初のメッセージを送ってみましょう',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.senderId != otherUserId;
                        
                        return MessageBubble(
                          message: message,
                          isMe: isMe,
                          showAvatar: !isMe,
                          otherUserPhotoUrl: otherUserPhotoUrl,
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
                    const Text('メッセージの読み込みに失敗しました'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: chatNotifier.refreshMessages,
                      child: const Text('再試行'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildMessageInput(context, messageController, focusNode, chatNotifier),
        ],
      ),
    );
  }

  Widget _buildMessageInput(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
    SnsChatViewModel notifier,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // 添付ファイルボタン（将来の拡張用）
            // IconButton(
            //   icon: const Icon(Icons.attach_file),
            //   onPressed: () => _showAttachmentOptions(context),
            // ),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: 'メッセージを入力...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _sendMessage(context, controller, notifier),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(
    BuildContext context,
    TextEditingController controller,
    SnsChatViewModel notifier,
  ) async {
    final content = controller.text.trim();
    if (content.isEmpty) return;

    // UI上でメッセージをクリア
    controller.clear();

    try {
      await notifier.sendMessage(
        receiverId: otherUserId,
        content: content,
      );
    } catch (e) {
      // エラー時はメッセージを復元
      controller.text = content;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('メッセージの送信に失敗しました'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}