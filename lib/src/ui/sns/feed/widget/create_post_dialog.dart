import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/model/sns/post_model.dart';
import '../sns_feed_view_model.dart';

class CreatePostDialog extends HookConsumerWidget {
  const CreatePostDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentController = useTextEditingController();
    final isLoading = useState(false);

    return AlertDialog(
      title: const Text('新しい投稿'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: '今何をしていますか？',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              maxLength: 280,
            ),
            const SizedBox(height: 16),
            // TODO: 画像選択機能
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () {
                    // TODO: 画像選択の実装
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: () {
                    // TODO: 位置情報の実装
                  },
                ),
              ],
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
                    final content = contentController.text.trim();
                    if (content.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('投稿内容を入力してください')),
                      );
                      return;
                    }

                    isLoading.value = true;
                    try {
                      await ref
                          .read(snsFeedViewModelProvider.notifier)
                          .createPost(content: content, type: PostType.text);

                      if (context.mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('投稿しました')));
                      }
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('投稿に失敗しました: $error')),
                        );
                      }
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
                  : const Text('投稿'),
        ),
      ],
    );
  }
}
