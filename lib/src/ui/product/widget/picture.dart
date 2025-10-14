// /Users/keizo/development/tliny/lib/src/ui/product/widget/picture.dart

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/logger.dart';

class PictureCover extends HookConsumerWidget {
  const PictureCover({super.key, required this.picture});
  final String? picture;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // // final l10n = useL10n();
    // final appRoute = useRouter();
    if (kDebugMode) {
      logger.d('PictureCover build'); // build時のロギング
    }
    return Center(
      child:
          (picture == null || picture == '')
              ? const Text(
                'NoImage',
                // style: theme.textTheme.h30,
              )
              : SizedBox.expand(
                child: CachedNetworkImage(
                  imageUrl: picture.toString(),
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey[300],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget: (context, url, error) {
                    if (kDebugMode) {
                      logger.e('CachedNetworkImage error: $error');
                    }
                    return Container(
                      color: Colors.grey[300],
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, color: Colors.red),
                          SizedBox(height: 4),
                          Text(
                            '画像読み込みエラー',
                            style: TextStyle(fontSize: 10, color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  },
                  // メモリ最適化のためのサイズ指定
                  memCacheWidth:
                      (200 * MediaQuery.of(context).devicePixelRatio).round(),
                  memCacheHeight:
                      (200 * MediaQuery.of(context).devicePixelRatio).round(),
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
    // // final l10n = useL10n();
    // final appRoute = useRouter();
    if (kDebugMode) {
      logger.d('PictureDetail build'); // build時のロギング
    }
    return Container(
      height: 100,
      width: 160,
      color: Colors.grey.withAlpha((255 * 0.3).toInt()),
      alignment: Alignment.center,
      child:
          (picture == null)
              ? (oldPicture == '' || oldPicture == null)
                  ? const Icon(Icons.add_photo_alternate)
                  : SizedBox.expand(
                    child: CachedNetworkImage(
                      imageUrl: oldPicture!,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(
                            width: 160,
                            height: 100,
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      errorWidget: (context, url, error) {
                        if (kDebugMode) {
                          logger.e('CachedNetworkImage error: $error');
                        }
                        return Container(
                          width: 160,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              SizedBox(height: 4),
                              Text(
                                '画像読み込みエラー',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // メモリ最適化のためのサイズ指定
                      memCacheWidth:
                          (160 * MediaQuery.of(context).devicePixelRatio)
                              .round(),
                      memCacheHeight:
                          (100 * MediaQuery.of(context).devicePixelRatio)
                              .round(),
                    ),
                  )
              : SizedBox.expand(child: Image.memory(picture!)),
    );
  }
}
