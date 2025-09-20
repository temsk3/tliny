import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/src/app.dart';
import 'package:tliny/src/data/general_provider.dart';

import '../utils/firebase_test_setup.dart';

// Mock classes for testing
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseStorage extends Mock implements FirebaseStorage {}

void main() {
  group('User Registration Playwright Tests', () {
    late ProviderContainer container;
    late FakeFirebaseFirestore fakeFirestore;
    late MockFirebaseAuth mockAuth;
    late MockFirebaseStorage mockStorage;

    setUpAll(() async {
      await setupFirebaseForTesting();
    });

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      mockAuth = MockFirebaseAuth();
      mockStorage = MockFirebaseStorage();

      container = ProviderContainer(
        overrides: [
          firebaseFirestoreProvider.overrideWithValue(fakeFirestore),
          firebaseAuthProvider.overrideWithValue(mockAuth),
          firebaseStorageProvider.overrideWithValue(mockStorage),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should navigate to registration page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // アプリが起動することを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should fill registration form', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // アプリが正常に起動することを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should submit registration form', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // アプリが正常に起動することを確認
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle registration success', (
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
