import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/order_repository.dart';

import '../../data/model/order_model.dart';
import '../../data/repository/auth_repository.dart';

part 'order_view_model.g.dart';

final logger = Logger();

@riverpod
class OrderViewModel extends _$OrderViewModel {
  late final authRepository = ref.watch(authRepositoryProvider);
  late final oderRepository = ref.watch(orderRepositoryProvider);

  @override
  FutureOr<List<Order>> build() {
    return readOrder();
  }

  // 取得
  Future<List<Order>> readOrder() async {
    logger.d('readCart');
    state = const AsyncLoading();
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    state = await AsyncValue.guard(
      () async {
        return oderRepository.readOrder(uid);
      },
    );
    return oderRepository.readOrder(uid);
  }
}
