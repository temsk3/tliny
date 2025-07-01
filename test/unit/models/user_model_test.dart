import 'package:flutter_test/flutter_test.dart';
import 'package:tliny/src/data/model/user_model.dart';

void main() {
  group('User Model Tests', () {
    test('User.empty() should create empty user with default values', () {
      final user = User.empty();

      expect(user.id, isNull);
      expect(user.name, equals(''));
      expect(user.email, equals(''));
      expect(user.phoneNumber, isNull);
      expect(user.photoUrl, isNull);
      expect(user.displayName, isNull);
    });

    test('User should be created with required fields', () {
      const user = User(
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: '1234567890',
      );

      expect(user.name, equals('Test User'));
      expect(user.email, equals('test@example.com'));
      expect(user.phoneNumber, equals('1234567890'));
    });

    test('User.copyWith should create new instance with updated fields', () {
      final original = User.empty();
      final updated = original.copyWith(
        id: 'user-1',
        name: 'Updated User',
        email: 'updated@example.com',
        displayName: 'Updated Display',
      );

      expect(updated.id, equals('user-1'));
      expect(updated.name, equals('Updated User'));
      expect(updated.email, equals('updated@example.com'));
      expect(updated.displayName, equals('Updated Display'));
      expect(updated.phoneNumber, equals(original.phoneNumber)); // unchanged
    });

    test('User should be equal when all fields are the same', () {
      const user1 = User(
        id: 'user-1',
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: '1234567890',
      );

      const user2 = User(
        id: 'user-1',
        name: 'Test User',
        email: 'test@example.com',
        phoneNumber: '1234567890',
      );

      expect(user1, equals(user2));
      expect(user1.hashCode, equals(user2.hashCode));
    });

    test('User should not be equal when fields differ', () {
      final user1 = User.empty().copyWith(name: 'User 1');
      final user2 = User.empty().copyWith(name: 'User 2');

      expect(user1, isNot(equals(user2)));
    });
  });

  group('PublicUsers Tests', () {
    test('PublicUsers should be created with fields', () {
      final publicUser = PublicUsers(id: 'user-1', displayName: 'Public User');

      expect(publicUser.id, equals('user-1'));
      expect(publicUser.displayName, equals('Public User'));
    });

    test(
      'PublicUsers.copyWith should create new instance with updated fields',
      () {
        final original = PublicUsers();
        final updated = original.copyWith(
          id: 'user-1',
          displayName: 'Updated Display',
        );

        expect(updated.id, equals('user-1'));
        expect(updated.displayName, equals('Updated Display'));
      },
    );

    test('PublicUsers should be equal when all fields are the same', () {
      final user1 = PublicUsers(id: 'user-1', displayName: 'Test User');

      final user2 = PublicUsers(id: 'user-1', displayName: 'Test User');

      expect(user1, equals(user2));
      expect(user1.hashCode, equals(user2.hashCode));
    });
  });
}
