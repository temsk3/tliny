import 'package:flutter/material.dart';

import '../../../../data/model/sns/follow_model.dart';

class UserSearchCard extends StatelessWidget {
  const UserSearchCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  final UserProfile user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: user.profileImageUrl != null
              ? NetworkImage(user.profileImageUrl!)
              : null,
          child: user.profileImageUrl == null
              ? Text(
                  user.displayName?.isNotEmpty == true
                      ? user.displayName![0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        title: Text(
          user.displayName ?? 'Unknown User',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user.bio?.isNotEmpty == true)
              Text(
                user.bio!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'フォロワー ${user.followersCount ?? 0}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '投稿 ${user.postsCount ?? 0}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}