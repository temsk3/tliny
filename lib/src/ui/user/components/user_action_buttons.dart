import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../settings/hooks/use_l10n.dart';

class UserActionButtons extends HookConsumerWidget {
  const UserActionButtons({
    super.key,
    required this.onBackPressed,
    required this.onEditPressed,
    this.onAccountLinkPressed,
    this.onAdminSitePressed,
    this.showAccountLinkButton = true,
    this.showAdminSiteButton = true,
  });

  final VoidCallback onBackPressed;
  final VoidCallback onEditPressed;
  final VoidCallback? onAccountLinkPressed;
  final VoidCallback? onAdminSitePressed;
  final bool showAccountLinkButton;
  final bool showAdminSiteButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = Theme.of(context);

    return Column(
      children: [
        // メインアクションボタン
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  context,
                  icon: Icons.arrow_back_ios_new,
                  label: l10n.backButton,
                  onPressed: onBackPressed,
                  style: ButtonStyle.outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton(
                  context,
                  icon: Icons.edit_outlined,
                  label: l10n.edit,
                  onPressed: onEditPressed,
                  style: ButtonStyle.filled,
                ),
              ),
            ],
          ),
        ),

        // 追加アクションボタン
        if (showAccountLinkButton || showAdminSiteButton) ...[
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (showAccountLinkButton) ...[
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: Icons.storefront_outlined,
                      label: '出品者登録・更新',
                      onPressed: onAccountLinkPressed ?? () {},
                      style: ButtonStyle.tonal,
                    ),
                  ),
                  if (showAdminSiteButton) const SizedBox(width: 12),
                ],
                if (showAdminSiteButton)
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: Icons.admin_panel_settings_outlined,
                      label: '管理サイト',
                      onPressed: onAdminSitePressed ?? () {},
                      style: ButtonStyle.tonal,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required ButtonStyle style,
  }) {
    final theme = Theme.of(context);

    switch (style) {
      case ButtonStyle.filled:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        );
      case ButtonStyle.outlined:
        return OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: theme.colorScheme.outline, width: 1.5),
          ),
        );
      case ButtonStyle.tonal:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 1,
          ),
        );
    }
  }
}

enum ButtonStyle { filled, outlined, tonal }
