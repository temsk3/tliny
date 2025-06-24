import 'dart:async';

import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';

import '../../data/model/ticket_model.dart';
import '../../data/repository/ticket_repository.dart';
import '../../utils/logger.dart';

// QRCodeScannerViewModelのProvider
final qrCodeScannerViewModelProvider =
    StateNotifierProvider<QRCodeScannerViewModel, String?>((ref) {
      return QRCodeScannerViewModel(
        ref.watch(ticketRepositoryProvider),
        ref.read(authRepositoryProvider),
        ref.watch(usageHistoryRepositoryProvider),
      );
    });

class QRCodeScannerViewModel extends StateNotifier<String?> {
  QRCodeScannerViewModel(
    this.ticketRepository,
    this.authRepository,
    this.usageHistoryRepository,
  ) : super(null);

  // チケットリポジトリ
  final TicketRepository ticketRepository;
  final AuthRepository authRepository;
  final UsageHistoryRepository usageHistoryRepository;

  /// ユーザーIDを初期設定する
  void setInitialUserId(String userId) {
    state = userId;
  }

  /// ユーザーIDをリセットする
  void resetUserId() {
    state = null;
  }

  /// ユーザーが有効かどうかを確認する
  /// 最初にスキャンしたユーザーと、以降のスキャンユーザーが一致するかどうかを確認する
  bool isValidUser(String currentUserId) {
    logger.d('isValidUser');
    if (state == null) {
      // stateがnullの場合は最初のスキャンなので、ユーザーIDを設定
      setInitialUserId(currentUserId);
      return true;
    }
    // stateがnullでない場合は、現在のユーザーIDとstateのユーザーIDが一致するかどうかを確認
    return state == currentUserId;
  }

  /// UUIDからチケット情報を取得する
  Future<List<Ticket>> findTicketsByUuid(String prefix, String uuid) async {
    try {
      final tickets = await ticketRepository.readAllTicket();
      // prefixに応じてUUIDを検索
      if (prefix == 'PDF') {
        return tickets.where((ticket) => ticket.pdfUuid == uuid).toList();
      } else if (prefix == 'REG') {
        return tickets.where((ticket) {
          print('ticket.uuid: ${ticket.uuid}, uuid: $uuid');
          print('ticket: $ticket');
          return ticket.uuid == uuid;
        }).toList();
      } else {
        // prefixが不正な場合は空のリストを返す
        return [];
      }
    } on Exception catch (e) {
      logger.e('Failed to find tickets by UUID: $e');
      return [];
    }
  }

  /// スキャンされたチケット情報をデータベースに更新する
  Future<void> updateDatabaseTickets(List<Ticket> scannedTickets) async {
    try {
      final user = authRepository.getCurrentUser();
      final uid = user?.uid;
      final name = user?.displayName;
      final eventId = scannedTickets.first.eventId;
      final usageTicket = <String>[];
      for (final ticket in scannedTickets) {
        final data = ticket.copyWith(
          isUsed: true,
          register: uid,
          registerName: name,
          deletedAt: DateTime.now(),
        );
        usageTicket.add(ticket.id!);
        // チケットの使用済みフラグをtrueに更新
        print('data.uuid: ${data.uuid}');
        final updatedTicket = await ticketRepository.updateTicket(data);
        logger.d('Updated ticket: $updatedTicket');
      }
      // チケットの使用履歴を更新
      await addUsageHistory(uid!, eventId!, usageTicket);
      logger.d('All tickets updated successfully.');
    } catch (e) {
      logger.e('Failed to update tickets: $e');
      rethrow; // エラーを再スロー
    }
  }

  String ticketCounts(List<Ticket> scannedTickets) {
    final tickets = scannedTickets.toList();

    // Count the occurrences of each ticket name
    final ticketCounts = groupBy(tickets, (Ticket ticket) => ticket.name);
    final ticketCountString = ticketCounts.entries
        .map((entry) {
          return '${entry.key}: ${entry.value.length}';
        })
        .join('\n');
    return ticketCountString;
  }

  Future<void> addUsageHistory(
    String uid,
    String eventId,
    List<String> useTicket,
  ) async {
    logger.d('addUsageHistory');
    final data = UsageHistory(
      dateOfUse: DateTime.now(),
      eventId: eventId,
      receptionistId: uid,
      useTicket: useTicket,
    );

    final id = await usageHistoryRepository.createUsageHistory(uid, data);
  }
}
