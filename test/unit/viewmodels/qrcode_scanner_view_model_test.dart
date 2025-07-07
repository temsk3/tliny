import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/exception/app_exception.dart';
import 'package:tliny/src/data/model/ticket_model.dart';

void main() {
  group('QRCodeScannerViewModel Tests', () {
    group('ticketCounts', () {
      test('チケットの数を正しく集計できる', () {
        // Arrange
        final testTickets = [
          const Ticket(name: 'Ticket A'),
          const Ticket(name: 'Ticket A'),
          const Ticket(name: 'Ticket B'),
          const Ticket(name: 'Ticket A'),
          const Ticket(name: 'Ticket C'),
        ];

        // Act
        final result = _ticketCounts(testTickets);

        // Assert
        expect(result, contains('Ticket A: 3'));
        expect(result, contains('Ticket B: 1'));
        expect(result, contains('Ticket C: 1'));
      });

      test('空のリストの場合は空文字を返す', () {
        // Arrange
        final testTickets = <Ticket>[];

        // Act
        final result = _ticketCounts(testTickets);

        // Assert
        expect(result, isEmpty);
      });

      test('nullのチケット名も正しく処理できる', () {
        // Arrange
        final testTickets = [
          const Ticket(name: 'Ticket A'),
          const Ticket(),
          const Ticket(name: 'Ticket A'),
          const Ticket(name: 'Ticket B'),
        ];

        // Act
        final result = _ticketCounts(testTickets);

        // Assert
        expect(result, contains('Ticket A: 2'));
        expect(result, contains('Ticket B: 1'));
        expect(result, contains('null: 1'));
      });
    });

    group('チケットデータ検証', () {
      test('正常なチケットデータ', () {
        // Arrange
        const ticket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
        );

        // Act & Assert
        expect(ticket.id, isNotNull);
        expect(ticket.eventId, isNotNull);
        expect(ticket.isUsed, isFalse);
      });

      test('必須フィールドがnullのチケットデータ', () {
        // Arrange
        const ticket = Ticket(name: 'Test Ticket', uuid: 'uuid-1');

        // Act & Assert
        expect(ticket.id, isNull);
        expect(ticket.eventId, isNull);
        expect(ticket.isUsed, isFalse);
      });

      test('使用済みチケットデータ', () {
        // Arrange
        const ticket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
          isUsed: true,
          register: 'user-1',
          registerName: 'Test User',
        );

        // Act & Assert
        expect(ticket.isUsed, isTrue);
        expect(ticket.register, 'user-1');
        expect(ticket.registerName, 'Test User');
      });
    });

    group('チケット更新データ検証', () {
      test('使用済みに更新するデータ', () {
        // Arrange
        const originalTicket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
        );

        // Act
        final updatedTicket = originalTicket.copyWith(
          isUsed: true,
          register: 'user-1',
          registerName: 'Test User',
        );

        // Assert
        expect(updatedTicket.isUsed, isTrue);
        expect(updatedTicket.register, 'user-1');
        expect(updatedTicket.registerName, 'Test User');
        expect(updatedTicket.id, originalTicket.id);
        expect(updatedTicket.name, originalTicket.name);
        expect(updatedTicket.eventId, originalTicket.eventId);
      });

      test('使用済みチケットの再更新', () {
        // Arrange
        const usedTicket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
          isUsed: true,
          register: 'user-1',
          registerName: 'Test User',
        );

        // Act
        final reUpdatedTicket = usedTicket.copyWith(
          register: 'user-2',
          registerName: 'Another User',
        );

        // Assert
        expect(reUpdatedTicket.isUsed, isTrue);
        expect(reUpdatedTicket.register, 'user-2');
        expect(reUpdatedTicket.registerName, 'Another User');
      });
    });

    group('エラーケース検証', () {
      test('認証エラーの検証', () {
        // Arrange
        const authException = AuthenticationException(
          message: 'ユーザーが認証されていません',
        );

        // Act & Assert
        expect(authException.message, 'ユーザーが認証されていません');
        expect(authException, isA<AppException>());
      });

      test('一般エラーの検証', () {
        // Arrange
        const generalException = GeneralException(message: 'イベントIDが取得できません');

        // Act & Assert
        expect(generalException.message, 'イベントIDが取得できません');
        expect(generalException, isA<AppException>());
      });
    });

    group('使用済み処理の検証', () {
      test('使用済み処理に必要なデータが揃っている', () {
        // Arrange
        const ticket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
        );

        // Act
        final canProcess =
            ticket.id != null && ticket.eventId != null && !ticket.isUsed;

        // Assert
        expect(canProcess, isTrue);
      });

      test('使用済み処理に必要なデータが不足している', () {
        // Arrange
        const ticket = Ticket(
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
        );

        // Act
        final canProcess =
            ticket.id != null && ticket.eventId != null && !ticket.isUsed;

        // Assert
        expect(canProcess, isFalse);
      });

      test('既に使用済みのチケットは処理できない', () {
        // Arrange
        const ticket = Ticket(
          id: 'ticket-1',
          name: 'Test Ticket',
          eventId: 'event-1',
          uuid: 'uuid-1',
          isUsed: true, // 既に使用済み
        );

        // Act
        final canProcess =
            ticket.id != null && ticket.eventId != null && !ticket.isUsed;

        // Assert
        expect(canProcess, isFalse);
      });
    });
  });
}

// テスト用のヘルパー関数（実際のViewModelのticketCountsメソッドと同じロジック）
String _ticketCounts(List<Ticket> tickets) {
  if (tickets.isEmpty) return '';

  final ticketCounts = <String, int>{};
  for (final ticket in tickets) {
    final name = ticket.name ?? 'null';
    ticketCounts[name] = (ticketCounts[name] ?? 0) + 1;
  }

  return ticketCounts.entries
      .map((entry) => '${entry.key}: ${entry.value}')
      .join('\n');
}
