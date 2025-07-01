import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/repository/image_repository.dart';
import '../../data/repository/uuid_repository.dart';
import '../../utils/logger.dart';

part 'image_view_model.g.dart';

/// 画像のURLリストを管理する StateNotifierProvider
@riverpod
class ImageViewModel extends _$ImageViewModel {
  /// 画像リポジトリを取得
  late final ImageRepository imageRepository = ref.watch(
    imageRepositoryProvider,
  );

  /// ViewModel が初期化された際に呼ばれる
  /// 初期状態は空の画像URLリスト
  @override
  FutureOr<List<String>> build() {
    return <String>[];
  }

  /// 画像URLリストを設定する
  ///
  /// 引数:
  ///   pictureURL: 画像URLのリスト
  Future<void> setImage(List<String> pictureURL) async {
    logger.d('setImage: pictureURL=$pictureURL', time: DateTime.now());
    try {
      // 状態を AsyncLoading に設定
      state = const AsyncLoading();
      // 状態を画像URLリストに設定
      state = AsyncValue.data(pictureURL);
    } on AppException catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e(
        'setImage: AppException - ${e.message}',
        stackTrace: st,
        time: DateTime.now(),
      );
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e(
        'setImage: Exception - $e',
        stackTrace: st,
        time: DateTime.now(),
      );
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// 画像を追加する
  ///
  /// 引数:
  ///   file: 選択された画像ファイル
  ///   path: 画像をアップロードするパス
  Future<void> addImage(XFile file, String path) async {
    logger.d('addImage: path=$path', time: DateTime.now());
    try {
      // 状態を AsyncLoading に設定
      state = const AsyncLoading();
      // 画像をアップロードし、画像URLを取得
      final imageBytes = await file.readAsBytes();
      final url = await imageRepository.uploadImage(
        image: imageBytes,
        path: path,
        name: file.name,
      );
      // 画像URLリストに新しい画像URLを追加
      state = AsyncValue.data([...?state.value, url]);
    } on AppException catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e(
        'addImage: AppException - ${e.message}',
        stackTrace: st,
        time: DateTime.now(),
      );
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e(
        'addImage: Exception - $e',
        stackTrace: st,
        time: DateTime.now(),
      );
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// 画像を更新する
  ///
  /// 引数:
  ///   file: 選択された画像ファイル
  ///   path: 画像をアップロードするパス
  Future<void> updateImage(XFile file, String path) async {
    logger.d(
      'updateImage: file=${file.name}, path=$path',
      time: DateTime.now(),
    );
    try {
      // 状態を AsyncLoading に設定
      state = const AsyncLoading();
      // 画像をアップロードし、画像URLを取得
      final url = await imageRepository.uploadImage(
        image: await file.readAsBytes(),
        path: path,
        name: file.name,
      );
      // 画像URLリストから古い画像URLを削除し、新しい画像URLを追加
      state = AsyncValue.data([
        for (final value in state.value!)
          if (value != url) value,
      ]);
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e('updateImage: error=$e, stackTrace=$st', time: DateTime.now());
      // エラーを再スロー
      rethrow;
    }
  }

  /// 画像を削除する
  ///
  /// 引数:
  ///   path: 画像を削除するパス
  ///   name: 画像の名前
  Future<void> deleteImage(String path, String? name) async {
    logger.d('deleteImage: path=$path, name=$name', time: DateTime.now());
    try {
      // 状態を AsyncLoading に設定
      state = const AsyncLoading();
      // 画像を削除
      await imageRepository.deleteImage(path: path, name: name);
      // 画像URLリストから削除された画像URLを削除（name一致でフィルタリングする場合はここで実装）
      // 今回はstate.valueのまま維持、または必要に応じてstateを更新
    } on AppException catch (e, st) {
      logger.e(
        'deleteImage: AppException - ${e.message}',
        stackTrace: st,
        time: DateTime.now(),
      );
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e(
        'deleteImage: Exception - $e',
        stackTrace: st,
        time: DateTime.now(),
      );
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }
}

/// 一時的な画像ファイルの情報を管理する StateNotifierProvider
@riverpod
class TempImageViewModel extends _$TempImageViewModel {
  /// ViewModel が初期化された際に呼ばれる
  /// 初期状態は null
  @override
  FutureOr<XFile?> build() {
    return null;
  }

  /// 一時的な画像ファイルを追加する
  ///
  /// ギャラリーから画像を選択
  Future<void> addTempImage() async {
    logger.d('addTempImage', time: DateTime.now());
    try {
      // 状態を AsyncLoading に設定
      state = const AsyncLoading();
      // ギャラリーから画像を選択
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // 状態を画像ファイルに設定
      state = AsyncValue.data(image);
    } on AppException catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e(
        'addTempImage: AppException - ${e.message}',
        stackTrace: st,
        time: DateTime.now(),
      );
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e(
        'addTempImage: Exception - $e',
        stackTrace: st,
        time: DateTime.now(),
      );

      // 画像デコードエラーの場合は専用メッセージを設定
      String errorMessage;
      if (e.toString().contains('ImageCodecException') ||
          e.toString().contains('Failed to decode image') ||
          e.toString().contains('InvalidStateError') ||
          e.toString().contains('track metadata')) {
        errorMessage = '画像の読み込みに失敗しました。別の画像をお試しください。';
      } else if (e.toString().contains('heic') ||
          e.toString().contains('HEIC')) {
        errorMessage = 'HEIC形式の画像は現在サポートされていません。JPEGまたはPNG形式の画像をお試しください。';
      } else {
        errorMessage = e.toString();
      }

      final appException = GeneralException(
        message: errorMessage,
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }
}

/// 一時的な画像ファイルのリストを管理する StateNotifierProvider
@riverpod
class TempImageListViewModel extends _$TempImageListViewModel {
  /// 画像リポジトリを取得
  late final ImageRepository imageRepository = ref.watch(
    imageRepositoryProvider,
  );

  /// UUIDリポジトリを取得
  late final UuidRepository uuidRepository = ref.watch(uuidRepositoryProvider);

  /// ViewModel が初期化された際に呼ばれる
  /// 初期状態は空の画像ファイルリスト
  @override
  FutureOr<Map<int, XFile>> build() {
    return <int, XFile>{};
  }

  /// 一時的な画像ファイルリストから画像をアップロードし、画像URLリストを取得する
  ///
  /// 引数:
  ///   path: 画像をアップロードするパス
  ///   list: 元の画像URLリスト
  Future<List<String>> getTempImage(String path, List<String> list) async {
    logger.d('getTempImage: path=$path, list=$list', time: DateTime.now());
    try {
      // 新しい画像URLリストを作成
      final newMap = list.asMap().map(MapEntry.new);

      // 一時的な画像ファイルリストを取得
      final map = state.value;
      // 一時的な画像ファイルリストが空の場合、元の画像URLリストを返す
      if (map == null || map.isEmpty) {
        return list;
      }
      // 一時的な画像ファイルリストをループ処理
      for (final key in map.keys) {
        // 元の画像URLリストにキーが存在する場合、画像を削除
        if (newMap.containsKey(key)) {
          await imageRepository.deleteImage(path: newMap[key]!, name: null);
          logger.d('delete : ${newMap[key]!}', time: DateTime.now());
        }
        // 一時的な画像ファイルリストの値を取得
        final value = map[key];
        // 値が null でない場合、画像をアップロードし、画像URLを取得
        if (value != null) {
          final url = await imageRepository.uploadImage(
            image: await value.readAsBytes(),
            path: path,
            name: value.name,
          );
          // 新しい画像URLリストに画像URLを追加
          newMap[key] = url;
        }
      }
      // 新しい画像URLリストを返す
      final newList = newMap.entries.map((e) => e.value).toList();
      return newList;
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e('getTempImage: error=$e, stackTrace=$st', time: DateTime.now());
      // エラーを再スロー
      rethrow;
    }
  }

  /// 一時的な画像ファイルリストに画像を追加する
  ///
  /// 引数:
  ///   index: 画像のインデックス
  ///   file: 選択された画像ファイル
  Future<void> setTempImage(int index, XFile file) async {
    logger.d(
      'setTempImage: index=$index, file=${file.name}',
      time: DateTime.now(),
    );
    try {
      // HEIC形式の画像をチェック
      if (file.name.toLowerCase().contains('.heic')) {
        throw GeneralException(
          message: 'HEIC形式の画像は現在サポートされていません。JPEGまたはPNG形式の画像をお試しください。',
          stackTrace: StackTrace.current,
        );
      }

      // 画像の読み込みテスト
      try {
        await file.readAsBytes();
      } on Exception catch (e) {
        if (e.toString().contains('ImageCodecException') ||
            e.toString().contains('Failed to decode image') ||
            e.toString().contains('InvalidStateError') ||
            e.toString().contains('track metadata')) {
          throw GeneralException(
            message: '画像の読み込みに失敗しました。別の画像をお試しください。',
            stackTrace: StackTrace.current,
          );
        }
        rethrow;
      }

      // 状態を AsyncLoading に設定
      state = const AsyncLoading();
      // 一時的な画像ファイルリストを取得
      final mapState = state.value!.map(MapEntry.new);
      // 一時的な画像ファイルリストに画像を追加
      mapState.addAll({index: file});
      // 状態を更新
      state = AsyncValue.data(mapState);
    } on AppException catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e(
        'setTempImage: AppException - ${e.message}',
        stackTrace: st,
        time: DateTime.now(),
      );
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e('setTempImage: error=$e, stackTrace=$st', time: DateTime.now());

      // 画像デコードエラーの場合は専用メッセージを設定
      String errorMessage;
      if (e.toString().contains('ImageCodecException') ||
          e.toString().contains('Failed to decode image') ||
          e.toString().contains('InvalidStateError') ||
          e.toString().contains('track metadata')) {
        errorMessage = '画像の読み込みに失敗しました。別の画像をお試しください。';
      } else if (e.toString().contains('heic') ||
          e.toString().contains('HEIC')) {
        errorMessage = 'HEIC形式の画像は現在サポートされていません。JPEGまたはPNG形式の画像をお試しください。';
      } else {
        errorMessage = e.toString();
      }

      final appException = GeneralException(
        message: errorMessage,
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// UUIDを生成する
  Future<String> get createUuid async {
    logger.d('createUuid', time: DateTime.now());
    try {
      // UUIDを生成
      return await uuidRepository.createUuid();
    } on Exception catch (e, st) {
      logger.e('createUuid: error=$e, stackTrace=$st', time: DateTime.now());
      rethrow;
    }
  }
}
