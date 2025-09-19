import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/program_model.dart';
import '../../data/model/ticket_model.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/ticket_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'ticket_list_view_model.g.dart';

@riverpod
AsyncValue<List<Ticket>> ticketsState(Ref ref) {
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
  bool showExpiredTickets = false; // 期限切れチケットの表示・非表示フラグ（デフォルト：非表示）

  // TicketRepositoryへのアクセスを簡略化
  TicketRepository get _repository => ref.watch(ticketRepositoryProvider);

  @override
  FutureOr<Set<String>> build() {
    selectedEventId = null;
    return selectedTicketIds;
  }

  // 期限切れチケットの表示・非表示を切り替える
  void toggleExpiredTicketsVisibility() {
    showExpiredTickets = !showExpiredTickets;
    debugPrint('toggleExpiredTicketsVisibility: $showExpiredTickets');
    // 状態を更新してUIの再構築を促す
    state = AsyncValue.data({...selectedTicketIds});
  }

  // 期限切れチケットの選択を解除する
  void removeExpiredTicketsFromSelection(List<Ticket> allTickets) {
    if (showExpiredTickets) return; // 期限切れチケットを表示している場合は何もしない

    final ticketsToRemove = <String>[];

    for (final ticketId in selectedTicketIds) {
      final ticket = allTickets.firstWhere(
        (t) => t.id == ticketId,
        orElse: Ticket.empty,
      );

      if (ticket.id != null && isTicketExpired(ticket)) {
        ticketsToRemove.add(ticketId);
      }
    }

    for (final ticketId in ticketsToRemove) {
      selectedTicketIds.remove(ticketId);
    }

    if (ticketsToRemove.isNotEmpty) {
      state = AsyncValue.data({...selectedTicketIds});
    }
  }

  // 期限切れチケットの表示状態を取得
  bool get isExpiredTicketsVisible => showExpiredTickets;

  // 期限切れ判定を共通化
  bool isTicketExpired(Ticket ticket) {
    final now = DateTime.now();

    // チケットの有効期限が設定されている場合
    if (ticket.expirationTo != null) {
      final isExpired = ticket.expirationTo!.isBefore(now);
      debugPrint(
        'isTicketExpired (ticket.expirationTo): ${ticket.id} -> $isExpired (${ticket.expirationTo} vs $now)',
      );
      return isExpired;
    }

    // イベントの開催期間で判定する場合
    if (ticket.eventId != null) {
      try {
        final event =
            ref.read(programStreamProvider(ticket.eventId!)).valueOrNull;
        if (event != null && event.eventTo != null) {
          final isExpired = event.eventTo!.isBefore(now);
          debugPrint(
            'isTicketExpired (event.eventTo): ${ticket.id} -> $isExpired (${event.eventTo} vs $now)',
          );
          return isExpired;
        } else {
          debugPrint(
            'isTicketExpired (no event data): ${ticket.id} -> false (event: $event)',
          );
        }
      } catch (e) {
        debugPrint(
          'isTicketExpired (error): ${ticket.id} -> false (error: $e)',
        );
        // エラーが発生した場合は期限切れでないとみなす
        return false;
      }
    }

    debugPrint('isTicketExpired (default): ${ticket.id} -> false');
    return false; // デフォルトでは期限切れでない
  }

  // 期限切れチケットをフィルタリングする
  List<Ticket> filterExpiredTickets(List<Ticket> tickets) {
    if (showExpiredTickets) {
      return tickets; // 全て表示
    }

    final filteredTickets =
        tickets.where((ticket) => !isTicketExpired(ticket)).toList();
    debugPrint(
      'filterExpiredTickets: ${tickets.length} -> ${filteredTickets.length}',
    );
    return filteredTickets;
  }

  // 使用可能なチケットが無いイベントをフィルタリングする
  Map<String, List<Ticket>> filterEventsWithNoValidTickets(
    Map<String, List<Ticket>> groupedTickets,
  ) {
    if (showExpiredTickets) {
      // 期限切れ表示時は、全てのイベントを表示（使用済みでも有効期限がない場合は表示）
      return groupedTickets;
    }

    final filteredMap = <String, List<Ticket>>{};

    for (final entry in groupedTickets.entries) {
      final eventId = entry.key;
      final tickets = entry.value;

      // このイベントに使用可能なチケットがあるかチェック
      final hasValidTickets = tickets.any((ticket) {
        // 未使用で有効期限内のチケットがあるかチェック
        if (!ticket.isUsed && !isTicketExpired(ticket)) return true;

        return false;
      });

      // 使用可能なチケットがある場合のみイベントを表示
      if (hasValidTickets) {
        filteredMap[eventId] = tickets;
      }
    }

    debugPrint(
      'filterEventsWithNoValidTickets (expired hidden): ${groupedTickets.length} -> ${filteredMap.length}',
    );
    return filteredMap;
  }

  Future<List<Ticket>> getTickets() async {
    final uid = getUserId();
    if (uid == null) return [];

    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      return await loading.guardFuture(() async {
        return _repository.readTicket(uid);
      });
    } on AppException catch (e, st) {
      logger.e('getTickets: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('getTickets: Exception - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
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
      // 未使用で有効期限内のもののみ選択可能
      if (ticket.isUsed) {
        // 使用済みチケットは選択できない
        return;
      }
      if (isTicketExpired(ticket)) {
        // 期限切れチケットは選択できない
        return;
      }
      selectedTicketIds.add(ticket.id!);
      selectedEventId ??= ticket.eventId; // 最初の選択時にイベントIDを設定
    }

    // 状態を強制的に更新（新しいSetオブジェクトを作成）
    final newSelectedIds = Set<String>.from(selectedTicketIds);
    state = AsyncValue.data(newSelectedIds);
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
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFuture(() async {
        await _repository.updateTicketField(ticket.id!, value);
      });
    } on AppException catch (e, st) {
      logger.e(
        '_updateTicketField: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('Error updating ticket $value: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
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
    try {
      for (final ticket in tickets) {
        if (isTicketSelected(ticket) && ticket.pdfUuid == null) {
          final uuid = const Uuid().v4();
          await _updateTicketField(ticket, {'pdfUuid': uuid});
        }
      }
    } on AppException catch (e, st) {
      logger.e(
        'generatePdfUuidsForTickets: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } on Exception catch (e, st) {
      logger.e('generatePdfUuidsForTickets: Exception - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  Future<void> printingTickets(List<Ticket> tickets) async {
    try {
      for (final ticket in tickets) {
        if (isTicketSelected(ticket)) {
          await _updateTicketField(ticket, {'isPrinting': true});
        }
      }
    } on AppException catch (e, st) {
      logger.e('printingTickets: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('printingTickets: Exception - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  Future<void> usedTickets(List<Ticket> tickets) async {
    try {
      for (final ticket in tickets) {
        if (isTicketSelected(ticket)) {
          await _updateTicketField(ticket, {'isUsed': true});
        }
      }
    } on AppException catch (e, st) {
      logger.e('usedTickets: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } on Exception catch (e, st) {
      logger.e('usedTickets: Exception - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  String? getUserId() {
    return ref.read(authRepositoryProvider).getCurrentUser()?.uid;
  }

  Program? getEvent(String eventId) {
    try {
      return ref.read(programStreamProvider(eventId)).valueOrNull;
    } catch (e) {
      return null;
    }
  }
}

enum SortOrder { eventName, expirationFrom }
