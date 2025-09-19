import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/data/repository/ticket_repository.dart';
import 'package:tliny/src/ui/usage_history/history_view_model.dart';

import 'usage_history_view_model_test.mocks.dart';

@GenerateMocks([UsageHistoryRepository, AuthRepository])
void main() {
  group('UsageHistoryViewModel', () {
    late ProviderContainer container;
    late MockUsageHistoryRepository mockUsageHistoryRepository;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockUsageHistoryRepository = MockUsageHistoryRepository();
      mockAuthRepository = MockAuthRepository();
      
      // 認証されたユーザーをモック
      when(mockAuthRepository.userId).thenAnswer((_) => Stream.value('user1'));
      
      container = ProviderContainer(
        overrides: [
          usageHistoryRepositoryProvider.overrideWithValue(
            mockUsageHistoryRepository,
          ),
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('利用履歴の取得', () {
      test('正常に利用履歴を取得できる', () async {
        // Arrange
        final mockUsageHistories = [
          UsageHistory(
            id: 'history1',
            dateOfUse: DateTime(2024, 1, 15, 10, 30),
            eventId: 'event1',
            receptionistId: 'user1',
            useTicket: ['ticket1', 'ticket2'],
          ),
          UsageHistory(
            id: 'history2',
            dateOfUse: DateTime(2024, 1, 14, 15, 45),
            eventId: 'event2',
            receptionistId: 'user1',
            useTicket: ['ticket3'],
          ),
        ];

        when(
          mockUsageHistoryRepository.readUsageHistory('user1'),
        ).thenAnswer((_) async => mockUsageHistories);

        // Act
        final result = await container.read(
          usageHistoryViewModelProvider.future,
        );

        // Assert
        expect(result, isA<List<UsageHistory>>());
        expect(result.length, 2);
        expect(result[0].id, 'history1');
        expect(result[1].id, 'history2');
        verify(mockUsageHistoryRepository.readUsageHistory('user1')).called(1);
      });

      test('利用履歴が空の場合、空のリストを返す', () async {
        // Arrange
        when(
          mockUsageHistoryRepository.readUsageHistory('user1'),
        ).thenAnswer((_) async => []);

        // Act
        final result = await container.read(
          usageHistoryViewModelProvider.future,
        );

        // Assert
        expect(result, isEmpty);
        verify(mockUsageHistoryRepository.readUsageHistory('user1')).called(1);
      });

      test('エラーが発生した場合、例外を投げる', () async {
        // Arrange
        when(
          mockUsageHistoryRepository.readUsageHistory('user1'),
        ).thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => container.read(usageHistoryViewModelProvider.future),
          throwsA(isA<Exception>()),
        );
        verify(mockUsageHistoryRepository.readUsageHistory('user1')).called(1);
      });
    });

    group('利用履歴の並び替え', () {
      test('利用履歴が日付順（新しい順）で並び替えられる', () async {
        // Arrange
        final mockUsageHistories = [
          UsageHistory(
            id: 'history1',
            dateOfUse: DateTime(2024, 1, 14, 10, 30), // 古い
            eventId: 'event1',
            receptionistId: 'user1',
            useTicket: ['ticket1'],
          ),
          UsageHistory(
            id: 'history2',
            dateOfUse: DateTime(2024, 1, 15, 15, 45), // 新しい
            eventId: 'event2',
            receptionistId: 'user1',
            useTicket: ['ticket2'],
          ),
        ];

        when(
          mockUsageHistoryRepository.readUsageHistory('user1'),
        ).thenAnswer((_) async => mockUsageHistories);

        // Act
        final result = await container.read(
          usageHistoryViewModelProvider.future,
        );

        // Assert
        expect(result.length, 2);
        expect(result[0].id, 'history2'); // 新しい順
        expect(result[1].id, 'history1');
      });
    });

    group('利用履歴のデータ検証', () {
      test('正常な利用履歴データ', () {
        // Arrange
        final usageHistory = UsageHistory(
          id: 'history1',
          dateOfUse: DateTime(2024, 1, 15, 10, 30),
          eventId: 'event1',
          receptionistId: 'user1',
          useTicket: ['ticket1', 'ticket2'],
        );

        // Act & Assert
        expect(usageHistory.id, 'history1');
        expect(usageHistory.eventId, 'event1');
        expect(usageHistory.receptionistId, 'user1');
        expect(usageHistory.useTicket, ['ticket1', 'ticket2']);
        expect(usageHistory.dateOfUse, DateTime(2024, 1, 15, 10, 30));
      });

      test('必須フィールドがnullの利用履歴データ', () {
        // Arrange
        final usageHistory = UsageHistory(
          dateOfUse: DateTime(2024, 1, 15, 10, 30),
          eventId: null,
          receptionistId: null,
          useTicket: null,
        );

        // Act & Assert
        expect(usageHistory.id, isNull);
        expect(usageHistory.eventId, isNull);
        expect(usageHistory.receptionistId, isNull);
        expect(usageHistory.useTicket, isNull);
        expect(usageHistory.dateOfUse, isNotNull);
      });
    });
  });
}
