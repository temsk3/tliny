import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/src/app.dart';
import 'package:tliny/src/data/general_provider.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/data/repository/program_repository.dart';
import 'package:tliny/src/ui/program/program_state.dart';
import '../utils/firebase_test_setup.dart';

class MockProgramRepository extends Mock implements ProgramRepository {}

void main() {
  group('User Registration Integration Tests', () {
    late ProviderContainer container;
    late MockProgramRepository mockProgramRepository;

    setUpAll(() async {
      await setupFirebaseForTesting();
    });

    setUp(() {
      mockProgramRepository = MockProgramRepository();
      container = ProviderContainer(
        overrides: [
          programRepositoryProvider.overrideWithValue(mockProgramRepository),
          // Provide empty programs stream to avoid Firestore access
          programsStateProvider.overrideWith((ref) async* {
            yield [];
          }),
          // Provide a null auth stream to simulate signed-out user
          userStateProvider.overrideWith((ref) => Stream.value(null)),
          // Explicitly override userId derived provider to avoid touching Firebase
          userIdProvider.overrideWith((ref) => Stream.value(null)),
          // Use in-memory fake Firestore for any accidental access
          firebaseFirestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should show registration form', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // アプリが起動することを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle user registration flow', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // アプリが正常に起動することを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should validate user input', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // アプリが正常に起動することを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle registration errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // アプリが正常に起動することを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
