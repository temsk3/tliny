import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tliny/src/data/general_provider.dart';
import 'package:tliny/src/data/model/exception/app_exception.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/test/utils/firebase_test_setup.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([
  firebase_auth.FirebaseAuth,
  firebase_auth.User,
  firebase_auth.UserCredential,
])
void main() {
  group('AuthRepository Tests', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;
    late MockUserCredential mockUserCredential;
    late AuthRepository authRepository;
    late ProviderContainer container;

    setUpAll(() async {
      await setupFirebaseForTesting();
    });

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();
      mockUserCredential = MockUserCredential();
      authRepository = AuthRepository(mockFirebaseAuth);

      container = ProviderContainer(
        overrides: [firebaseAuthProvider.overrideWithValue(mockFirebaseAuth)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('authStateChanges', () {
      test('should return stream of boolean values', () {
        when(
          mockFirebaseAuth.authStateChanges(),
        ).thenAnswer((_) => Stream.value(mockUser));

        final stream = authRepository.authStateChanges;
        expect(stream, isA<Stream<bool>>());
      });

      test('should return true when user is authenticated', () async {
        when(
          mockFirebaseAuth.authStateChanges(),
        ).thenAnswer((_) => Stream.value(mockUser));

        final result = await authRepository.authStateChanges.first;
        expect(result, isTrue);
      });

      test('should return false when user is not authenticated', () async {
        when(
          mockFirebaseAuth.authStateChanges(),
        ).thenAnswer((_) => Stream.value(null));

        final result = await authRepository.authStateChanges.first;
        expect(result, isFalse);
      });
    });

    group('userId', () {
      test('should return user ID when user is authenticated', () async {
        when(
          mockFirebaseAuth.authStateChanges(),
        ).thenAnswer((_) => Stream.value(mockUser));
        when(mockUser.uid).thenReturn('test-user-id');

        final result = await authRepository.userId.first;
        expect(result, equals('test-user-id'));
      });

      test('should return null when user is not authenticated', () async {
        when(
          mockFirebaseAuth.authStateChanges(),
        ).thenAnswer((_) => Stream.value(null));

        final result = await authRepository.userId.first;
        expect(result, isNull);
      });
    });

    group('signInWithEmail', () {
      test('should sign in successfully with valid credentials', () async {
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).thenAnswer((_) async => mockUserCredential);

        await authRepository.signInWithEmail('test@example.com', 'password123');

        verify(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'password123',
          ),
        ).called(1);
      });

      test('should throw error for invalid email', () async {
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'invalid-email',
            password: 'password123',
          ),
        ).thenThrow(firebase_auth.FirebaseAuthException(code: 'invalid-email'));

        expect(
          () => authRepository.signInWithEmail('invalid-email', 'password123'),
          throwsA(isA<AuthenticationException>()),
        );
      });

      test('should throw error for wrong password', () async {
        when(
          mockFirebaseAuth.signInWithEmailAndPassword(
            email: 'test@example.com',
            password: 'wrong-password',
          ),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(code: 'wrong-password'),
        );

        expect(
          () => authRepository.signInWithEmail(
            'test@example.com',
            'wrong-password',
          ),
          throwsA(isA<AuthenticationException>()),
        );
      });
    });

    group('signUp', () {
      test('should create user successfully', () async {
        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockUser.uid).thenReturn('test-user-id');
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'new@example.com',
            password: 'password123',
          ),
        ).thenAnswer((_) async => mockUserCredential);

        final result = await authRepository.signUp(
          'new@example.com',
          'password123',
        );

        expect(result, equals(mockUserCredential));
        verify(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'new@example.com',
            password: 'password123',
          ),
        ).called(1);
      });

      test('should throw error for weak password', () async {
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'new@example.com',
            password: '123',
          ),
        ).thenThrow(firebase_auth.FirebaseAuthException(code: 'weak-password'));

        expect(
          () => authRepository.signUp('new@example.com', '123'),
          throwsA(isA<AuthenticationException>()),
        );
      });

      test('should throw error for existing email', () async {
        when(
          mockFirebaseAuth.createUserWithEmailAndPassword(
            email: 'existing@example.com',
            password: 'password123',
          ),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(code: 'email-already-in-use'),
        );

        expect(
          () => authRepository.signUp('existing@example.com', 'password123'),
          throwsA(isA<AuthenticationException>()),
        );
      });
    });

    group('signOut', () {
      test('should sign out successfully', () async {
        when(mockFirebaseAuth.signOut()).thenAnswer((_) async {
          return;
        });

        await authRepository.signOut();

        verify(mockFirebaseAuth.signOut()).called(1);
      });

      test('should handle sign out error', () async {
        when(
          mockFirebaseAuth.signOut(),
        ).thenThrow(firebase_auth.FirebaseAuthException(code: 'unknown'));

        expect(
          () => authRepository.signOut(),
          throwsA(isA<GeneralException>()),
        );
      });
    });

    group('getCurrentUser', () {
      test('should return current user when authenticated', () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        final result = authRepository.getCurrentUser();

        expect(result, equals(mockUser));
      });

      test('should return null when not authenticated', () {
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        final result = authRepository.getCurrentUser();

        expect(result, isNull);
      });
    });

    group('updateDisplayName', () {
      test('should update display name successfully', () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.displayName).thenReturn('Old Name');
        when(mockUser.updateDisplayName('New Name')).thenAnswer((_) async {});

        authRepository.updateDisplayName('New Name');

        verify(mockUser.updateDisplayName('New Name')).called(1);
      });

      test('should not update if display name is the same', () {
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.displayName).thenReturn('Same Name');

        authRepository.updateDisplayName('Same Name');

        verifyNever(mockUser.updateDisplayName(any));
      });
    });

    group('sendPasswordResetEmail', () {
      test('should send password reset email successfully', () async {
        when(
          mockFirebaseAuth.sendPasswordResetEmail(email: 'test@example.com'),
        ).thenAnswer((_) async {
          return;
        });

        await authRepository.sendPasswordResetEmail('test@example.com');

        verify(
          mockFirebaseAuth.sendPasswordResetEmail(email: 'test@example.com'),
        ).called(1);
      });

      test('should handle password reset error', () async {
        when(
          mockFirebaseAuth.sendPasswordResetEmail(email: 'invalid@example.com'),
        ).thenThrow(
          firebase_auth.FirebaseAuthException(code: 'user-not-found'),
        );

        expect(
          () => authRepository.sendPasswordResetEmail('invalid@example.com'),
          throwsA(isA<AuthenticationException>()),
        );
      });
    });
  });

  group('convertAuthError', () {
    test('should convert invalid-email error', () {
      final result = convertAuthError('invalid-email');
      expect(result, equals('メールアドレスの形式が正しくありません。正しいメールアドレスを入力してください。'));
    });

    test('should convert wrong-password error', () {
      final result = convertAuthError('wrong-password');
      expect(result, equals('パスワードが間違っています。正しいパスワードを入力してください。'));
    });

    test('should convert user-not-found error', () {
      final result = convertAuthError('user-not-found');
      expect(
        result,
        equals('このメールアドレスで登録されたユーザーが見つかりません。メールアドレスを確認するか、新規登録してください。'),
      );
    });

    test('should convert weak-password error', () {
      final result = convertAuthError('weak-password');
      expect(result, equals('パスワードが弱すぎます。6文字以上のパスワードを設定してください。'));
    });

    test('should convert user-disabled error', () {
      final result = convertAuthError('user-disabled');
      expect(result, equals('このアカウントは無効になっています。管理者にお問い合わせください。'));
    });

    test('should convert email-already-in-use error', () {
      final result = convertAuthError('email-already-in-use');
      expect(
        result,
        equals('このメールアドレスは既に使用されています。別のメールアドレスを使用するか、ログインしてください。'),
      );
    });

    test('should return default error for unknown error code', () {
      final result = convertAuthError('unknown-error');
      expect(result, equals('認証エラーが発生しました。しばらく時間をおいてから再度お試しください。'));
    });
  });
}
