import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/favorite_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/favorite_repository.dart';
import '../common/loading_screen.dart';

part 'favorite_view_model.g.dart';

final logger = Logger();

@riverpod
class FavoriteViewModel extends _$FavoriteViewModel {
  late final FavoriteRepository favoriteRepository = ref.read(
    favoriteRepositoryProvider,
  );
  late final AuthRepository authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<Favorite>> build() {
    return _readFavoriteDirectly();
  }

  // 直接お気に入りを取得（buildメソッド用）
  Future<List<Favorite>> _readFavoriteDirectly() async {
    logger.d('_readFavoriteDirectly');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    try {
      return await favoriteRepository.readFavorites(uid);
    } on AppException catch (e, st) {
      logger.e(
        '_readFavoriteDirectly: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('_readFavoriteDirectly: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      rethrow;
    }
  }

  // 取得（ローディング付き）
  Future<List<Favorite>> readFavorite() async {
    logger.d('readFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      final favorites = await loading.guardFuture(() async {
        return favoriteRepository.readFavorites(uid);
      });
      state = AsyncValue.data(favorites);
      return favorites;
    } on AppException catch (e, st) {
      logger.e('readFavorite: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('readFavorite: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  // 追加
  Future<void> addFavorite(Favorite data) async {
    logger.d('addFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      try {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        final favoriteId = await loading.guardFuture(() async {
          return favoriteRepository.createFavorite(uid, data);
        });
        final updatedFavorites = [
          ...?state.value,
          data.copyWith(id: favoriteId),
        ];
        state = AsyncValue.data(updatedFavorites);
      } on AppException catch (e, st) {
        logger.e('addFavorite: AppException - ${e.message}', stackTrace: st);
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('addFavorite: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );
        state = AsyncValue.error(appException, st);
        rethrow;
      }
    }
  }

  // 更新
  Future<void> updateFavorite(String uid, Favorite data) async {
    logger.d('updateFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      try {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        final id = await loading.guardFuture(() async {
          return favoriteRepository.updateFavorite(uid, data);
        });
        final updatedFavorites = [
          for (final favorite in state.value!)
            if (favorite.id == id) data else favorite,
        ];
        state = AsyncValue.data(updatedFavorites);
      } on AppException catch (e, st) {
        logger.e('updateFavorite: AppException - ${e.message}', stackTrace: st);
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('updateFavorite: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );
        state = AsyncValue.error(appException, st);
        rethrow;
      }
    }
  }

  //削除
  Future<void> deleteFavorite(String favoriteId) async {
    logger.d('deleteFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      try {
        final loading = ref.read(globalLoadingControllerProvider.notifier);
        await loading.guardFuture(() async {
          await favoriteRepository.deleteFavorite(uid, favoriteId);
        });
        final updatedFavorites = [
          for (final favorite in state.value!)
            if (favorite.id != favoriteId) favorite,
        ];
        state = AsyncValue.data(updatedFavorites);
      } on AppException catch (e, st) {
        logger.e('deleteFavorite: AppException - ${e.message}', stackTrace: st);
        state = AsyncValue.error(e, st);
        rethrow;
      } on Exception catch (e, st) {
        logger.e('deleteFavorite: Exception - $e', stackTrace: st);
        final appException = GeneralException(
          message: e.toString(),
          stackTrace: st,
        );
        state = AsyncValue.error(appException, st);
        rethrow;
      }
    }
  }
}
