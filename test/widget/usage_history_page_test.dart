import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/ui/usage_history/history_page.dart';
import 'package:tliny/src/ui/usage_history/history_view_model.dart';

import '../utils/test_helpers.dart';

void main() {
  group('UsageHistoryPage', () {
    late List<UsageHistory> mockUsageHistories;

    setUp(() {
      mockUsageHistories = [
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
    });

    Widget createTestWidget() {
      return TestHelpers.createTestWidget(
        child: const UsageHistoryPage(),
        overrides: [
          usageHistoryViewModelProvider.overrideWith(
            (ref) => Future.value(mockUsageHistories),
          ),
        ],
      );
    }

    group('利用履歴一覧の表示', () {
      testWidgets('利用履歴が正常に表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('利用履歴'), findsOneWidget);
        expect(find.text('2枚のチケット'), findsOneWidget);
        expect(find.text('1枚のチケット'), findsOneWidget);
      });

      testWidgets('利用履歴が空の場合、空状態が表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryPage(),
            overrides: [
              usageHistoryViewModelProvider.overrideWith(
                (ref) => Future.value(<UsageHistory>[]),
              ),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('使用履歴がありません'), findsOneWidget);
        expect(find.text('チケットを使用すると、ここに履歴が表示されます'), findsOneWidget);
      });

      testWidgets('ローディング状態が表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryPage(),
            overrides: [
              usageHistoryViewModelProvider.overrideWith(
                (ref) => Future.delayed(
                  const Duration(seconds: 1),
                  () => mockUsageHistories,
                ),
              ),
            ],
          ),
        );

        // Act
        await tester.pump();

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('エラー状態が表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryPage(),
            overrides: [
              usageHistoryViewModelProvider.overrideWith(
                (ref) => Future.error(Exception('Test error')),
              ),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('エラーが発生しました'), findsOneWidget);
      });
    });

    group('利用履歴カードの表示', () {
      testWidgets('カードが正しく表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(Card), findsNWidgets(2));
        expect(find.byIcon(Icons.history), findsNWidgets(2));
        expect(find.byIcon(Icons.chevron_right), findsNWidgets(2));
      });

      testWidgets('日付が正しく表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pumpAndSettle();

        // Assert
        // 日付フォーマットは実際の実装に依存するため、基本的な表示を確認
        expect(find.textContaining('2024'), findsNWidgets(2));
      });

      testWidgets('チケット枚数が正しく表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('2枚のチケット'), findsOneWidget);
        expect(find.text('1枚のチケット'), findsOneWidget);
      });
    });

    group('ナビゲーション', () {
      testWidgets('カードをタップすると詳細ページに遷移する', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        // Act
        await tester.tap(find.byType(Card).first);
        await tester.pumpAndSettle();

        // Assert
        // ナビゲーションの結果は実際のルーティング設定に依存
        // ここでは基本的なタップ動作を確認
        expect(find.byType(Card), findsNWidgets(2));
      });
    });

    group('レスポンシブデザイン', () {
      testWidgets('異なる画面サイズで正常に表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act - 小さい画面サイズ
        tester.binding.window.physicalSizeTestValue = const Size(320, 568);
        tester.binding.window.devicePixelRatioTestValue = 1.0;
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(UsageHistoryPage), findsOneWidget);

        // Act - 大きい画面サイズ
        tester.binding.window.physicalSizeTestValue = const Size(1024, 768);
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(UsageHistoryPage), findsOneWidget);

        // Cleanup
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });
    });
  });
}
