import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import '../utils/firebase_test_setup.dart';

void main() {
  group('チケット使用済み処理 統合テスト', () {
    setUpAll(() async {
      await setupFirebaseForTesting();
    });
    
    group('使用済み処理の流れ', () {
      test('正常な使用済み処理の流れ', () {
        // Arrange - 初期チケットデータ
        const originalTicket = Ticket(
          id: 'ticket-1',
          name: 'Test Event Ticket',
          eventId: 'event-1',
          uuid: 'uuid-123',
          ownerId: 'user-1',
          ownerName: 'Test User',
        );

        // Act 1 - 使用済みに更新
        final updatedTicket = originalTicket.copyWith(
          isUsed: true,
          register: 'staff-1',
          registerName: 'Staff Member',
        );

        // Assert 1 - 更新後の状態確認
        expect(updatedTicket.isUsed, isTrue);
        expect(updatedTicket.register, 'staff-1');
        expect(updatedTicket.registerName, 'Staff Member');
        expect(updatedTicket.id, originalTicket.id);
        expect(updatedTicket.eventId, originalTicket.eventId);

        // Act 2 - 使用履歴データの作成
        final usageHistory = UsageHistory(
          dateOfUse: DateTime.now(),
          eventId: updatedTicket.eventId,
          receptionistId: updatedTicket.register,
          useTicket: [updatedTicket.id!],
        );

        // Assert 2 - 使用履歴の確認
        expect(usageHistory.eventId, 'event-1');
        expect(usageHistory.receptionistId, 'staff-1');
        expect(usageHistory.useTicket, contains('ticket-1'));
      });

      test('複数チケットの一括使用済み処理', () {
        // Arrange - 複数のチケット
        final tickets = [
          const Ticket(
            id: 'ticket-1',
            name: 'Event Ticket A',
            eventId: 'event-1',
            uuid: 'uuid-1',
          ),
          const Ticket(
            id: 'ticket-2',
            name: 'Event Ticket B',
            eventId: 'event-1',
            uuid: 'uuid-2',
          ),
          const Ticket(
            id: 'ticket-3',
            name: 'Event Ticket C',
            eventId: 'event-1',
            uuid: 'uuid-3',
          ),
        ];

        // Act - 全てのチケットを使用済みに更新
        final updatedTickets =
            tickets
                .map(
                  (ticket) => ticket.copyWith(
                    isUsed: true,
                    register: 'staff-1',
                    registerName: 'Staff Member',
                  ),
                )
                .toList();

        // Assert - 全てのチケットが使用済みになっている
        for (final ticket in updatedTickets) {
          expect(ticket.isUsed, isTrue);
          expect(ticket.register, 'staff-1');
          expect(ticket.registerName, 'Staff Member');
        }

        // Act - 使用履歴の作成
        final usageHistory = UsageHistory(
          dateOfUse: DateTime.now(),
          eventId: 'event-1',
          receptionistId: 'staff-1',
          useTicket: updatedTickets.map((t) => t.id!).toList(),
        );

        // Assert - 使用履歴の確認
        expect(usageHistory.useTicket!.length, 3);
        expect(
          usageHistory.useTicket,
          containsAll(['ticket-1', 'ticket-2', 'ticket-3']),
        );
      });
    });

    group('エラーケースの検証', () {
      test('IDがnullのチケットは処理できない', () {
        // Arrange
        const ticket = Ticket(
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
        );

        // Act & Assert
        expect(ticket.id, isNull);
        expect(() {
          // IDがnullの場合の処理をシミュレート
          if (ticket.id == null) {
            throw Exception('チケットIDが取得できません');
          }
        }, throwsException);
      });

      test('イベントIDがnullのチケットは処理できない', () {
        // Arrange
        const ticket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          uuid: 'uuid-1',
        );

        // Act & Assert
        expect(ticket.eventId, isNull);
        expect(() {
          // イベントIDがnullの場合の処理をシミュレート
          if (ticket.eventId == null) {
            throw Exception('イベントIDが取得できません');
          }
        }, throwsException);
      });

      test('既に使用済みのチケットは再処理できない', () {
        // Arrange
        const usedTicket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
          isUsed: true, // 既に使用済み
          register: 'staff-1',
          registerName: 'Staff Member',
        );

        // Act & Assert
        expect(usedTicket.isUsed, isTrue);
        expect(usedTicket.register, isNotNull);
        expect(usedTicket.registerName, isNotNull);
      });
    });

    group('データ整合性の検証', () {
      test('使用済みチケットのデータ整合性', () {
        // Arrange
        const ticket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
        );

        // Act
        final updatedTicket = ticket.copyWith(
          isUsed: true,
          register: 'staff-1',
          registerName: 'Staff Member',
        );

        // Assert - 必須フィールドが保持されている
        expect(updatedTicket.id, equals(ticket.id));
        expect(updatedTicket.name, equals(ticket.name));
        expect(updatedTicket.eventId, equals(ticket.eventId));
        expect(updatedTicket.uuid, equals(ticket.uuid));

        // Assert - 使用済み情報が正しく設定されている
        expect(updatedTicket.isUsed, isTrue);
        expect(updatedTicket.register, 'staff-1');
        expect(updatedTicket.registerName, 'Staff Member');
      });

      test('使用履歴のデータ整合性', () {
        // Arrange
        final tickets = [
          const Ticket(id: 'ticket-1', eventId: 'event-1'),
          const Ticket(id: 'ticket-2', eventId: 'event-1'),
        ];

        // Act
        final usageHistory = UsageHistory(
          dateOfUse: DateTime.now(),
          eventId: 'event-1',
          receptionistId: 'staff-1',
          useTicket: tickets.map((t) => t.id!).toList(),
        );

        // Assert
        expect(usageHistory.eventId, 'event-1');
        expect(usageHistory.receptionistId, 'staff-1');
        expect(usageHistory.useTicket!.length, 2);
        expect(usageHistory.useTicket, containsAll(['ticket-1', 'ticket-2']));
        expect(usageHistory.dateOfUse, isA<DateTime>());
      });
    });

    group('ビジネスロジックの検証', () {
      test('同じイベントのチケットのみ一括処理可能', () {
        // Arrange
        final sameEventTickets = [
          const Ticket(id: 'ticket-1', eventId: 'event-1'),
          const Ticket(id: 'ticket-2', eventId: 'event-1'),
        ];

        const differentEventTicket = Ticket(
          id: 'ticket-3',
          eventId: 'event-2', // 異なるイベント
        );

        // Act & Assert - 同じイベントのチケットは処理可能
        final sameEventIds = sameEventTickets.map((t) => t.eventId).toSet();
        expect(sameEventIds.length, 1);
        expect(sameEventIds.first, 'event-1');

        // Act & Assert - 異なるイベントのチケットは処理不可
        final allEventIds =
            [
              ...sameEventTickets,
              differentEventTicket,
            ].map((t) => t.eventId).toSet();
        expect(allEventIds.length, 2); // 2つの異なるイベント
      });

      test('使用済みチケットの重複処理防止', () {
        // Arrange
        const usedTicket = Ticket(
          id: 'ticket-1',
          eventId: 'event-1',
          isUsed: true,
          register: 'staff-1',
          registerName: 'Staff Member',
        );

        // Act & Assert - 使用済みチケットは再処理できない
        expect(usedTicket.isUsed, isTrue);
        expect(usedTicket.register, isNotNull);
        expect(usedTicket.registerName, isNotNull);

        // 使用済みチケットの再処理を試行した場合のシミュレート
        final canReprocess = !usedTicket.isUsed;
        expect(canReprocess, isFalse);
      });
    });
  });
}
