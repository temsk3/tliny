import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/user_repository.dart';

import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository.dart';

part 'drawer_state.g.dart';

@riverpod
FutureOr<PackageInfo> getPackageInfo(GetPackageInfoRef ref) {
  return PackageInfo.fromPlatform();
}

@riverpod
Stream<User?> userStreamState(UserStreamStateRef ref) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    return Stream.value(null);
  }
  return ref.watch(userRepositoryProvider).watchUser(uid);
}
