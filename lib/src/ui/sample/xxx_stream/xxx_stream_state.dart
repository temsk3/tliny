import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/repository/xxx/xxx_repository_impl.dart';

final xxxStreamStateProvider =
    StreamProvider((ref) => ref.watch(xxxRepositoryProvider).streamXxx());
