import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/user_repository.dart';
import 'package:tliny/src/utils/logger.dart';

import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository.dart';

part 'drawer_state.g.dart';

@riverpod
FutureOr<PackageInfo> getPackageInfo(Ref ref) {
  return PackageInfo.fromPlatform();
}

@riverpod
Stream<User?> userStreamState(Ref ref) {
  final uidAsyncValue = ref.watch(userIdProvider);

  return uidAsyncValue.when(
    data: (uid) {
      if (uid == null) {
        logger.i('userStreamState: ユーザーIDが取得できませんでした');
        return Stream.value(null);
      }
      try {
        return ref.watch(userRepositoryProvider).watchUser(uid);
      } on Exception catch (e, st) {
        logger.e('userStreamState: エラー', error: e, stackTrace: st);
        return Stream.value(null);
      }
    },
    loading: () {
      logger.i('userStreamState: 認証状態を確認中');
      return Stream.value(null);
    },
    error: (error, stackTrace) {
      logger.e('userStreamState: 認証エラー', error: error, stackTrace: stackTrace);
      return Stream.value(null);
    },
  );
}
