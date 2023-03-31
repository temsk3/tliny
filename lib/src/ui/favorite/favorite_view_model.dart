import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/favorite_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/favorite_repository.dart';

part 'favorite_view_model.g.dart';

final logger = Logger();

@riverpod
class FavoriteViewModel extends _$FavoriteViewModel {
  late final favoriteRepository = ref.read(favoriteRepositoryProvider);
  late final authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<Favorite>> build() {
    return readFavorite();
  }

  // 取得
  Future<List<Favorite>> readFavorite() async {
    logger.d('readFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        return favoriteRepository.readFavorites(uid);
      },
    );
    return favoriteRepository.readFavorites(uid);
  }

  // 追加
  Future<void> addFavorite(Favorite data) async {
    logger.d('addFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final favoriteId = await favoriteRepository.createFavorite(uid, data);
          return [...?state.value, data.copyWith(id: favoriteId)];
        },
      );
    }
  }

  // 更新
  Future<void> updateFavorite(String uid, Favorite data) async {
    logger.d('updateFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final id = await favoriteRepository.updateFavorite(uid, data);
          return [
            for (final favorite in state.value!)
              if (favorite.id == id) data else favorite
          ];
        },
      );
    }
  }

  //削除
  Future<void> deleteFavorite(String favoriteId) async {
    logger.d('deleteFavorite');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          await favoriteRepository.deleteFavorite(uid, favoriteId);
          return [
            for (final favorite in state.value!)
              if (favorite.id != favoriteId) favorite
          ];
        },
      );
    }
  }
}
