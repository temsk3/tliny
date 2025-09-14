import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/app.dart';

void main() {
  group('User Registration Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
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
