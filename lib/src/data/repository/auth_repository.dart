import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';
import '../general_provider.dart';
import '../model/exception/app_exception.dart';

part 'auth_repository.g.dart';

// AuthRepositoryProvider
@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
}

// 認証状態プロバイダー
@riverpod
Stream<bool> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

// UserIdプロバイダー
@riverpod
Stream<String?> userId(Ref ref) {
  return ref.watch(authRepositoryProvider).userId;
}

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  /// 認証状態の変化を監視するストリーム
  Stream<bool> get authStateChanges =>
      _auth.authStateChanges().map((user) => user != null);

  /// ユーザーIDを監視するストリーム
  Stream<String?> get userId {
    logger.d('userId: ストリーム開始', time: DateTime.now());
    return _auth.authStateChanges().map((user) {
      logger.d(
        'userId: authStateChanges - user=${user?.uid}',
        time: DateTime.now(),
      );
      if (user != null) {
        return user.uid;
      } else {
        return null;
      }
    });
  }

  /// メールアドレスとパスワードを使用してサインインする
  Future<void> signInWithEmail(String email, String password) async {
    logger.i('signInWithEmail: メールアドレスとパスワードを使用してサインインします');
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      logger.i('signInWithEmail: サインイン成功');
    } on FirebaseAuthException catch (e) {
      logger.e('signInWithEmail: サインイン失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// パスワードリセットメールを送信する
  Future<void> sendPasswordResetEmail(String email) async {
    logger.i('sendPasswordResetEmail: パスワードリセットメールを送信します');
    try {
      await _auth.sendPasswordResetEmail(email: email);
      logger.i('sendPasswordResetEmail: パスワードリセットメール送信成功');
    } on FirebaseAuthException catch (e) {
      logger.e('sendPasswordResetEmail: パスワードリセットメール送信失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// 新規ユーザーを登録する
  Future<UserCredential> signUp(String email, String password) async {
    logger.i('signUp: 新規ユーザーを登録します');
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i('signUp: ユーザー登録成功');
      return result;
    } on FirebaseAuthException catch (e) {
      logger.e('signUp: ユーザー登録失敗', error: e);
      throw AuthenticationException(
        message: convertAuthError(e.code),
        code: e.code,
        stackTrace: e.stackTrace,
      );
    }
  }

  /// サインアウトする
  Future<void> signOut() async {
    logger.i('signOut: サインアウトします');
    try {
      await _auth.signOut();
      logger.i('signOut: サインアウト成功');
    } on FirebaseAuthException catch (e) {
      logger.e('signOut: サインアウト失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// 現在のユーザーを取得する
  User? getCurrentUser() {
    logger.i('getCurrentUser: 現在のユーザーを取得します');
    try {
      final user = _auth.currentUser;
      logger.i('getCurrentUser: 現在のユーザーを取得しました');
      return user;
    } on FirebaseAuthException catch (e) {
      logger.e('getCurrentUser: 現在のユーザー取得失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// ユーザーの表示名を更新する
  void updateDisplayName(String? displayName) {
    logger.i('updateDisplayName: ユーザーの表示名を更新します');
    try {
      if (_auth.currentUser!.displayName != displayName ||
          _auth.currentUser!.displayName != null) {
        _auth.currentUser!.updateDisplayName(displayName);
        logger.i('updateDisplayName: ユーザーの表示名更新成功');
      }
    } on FirebaseAuthException catch (e) {
      logger.e('updateDisplayName: ユーザーの表示名更新失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// ユーザーのメールアドレスを更新する
  void updateEmail(String email) {
    logger.i('updateEmail: ユーザーのメールアドレスを更新します');
    try {
      if (_auth.currentUser!.email != email ||
          _auth.currentUser!.email != null) {
        _auth.currentUser!.verifyBeforeUpdateEmail(email);
        logger.i('updateEmail: ユーザーのメールアドレス更新成功');
      }
    } on FirebaseAuthException catch (e) {
      logger.e('updateEmail: ユーザーのメールアドレス更新失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// ユーザーのパスワードを更新する
  void updatePassword(String password) {
    logger.i('updatePassword: ユーザーのパスワードを更新します');
    try {
      _auth.currentUser!.updatePassword(password);
      logger.i('updatePassword: ユーザーのパスワード更新成功');
    } on FirebaseAuthException catch (e) {
      logger.e('updatePassword: ユーザーのパスワード更新失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// ユーザーのプロフィール画像のURLを更新する
  void updatePhotoUrl(String? photoUrl) {
    logger.i('updatePhotoUrl: ユーザーのプロフィール画像のURLを更新します');
    try {
      if (photoUrl != null) {
        _auth.currentUser!.updatePhotoURL(photoUrl);
        logger.i('updatePhotoUrl: ユーザーのプロフィール画像のURL更新成功');
      }
    } on FirebaseAuthException catch (e) {
      logger.e('updatePhotoUrl: ユーザーのプロフィール画像のURL更新失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }
}

/// FirebaseAuth のエラーコードからエラー文言を返す（https://firebase.google.com/docs/auth/admin/errors?hl=ja）
String convertAuthError(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'メールアドレスを正しい形式で入力してください';
    case 'wrong-password':
      return 'パスワードが間違っています';
    case 'user-not-found':
      return 'ユーザーが見つかりません';
    case 'weak-password':
      return 'パスワードは6文字以上で入力してください';
    case 'user-disabled':
      return 'ユーザーが無効です';
    case 'email-already-in-use':
      return 'このメールアドレスは既に登録されています';
    default:
      return '不明なエラーです';
  }
}
