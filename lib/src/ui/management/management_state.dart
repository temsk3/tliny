import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/order_model.dart';
import '../../data/model/product_model.dart';
import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/order_repository.dart';
import '../../data/repository/product_repository.dart';
import '../../data/repository/ticket_repository.dart';

part 'management_state.g.dart';

@riverpod
Stream<List<Order>> managementState(Ref ref, String eventId) {
  return ref.watch(orderRepositoryProvider).watchEventOrder(eventId);
}

@riverpod
Stream<List<Product>> productsManagementState(Ref ref, String eventId) {
  return ref.watch(productRepositoryProvider).watchProducts();
}

@riverpod
Stream<List<Ticket>> allTicketState(Ref ref) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    // throw Error();
    return Stream.value([]);
  }
  return ref.watch(ticketRepositoryProvider).watchAllTicket();
}
