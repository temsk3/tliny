import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';

part 'image_repository.g.dart';

// ImageRepositoryProvider
@Riverpod(keepAlive: true)
ImageRepository imageRepository(Ref ref) {
  return ImageRepository(ref.watch(firebaseStorageProvider));
}

class ImageRepository {
  ImageRepository(this._storage);
  final FirebaseStorage _storage;

  /// 画像をアップロードする
  Future<String> uploadImage({
    required Uint8List image,
    required String path,
    required String name,
  }) async {
    logger.i('uploadImage: 画像をアップロードします path=$path, name=$name');
    try {
      final storageRef = _storage.ref();
      final mountainsRef = storageRef.child(path).child(name);

      await mountainsRef.putData(
        image,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final downloadUrl = await mountainsRef.getDownloadURL();
      logger.i('uploadImage: 画像のアップロードが完了しました');
      return downloadUrl;
    } on FirebaseException catch (e, st) {
      logger.e('uploadImage: FirebaseStorageエラー', error: e, stackTrace: st);
      throw GeneralException(
        message: '画像のアップロードに失敗しました: ${e.message}',
        stackTrace: st,
      );
    } on Exception catch (e, st) {
      logger.e('uploadImage: 予期しないエラー', error: e, stackTrace: st);
      throw GeneralException(message: '画像のアップロードに失敗しました', stackTrace: st);
    }
  }

  /// 画像を削除する
  Future<void> deleteImage({
    required String path,
    required String? name,
  }) async {
    logger.i('deleteImage: 画像を削除します path=$path, name=$name');
    try {
      final storageRef = _storage.ref();
      final mountainsRef = storageRef.child(path);

      if (name == null) {
        // フォルダ全体を削除
        await mountainsRef.delete();
        logger.i('deleteImage: フォルダ全体を削除しました');
      } else {
        // 特定のファイルを削除
        await mountainsRef.child(name).delete();
        logger.i('deleteImage: 特定のファイルを削除しました');
      }
    } on FirebaseException catch (e, st) {
      logger.e('deleteImage: FirebaseStorageエラー', error: e, stackTrace: st);
      throw GeneralException(
        message: '画像の削除に失敗しました: ${e.message}',
        stackTrace: st,
      );
    } on Exception catch (e, st) {
      logger.e('deleteImage: 予期しないエラー', error: e, stackTrace: st);
      throw GeneralException(message: '画像の削除に失敗しました', stackTrace: st);
    }
  }

  /// 画像のダウンロードURLを取得する
  Future<String> getDownloadUrl({
    required String path,
    required String name,
  }) async {
    logger.i('getDownloadUrl: ダウンロードURLを取得します path=$path, name=$name');
    try {
      final storageRef = _storage.ref();
      final fileRef = storageRef.child(path).child(name);
      final downloadUrl = await fileRef.getDownloadURL();
      logger.i('getDownloadUrl: ダウンロードURLを取得しました');
      return downloadUrl;
    } on FirebaseException catch (e, st) {
      logger.e('getDownloadUrl: FirebaseStorageエラー', error: e, stackTrace: st);
      throw GeneralException(
        message: 'ダウンロードURLの取得に失敗しました: ${e.message}',
        stackTrace: st,
      );
    } on Exception catch (e, st) {
      logger.e('getDownloadUrl: 予期しないエラー', error: e, stackTrace: st);
      throw GeneralException(message: 'ダウンロードURLの取得に失敗しました', stackTrace: st);
    }
  }

  /// フォルダ内のファイル一覧を取得する
  Future<List<String>> listFiles({required String path}) async {
    logger.i('listFiles: ファイル一覧を取得します path=$path');
    try {
      final storageRef = _storage.ref();
      final folderRef = storageRef.child(path);
      final listResult = await folderRef.listAll();
      final fileNames = listResult.items.map((item) => item.name).toList();
      logger.i('listFiles: ファイル一覧を取得しました count=${fileNames.length}');
      return fileNames;
    } on FirebaseException catch (e, st) {
      logger.e('listFiles: FirebaseStorageエラー', error: e, stackTrace: st);
      throw GeneralException(
        message: 'ファイル一覧の取得に失敗しました: ${e.message}',
        stackTrace: st,
      );
    } on Exception catch (e, st) {
      logger.e('listFiles: 予期しないエラー', error: e, stackTrace: st);
      throw GeneralException(message: 'ファイル一覧の取得に失敗しました', stackTrace: st);
    }
  }
}
