import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/repository/auth_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';

part 'auth_view_model.g.dart';

/// 認証状態を管理する ViewModel
@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  User? build() {
    return ref.read(authRepositoryProvider).getCurrentUser();
  }

  /// メールアドレスとパスワードを使用してサインインする
  Future<void> signIn(String email, String password) async {
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      await loading.guardFutureWithMinDuration(() async {
        await ref.read(authRepositoryProvider).signInWithEmail(email, password);
        logger.i('Successfully signed in with email: $email'); // 成功ログを追加
      }, message: 'ログイン中...');
    } on FirebaseAuthException catch (e) {
      logger.e('signIn failed: ${e.code} - ${e.message}');
      throw AuthenticationException(
        message: _convertAuthError(e.code),
        code: e.code,
        stackTrace: e.stackTrace,
      );
    } on AppException catch (e, st) {
      logger.e('signIn failed: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('signIn failed: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// Googleアカウントを使用してサインインする
  Future<void> signInWithGoogle() async {
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      await loading.guardFutureWithMinDuration(() async {
        await ref.read(authRepositoryProvider).signInWithGoogle();
        logger.i('Successfully signed in with Google'); // 成功ログを追加
      }, message: 'Googleでログイン中...');
    } on FirebaseAuthException catch (e) {
      logger.e('signInWithGoogle failed: ${e.code} - ${e.message}');
      throw AuthenticationException(
        message: _convertAuthError(e.code),
        code: e.code,
        stackTrace: e.stackTrace,
      );
    } on AppException catch (e, st) {
      logger.e('signInWithGoogle failed: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('signInWithGoogle failed: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// パスワードリセットメールを送信する
  Future<void> sendPasswordResetEmail(String email) async {
    // メールアドレスの事前バリデーション
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty) {
      throw ValidationException(
        message: 'メールアドレスを入力してください。',
        stackTrace: StackTrace.current,
      );
    }

    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      await loading.guardFutureWithMinDuration(() async {
        await ref
            .read(authRepositoryProvider)
            .sendPasswordResetEmail(trimmedEmail);
        logger.i('Password reset email sent to: $trimmedEmail'); // 成功ログを追加
      }, message: 'パスワードリセットメール送信中...');
    } on FirebaseAuthException catch (e) {
      logger.e('sendPasswordResetEmail failed: ${e.code} - ${e.message}');
      throw _convertPasswordResetError(e);
    } on AppException catch (e, st) {
      logger.e('sendPasswordResetEmail failed: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('sendPasswordResetEmail failed: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// メールアドレスとパスワードを使用してサインアップする
  Future<void> signUp(String email, String password) async {
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      await loading.guardFutureWithMinDuration(() async {
        await ref.read(authRepositoryProvider).signUp(email, password);
        logger.i('Successfully signed up with email: $email'); // 成功ログを追加
      }, message: 'アカウント作成中...');
    } on FirebaseAuthException catch (e) {
      logger.e('signUp failed: ${e.code} - ${e.message}');
      throw AuthenticationException(
        message: _convertAuthError(e.code),
        code: e.code,
        stackTrace: e.stackTrace,
      );
    } on AppException catch (e, st) {
      logger.e('signUp failed: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('signUp failed: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// サインアウトする
  Future<void> signOut() async {
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      await loading.guardFutureWithMinDuration(() async {
        await ref.read(authRepositoryProvider).signOut();
        logger.i('Successfully signed out.'); // 成功ログを追加
      }, message: 'ログアウト中...');
    } on AppException catch (e, st) {
      logger.e('signOut failed: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('signOut failed: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// Googleサインアウトする
  Future<void> signOutGoogle() async {
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      await loading.guardFutureWithMinDuration(() async {
        await ref.read(authRepositoryProvider).signOutGoogle();
        logger.i('Successfully signed out from Google.'); // 成功ログを追加
      }, message: 'Googleからログアウト中...');
    } on AppException catch (e, st) {
      logger.e('signOutGoogle failed: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('signOutGoogle failed: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// パスワードリセットエラーを適切な例外に変換
  AppException _convertPasswordResetError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return ValidationException(
          message: 'メールアドレスの形式が正しくありません。正しいメールアドレスを入力してください。',
          stackTrace: e.stackTrace,
        );
      case 'user-not-found':
        return ValidationException(
          message: 'このメールアドレスで登録されたユーザーが見つかりません。メールアドレスを確認してください。',
          stackTrace: e.stackTrace,
        );
      case 'too-many-requests':
        return ValidationException(
          message: '試行回数が多すぎます。しばらく時間をおいてから再度お試行してください。',
          stackTrace: e.stackTrace,
        );
      case 'network-request-failed':
        return NetworkException(
          message: 'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試行してください。',
          code: e.code,
          stackTrace: e.stackTrace,
        );
      case 'operation-not-allowed':
        return GeneralException(
          message: 'パスワードリセット機能が無効になっています。管理者にお問い合わせください。',
          stackTrace: e.stackTrace,
        );
      default:
        return GeneralException(
          message: 'パスワードリセットメールの送信に失敗しました。しばらく時間をおいてから再度お試行してください。',
          stackTrace: e.stackTrace,
        );
    }
  }

  /// Firebase認証エラーコードをユーザーフレンドリーなメッセージに変換
  String _convertAuthError(String code) {
    switch (code) {
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
        return '試行回数が多すぎます。しばらく時間をおいてから再度お試行してください。';
      case 'operation-not-allowed':
        return 'この操作は許可されていません。管理者にお問い合わせください。';
      case 'network-request-failed':
        return 'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試行してください。';
      case 'invalid-credential':
        return '認証情報が無効です。メールアドレスとパスワードを確認してください。';
      case 'account-exists-with-different-credential':
        return 'このメールアドレスは別の認証方法で既に登録されています。';
      case 'requires-recent-login':
        return 'セキュリティのため、再度ログインしてください。';
      default:
        return '認証エラーが発生しました。しばらく時間をおいてから再度お試行してください。';
    }
  }
}
