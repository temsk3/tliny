import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  // GoogleSignInの設定を修正
  final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // iOSプラットフォームでの問題を解決するための設定
    clientId:
        '736590453040-2fpunln7gljjoaviks28upfq138bn7g1.apps.googleusercontent.com',
  );

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

  /// ユーザーデータの作成を待機する共通メソッド
  Future<void> _waitForUserDataCreation(String uid) async {
    logger.i('_waitForUserDataCreation: ユーザーデータ作成を待機中... uid=$uid');

    // 最大10秒間、ユーザーデータの作成を待機
    var retryCount = 0;
    const maxRetries = 20; // 500ms × 20 = 10秒

    while (retryCount < maxRetries) {
      try {
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          logger.i('_waitForUserDataCreation: ユーザーデータ作成完了');
          break;
        }

        await Future.delayed(const Duration(milliseconds: 500));
        retryCount++;
      } catch (e) {
        logger.w('_waitForUserDataCreation: ユーザーデータ確認中にエラー', error: e);
        await Future.delayed(const Duration(milliseconds: 500));
        retryCount++;
      }
    }

    if (retryCount >= maxRetries) {
      logger.w('_waitForUserDataCreation: ユーザーデータ作成待機タイムアウト');
    }
  }

  /// Googleアカウントを使用してサインインする
  Future<UserCredential> signInWithGoogle() async {
    logger.i('signInWithGoogle: Googleアカウントを使用してサインインします');
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        // Webプラットフォーム用の実装
        userCredential = await _signInWithGoogleWeb();
      } else {
        // モバイルプラットフォーム用の実装
        userCredential = await _signInWithGoogleMobile();
      }

      // ユーザーデータの作成を待つ（Cloud Functionsの処理完了を待機）
      if (userCredential.user != null) {
        await _waitForUserDataCreation(userCredential.user!.uid);
      }

      return userCredential;
    } catch (e, stackTrace) {
      logger.e('signInWithGoogle: 予期しないエラー', error: e);
      throw GeneralException(
        message: 'Googleサインイン中にエラーが発生しました',
        stackTrace: stackTrace,
      );
    }
  }

  /// Webプラットフォーム用のGoogle Sign-In
  Future<UserCredential> _signInWithGoogleWeb() async {
    logger.i('_signInWithGoogleWeb: Webプラットフォーム用のGoogle Sign-Inを開始');

    try {
      // Web用のGoogle認証プロバイダーを使用
      final authProvider = GoogleAuthProvider();

      // カスタムパラメータを追加
      authProvider.addScope('email');
      authProvider.addScope('profile');

      // Firebaseでのサインイン
      final userCredential = await _auth.signInWithPopup(authProvider);
      logger.i(
        '_signInWithGoogleWeb: Web Googleサインイン成功 - uid: ${userCredential.user?.uid}',
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      logger.e('_signInWithGoogleWeb: Web Googleサインイン失敗', error: e);
      throw AuthenticationException(
        message: convertAuthError(e.code),
        code: e.code,
        stackTrace: e.stackTrace,
      );
    }
  }

  /// モバイルプラットフォーム用のGoogle Sign-In
  Future<UserCredential> _signInWithGoogleMobile() async {
    logger.i('_signInWithGoogleMobile: モバイルプラットフォーム用のGoogle Sign-Inを開始');

    try {
      // 既存のサインインをクリア
      await _googleSignIn.signOut();

      // Googleサインインの実行
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        logger.i('_signInWithGoogleMobile: ユーザーがサインインをキャンセルしました');
        throw const AuthenticationException(
          message: 'サインインがキャンセルされました',
          code: 'sign-in-cancelled',
        );
      }

      logger.i(
        '_signInWithGoogleMobile: Googleユーザー取得成功 - email: ${googleUser.email}',
      );

      // Google認証情報の取得
      final googleAuth = await googleUser.authentication;

      // Firebase認証情報の作成
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebaseでのサインイン
      final userCredential = await _auth.signInWithCredential(credential);
      logger.i(
        '_signInWithGoogleMobile: モバイル Googleサインイン成功 - uid: ${userCredential.user?.uid}',
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      logger.e('_signInWithGoogleMobile: モバイル Googleサインイン失敗', error: e);

      // iOSプラットフォーム特有のエラー処理
      if (e.code == 'invalid-credential') {
        throw AuthenticationException(
          message: 'Google認証の設定に問題があります。開発者にお問い合わせください。',
          code: e.code,
          stackTrace: e.stackTrace,
        );
      }

      throw AuthenticationException(
        message: convertAuthError(e.code),
        code: e.code,
        stackTrace: e.stackTrace,
      );
    }
  }

  /// Googleサインアウトする
  Future<void> signOutGoogle() async {
    logger.i('signOutGoogle: Googleサインアウトします');
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      logger.i('signOutGoogle: Googleサインアウト成功');
    } on FirebaseAuthException catch (e) {
      logger.e('signOutGoogle: Googleサインアウト失敗', error: e);
      throw GeneralException(
        message: convertAuthError(e.code),
        stackTrace: e.stackTrace,
      );
    }
  }

  /// メールアドレスとパスワードを使用してサインインする
  Future<void> signInWithEmail(String email, String password) async {
    logger.i('signInWithEmail: メールアドレスとパスワードを使用してサインインします');
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      logger.i('signInWithEmail: サインイン成功');
    } on FirebaseAuthException catch (e) {
      logger.e('signInWithEmail: サインイン失敗', error: e);
      throw AuthenticationException(
        message: convertAuthError(e.code),
        code: e.code,
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
      throw AuthenticationException(
        message: convertAuthError(e.code),
        code: e.code,
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

      // ユーザーデータの作成を待つ（Cloud Functionsの処理完了を待機）
      if (result.user != null) {
        await _waitForUserDataCreation(result.user!.uid);
      }

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
  Future<void> updateDisplayName(String? displayName) async {
    logger.i('updateDisplayName: ユーザーの表示名を更新します');
    try {
      if (_auth.currentUser!.displayName != displayName ||
          _auth.currentUser!.displayName != null) {
        await _auth.currentUser!.updateDisplayName(displayName);
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
  Future<void> updateEmail(String email) async {
    logger.i('updateEmail: ユーザーのメールアドレスを更新します');
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw GeneralException(
          message: 'ユーザーが認証されていません',
          stackTrace: StackTrace.current,
        );
      }

      if (currentUser.email != email) {
        await currentUser.verifyBeforeUpdateEmail(email);
        logger.i('updateEmail: ユーザーのメールアドレス更新成功');
      } else {
        logger.i('updateEmail: メールアドレスが同じため更新をスキップ');
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
  Future<void> updatePhotoUrl(String? photoUrl) async {
    logger.i('updatePhotoUrl: ユーザーのプロフィール画像のURLを更新します');
    try {
      if (photoUrl != null) {
        await _auth.currentUser!.updatePhotoURL(photoUrl);
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
      return 'メールアドレスの形式が正しくありません。正しいメールアドレスを入力してください。';
    case 'wrong-password':
      return 'パスワードが間違っています。正しいパスワードを入力してください。';
    case 'user-not-found':
      return 'このメールアドレスで登録されたユーザーが見つかりません。メールアドレスを確認するか、新規登録してください。';
    case 'weak-password':
      return 'パスワードが弱すぎます。6文字以上のパスワードを設定してください。';
    case 'user-disabled':
      return 'このアカウントは無効になっています。管理者にお問い合わせください。';
    case 'email-already-in-use':
      return 'このメールアドレスは既に使用されています。別のメールアドレスを使用するか、ログインしてください。';
    case 'too-many-requests':
      return '試行回数が多すぎます。しばらく時間をおいてから再度お試しください。';
    case 'operation-not-allowed':
      return 'この操作は許可されていません。管理者にお問い合わせください。';
    case 'network-request-failed':
      return 'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試しください。';
    case 'invalid-credential':
      return '認証情報が無効です。メールアドレスとパスワードを確認してください。';
    case 'account-exists-with-different-credential':
      return 'このメールアドレスは別の認証方法で既に登録されています。';
    case 'requires-recent-login':
      return 'セキュリティのため、再度ログインしてください。';
    default:
      return '認証エラーが発生しました。しばらく時間をおいてから再度お試しください。';
  }
}
