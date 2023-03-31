import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/ticket_repository.dart';

part 'ticket_state.g.dart';

@riverpod
Stream<List<Ticket>> ticketsState(TicketsStateRef ref) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    // throw Error();
    return Stream.value([]);
  }
  return ref.watch(ticketRepositoryProvider).watchTickets(uid);
}

@riverpod
Stream<Ticket> ticketState(TicketStateRef ref, String ticketId) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    return Stream.value(Ticket.empty());
  }
  return ref.watch(ticketRepositoryProvider).watchTicket(uid, ticketId);
}
