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
      await loading.guardFuture(() async {
        await ref.read(authRepositoryProvider).signInWithEmail(email, password);
        logger.i('Successfully signed in with email: $email'); // 成功ログを追加
      });
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
      await loading.guardFuture(() async {
        await ref.read(authRepositoryProvider).signInWithGoogle();
        logger.i('Successfully signed in with Google'); // 成功ログを追加
      });
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
    final loading = ref.read(globalLoadingControllerProvider.notifier);
    try {
      await loading.guardFuture(() async {
        await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
        logger.i('Password reset email sent to: $email'); // 成功ログを追加
      });
    } on FirebaseAuthException catch (e) {
      logger.e('sendPasswordResetEmail failed: ${e.code} - ${e.message}');
      throw AuthenticationException(
        message: _convertAuthError(e.code),
        code: e.code,
        stackTrace: e.stackTrace,
      );
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
      await loading.guardFuture(() async {
        await ref.read(authRepositoryProvider).signUp(email, password);
        logger.i('Successfully signed up with email: $email'); // 成功ログを追加
      });
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
      await loading.guardFuture(() async {
        await ref.read(authRepositoryProvider).signOut();
        logger.i('Successfully signed out.'); // 成功ログを追加
      });
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
      await loading.guardFuture(() async {
        await ref.read(authRepositoryProvider).signOutGoogle();
        logger.i('Successfully signed out from Google.'); // 成功ログを追加
      });
    } on AppException catch (e, st) {
      logger.e('signOutGoogle failed: ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('signOutGoogle failed: $e', stackTrace: st);
      throw GeneralException(message: e.toString(), stackTrace: st);
    }
  }

  /// Firebase認証エラーコードをユーザーフレンドリーなメッセージに変換
  String _convertAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'ユーザーが見つかりません';
      case 'wrong-password':
        return 'パスワードが間違っています';
      case 'email-already-in-use':
        return 'このメールアドレスは既に使用されています';
      case 'weak-password':
        return 'パスワードが弱すぎます';
      case 'invalid-email':
        return 'メールアドレスの形式が正しくありません';
      case 'user-disabled':
        return 'このアカウントは無効になっています';
      case 'too-many-requests':
        return '試行回数が多すぎます。しばらく時間をおいてから再試行してください';
      case 'operation-not-allowed':
        return 'この操作は許可されていません';
      case 'network-request-failed':
        return 'ネットワークエラーが発生しました';
      default:
        return '認証エラーが発生しました';
    }
  }
}
