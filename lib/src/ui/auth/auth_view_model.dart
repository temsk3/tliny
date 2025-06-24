import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/auth_repository.dart';
import '../../utils/logger.dart';

/// 認証状態を管理する ViewModel
final authViewModelProvider = StateNotifierProvider<AuthViewModel, User?>(
  AuthViewModel.new,
);

class AuthViewModel extends StateNotifier<User?> {
  AuthViewModel(this._ref) : super(null);
  final Ref _ref;

  /// 現在のユーザー情報を取得する
  @override
  User? get state => _ref.read(authRepositoryProvider).getCurrentUser();

  /// メールアドレスとパスワードを使用してサインインする
  Future<void> signIn(String email, String password) async {
    try {
      await _ref.read(authRepositoryProvider).signInWithEmail(email, password);
      logger.i('Successfully signed in with email: $email'); // 成功ログを追加
    } on FirebaseAuthException catch (e) {
      logger.e('signIn failed: ${e.code} - ${e.message}');
      rethrow; // Firebase例外は再スロー
    } catch (e, st) {
      logger.e('signIn failed: $e', stackTrace: st);
      rethrow; // その他の例外も再スロー
    }
  }

  /// パスワードリセットメールを送信する
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
      logger.i('Password reset email sent to: $email'); // 成功ログを追加
    } on FirebaseAuthException catch (e) {
      logger.e('sendPasswordResetEmail failed: ${e.code} - ${e.message}');
      rethrow;
    } catch (e, st) {
      logger.e('sendPasswordResetEmail failed: $e', stackTrace: st);
      rethrow;
    }
  }

  /// メールアドレスとパスワードを使用してサインアップする
  Future<void> signUp(String email, String password) async {
    try {
      await _ref.read(authRepositoryProvider).signUp(email, password);
      logger.i('Successfully signed up with email: $email'); // 成功ログを追加
    } on FirebaseAuthException catch (e) {
      logger.e('signUp failed: ${e.code} - ${e.message}');
      rethrow;
    } catch (e, st) {
      logger.e('signUp failed: $e', stackTrace: st);
      rethrow;
    }
  }

  /// サインアウトする
  Future<void> signOut() async {
    try {
      await _ref.read(authRepositoryProvider).signOut();
      logger.i('Successfully signed out.'); // 成功ログを追加
    } catch (e, st) {
      logger.e('signOut failed: $e', stackTrace: st);
      rethrow;
    }
  }
}
