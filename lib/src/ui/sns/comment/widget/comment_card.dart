import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/sns/post_model.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.comment,
    this.onDelete,
  });

  final PostComment comment;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ユーザーアバター
          CircleAvatar(
            radius: 16,
            backgroundImage: comment.userPhotoUrl != null
                ? NetworkImage(comment.userPhotoUrl!)
                : null,
            child: comment.userPhotoUrl == null
                ? Text(
                    comment.userName.isNotEmpty 
                        ? comment.userName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // コメント内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ユーザー名と時間
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(comment.createdAt),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    if (onDelete != null)
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('削除'),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'delete' && onDelete != null) {
                            onDelete!();
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                // コメント本文
                Text(
                  comment.content,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
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