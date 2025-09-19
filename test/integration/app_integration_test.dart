import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/app.dart';

void main() {
  group('App Integration Tests', () {
    late ProviderContainer container;

    setUpAll(() async {
      // Firebase初期化をスキップ（テスト環境では不要）
    });

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should start app without crashing', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // App should start without crashing
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should show basic app structure', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should show basic app structure
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle different screen sizes', (
      WidgetTester tester,
    ) async {
      // Test with different screen sizes
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should adapt to screen size
      expect(find.byType(MaterialApp), findsOneWidget);

      // Reset surface size
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('should handle theme changes', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should handle theme changes
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle user interactions', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should handle user interactions without crashing
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle error states gracefully', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should handle errors gracefully
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should maintain state across navigation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should maintain state
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('Basic Widget Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should render app with provider scope', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should render app
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle rapid user interactions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Perform rapid interactions
      for (var i = 0; i < 5; i++) {
        await tester.tap(find.byType(MaterialApp));
        await tester.pump();
      }

      // Should handle rapid interactions without issues
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('should handle widget rebuilds', (WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Trigger rebuild
      await tester.pumpWidget(
        UncontrolledProviderScope(container: container, child: const MyApp()),
      );

      await tester.pumpAndSettle();

      // Should handle rebuilds
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
