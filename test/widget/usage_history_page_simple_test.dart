import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/ui/usage_history/history_page.dart';

import '../utils/test_helpers.dart';

void main() {
  group('UsageHistoryPage Simple Tests', () {
    testWidgets('ページが正常に表示される', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestWidget(child: const UsageHistoryPage()),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(UsageHistoryPage), findsOneWidget);
    });

    testWidgets('AppBarが表示される', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestWidget(child: const UsageHistoryPage()),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('Scaffoldが表示される', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        TestHelpers.createTestWidget(child: const UsageHistoryPage()),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
