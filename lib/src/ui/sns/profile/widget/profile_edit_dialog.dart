import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../data/model/sns/follow_model.dart';

class ProfileEditDialog extends HookWidget {
  const ProfileEditDialog({
    super.key,
    required this.profile,
    required this.onSave,
  });

  final UserProfile profile;
  final Function(String? displayName, String? bio, bool? isPrivate) onSave;

  @override
  Widget build(BuildContext context) {
    final displayNameController = useTextEditingController(
      text: profile.displayName ?? '',
    );
    final bioController = useTextEditingController(text: profile.bio ?? '');
    final isPrivate = useState(profile.isPrivate ?? false);
    final isLoading = useState(false);

    return AlertDialog(
      title: const Text('プロファイル編集'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: displayNameController,
              decoration: const InputDecoration(
                labelText: '表示名',
                hintText: '表示名を入力してください',
                border: OutlineInputBorder(),
              ),
              maxLength: 50,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: '自己紹介',
                hintText: '自己紹介を入力してください',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              maxLength: 200,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('プライベートアカウント'),
              subtitle: const Text('フォロワーのみが投稿を見ることができます'),
              value: isPrivate.value,
              onChanged:
                  isLoading.value ? null : (value) => isPrivate.value = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isLoading.value ? null : () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed:
              isLoading.value
                  ? null
                  : () async {
                    isLoading.value = true;
                    try {
                      await onSave(
                        displayNameController.text.trim(),
                        bioController.text.trim(),
                        isPrivate.value,
                      );
                    } finally {
                      isLoading.value = false;
                    }
                  },
          child:
              isLoading.value
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('保存'),
        ),
      ],
    );
  }
}
