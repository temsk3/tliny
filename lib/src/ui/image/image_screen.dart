import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tliny/src/ui/common/asyncvalue_widget.dart';

import '../../data/model/exception/app_exception.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import '../common/error_handler.dart';
import 'image_view_model.dart';

class ImageScreen extends HookConsumerWidget {
  const ImageScreen({super.key, required this.imageList});
  final List<String> imageList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();

    final picker = ImagePicker();
    File? file;
    final imageState = useState(file);

    // 画像をギャラリーから選ぶ関数
    Future<void> pickImage() async {
      try {
        final image = await picker.pickImage(source: ImageSource.gallery);
        // 画像がnullの場合戻る
        if (image == null) {
          return;
        }

        final imageTemp = File(image.path);

        imageState.value = imageTemp;
      } on PlatformException catch (e) {
        logger.e('Failed to pick image: $e');
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, e, l10n);
        }
      } on Exception catch (e) {
        logger.e('Failed to pick image: $e');
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, e, l10n);
        }
      }
    }

    // カメラを使う関数
    Future<void> pickImageCamera() async {
      try {
        final image = await picker.pickImage(source: ImageSource.camera);
        // 画像がnullの場合戻る
        if (image == null) {
          return;
        }

        final imageTemp = File(image.path);

        imageState.value = imageTemp;
      } on PlatformException catch (e) {
        logger.e('Failed to pick image: $e');
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, e, l10n);
        }
      } on Exception catch (e) {
        logger.e('Failed to pick image: $e');
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, e, l10n);
        }
      }
    }

    return Column(
      children: [
        OutlinedButton(
          onPressed: () async {
            try {
              await pickImage();
            } catch (e) {
              logger.e('Failed to pick image: $e');
              if (context.mounted) {
                ErrorHandler.showErrorSnackBar(context, e, l10n);
              }
            }
          },
          child: Text(l10n.selectImage),
        ),
      ],
    );
  }
}

class EditCircleAvatar extends HookConsumerWidget {
  const EditCircleAvatar(this.photoUrl, {super.key});
  final String? photoUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final state = ref.watch(tempImageViewModelProvider);
    final viewModel = ref.watch(tempImageViewModelProvider.notifier);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        return InkWell(
          onTap: () async {
            try {
              await viewModel.addTempImage();
            } on Exception catch (e) {
              logger.e('Failed to add temp image: $e');
            }
          },
          child:
              data == null
                  ? CircleAvatar(
                    radius: 75,
                    backgroundImage:
                        photoUrl == null ? null : NetworkImage(photoUrl!),
                  )
                  : CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage(data.path),
                  ),
        );
      },
    );
  }
}

class EditPictureView extends HookConsumerWidget {
  const EditPictureView({
    super.key,
    required this.imageViewModel,
    required this.picture,
    required this.index,
    this.height,
    this.width,
    required this.imageState,
  });
  final TempImageListViewModel imageViewModel;
  final List<String> picture;
  final int index;
  final double? height;
  final double? width;
  final ValueNotifier<Uint8List?> imageState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final picker = ImagePicker();

