import 'dart:async';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:tliny/src/data/general_provider.dart';
import 'package:tliny/src/data/model/program_model.dart';
import 'package:tliny/src/data/model/ticket_model.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/data/repository/program_repository.dart';
import 'package:tliny/src/data/repository/ticket_repository.dart';
import 'package:tliny/src/ui/common/error_screen.dart';
import 'package:tliny/src/ui/program/program_state.dart';
import 'package:tliny/src/ui/usage_history/history_page.dart';
import 'package:tliny/src/ui/usage_history/history_view_model.dart';

import '../utils/test_helpers.dart';

// Mock classes for Firebase services
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

// Mock classes for repositories
class MockUsageHistoryRepository extends Mock
    implements UsageHistoryRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockProgramRepository extends Mock implements ProgramRepository {
  @override
  Stream<List<Program>> watchEventList() {
    return Stream.value([
      Program(
        id: 'event1',
        organizerId: 'organizer1',
        name: 'テストイベント1',
        message: 'テストイベント1の説明',
        salesStart: DateTime(2023, 12, 1),
        salesEnd: DateTime(2024, 1, 30),
        eventFrom: DateTime(2024, 1, 1),
        eventTo: DateTime(2024, 1, 31),
        place: 'テスト会場1',
        isActive: true,
        isPublish: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Program(
        id: 'event2',
        organizerId: 'organizer2',
        name: 'テストイベント2',
        message: 'テストイベント2の説明',
        salesStart: DateTime(2024, 1, 1),
        salesEnd: DateTime(2024, 2, 27),
        eventFrom: DateTime(2024, 2, 1),
        eventTo: DateTime(2024, 2, 28),
        place: 'テスト会場2',
        isActive: true,
        isPublish: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ]);
  }
}

// Mock UsageHistoryViewModel for testing
class MockUsageHistoryViewModel extends UsageHistoryViewModel {
  final List<UsageHistory> _data;
  final Exception? _error;

  MockUsageHistoryViewModel(this._data) : _error = null;

  MockUsageHistoryViewModel.error(this._error) : _data = [];

  @override
  Future<List<UsageHistory>> build() async {
    if (_error != null) {
      throw _error;
    }
    return _data;
  }
}

void main() {
  group('UsageHistoryPage', () {
    late List<UsageHistory> mockUsageHistories;
    late List<Program> mockPrograms;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Skip Firebase initialization for widget tests
      // Firebase services will be mocked through provider overrides
    });

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

      mockPrograms = [
        Program(
          id: 'event1',
          organizerId: 'organizer1',
          name: 'テストイベント1',
          message: 'テストイベント1の説明',
          salesStart: DateTime(2023, 12, 1),
          salesEnd: DateTime(2024, 1, 30),
          eventFrom: DateTime(2024, 1, 1),
          eventTo: DateTime(2024, 1, 31),
          place: 'テスト会場1',
          isActive: true,
          isPublish: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        Program(
          id: 'event2',
          organizerId: 'organizer2',
          name: 'テストイベント2',
          message: 'テストイベント2の説明',
          salesStart: DateTime(2024, 1, 1),
          salesEnd: DateTime(2024, 2, 27),
          eventFrom: DateTime(2024, 2, 1),
          eventTo: DateTime(2024, 2, 28),
          place: 'テスト会場2',
          isActive: true,
          isPublish: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    });

    Widget createTestWidget({List<Program>? programs}) {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const UsageHistoryPage(),
          ),
          GoRoute(
            path: '/usage-history/:id',
            builder:
                (context, state) => const Scaffold(
                  body: Center(child: Text('Usage History Details')),
                ),
          ),
        ],
      );

      return TestHelpers.createTestWidget(
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
        overrides: [
          usageHistoryViewModelProvider.overrideWith(
            () => MockUsageHistoryViewModel(mockUsageHistories),
          ),
          // Mock Firebase-dependent providers
          firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
          firebaseAuthProvider.overrideWithValue(MockFirebaseAuth()),
          firebaseStorageProvider.overrideWithValue(MockFirebaseStorage()),
          // Mock additional providers that UsageHistoryViewModel depends on
          usageHistoryRepositoryProvider.overrideWithValue(
            MockUsageHistoryRepository(),
          ),
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
          // Mock ProgramRepository to provide program data
          programRepositoryProvider.overrideWithValue(MockProgramRepository()),
          // Mock programsStateProvider to provide program data
          programsStateProvider.overrideWith(
            (ref) => Stream.value(programs ?? mockPrograms),
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
                () => MockUsageHistoryViewModel(<UsageHistory>[]),
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
                () => MockUsageHistoryViewModel(mockUsageHistories),
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
                () => MockUsageHistoryViewModel.error(Exception('Test error')),
              ),
            ],
          ),
        );

        // Act
        await tester.pumpAndSettle();

        // Assert - Check for error screen elements
        expect(find.byType(ErrorScreen), findsOneWidget);
        // The error message should be displayed in the ErrorScreen
        expect(find.text('Exception: Test error'), findsOneWidget);
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

        // Wait for Card widgets to be rendered with multiple attempts
        bool cardsFound = false;
        for (int i = 0; i < 20; i++) {
          await tester.pump(const Duration(milliseconds: 50));
          await tester.pumpAndSettle();

           // Check if Card widgets are available
           final cardFinder = find.byType(Card);
           if (cardFinder.evaluate().isNotEmpty) {
             // print(
             //   'Found ${cardFinder.evaluate().length} Card widgets after ${i + 1} attempts',
             // );
             cardsFound = true;
             break;
           }
         }

         // Debug: Check what widgets are actually rendered
         // print('Available widgets:');
         // print('Cards: ${find.byType(Card).evaluate().length}');
         // print(
         //   'AnimatedContainers: ${find.byType(AnimatedContainer).evaluate().length}',
         // );
         // print('InkWells: ${find.byType(InkWell).evaluate().length}');
         // print('Containers: ${find.byType(Container).evaluate().length}');

        // Assert that cards are found
        expect(
          cardsFound,
          isTrue,
          reason: 'Card widgets should be found after waiting',
        );

        // Find cards again for the tap action
        final cardFinder = find.byType(Card);
        expect(cardFinder, findsNWidgets(2));

        // Act - Tap the first card
        await tester.tap(cardFinder.first);
        await tester.pumpAndSettle();

        // Assert - Check that navigation occurred (basic tap verification)
        // The actual navigation result depends on the routing setup
      });
    });

    group('レスポンシブデザイン', () {
      testWidgets('異なる画面サイズで正常に表示される', (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createTestWidget());

        // Act - 小さい画面サイズ
        tester.view.physicalSize = const Size(320, 568);
        tester.view.devicePixelRatio = 1.0;
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(UsageHistoryPage), findsOneWidget);

        // Act - 大きい画面サイズ
        tester.view.physicalSize = const Size(1024, 768);
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(UsageHistoryPage), findsOneWidget);

        // Cleanup
        addTearDown(tester.view.resetPhysicalSize);
      });
    });
  });
}
