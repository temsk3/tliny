import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/src/data/model/product_model.dart';
import 'package:tliny/src/data/model/user_model.dart' as app_user;
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/data/repository/product_repository.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockProductRepository extends Mock implements ProductRepository {}

// Mock providers for testing
final mockAuthRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});

final mockProductRepositoryProvider = Provider<ProductRepository>((ref) {
  return MockProductRepository();
});

// Test data
class TestData {
  static final testUser = app_user.User(
    id: 'test-user-id',
    email: 'test@example.com',
    name: 'Test User',
    phoneNumber: '+1234567890',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  static final List<Product> testProducts = [
    Product.empty().copyWith(
      id: 'product-1',
      name: 'Test Product 1',
      price: 1000,
      isActive: true,
      isPublish: true,
    ),
    Product.empty().copyWith(
      id: 'product-2',
      name: 'Test Product 2',
      price: 2000,
      isActive: true,
      isPublish: true,
    ),
  ];

  static final Product testProduct = Product.empty().copyWith(
    id: 'test-product-id',
    name: 'Test Product',
    price: 1500,
    isActive: true,
    isPublish: true,
  );
}
