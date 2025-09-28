import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/ticket_repository.dart';

// part 'history_state.freezed.dart';
part 'history_state.g.dart';

@riverpod
Stream<UsageHistory> usageHistoryState(Ref ref, String id) {
  final uidAsyncValue = ref.watch(userIdProvider);
  final uid = uidAsyncValue.value;
  if (uid == null) {
    throw Error();
  }
  return ref.watch(usageHistoryRepositoryProvider).watchUsageHistory(uid, id);
}

@riverpod
Stream<Ticket> ticketStreamState(Ref ref, String id) {
  // uidパラメータは不要なので、チケットIDだけでチケットを取得
  return ref.watch(ticketRepositoryProvider).watchTicket('', id);
}

// @riverpod
// class UsageHistory extends _$UsageHistory {
//   TicketRepository get _repository => ref.watch(ticketRepositoryProvider);
//   String? get _uid => ref.read(authRepositoryProvider).getCurrentUser()?.uid;
//   @override
//   Future<UsageHistoryState> build() async {
//     return _fetchUsageHistory();
//   }

//   String? getUserId() {
//     return ref.read(authRepositoryProvider).getCurrentUser()?.uid;
//   }

//   Future<UsageHistoryState> _fetchUsageHistory() async {
//     return UsageHistoryState(
//       _uid != null ? await _repository.readTicket(_uid!) : <Ticket>[],
//     );
//   }
// }

// @freezed
// class UsageHistoryState with _$UsageHistoryState {
//   factory UsageHistoryState(List<Ticket> ticketList) = _UsageHistoryState;

//   UsageHistoryState._();
// }
