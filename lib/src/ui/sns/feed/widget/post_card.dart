import 'package:flutter/material.dart';

import '../../../../data/model/sns/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  final Post post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ユーザー情報
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      post.userPhotoUrl != null
                          ? NetworkImage(post.userPhotoUrl!)
                          : null,
                  child:
                      post.userPhotoUrl == null
                          ? Text(post.userName.substring(0, 1).toUpperCase())
                          : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatDateTime(post.createdAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // Handle menu actions
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(value: 'report', child: Text('報告')),
                      ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 投稿内容
            Text(post.content, style: Theme.of(context).textTheme.bodyMedium),

            // 画像表示
            if (post.imageUrls?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              if (post.imageUrls!.length == 1)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    post.imageUrls!.first,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: post.imageUrls!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            post.imageUrls![index],
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],

            const SizedBox(height: 12),

            // アクションボタン
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: onLike,
                ),
                Text('${post.likesCount ?? 0}'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: onComment,
                ),
                Text('${post.commentsCount ?? 0}'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: onShare,
                ),
                Text('${post.sharesCount ?? 0}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}時間前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日前';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }
}
