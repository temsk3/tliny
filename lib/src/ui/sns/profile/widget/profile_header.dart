import 'package:flutter/material.dart';

import '../../../../data/model/sns/follow_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    required this.isFollowing,
    required this.isOwnProfile,
    required this.onFollowToggle,
    required this.onEditProfile,
  });

  final UserProfile? profile;
  final bool isFollowing;
  final bool isOwnProfile;
  final VoidCallback onFollowToggle;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.8),
            Theme.of(context).primaryColor.withOpacity(0.4),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(),
              // プロファイル画像
              CircleAvatar(
                radius: 50,
                backgroundImage: profile?.profileImageUrl != null
                    ? NetworkImage(profile!.profileImageUrl!)
                    : null,
                child: profile?.profileImageUrl == null
                    ? Text(
                        profile?.displayName?.isNotEmpty == true
                            ? profile!.displayName![0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              // ユーザー名
              Text(
                profile?.displayName ?? 'Unknown User',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // Bio
              if (profile?.bio?.isNotEmpty == true)
                Text(
                  profile!.bio!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 16),
              // フォロー数・フォロワー数・投稿数
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn(
                    '投稿',
                    profile?.postsCount?.toString() ?? '0',
                  ),
                  _buildStatColumn(
                    'フォロワー',
                    profile?.followersCount?.toString() ?? '0',
                  ),
                  _buildStatColumn(
                    'フォロー中',
                    profile?.followingCount?.toString() ?? '0',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // フォローボタンまたは編集ボタン
              if (isOwnProfile)
                ElevatedButton.icon(
                  onPressed: onEditProfile,
                  icon: const Icon(Icons.edit),
                  label: const Text('プロファイルを編集'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                )
              else
                ElevatedButton.icon(
                  onPressed: onFollowToggle,
                  icon: Icon(isFollowing ? Icons.person_remove : Icons.person_add),
                  label: Text(isFollowing ? 'フォロー解除' : 'フォロー'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFollowing ? Colors.grey[600] : Colors.white,
                    foregroundColor: isFollowing ? Colors.white : Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}