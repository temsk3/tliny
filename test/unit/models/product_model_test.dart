import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/product_model.dart';

void main() {
  group('Product Model Tests', () {
    test('Product.empty() should create empty product with default values', () {
      final product = Product.empty();

      expect(product.id, isNull);
      expect(product.name, equals(''));
      expect(product.genre, equals(GenreType.others));
      expect(product.desc, equals(''));
      expect(product.stock, equals(0));
      expect(product.price, equals(50));
      expect(product.pictureURL, isEmpty);
      expect(product.isActive, isTrue);
      expect(product.isPublish, isTrue);
    });

    test('Product should be created with required fields', () {
      final product = Product(
        name: 'Test Product',
        genre: GenreType.foods,
        desc: 'Test Description',
        expirationFrom: DateTime(2024),
        expirationTo: DateTime(2024, 12, 31),
        isActive: true,
        isPublish: true,
        salesStart: DateTime(2024),
        salesEnd: DateTime(2024, 12, 31),
      );

      expect(product.name, equals('Test Product'));
      expect(product.genre, equals(GenreType.foods));
      expect(product.desc, equals('Test Description'));
      expect(product.stock, equals(0)); // default value
      expect(product.price, equals(50)); // default value
    });

    test('Product.copyWith should create new instance with updated fields', () {
      final original = Product.empty();
      final updated = original.copyWith(
        id: 'test-id',
        name: 'Updated Product',
        price: 1000,
        stock: 10,
      );

      expect(updated.id, equals('test-id'));
      expect(updated.name, equals('Updated Product'));
      expect(updated.price, equals(1000));
      expect(updated.stock, equals(10));
      expect(updated.genre, equals(original.genre)); // unchanged
    });

    test('Product should be equal when all fields are the same', () {
      final product1 = Product(
        id: 'test-id',
        name: 'Test Product',
        genre: GenreType.goods,
        desc: 'Test Description',
        expirationFrom: DateTime(2024),
        expirationTo: DateTime(2024, 12, 31),
        isActive: true,
        isPublish: true,
        salesStart: DateTime(2024),
        salesEnd: DateTime(2024, 12, 31),
      );

      final product2 = Product(
        id: 'test-id',
        name: 'Test Product',
        genre: GenreType.goods,
        desc: 'Test Description',
        expirationFrom: DateTime(2024),
        expirationTo: DateTime(2024, 12, 31),
        isActive: true,
        isPublish: true,
        salesStart: DateTime(2024),
        salesEnd: DateTime(2024, 12, 31),
      );

      expect(product1, equals(product2));
      expect(product1.hashCode, equals(product2.hashCode));
    });

    test('Product should not be equal when fields differ', () {
      final product1 = Product.empty().copyWith(name: 'Product 1');
      final product2 = Product.empty().copyWith(name: 'Product 2');

      expect(product1, isNot(equals(product2)));
    });

    test('Product should serialize to JSON correctly', () {
      final product = Product(
        id: 'test-id',
        register: 'test-register',
        code: 'TEST001',
        name: 'Test Product',
        genre: GenreType.foods,
        desc: 'Test description',
        stock: 10,
        price: 1000,
        pictureURL: ['image1.jpg'],
        expirationFrom: DateTime(2024),
        expirationTo: DateTime(2024, 12, 31),
        isActive: true,
        isPublish: true,
        salesStart: DateTime(2024),
        salesEnd: DateTime(2024, 12, 31),
      );

      final json = product.toJson();

      expect(json['id'], 'test-id');
      expect(json['register'], 'test-register');
      expect(json['code'], 'TEST001');
      expect(json['name'], 'Test Product');
      expect(json['genre'], 'foods');
      expect(json['desc'], 'Test description');
      expect(json['stock'], 10);
      expect(json['price'], 1000);
      expect(json['pictureURL'], ['image1.jpg']);
      expect(json['isActive'], true);
      expect(json['isPublish'], true);
    });

    test('Product should deserialize from JSON correctly', () {
      final json = {
        'id': 'test-id',
        'register': 'test-register',
        'code': 'TEST001',
        'name': 'Test Product',
        'genre': 'foods',
        'desc': 'Test description',
        'stock': 10,
        'price': 1000,
        'pictureURL': ['image1.jpg'],
        'expirationFrom': Timestamp.fromDate(DateTime(2024)),
        'expirationTo': Timestamp.fromDate(DateTime(2024, 12, 31)),
        'isActive': true,
        'isPublish': true,
        'salesStart': Timestamp.fromDate(DateTime(2024)),
        'salesEnd': Timestamp.fromDate(DateTime(2024, 12, 31)),
      };

      final product = Product.fromJson(json);

      expect(product.id, 'test-id');
      expect(product.register, 'test-register');
      expect(product.code, 'TEST001');
      expect(product.name, 'Test Product');
      expect(product.genre, GenreType.foods);
      expect(product.desc, 'Test description');
      expect(product.stock, 10);
      expect(product.price, 1000);
      expect(product.pictureURL, ['image1.jpg']);
      expect(product.isActive, isTrue);
      expect(product.isPublish, isTrue);
    });

    test('ProductQueryParameter should work correctly', () {
      final queryParam = ProductQueryParameter(
        'test-program-id',
        GenreType.foods,
      );

      expect(queryParam.programId, 'test-program-id');
      expect(queryParam.genre, GenreType.foods);

      final json = queryParam.toJson();
      expect(json['programId'], 'test-program-id');
      expect(json['genre'], 'foods');

      final fromJson = ProductQueryParameter.fromJson(json);
      expect(fromJson.programId, 'test-program-id');
      expect(fromJson.genre, GenreType.foods);
    });
  });

  group('GenreType Tests', () {
    test('GenreType should have correct name values', () {
      expect(GenreType.goods.name, equals('goods'));
      expect(GenreType.foods.name, equals('foods'));
      expect(GenreType.others.name, equals('others'));
    });

    test('GenreType.values should contain all enum values', () {
      expect(
        GenreType.values,
        containsAll([GenreType.goods, GenreType.foods, GenreType.others]),
      );
    });
  });

  group('ProductQueryParameter Tests', () {
    test('ProductQueryParameter should be created with parameters', () {
      final param = ProductQueryParameter('program-1', GenreType.foods);

      expect(param.programId, equals('program-1'));
      expect(param.genre, equals(GenreType.foods));
    });

    test(
      'ProductQueryParameter should be equal when parameters are the same',
      () {
        final param1 = ProductQueryParameter('program-1', GenreType.foods);
        final param2 = ProductQueryParameter('program-1', GenreType.foods);

        expect(param1, equals(param2));
      },
    );
  });
}
