import 'dart:async';

import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/model/ticket_model.dart';
import '../../data/repository/ticket_repository.dart';
import '../../utils/logger.dart';

part 'qrcode_scanner_view_model.g.dart';

/// QRコードスキャナーのViewModel
@riverpod
class QRCodeScannerViewModel extends _$QRCodeScannerViewModel {
  @override
  String? build() => null;

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
      final tickets = await ref.read(ticketRepositoryProvider).readAllTicket();
      // prefixに応じてUUIDを検索
      if (prefix == 'PDF') {
        return tickets.where((ticket) => ticket.pdfUuid == uuid).toList();
      } else if (prefix == 'REG') {
        return tickets.where((ticket) {
          logger.d('ticket.uuid: ${ticket.uuid}, uuid: $uuid');
          logger.d('ticket: $ticket');
          return ticket.uuid == uuid;
        }).toList();
      } else {
        // prefixが不正な場合は空のリストを返す
        return [];
      }
    } on AppException catch (e, st) {
      logger.e('Failed to find tickets by UUID: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('Failed to find tickets by UUID: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// スキャンされたチケット情報をデータベースに更新する
  Future<void> updateDatabaseTickets(List<Ticket> scannedTickets) async {
    try {
      logger.d('updateDatabaseTickets: 開始 - チケット数: ${scannedTickets.length}');

      final user = ref.read(authRepositoryProvider).getCurrentUser();
      if (user == null) {
        logger.e('updateDatabaseTickets: ユーザーが認証されていません');
        throw const AuthenticationException(message: 'ユーザーが認証されていません');
      }

      final uid = user.uid;
      final name = user.displayName;
      logger.d('updateDatabaseTickets: ユーザー情報 - uid: $uid, name: $name');

      final eventId = scannedTickets.first.eventId;
      if (eventId == null) {
        logger.e('updateDatabaseTickets: イベントIDが取得できません');
        throw const GeneralException(message: 'イベントIDが取得できません');
      }
      logger.d('updateDatabaseTickets: イベントID - $eventId');

      final usageTicket = <String>[];
      for (final ticket in scannedTickets) {
        logger.d(
          'updateDatabaseTickets: チケット処理開始 - id: ${ticket.id}, name: ${ticket.name}',
        );

        if (ticket.id == null) {
          logger.e('updateDatabaseTickets: チケットIDがnullです - ticket: $ticket');
          throw const GeneralException(message: 'チケットIDが取得できません');
        }

        final data = ticket.copyWith(
          isUsed: true,
          register: uid,
          registerName: name,
        );
        usageTicket.add(ticket.id!);

        // チケットの使用済みフラグをtrueに更新
        logger.d(
          'updateDatabaseTickets: チケット更新開始 - id: ${ticket.id}, uuid: ${data.uuid}',
        );
        final updatedTicket = await ref
            .read(ticketRepositoryProvider)
            .updateTicket(data);
        logger.d('updateDatabaseTickets: チケット更新完了 - $updatedTicket');
      }

      // チケットの使用履歴を更新
      logger.d(
        'updateDatabaseTickets: 使用履歴作成開始 - uid: $uid, eventId: $eventId, usageTicket: $usageTicket',
      );
      await addUsageHistory(uid, eventId, usageTicket);
      logger.d('updateDatabaseTickets: 使用履歴作成完了');

      logger.d('updateDatabaseTickets: 全ての処理が完了しました');
    } on AppException catch (e, st) {
      logger.e(
        'updateDatabaseTickets: AppException - ${e.message}',
        stackTrace: st,
      );
      rethrow;
    } catch (e, st) {
      logger.e('updateDatabaseTickets: Exception - $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
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

    final id = await ref
        .read(usageHistoryRepositoryProvider)
        .createUsageHistory(uid, data);
    logger.d('Usage history created with ID: $id');
  }
}
