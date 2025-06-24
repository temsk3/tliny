import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/order_repository.dart';

import '../../data/model/order_model.dart';
import '../../data/repository/auth_repository.dart';

part 'order_state.g.dart';

@riverpod
Stream<List<Order>> ordersState(OrdersStateRef ref) {
  final uid = ref.watch(userIdProvider).value;
  if (uid == null) {
    return Stream.value([]);
  }
  return ref.watch(orderRepositoryProvider).watchOrder(uid);
}
