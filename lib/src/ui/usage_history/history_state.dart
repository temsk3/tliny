import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/ticket_repository.dart';

part 'history_state.g.dart';

@riverpod
Stream<UsageHistory> usageHistoryState(
  UsageHistoryStateRef ref,
  String id,
) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    throw Error();
  }
  return ref.watch(usageHistoryRepositoryProvider).watchUsageHistory(uid, id);
}

@riverpod
Stream<Ticket> ticketStreamState(TicketStreamStateRef ref, String id) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    throw Error();
  }
  return ref.watch(ticketRepositoryProvider).watchTicket(uid, id);
}
