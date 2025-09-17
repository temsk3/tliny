import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/sns/message_model.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  final Conversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // 現在のユーザーと相手のユーザー情報を取得
    // TODO: 現在のユーザーIDを取得する機能を実装
    final currentUserId = 'current_user_id'; // 仮の値
    final otherUserIndex =
        conversation.participantIds?[0] == currentUserId ? 1 : 0;
    final otherUserName =
        conversation.participantNames?.isNotEmpty == true
            ? conversation.participantNames![otherUserIndex]
            : 'Unknown User';
    final otherUserPhotoUrl =
        conversation.participantPhotoUrls?.isNotEmpty == true
            ? conversation.participantPhotoUrls![otherUserIndex]
            : null;

    // 未読数を取得
    final unreadCount = conversation.unreadCounts?[currentUserId] ?? 0;
    final hasUnread = unreadCount > 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: hasUnread ? 2 : 1,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage:
              otherUserPhotoUrl != null
                  ? NetworkImage(otherUserPhotoUrl)
                  : null,
          child:
              otherUserPhotoUrl == null
                  ? Text(
                    otherUserName.isNotEmpty
                        ? otherUserName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                  : null,
        ),
        title: Text(
          otherUserName,
          style: TextStyle(
            fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conversation.lastMessageContent ?? '',
              style: TextStyle(
                color: hasUnread ? Colors.black87 : Colors.grey[600],
                fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              _formatDateTime(conversation.lastMessageAt),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing:
            hasUnread
                ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    unreadCount > 99 ? '99+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : null,
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'たった今';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}時間前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日前';
    } else {
      return DateFormat('MM/dd HH:mm').format(dateTime);
    }
  }
}
