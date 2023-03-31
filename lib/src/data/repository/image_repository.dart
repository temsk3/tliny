import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../general_provider.dart';

part 'image_repository.g.dart';

// CartRepositoryProvider
@Riverpod(keepAlive: true)
ImageRepository imageRepository(ImageRepositoryRef ref) {
  return ImageRepository(ref.watch(firebaseStorageProvider));
}

class ImageRepository {
  ImageRepository(this._storage);
  final FirebaseStorage _storage;

  // 登録
  Future<String> uploadImage({
    required Uint8List image,
    required String path,
    required String name,
  }) async {
    final storageRef = _storage.ref();
    final mountainsRef = storageRef.child(path).child(name);
    try {
      await mountainsRef.putData(
        image,
        SettableMetadata(
          contentType: 'image/jpeg',
        ),
      );
    } on FirebaseException catch (e) {
      e.toString();
    }
    return mountainsRef.getDownloadURL();
  }

  // 削除
  Future<String> deleteImage({
    required String path,
    required String name,
  }) async {
    final storageRef = _storage.ref();
    final mountainsRef = storageRef.child(path);
    final url = mountainsRef.child(name).getDownloadURL();

    final listResult = await mountainsRef.listAll();
    for (final item in listResult.items) {
      if (item.name == name) {
        await mountainsRef.child(name).delete();
      }
    }
    return url;
  }
}
