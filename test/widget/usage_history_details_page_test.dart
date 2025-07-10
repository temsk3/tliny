import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/ui/usage_history/history_details.dart';
import 'package:tliny/src/ui/usage_history/history_state.dart';

import '../utils/test_helpers.dart';

void main() {
  group('UsageHistoryDetailsPage', () {
    late List<String> mockTicketIds;
    late Ticket mockTicket;

    setUp(() {
      mockTicketIds = ['ticket1', 'ticket2', 'ticket3'];
      mockTicket = const Ticket(
        id: 'ticket1',
        name: 'テストチケット',
        eventName: 'テストイベント',
        registerName: 'テスト受付者',
        price: 1000,
        isUsed: true,
      );
    });

    Widget createTestWidget() {
      return TestHelpers.createTestWidget(
        child: const UsageHistoryDetailsPage(
          list: ['ticket1', 'ticket2', 'ticket3'],
        ),
        overrides: [
          ticketStreamStateProvider(
            'ticket1',
          ).overrideWith((ref) => Stream.value(mockTicket)),
          ticketStreamStateProvider('ticket2').overrideWith(
            (ref) => Stream.value(mockTicket.copyWith(id: 'ticket2')),
          ),
          ticketStreamStateProvider('ticket3').overrideWith(
            (ref) => Stream.value(mockTicket.copyWith(id: 'ticket3')),
          ),
        ],
      );
    }

    group('ヘッダーセクションの表示', () {
      testWidgets('ヘッダーが正しく表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('利用履歴詳細'), findsOneWidget);
        expect(find.text('使用されたチケット'), findsOneWidget);
        expect(find.text('3枚のチケットが使用されました'), findsOneWidget);
        expect(find.byIcon(Icons.confirmation_number), findsOneWidget);
      });
    });

    group('チケットカードの表示', () {
      testWidgets('チケットカードが正しく表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(Card), findsNWidgets(3));
        expect(find.text('テストチケット'), findsNWidgets(3));
        expect(find.text('テストイベント'), findsNWidgets(3));
        expect(find.text('受付者: テスト受付者'), findsNWidgets(3));
        expect(find.text('価格: ¥1,000'), findsNWidgets(3));
        expect(find.text('使用済み'), findsNWidgets(3));
        expect(find.byIcon(Icons.check_circle), findsNWidgets(3));
      });

      testWidgets('チケット情報がnullの場合の表示', (WidgetTester tester) async {
        // Arrange
        final nullTicket = const Ticket(
          id: 'ticket1',
          name: null,
          eventName: null,
          registerName: null,
          price: null,
        );

        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryDetailsPage(list: ['ticket1']),
            overrides: [
              ticketStreamStateProvider(
                'ticket1',
              ).overrideWith((ref) => Stream.value(nullTicket)),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('不明なチケット'), findsOneWidget);
        expect(find.text('使用済み'), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsOneWidget);
      });
    });

    group('ローディング状態', () {
      testWidgets('ローディング状態が表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryDetailsPage(list: ['ticket1']),
            overrides: [
              ticketStreamStateProvider(
                'ticket1',
              ).overrideWith((ref) => const Stream.empty()),
            ],
          ),
        );

        // Act
        await tester.pump();

        // Assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('エラー状態', () {
      testWidgets('エラー状態が表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryDetailsPage(list: ['ticket1']),
            overrides: [
              ticketStreamStateProvider(
                'ticket1',
              ).overrideWith((ref) => Stream.error(Exception('Test error'))),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('チケットが見つかりません'), findsOneWidget);
        expect(find.text('ID: ticket1'), findsOneWidget);
        expect(find.text('エラー'), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
      });

      testWidgets('エラー詳細が表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          TestHelpers.createTestWidget(
            child: const UsageHistoryDetailsPage(list: ['ticket1']),
            overrides: [
              ticketStreamStateProvider(
                'ticket1',
              ).overrideWith((ref) => Stream.error(Exception('Test error'))),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('エラー詳細:'), findsOneWidget);
        expect(find.textContaining('Test error'), findsOneWidget);
      });
    });

    group('複数チケットの表示', () {
      testWidgets('複数のチケットが正しく表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(Card), findsNWidgets(3));
        expect(find.text('テストチケット'), findsNWidgets(3));
        expect(find.text('使用済み'), findsNWidgets(3));
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
        expect(find.byType(UsageHistoryDetailsPage), findsOneWidget);

        // Act - 大きい画面サイズ
        tester.binding.window.physicalSizeTestValue = const Size(1024, 768);
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(UsageHistoryDetailsPage), findsOneWidget);

        // Cleanup
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });
    });

    group('アニメーション', () {
      testWidgets('カードが順次表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act
        await tester.pump();

        // Assert
        expect(find.byType(AnimatedContainer), findsNWidgets(3));
      });
    });
  });
}
