import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../data/model/user_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../image/image_screen.dart';
import '../email_change_page.dart';
import '../password_change_page.dart';

class UserEditForm extends HookConsumerWidget {
  const UserEditForm({
    super.key,
    required this.user,
    required this.onSave,
    this.onCancel,
    this.isLoading = false,
  });

  final User user;
  final VoidCallback onSave;
  final VoidCallback? onCancel;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = Theme.of(context);
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final displayNameController = useTextEditingController(
      text: user.displayName ?? '',
    );
    final nameController = useTextEditingController(text: user.name ?? '');
    final phoneNumberController = useTextEditingController(
      text: user.phoneNumber ?? '',
    );

    return Form(
      key: formKey,
      child: Column(
        children: [
          // プロフィール画像編集セクション
          _buildProfileImageSection(context, theme),
          const SizedBox(height: 32),

          // メールアドレス表示セクション
          _buildEmailSection(context, l10n, theme),
          const SizedBox(height: 16),

          // メールアドレス変更ボタン
          _buildEmailChangeButton(context, l10n, theme),
          const SizedBox(height: 16),

          // パスワード変更ボタン
          _buildPasswordChangeButton(context, l10n, theme),
          const SizedBox(height: 32),

          // フォームフィールド
          _buildFormFields(
            context,
            l10n,
            theme,
            displayNameController,
            nameController,
            phoneNumberController,
          ),
          const SizedBox(height: 32),

          // 保存ボタン
          _buildSaveButton(
            context,
            l10n,
            theme,
            formKey,
            displayNameController,
            nameController,
            phoneNumberController,
          ),
          const SizedBox(height: 16),
          // 戻るボタン
          if (onCancel != null) _buildCancelButton(context, l10n, theme),
        ],
      ),
    );
  }

  Widget _buildProfileImageSection(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Text(
            'プロフィール画像',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          EditCircleAvatar(user.photoUrl),
        ],
      ),
    );
  }

  Widget _buildEmailSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                color: theme.colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.email,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            user.email ?? l10n.noEmail,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailChangeButton(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const EmailChangePage()),
          );
        },
        icon: const Icon(Icons.email_outlined),
        label: Text(l10n.changeEmail),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: theme.colorScheme.outline, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildPasswordChangeButton(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const PasswordChangePage()),
          );
        },
        icon: const Icon(Icons.lock_outlined),
        label: Text(l10n.changePassword),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: theme.colorScheme.outline, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildFormFields(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    TextEditingController displayNameController,
    TextEditingController nameController,
    TextEditingController phoneNumberController,
  ) {
    return Column(
      children: [
        _buildTextField(
          context,
          controller: displayNameController,
          label: l10n.displayName,
          icon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.pleaseEnterSomeText;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          context,
          controller: nameController,
          label: l10n.name,
          icon: Icons.badge_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.pleaseEnterSomeText;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          context,
          controller: phoneNumberController,
          label: l10n.phone,
          icon: Icons.phone_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return l10n.pleaseEnterSomeText;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: theme.colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
      ),
      validator: validator,
    );
  }

  Widget _buildCancelButton(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onCancel,
        icon: const Icon(Icons.arrow_back_ios_new),
        label: Text(l10n.backButton),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: theme.colorScheme.outline, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    GlobalKey<FormState> formKey,
    TextEditingController displayNameController,
    TextEditingController nameController,
    TextEditingController phoneNumberController,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed:
            isLoading
                ? null
                : () {
                  if (formKey.currentState!.validate()) {
                    onSave();
                  }
                },
        icon:
            isLoading
                ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.onPrimary,
                    ),
                  ),
                )
                : const Icon(Icons.save_outlined),
        label: Text(isLoading ? '保存中...' : '保存'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
