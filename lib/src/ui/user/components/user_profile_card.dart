import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../data/model/user_model.dart';
import '../../../settings/hooks/use_l10n.dart';

class UserProfileCard extends HookConsumerWidget {
  const UserProfileCard({
    super.key,
    required this.user,
    this.onEditPressed,
    this.showEditButton = true,
  });

  final User user;
  final VoidCallback? onEditPressed;
  final bool showEditButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // プロフィール画像セクション
            _buildProfileImageSection(context),
            const SizedBox(height: 24),

            // ユーザー情報セクション
            _buildUserInfoSection(context, l10n),
            const SizedBox(height: 24),

            // アクションボタンセクション
            if (showEditButton) _buildActionButtons(context, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImageSection(BuildContext context) {
    return Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                user.photoUrl != null
                    ? CachedNetworkImageProvider(user.photoUrl!)
                    : null,
            child:
                user.photoUrl == null
                    ? (user.displayName != null && user.displayName!.isNotEmpty
                        ? Text(
                          user.displayName![0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                        : const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 60,
                        ))
                    : null,
          ),
        ),
        if (showEditButton)
          Positioned(
            bottom: 0,
            right: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                ),
              ),
              child: IconButton(
                onPressed: onEditPressed,
                icon: const Icon(Icons.edit, size: 20),
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUserInfoSection(BuildContext context, AppLocalizations l10n) {
    return Column(
      children: [
        // 表示名
        if (user.displayName != null && user.displayName!.isNotEmpty)
          _buildInfoRow(
            context,
            Icons.person_outline,
            l10n.displayName,
            user.displayName!,
          ),

        // 名前
        if (user.name != null && user.name!.isNotEmpty)
          _buildInfoRow(context, Icons.badge_outlined, l10n.name, user.name!),

        // メールアドレス
        if (user.email != null && user.email!.isNotEmpty)
          _buildInfoRow(context, Icons.email_outlined, l10n.email, user.email!),

        // 電話番号
        if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty)
          _buildInfoRow(
            context,
            Icons.phone_outlined,
            l10n.phone,
            user.phoneNumber!,
          ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit_outlined),
            label: Text(l10n.edit),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
