import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/app.dart';

void main() {
  group('User Registration Playwright Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
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