    Future<void> pickImage() async {
      try {
        final image = await picker.pickImage(source: ImageSource.gallery);
        // 画像がnullの場合戻る
        if (image == null) {
          return;
        }
        logger.d('Picked image: ${image.name}');

        // setTempImageでエラーハンドリング
        try {
          await imageViewModel.setTempImage(index, image);
          final imageTemp = await image.readAsBytes();
          imageState.value = imageTemp;
        } on AppException catch (e) {
          logger.e('setTempImage AppException: ${e.message}');
          if (context.mounted) {
            ErrorHandler.showErrorSnackBar(context, e, l10n);
          }
        } on Exception catch (e) {
          logger.e('setTempImage Exception: $e');
          if (context.mounted) {
            ErrorHandler.showErrorSnackBar(context, e, l10n);
          }
        }
      } on PlatformException catch (e) {
        logger.e('Failed to pick image: $e');
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, e, l10n);
        }
      } on Exception catch (e) {
        logger.e('Failed to pick image: $e');
        if (context.mounted) {
          ErrorHandler.showErrorSnackBar(context, e, l10n);
        }
      }
    }

    return InkWell(
      onTap: () async {
        try {
          await pickImage();
        } on Exception catch (e) {
          logger.e('Failed to pick image: $e');
          if (context.mounted) {
            ErrorHandler.showErrorSnackBar(context, e, l10n);
          }
        }
      },
      child:
          imageState.value == null
              ? Container(
                height: height ?? 90,
                width: width ?? 160,
                color: Colors.grey.withValues(alpha: 0.3),
                alignment: Alignment.center,
                child:
                    (picture.isEmpty)
                        ? const Icon(Icons.add_photo_alternate)
                        : SizedBox.expand(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: picture[index],
                            placeholder:
                                (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            errorWidget: (context, url, error) {
                              logger.e(
                                'CachedNetworkImage error: $error for URL: $url',
                              );
                              return Container(
                                color: Colors.grey[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.error, color: Colors.red),
                                    const SizedBox(height: 4),
                                    Text(
                                      '画像読み込みエラー',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.red[700],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
              )
              : SizedBox(
                height: height ?? 90,
                width: width ?? 160,
                child: Image.memory(imageState.value!, fit: BoxFit.scaleDown),
              ),
    );
  }
}

class PictureView extends HookWidget {
  const PictureView({
    super.key,
    required this.picture,
    required this.index,
    this.height,
    this.width,
    this.tap = true,
  });
  final List<String> picture;
  final int index;
  final double? height;
  final double? width;
  final bool tap;

  @override
  Widget build(BuildContext context) {
    // final appRoute = useRouter();
    return Container(
      height: height ?? 45,
      width: width ?? 80,
      color: Colors.grey.withValues(alpha: 0.3),
      alignment: Alignment.center,
      child:
          (picture.isEmpty || index >= picture.length)
              ? const Text('NoImage')
              : InkWell(
                onTap:
                    tap
                        ? () {
                          try {
                            showGeneralDialog(
                              transitionDuration: const Duration(
                                milliseconds: 1000,
                              ),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              pageBuilder: (context, animation1, animation2) {
                                return DefaultTextStyle(
                                  style:
                                      Theme.of(
                                        context,
                                      ).primaryTextTheme.bodyLarge!,
                                  child: Center(
                                    child: SizedBox(
                                      // height: 500,
                                      // width: 500,
                                      child: SingleChildScrollView(
                                        child: Stack(
                                          children: [
                                            InteractiveViewer(
                                              minScale: 0.1,
                                              maxScale: 5,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: picture[0],
                                                placeholder:
                                                    (
                                                      context,
                                                      url,
                                                    ) => const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget: (
                                                  context,
                                                  url,
                                                  error,
                                                ) {
                                                  logger.e(
                                                    'CachedNetworkImage error: $error',
                                                  );
                                                  return Container(
                                                    color: Colors.grey[300],
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          '画像読み込みエラー',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.red[700],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // SafeArea(
                                            //   child: IconButton(
                                            //     onPressed: appRoute.pop,
                                            //     icon: const Icon(
                                            //       Icons.close,
                                            //     ),
                                            //   ),
                                            // )
                                            TextButton(
                                              onPressed:
                                                  () => RouterUtils.safePop(
                                                    context,
                                                  ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } on Exception catch (e) {
                            logger.e('Failed to show dialog: $e');
                          }
                        }
                        : null,
                child: SizedBox.expand(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: picture[index],
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) {
                      logger.e(
                        'CachedNetworkImage error: $error for URL: $url',
                      );
                      return Container(
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(height: 4),
                            Text(
                              '画像読み込みエラー',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
    );
  }
}
