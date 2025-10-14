import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:tliny/src/data/model/product_model.dart';
import 'package:tliny/src/data/model/program_model.dart';
import 'package:tliny/src/data/repository/product_repository.dart';
import 'package:tliny/src/ui/product/product_list.dart';
import 'package:tliny/src/ui/product/product_state.dart';
import 'package:tliny/src/ui/product/widget/product_card.dart';

import 'product_list_test.mocks.dart';

@GenerateMocks([ProductRepository, AppLocalizations])
void main() {
  group('ProductList Widget Tests', () {
    late MockProductRepository mockProductRepository;
    late MockAppLocalizations mockAppLocalizations;
    late Program testProgram;
    late List<Product> testProducts;

    setUp(() {
      mockProductRepository = MockProductRepository();
      mockAppLocalizations = MockAppLocalizations();
      
      // Mock AppLocalizations methods that are used in ProductCard
      when(mockAppLocalizations.product).thenReturn('Product');
      when(mockAppLocalizations.price).thenReturn('Price');
      when(mockAppLocalizations.stock).thenReturn('Stock');
      when(mockAppLocalizations.currency(any)).thenReturn('¥1000');

      testProgram = Program.empty().copyWith(
        id: 'program-1',
        name: 'Test Program',
      );

      testProducts = [
        Product.empty().copyWith(
          id: 'product-1',
          name: 'Product A',
          price: 1000,
          stock: 5,
          isActive: true,
          isPublish: true,
        ),
        Product.empty().copyWith(
          id: 'product-2',
          name: 'Product B',
          price: 2000,
          stock: 0,
          isActive: true,
          isPublish: true,
        ),
        Product.empty().copyWith(
          id: 'product-3',
          name: 'Product C',
          price: 1500,
          stock: 3,
          isActive: false,
          isPublish: true,
        ),
      ];
    });

    Widget createTestWidget() {
      return ProviderScope(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
          productsStateProvider(testProgram.id!, null).overrideWith((ref) {
            return Stream.value(testProducts);
          }),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ja', ''), Locale('en', '')],
          home: Localizations(
            locale: const Locale('ja', ''),
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            child: Scaffold(body: ProductListPage(program: testProgram)),
          ),
        ),
      );
    }

    Widget createTestWidgetWithGenre(GenreType genre) {
      return ProviderScope(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
          productsStateProvider(testProgram.id!, genre).overrideWith((ref) {
            return Stream.value(testProducts);
          }),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ja', ''), Locale('en', '')],
          home: Localizations(
            locale: const Locale('ja', ''),
            delegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            child: Scaffold(
              body: ProductListPage(program: testProgram, genre: genre),
            ),
          ),
        ),
      );
    }

    testWidgets('should display loading state initially', (
      WidgetTester tester,
    ) async {
      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(testProducts));

      await tester.pumpWidget(createTestWidget());

      // Should show loading indicator initially
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display products in grid layout', (
      WidgetTester tester,
    ) async {
      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(testProducts));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should display active products only
      expect(find.text('Product A'), findsOneWidget);
      expect(find.text('Product B'), findsOneWidget);
      expect(find.text('Product C'), findsNothing); // Inactive product

      // Should display prices
      expect(find.text('¥1,000'), findsOneWidget);
      expect(find.text('¥2,000'), findsOneWidget);
    });

    testWidgets('should filter products by genre', (WidgetTester tester) async {
      final foodProducts = [
        Product.empty().copyWith(
          id: 'food-1',
          name: 'Food Product',
          genre: GenreType.foods,
          isActive: true,
          isPublish: true,
        ),
      ];

      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(foodProducts));

      await tester.pumpWidget(createTestWidgetWithGenre(GenreType.foods));
      await tester.pumpAndSettle();

      expect(find.text('Food Product'), findsOneWidget);
    });

    testWidgets('should display empty state when no products', (
      WidgetTester tester,
    ) async {
      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value([]));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should handle empty state gracefully
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should handle error state', (WidgetTester tester) async {
      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.error(Exception('Database error')));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should handle error state gracefully
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('should sort products by name', (WidgetTester tester) async {
      final unsortedProducts = [
        Product.empty().copyWith(
          id: 'product-3',
          name: 'Zebra Product',
          isActive: true,
          isPublish: true,
        ),
        Product.empty().copyWith(
          id: 'product-1',
          name: 'Apple Product',
          isActive: true,
          isPublish: true,
        ),
        Product.empty().copyWith(
          id: 'product-2',
          name: 'Banana Product',
          isActive: true,
          isPublish: true,
        ),
      ];

      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(unsortedProducts));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Products should be sorted alphabetically
      final productCards = find.byType(ProductCard);
      expect(productCards, findsNWidgets(3));
    });

    testWidgets('should filter out inactive products', (
      WidgetTester tester,
    ) async {
      final mixedProducts = [
        Product.empty().copyWith(
          id: 'active-1',
          name: 'Active Product',
          isActive: true,
          isPublish: true,
        ),
        Product.empty().copyWith(
          id: 'inactive-1',
          name: 'Inactive Product',
          isActive: false,
          isPublish: true,
        ),
      ];

      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(mixedProducts));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should only show active products
      expect(find.text('Active Product'), findsOneWidget);
      expect(find.text('Inactive Product'), findsNothing);
    });

    testWidgets('should handle products with null values', (
      WidgetTester tester,
    ) async {
      final productsWithNulls = [
        Product.empty().copyWith(
          id: 'null-product',
          name: null,
          price: 1000,
          isActive: true,
          isPublish: true,
        ),
      ];

      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(productsWithNulls));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should handle null values gracefully
      expect(find.byType(ProductCard), findsOneWidget);
    });

    testWidgets('should have proper grid layout properties', (
      WidgetTester tester,
    ) async {
      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(testProducts));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final gridView = find.byType(GridView);
      expect(gridView, findsOneWidget);

      final gridViewWidget = tester.widget<GridView>(gridView);
      expect(gridViewWidget.padding, equals(const EdgeInsets.all(16)));
    });

    testWidgets('should handle program with null id', (
      WidgetTester tester,
    ) async {
      // Create a program with null id
      final nullIdProgram = Program.empty().copyWith(
        name: 'Test Program',
        id: null,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productRepositoryProvider.overrideWithValue(mockProductRepository),
          ],
          child: MaterialApp(
            home: Scaffold(body: ProductListPage(program: nullIdProgram)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should handle null program id gracefully
      expect(find.text('プログラムIDが設定されていません'), findsOneWidget);
    });

    testWidgets('should handle program with null id safely', (
      WidgetTester tester,
    ) async {
      // Create a program with null id
      final nullIdProgram = Program.empty().copyWith(
        name: 'Test Program',
        id: null, // Explicitly set to null
      );

      when(
        mockProductRepository.watchProducts(),
      ).thenAnswer((_) => Stream.value(testProducts));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productRepositoryProvider.overrideWithValue(mockProductRepository),
          ],
          child: MaterialApp(
            home: Scaffold(body: ProductListPage(program: nullIdProgram)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should handle null program id gracefully
      expect(find.text('プログラムIDが設定されていません'), findsOneWidget);
    });
  });
}
