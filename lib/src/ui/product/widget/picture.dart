// /Users/keizo/development/tliny/lib/src/ui/product/widget/picture.dart
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../settings/hooks/use_l10n.dart';
import '../../../utils/logger.dart';

class PictureCover extends HookConsumerWidget {
  const PictureCover({super.key, required this.picture});
  final String? picture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    logger.d('PictureCover build'); // build時のロギング
    return Container(
      // color: theme.appColors.primary,
      child: Center(
        child: (picture == null || picture == '')
            ? const Text(
                'NoImage',
                // style: theme.textTheme.h30,
              )
            : SizedBox.expand(
                child: CachedNetworkImage(
                  imageUrl: picture.toString(),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
      ),
    );
  }
}

class PictureDetail extends HookConsumerWidget {
  const PictureDetail({super.key, required this.picture, this.oldPicture});
  final Uint8List? picture;
  final String? oldPicture;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    logger.d('PictureDetail build'); // build時のロギング
    return Container(
      height: 100,
      width: 160,
      color: Colors.grey.withOpacity(0.3),
      alignment: Alignment.center,
      child: (picture == null)
          ? (oldPicture == '' || oldPicture == null)
              ? const Icon(Icons.add_photo_alternate)
              : SizedBox.expand(
                  child: CachedNetworkImage(
                    imageUrl: oldPicture!,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
          : SizedBox.expand(
              child: Image.memory(picture!),
            ),
    );
  }
}
