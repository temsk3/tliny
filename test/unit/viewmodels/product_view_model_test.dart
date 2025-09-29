import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/src/data/model/exception/app_exception.dart';
import 'package:tliny/src/data/model/product_model.dart';
import 'package:tliny/src/data/model/program_model.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/data/repository/product_repository.dart';
import 'package:tliny/src/data/repository/staff_repository.dart';
import 'package:tliny/src/ui/product/product_view_model.dart';
import 'package:tliny/test/utils/firebase_test_setup.dart';

import 'product_view_model_test.mocks.dart';

@GenerateMocks([
  ProductRepository,
  AuthRepository,
  StaffRepository,
  firebase_auth.User,
])
void main() {
  group('ProductViewModel Tests', () {
    late MockProductRepository mockProductRepository;
    late MockAuthRepository mockAuthRepository;
    late MockStaffRepository mockStaffRepository;
    late ProviderContainer container;
    late MockUser mockUser;

    setUpAll(() async {
      await setupFirebaseForTesting();
    });

    setUp(() {
      mockProductRepository = MockProductRepository();
      mockAuthRepository = MockAuthRepository();
      mockStaffRepository = MockStaffRepository();
      mockUser = MockUser();

      // Mock the userId method on the auth repository
      when(
        mockAuthRepository.userId,
      ).thenAnswer((_) => Stream.value('test-user-id'));

      container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          staffRepositoryProvider.overrideWithValue(mockStaffRepository),
          userIdProvider.overrideWith((ref) async* {
            yield 'test-user-id';
          }),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('build should load products successfully', () async {
      final testProducts = [
        Product.empty().copyWith(
          id: 'product-1',
          name: 'Test Product 1',
          price: 1000,
        ),
        Product.empty().copyWith(
          id: 'product-2',
          name: 'Test Product 2',
          price: 2000,
        ),
      ];

      when(
        mockProductRepository.readProducts(),
      ).thenAnswer((_) async => testProducts);

      final viewModel = container.read(productViewModelProvider.notifier);
      final result = await viewModel.build();

      expect(result, equals(testProducts));
      verify(
        mockProductRepository.readProducts(),
      ).called(greaterThanOrEqualTo(1));
    });

    test('readProduct should load products successfully', () async {
      final testProducts = [
        Product.empty().copyWith(
          id: 'product-1',
          name: 'Test Product 1',
          price: 1000,
        ),
        Product.empty().copyWith(
          id: 'product-2',
          name: 'Test Product 2',
          price: 2000,
        ),
      ];

      when(
        mockProductRepository.readProducts(),
      ).thenAnswer((_) async => testProducts);

      final viewModel = container.read(productViewModelProvider.notifier);
      final result = await viewModel.readProduct();

      expect(result, equals(testProducts));
      verify(
        mockProductRepository.readProducts(),
      ).called(greaterThanOrEqualTo(1));
    });

    test('readProduct should handle errors', () async {
      when(
        mockProductRepository.readProducts(),
      ).thenThrow(Exception('Database error'));

      final viewModel = container.read(productViewModelProvider.notifier);

      await expectLater(viewModel.readProduct, throwsA(isA<Exception>()));
      verify(
        mockProductRepository.readProducts(),
      ).called(greaterThanOrEqualTo(1));
    });

    test('addProduct should create product successfully', () async {
      final testProgram = Program.empty().copyWith(
        id: 'program-1',
        name: 'Test Program',
        organizerId: 'organizer-1',
      );

      final testProduct = Product.empty().copyWith(
        name: 'New Product',
        price: 1500,
      );

      // 認証されたユーザーをモック
      when(mockAuthRepository.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test-user-id');
      when(
        mockAuthRepository.userId,
      ).thenAnswer((_) => Stream.value('test-user-id'));
      when(
        mockStaffRepository.checkExistenceStaff(any, any),
      ).thenAnswer((_) async => true);
      when(
        mockProductRepository.createProduct(any),
      ).thenAnswer((_) async => 'new-product-id');

      // Container is already set up in setUp method

      final viewModel = container.read(productViewModelProvider.notifier);
      await viewModel.addProduct(testProgram, testProduct);

      verify(
        mockProductRepository.createProduct(any),
      ).called(greaterThanOrEqualTo(1));
    });

    test('addProduct should handle null user ID', () async {
      final testProgram = Program.empty().copyWith(id: 'test-program-id');
      final testProduct = Product.empty();

      // Override userIdProvider to return null
      container = ProviderContainer(
        overrides: [
          productRepositoryProvider.overrideWithValue(mockProductRepository),
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
          staffRepositoryProvider.overrideWithValue(mockStaffRepository),
          userIdProvider.overrideWith((ref) async* {
            yield null;
          }),
        ],
      );

      when(
        mockStaffRepository.checkExistenceStaff(any, any),
      ).thenAnswer((_) async => true);

      final viewModel = container.read(productViewModelProvider.notifier);

      await expectLater(
        () => viewModel.addProduct(testProgram, testProduct),
        throwsA(isA<AuthenticationException>()),
      );

      verifyNever(mockProductRepository.createProduct(any));
    });

    test('updateProduct should update product successfully', () async {
      final testProduct = Product.empty().copyWith(
        id: 'product-1',
        name: 'Updated Product',
        price: 2500,
      );

      // 認証されたユーザーをモック
      when(mockAuthRepository.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test-user-id');
      when(
        mockAuthRepository.userId,
      ).thenAnswer((_) => Stream.value('test-user-id'));
      when(
        mockStaffRepository.checkExistenceStaff(any, any),
      ).thenAnswer((_) async => true);
      when(
        mockProductRepository.updateProduct(testProduct),
      ).thenAnswer((_) async => 'product-1');

      // Container is already set up in setUp method

      final viewModel = container.read(productViewModelProvider.notifier);
      await viewModel.updateProduct(testProduct);

      verify(
        mockProductRepository.updateProduct(testProduct),
      ).called(greaterThanOrEqualTo(1));
    });

    test('updateProduct should handle errors', () async {
      final testProduct = Product.empty().copyWith(
        id: 'product-1',
        name: 'Updated Product',
      );

      // 認証されたユーザーをモック
      when(mockAuthRepository.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test-user-id');
      when(
        mockAuthRepository.userId,
      ).thenAnswer((_) => Stream.value('test-user-id'));
      when(
        mockStaffRepository.checkExistenceStaff(any, any),
      ).thenAnswer((_) async => true);
      when(
        mockProductRepository.updateProduct(testProduct),
      ).thenThrow(Exception('Update failed'));

      // Container is already set up in setUp method

      final viewModel = container.read(productViewModelProvider.notifier);

      await expectLater(
        () => viewModel.updateProduct(testProduct),
        throwsA(isA<Exception>()),
      );
      verify(
        mockProductRepository.updateProduct(testProduct),
      ).called(greaterThanOrEqualTo(1));
    });

    test('deleteProduct should delete product successfully', () async {
      final testProduct = Product.empty().copyWith(id: 'product-1');

      // 認証されたユーザーをモック
      when(mockAuthRepository.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test-user-id');
      when(
        mockAuthRepository.userId,
      ).thenAnswer((_) => Stream.value('test-user-id'));
      when(
        mockStaffRepository.checkExistenceStaff(any, any),
      ).thenAnswer((_) async => true);
      when(
        mockProductRepository.readProducts(),
      ).thenAnswer((_) async => [testProduct]);
      when(
        mockProductRepository.deleteProduct('product-1'),
      ).thenAnswer((_) async {});

      // Container is already set up in setUp method

      final viewModel = container.read(productViewModelProvider.notifier);
      await viewModel.deleteProduct(testProduct.id!);

      verify(
        mockProductRepository.deleteProduct('product-1'),
      ).called(greaterThanOrEqualTo(1));
    });

    test('deleteProduct should handle errors', () async {
      final testProduct = Product.empty().copyWith(id: 'product-1');

      // 認証されたユーザーをモック
      when(mockAuthRepository.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test-user-id');
      when(
        mockAuthRepository.userId,
      ).thenAnswer((_) => Stream.value('test-user-id'));
      when(
        mockStaffRepository.checkExistenceStaff(any, any),
      ).thenAnswer((_) async => true);
      when(
        mockProductRepository.readProducts(),
      ).thenAnswer((_) async => [testProduct]);
      when(
        mockProductRepository.deleteProduct('product-1'),
      ).thenThrow(Exception('Delete failed'));

      // Container is already set up in setUp method

      final viewModel = container.read(productViewModelProvider.notifier);

      await expectLater(
        () => viewModel.deleteProduct(testProduct.id!),
        throwsA(isA<Exception>()),
      );
      verify(
        mockProductRepository.deleteProduct('product-1'),
      ).called(greaterThanOrEqualTo(1));
    });

    test('registerProduct should add new product when id is null', () async {
      final testProgram = Program.empty().copyWith(
        id: 'program-1',
        organizerId: 'organizer-1',
      );

      final testProduct = Product.empty().copyWith(
        name: 'New Product',
        price: 1500,
      );

      // 認証されたユーザーをモック
      when(mockAuthRepository.getCurrentUser()).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test-user-id');
      when(
        mockAuthRepository.userId,
      ).thenAnswer((_) => Stream.value('test-user-id'));
      when(
        mockStaffRepository.checkExistenceStaff(any, any),
      ).thenAnswer((_) async => true);
      when(
        mockProductRepository.createProduct(any),
      ).thenAnswer((_) async => 'new-product-id');

      // Container is already set up in setUp method

      final viewModel = container.read(productViewModelProvider.notifier);
      final result = await viewModel.registerProduct(testProgram, testProduct);

      expect(result, isTrue);
      verify(
        mockProductRepository.createProduct(any),
      ).called(greaterThanOrEqualTo(1));
      verifyNever(mockProductRepository.updateProduct(any));
    });

    test(
      'registerProduct should update existing product when id is not null',
      () async {
        final testProduct = Product.empty().copyWith(
          id: 'product-1',
          name: 'Updated Product',
          price: 2500,
        );

        // 認証されたユーザーをモック
        when(mockAuthRepository.getCurrentUser()).thenReturn(mockUser);
        when(mockUser.uid).thenReturn('test-user-id');
        when(
          mockAuthRepository.userId,
        ).thenAnswer((_) => Stream.value('test-user-id'));
        when(
          mockStaffRepository.checkExistenceStaff(any, any),
        ).thenAnswer((_) async => true);
        when(
          mockProductRepository.updateProduct(testProduct),
        ).thenAnswer((_) async => 'product-1');

        // userIdProviderを正しくオーバーライド
        container = ProviderContainer(
          overrides: [
            productRepositoryProvider.overrideWithValue(mockProductRepository),
            authRepositoryProvider.overrideWithValue(mockAuthRepository),
            staffRepositoryProvider.overrideWithValue(mockStaffRepository),
            userIdProvider.overrideWith((ref) async* {
              yield 'test-user-id';
            }),
          ],
        );

        final viewModel = container.read(productViewModelProvider.notifier);
        final result = await viewModel.registerProduct(
          Program.empty(),
          testProduct,
        );

        expect(result, isTrue);
        verify(
          mockProductRepository.updateProduct(testProduct),
        ).called(greaterThanOrEqualTo(1));
        verifyNever(mockProductRepository.createProduct(any));
      },
    );
  });
}
