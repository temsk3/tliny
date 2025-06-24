import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/auth_repository.dart';

final StreamProvider<bool> userStateProvider = StreamProvider((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
