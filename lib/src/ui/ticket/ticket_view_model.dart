import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/ticket_repository.dart';

part 'ticket_view_model.g.dart';

final logger = Logger();

@riverpod
class TicketViewModel extends _$TicketViewModel {
  late final ticketRepository = ref.read(ticketRepositoryProvider);
  late final authRepository = ref.read(authRepositoryProvider);

  @override
  FutureOr<List<Ticket>> build() {
    return readTicket();
  }

  // 取得
  Future<List<Ticket>> readTicket() async {
    logger.d('readTicket');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid == null) {
      return [];
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        return ticketRepository.readTicket(uid);
      },
    );
    return ticketRepository.readTicket(uid);
  }

  // 追加
  Future<void> addTicket(Ticket data) async {
    logger.d('addTicket');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final ticketId = await ticketRepository.createTicket(uid, data);
          return [...?state.value, data.copyWith(id: ticketId)];
        },
      );
    }
  }

  // 更新
  Future<void> updateTicket(Ticket data) async {
    logger.d('updateTicket');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          final id = await ticketRepository.updateTicket(uid, data);
          return [
            for (final ticket in state.value!)
              if (ticket.id == id) data else ticket
          ];
        },
      );
    }
  }

  //削除
  Future<void> deleteTicket(String ticketId) async {
    logger.d('deleteTicket');
    final uidAsyncValue = ref.watch(userIdProvider);
    final uid = uidAsyncValue.value;
    if (uid != null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(
        () async {
          await ticketRepository.deleteTicket(uid, ticketId);
          return [
            for (final ticket in state.value!)
              if (ticket.id != ticketId) ticket
          ];
        },
      );
    }
  }

  //
  Future<void> usageTicket(List<String> list) async {
    final ticketList = await readTicket();
    for (final id in list) {
      for (final element in ticketList) {
        if (element.id == id) {
          await updateTicket(element.copyWith(isActive: false));
        }
      }
    }
  }
}

@riverpod
class TicketCheckList extends _$TicketCheckList {
  @override
  Set<String> build() {
    return <String>{};
  }

  Set<String> readTicketCheckList() {
    state = <String>{};
    logger.d('readTicketFlag', state);
    return state;
  }

  void addTicketCheckList(String ticketId) {
    state.add(ticketId);
    logger.d('addTicketFlag', state);
  }

  void deleteTicketCheckList(String ticketId) {
    state.remove(ticketId);
    logger.d('deleteTicketFlag', state);
  }
}
