import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/sns/message_model.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.showAvatar = false,
    this.otherUserPhotoUrl,
  });

  final DirectMessage message;
  final bool isMe;
  final bool showAvatar;
  final String? otherUserPhotoUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: otherUserPhotoUrl != null
                  ? NetworkImage(otherUserPhotoUrl!)
                  : null,
              child: otherUserPhotoUrl == null
                  ? Text(
                      message.senderName.isNotEmpty 
                          ? message.senderName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(fontSize: 12),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
          ] else if (!isMe && !showAvatar) ...[
            const SizedBox(width: 40), // アバターの幅分のスペース
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isMe 
                    ? Theme.of(context).primaryColor
                    : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.createdAt),
                        style: TextStyle(
                          color: isMe 
                              ? Colors.white.withOpacity(0.7)
                              : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message.isRead == true 
                              ? Icons.done_all 
                              : Icons.done,
                          size: 16,
                          color: message.isRead == true 
                              ? Colors.blue[300]
                              : Colors.white.withOpacity(0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 8),
        ],
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    if (messageDate == today) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      final difference = today.difference(messageDate).inDays;
      if (difference == 1) {
        return '昨日 ${DateFormat('HH:mm').format(dateTime)}';
      } else if (difference < 7) {
        return '${difference}日前 ${DateFormat('HH:mm').format(dateTime)}';
      } else {
        return DateFormat('MM/dd HH:mm').format(dateTime);
      }
    }
  }
}