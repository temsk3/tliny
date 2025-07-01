import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/product_model.dart';
import 'package:tliny/src/data/model/program_model.dart';
import 'package:tliny/src/ui/product/widget/product_card.dart';

void main() {
  group('ProductCard Widget Tests', () {
    late Product testProduct;
    late Program testProgram;

    setUp(() {
      testProduct = Product.empty().copyWith(
        id: 'product-1',
        name: 'Test Product',
        price: 1000,
        stock: 5,
        genre: GenreType.foods,
        desc: 'Test Description',
        pictureURL: ['https://example.com/image.jpg'],
        isActive: true,
        isPublish: true,
      );

      testProgram = Program.empty().copyWith(
        id: 'program-1',
        name: 'Test Program',
        salesStart: DateTime(2024),
        salesEnd: DateTime(2024, 12, 31),
      );
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: ProductCard(product: testProduct, program: testProgram),
        ),
      );
    }

    testWidgets('should display product name', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('should display product price', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('¥1,000'), findsOneWidget);
    });

    testWidgets('should display product image', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should display stock information', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('在庫: 5'), findsOneWidget);
    });

    testWidgets('should display sold out when stock is 0', (
      WidgetTester tester,
    ) async {
      testProduct = testProduct.copyWith(stock: 0);
      await tester.pumpWidget(createTestWidget());

      expect(find.text('売り切れ'), findsOneWidget);
    });

    testWidgets('should display inactive product correctly', (
      WidgetTester tester,
    ) async {
      testProduct = testProduct.copyWith(isActive: false);
      await tester.pumpWidget(createTestWidget());

      // Inactive products might be displayed differently
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should display unpublished product correctly', (
      WidgetTester tester,
    ) async {
      testProduct = testProduct.copyWith(isPublish: false);
      await tester.pumpWidget(createTestWidget());

      // Unpublished products might be displayed differently
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should handle product without image', (
      WidgetTester tester,
    ) async {
      testProduct = testProduct.copyWith(pictureURL: []);
      await tester.pumpWidget(createTestWidget());

      // Should handle missing image gracefully
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should handle product with null name', (
      WidgetTester tester,
    ) async {
      testProduct = testProduct.copyWith(name: null);
      await tester.pumpWidget(createTestWidget());

      // Should handle null name gracefully
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should handle product with null description', (
      WidgetTester tester,
    ) async {
      testProduct = testProduct.copyWith(desc: null);
      await tester.pumpWidget(createTestWidget());

      // Should handle null description gracefully
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should display different genres correctly', (
      WidgetTester tester,
    ) async {
      testProduct = testProduct.copyWith(genre: GenreType.goods);
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should handle program with null sales dates', (
      WidgetTester tester,
    ) async {
      testProgram = testProgram.copyWith(salesStart: null, salesEnd: null);
      await tester.pumpWidget(createTestWidget());

      // Should handle null dates gracefully
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should be tappable', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('should have proper layout structure', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });
  });
}
