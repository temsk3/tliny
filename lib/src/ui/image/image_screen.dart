import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';

final logger = Logger();

class ImageScreen extends HookConsumerWidget {
  const ImageScreen({super.key, required this.imageList});
  final List<String> imageList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();

    final picker = ImagePicker();
    File? file;
    final imageState = useState(file);

    // 画像をギャラリーから選ぶ関数
    Future<void> pickImage() async {
      try {
        final image = await picker.pickImage(source: ImageSource.gallery);
        // 画像がnullの場合戻る
        if (image == null) return;

        final imageTemp = File(image.path);

        imageState.value = imageTemp;
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    // カメラを使う関数
    Future<void> pickImageCamera() async {
      try {
        final image = await picker.pickImage(source: ImageSource.camera);
        // 画像がnullの場合戻る
        if (image == null) return;

        final imageTemp = File(image.path);

        imageState.value = imageTemp;
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    return Column(
      children: [
        if (file != null)
          Image.file(
            file,
            fit: BoxFit.cover,
          ),
        OutlinedButton(
          onPressed: () async {
            await pickImage();
          },
          child: const Text('画像を選択'),
        )
      ],
    );
  }
}

// class PictureCover extends HookConsumerWidget {
//   const PictureCover({super.key, required this.picture});
//   final String? picture;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.watch(appThemeProvider);
//     final l10n = useL10n();
//     final appRoute = useRouter();
//     return Container(
//       child: Center(
//         child: (picture == null || picture == '')
//             ? Text(
//                 'NoImage',
//                 style: theme.textTheme.h30,
//               )
//             : SizedBox.expand(
//                 child: CachedNetworkImage(
//                   imageUrl: picture.toString(),
//                   placeholder: (context, url) =>
//                       const CircularProgressIndicator(),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class PictureDetail extends StatelessWidget {
//   const PictureDetail({super.key, required this.picture, this.oldPicture});
//   final Uint8List? picture;
//   final String? oldPicture;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: 160,
//       color: Colors.grey.withOpacity(0.3),
//       alignment: Alignment.center,
//       child: (picture == null)
//           ? (oldPicture == '' || oldPicture == null)
//               ? const Icon(Icons.add_photo_alternate)
//               : SizedBox.expand(
//                   child: CachedNetworkImage(
//                     imageUrl: oldPicture!,
//                     placeholder: (context, url) =>
//                         const CircularProgressIndicator(),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error),
//                   ),
//                 )
//           : SizedBox.expand(
//               child: Image.memory(picture!),
//             ),
//     );
//   }
// }

class PictureEditView extends HookWidget {
  const PictureEditView({
    super.key,
    required this.picture,
    this.height,
    this.width,
  });
  final List<String> picture;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    // File? file;
    Uint8List? file;
    final imageState = useState(file);
    Future<void> pickImage() async {
      try {
        final image = await picker.pickImage(source: ImageSource.gallery);
        // 画像がnullの場合戻る
        if (image == null) return;
        logger.d(image.name);
        // final imageTemp = File(image.path);
        final imageTemp = await image.readAsBytes();

        imageState.value = imageTemp;
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    return InkWell(
      onTap: () async {
        await pickImage();
      },
      child: imageState.value == null
          ? Container(
              height: height ?? 90,
              width: width ?? 160,
              color: Colors.grey.withOpacity(0.3),
              alignment: Alignment.center,
              child: (picture.isEmpty)
                  ? const Icon(Icons.add_photo_alternate)
                  : SizedBox.expand(
                      child: CachedNetworkImage(
                        imageUrl: picture[0],
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
            )
          : SizedBox(
              height: height ?? 90,
              width: width ?? 160,
              child: Image.memory(
                imageState.value!,
                fit: BoxFit.scaleDown,
              ),
            ),
    );
  }
}

class PictureDetailView extends HookWidget {
  const PictureDetailView({
    super.key,
    required this.picture,
    this.height,
    this.width,
  });
  final List<String> picture;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final appRoute = useRouter();
    return Container(
      height: height ?? 45,
      width: width ?? 80,
      color: Colors.grey.withOpacity(0.3),
      alignment: Alignment.center,
      child: (picture.isEmpty)
          ? const Text(
              'NoImage',
            )
          : InkWell(
              child: SizedBox.expand(
                child: CachedNetworkImage(
                  imageUrl: picture[0],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              onTap: () {
                showGeneralDialog(
                  transitionDuration: const Duration(milliseconds: 1000),
                  barrierDismissible: true,
                  barrierLabel: '',
                  context: context,
                  pageBuilder: (context, animation1, animation2) {
                    return DefaultTextStyle(
                      style: Theme.of(context).primaryTextTheme.bodyLarge!,
                      child: Center(
                        child: SizedBox(
                          height: 500,
                          width: 500,
                          child: SingleChildScrollView(
                            child: Stack(
                              children: [
                                InteractiveViewer(
                                  minScale: 0.1,
                                  maxScale: 5,
                                  child: Container(
                                    child: CachedNetworkImage(
                                      imageUrl: picture[0],
                                      placeholder: (
                                        context,
                                        url,
                                      ) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (
                                        context,
                                        url,
                                        error,
                                      ) =>
                                          const Icon(
                                        Icons.error,
                                      ),
                                    ),
                                  ),
                                ),
                                SafeArea(
                                  child: IconButton(
                                    onPressed: appRoute.pop,
                                    icon: const Icon(
                                      Icons.close,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
