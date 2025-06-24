import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/program_model.dart';
import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/ticket_repository.dart';
import '../../utils/logger.dart';

part 'ticket_list_view_model.g.dart';

@riverpod
AsyncValue<List<Ticket>> ticketsState(TicketsStateRef ref) {
  final uidAsyncValue = ref.watch(userIdProvider);
  return uidAsyncValue.when(
    data:
        (userId) =>
            userId != null
                ? ref.watch(ticketsStreamProvider(userId))
                : const AsyncValue.data([]),
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
}

@Riverpod(keepAlive: true)
class TicketListViewModel extends _$TicketListViewModel {
  // Setを使うことで、`contains`の処理が効率的になります。
  final Set<String> selectedTicketIds = {};
  String? selectedEventId;
  String? sharedUuid;

  // TicketRepositoryへのアクセスを簡略化
  TicketRepository get _repository => ref.watch(ticketRepositoryProvider);

  @override
  FutureOr<Set<String>> build() {
    selectedEventId = null;
    return selectedTicketIds;
  }

  Future<List<Ticket>> getTickets() async {
    final uid = getUserId();
    return uid != null ? _repository.readTicket(uid) : [];
  }

  bool isTicketSelected(Ticket ticket) => selectedTicketIds.contains(ticket.id);

  void toggleTicketSelection(Ticket ticket) {
    // if (ticket.isUsed) return; // 使用済みチケットは選択できない

    if (selectedEventId != null && selectedEventId != ticket.eventId) {
      // 既にイベントが選択されていて、異なるイベントのチケットが選択された場合
      return; // 何もしない
    }

    if (selectedTicketIds.contains(ticket.id)) {
      selectedTicketIds.remove(ticket.id);
      if (selectedTicketIds.isEmpty) {
        selectedEventId = null; // 全ての選択が解除されたらイベントIDもクリア
      }
    } else {
      if (ticket.isUsed) {
        // 使用済みチケットは選択できない
        return;
      }
      selectedTicketIds.add(ticket.id!);
      selectedEventId ??= ticket.eventId; // 最初の選択時にイベントIDを設定
    }

    state = AsyncValue.data({...selectedTicketIds});
  }

  bool isDifferentEvent(Ticket ticket) {
    // selectedEventIdがnullの場合はfalseを返す
    if (selectedEventId == null) return false;

    return selectedEventId != ticket.eventId;
  }

  Set<String> getSelectedTicketIds() => selectedTicketIds;

  void resetSelectedTickets() {
    selectedTicketIds.clear();
    selectedEventId = null;
    state = const AsyncValue.data({}); // 空のSetを返す
  }

  // Firestoreへの書き込みを一つの関数にまとめ、共通化
  Future<void> _updateTicketField(
    Ticket ticket,
    Map<String, dynamic> value,
  ) async {
    try {
      await _repository.updateTicketField(ticket.id!, value);
    } catch (e, st) {
      logger.e('Error updating ticket $value: $e', stackTrace: st);
    }
  }

  String getSharedUuid(List<Ticket> tickets) {
    if (sharedUuid == null ||
        tickets.any((ticket) => ticket.uuid != sharedUuid)) {
      sharedUuid = const Uuid().v4();
      for (final ticket in tickets) {
        if (isTicketSelected(ticket)) {
          _updateTicketField(ticket, {'uuid': sharedUuid});
        }
      }
    }
    return sharedUuid!;
  }

  Future<void> generatePdfUuidsForTickets(List<Ticket> tickets) async {
    for (final ticket in tickets) {
      if (isTicketSelected(ticket) && ticket.pdfUuid == null) {
        final uuid = const Uuid().v4();
        await _updateTicketField(ticket, {'pdfUuid': uuid});
      }
    }
  }

  Future<void> printingTickets(List<Ticket> tickets) async {
    for (final ticket in tickets) {
      if (isTicketSelected(ticket)) {
        await _updateTicketField(ticket, {'isPrinting': true});
      }
    }
  }

  Future<void> usedTickets(List<Ticket> tickets) async {
    for (final ticket in tickets) {
      if (isTicketSelected(ticket)) {
        await _updateTicketField(ticket, {'isUsed': true});
      }
    }
  }

  String? getUserId() {
    return ref.read(authRepositoryProvider).getCurrentUser()?.uid;
  }

  Program? getEvent(String eventId) {
    return ref.read(programStreamProvider(eventId)).valueOrNull;
  }
}

enum SortOrder { eventName, expirationFrom }
