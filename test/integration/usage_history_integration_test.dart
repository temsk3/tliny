import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/ui/usage_history/history_details.dart';
import 'package:tliny/src/ui/usage_history/history_page.dart';
import 'package:tliny/src/ui/usage_history/history_view_model.dart';

import '../utils/test_helpers.dart';
import '../utils/firebase_test_setup.dart';

void main() {
  group('UsageHistory Integration Tests', () {
    late UsageHistory mockUsageHistory1;
    late UsageHistory mockUsageHistory2;
    late List<UsageHistory> mockUsageHistories;

    setUpAll(() async {
      await setupFirebaseForTesting();
    });

    setUp(() {
      mockUsageHistory1 = UsageHistory(
        id: 'history1',
        dateOfUse: DateTime.now(),
        eventId: 'event1',
        receptionistId: 'user1',
        useTicket: ['ticket1', 'ticket2', 'ticket3'],
      );

      mockUsageHistory2 = UsageHistory(
        id: 'history2',
        dateOfUse: DateTime.now().subtract(const Duration(days: 1)),
        eventId: 'event2',
        receptionistId: 'user1',
        useTicket: ['ticket4'],
      );

      mockUsageHistories = [mockUsageHistory1, mockUsageHistory2];
    });

    group('利用履歴一覧の基本表示', () {
      testWidgets('利用履歴一覧が正しく表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryPage(),
            overrides: [
              usageHistoryViewModelProvider.overrideWith(
                () => MockUsageHistoryViewModel(mockUsageHistories),
              ),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();
        // extra settle for CI flakiness
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text('チケット使用履歴'), findsOneWidget);
        expect(find.byType(Card), findsNWidgets(2));
        expect(find.text('3枚のチケット'), findsOneWidget);
        expect(find.text('1枚のチケット'), findsOneWidget);
      });
    });

    group('空状態の処理', () {
      testWidgets('利用履歴が空の場合の表示', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryPage(),
            overrides: [
              usageHistoryViewModelProvider.overrideWith(
                () => MockUsageHistoryViewModel([]),
              ),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text('使用履歴がありません'), findsOneWidget);
        expect(find.text('チケットを使用すると、ここに履歴が表示されます'), findsOneWidget);
        expect(find.byIcon(Icons.history_outlined), findsOneWidget);
      });
    });

    group('ローディング状態', () {
      testWidgets('ローディング状態の表示', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryPage(),
            overrides: [
              usageHistoryViewModelProvider.overrideWith(
                () => MockUsageHistoryViewModel(
                  mockUsageHistories,
                  delay: const Duration(milliseconds: 100),
                ),
              ),
            ],
          ),
        );

        // Act
        await tester.pump();
        // Assert: loading indicator should appear before data resolves
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        // Then settle timers to clean up
        await tester.pumpAndSettle();
      });
    });

    group('利用履歴詳細ページ', () {
      testWidgets('詳細ページが正しく表示される', (WidgetTester tester) async {
        // Arrange
        const ticketIds = ['ticket1', 'ticket2', 'ticket3'];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryDetailsPage(list: ticketIds),
          ),
        );
        await tester.pumpAndSettle();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 100));

        // Assert
        expect(find.text('利用履歴詳細'), findsOneWidget);
        expect(find.text('使用されたチケット'), findsOneWidget);
        expect(find.text('3枚のチケットが使用されました'), findsOneWidget);
      });

      testWidgets('空のチケットリストの場合', (WidgetTester tester) async {
        // Arrange
        const ticketIds = <String>[];

        // Act
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryDetailsPage(list: ticketIds),
          ),
        );
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('利用履歴詳細'), findsOneWidget);
        expect(find.text('使用されたチケット'), findsOneWidget);
        expect(find.text('0枚のチケットが使用されました'), findsOneWidget);
      });
    });
  });
}

// モックViewModelクラス
class MockUsageHistoryViewModel extends UsageHistoryViewModel {
  MockUsageHistoryViewModel(this._usageHistories, {this.delay});
  final List<UsageHistory> _usageHistories;
  final Duration? delay;

  @override
  Future<List<UsageHistory>> build() async {
    if (delay != null) {
      await Future.delayed(delay!);
    }
    return _usageHistories;
  }
}
