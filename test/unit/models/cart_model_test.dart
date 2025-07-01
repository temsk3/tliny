import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/cart_model.dart';

void main() {
  group('Cart Model Tests', () {
    test('Cart.empty() should create empty cart with default values', () {
      final cart = Cart.empty();

      expect(cart.id, isNull);
      expect(cart.quantity, equals(0));
      expect(cart.productId, isNull);
      expect(cart.programId, isNull);
      expect(cart.productDocRef, isNull);
    });

    test('Cart should be created with required fields', () {
      const cart = Cart(
        quantity: 2,
        productId: 'product-1',
        programId: 'program-1',
      );

      expect(cart.quantity, equals(2));
      expect(cart.productId, equals('product-1'));
      expect(cart.programId, equals('program-1'));
    });

    test('Cart.copyWith should create new instance with updated fields', () {
      final original = Cart.empty();
      final updated = original.copyWith(
        id: 'cart-1',
        quantity: 5,
        productId: 'product-1',
        programId: 'program-1',
      );

      expect(updated.id, equals('cart-1'));
      expect(updated.quantity, equals(5));
      expect(updated.productId, equals('product-1'));
      expect(updated.programId, equals('program-1'));
    });

    test('Cart should be equal when all fields are the same', () {
      const cart1 = Cart(
        id: 'cart-1',
        quantity: 2,
        productId: 'product-1',
        programId: 'program-1',
      );

      const cart2 = Cart(
        id: 'cart-1',
        quantity: 2,
        productId: 'product-1',
        programId: 'program-1',
      );

      expect(cart1, equals(cart2));
      expect(cart1.hashCode, equals(cart2.hashCode));
    });

    test('Cart should not be equal when fields differ', () {
      final cart1 = Cart.empty().copyWith(quantity: 1);
      final cart2 = Cart.empty().copyWith(quantity: 2);

      expect(cart1, isNot(equals(cart2)));
    });

    test('Cart should handle quantity validation', () {
      const cart = Cart(
        quantity: 0,
        productId: 'product-1',
        programId: 'program-1',
      );

      expect(cart.quantity, equals(0));

      final updatedCart = cart.copyWith(quantity: 10);
      expect(updatedCart.quantity, equals(10));
    });
  });
}
