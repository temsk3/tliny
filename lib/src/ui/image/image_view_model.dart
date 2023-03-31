import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/image_repository.dart';

part 'image_view_model.g.dart';

final logger = Logger();

@riverpod
class ImageViewModel extends _$ImageViewModel {
  late final imageRepository = ref.watch(imageRepositoryProvider);

  @override
  FutureOr<List<String>> build() {
    return <String>[];
  }

  // 取得
  Future<void> readImage(List<String> pictureURL) async {
    logger.d('readImage');
    state = const AsyncLoading();
    state = AsyncValue.data(
      pictureURL,
    );
  }

  // 追加
  Future<void> addImage(XFile file, String path) async {
    logger.d('addImage');
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final url = await imageRepository.uploadImage(
          image: await file.readAsBytes(),
          path: path,
          name: file.name,
        );
        return [...?state.value, url];
      },
    );
  }

  // 更新
  Future<void> updateImage(XFile file, String path, String name) async {
    logger.d('updateImage');
    await imageRepository.uploadImage(
      image: await file.readAsBytes(),
      path: path,
      name: file.name,
    );
  }

  //削除
  Future<void> deleteImage(String path, String name) async {
    logger.d('deleteImage');
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final url = await imageRepository.deleteImage(path: path, name: name);
        return [
          for (final value in state.value!)
            if (value != url) value
        ];
      },
    );
  }
}
