import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/repository/auth_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';
import 'user_view_model.dart';

part 'password_change_view_model.g.dart';

/// パスワード変更を管理する ViewModel
@riverpod
class PasswordChangeViewModel extends _$PasswordChangeViewModel {
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);

  @override
  FutureOr<void> build() {
    // 初期状態
    return null;
  }

  /// パスワードを確認して新しいパスワードに変更する
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    logger.d('changePassword: パスワード変更を開始します');

    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFutureWithMinDuration(() async {
        // 現在のユーザーを取得
        final currentUser = authRepository.getCurrentUser();
        if (currentUser == null) {
          throw AuthenticationException(
            message: 'ユーザーが認証されていません',
            code: 'user-not-found',
            stackTrace: StackTrace.current,
          );
        }

        // 現在のメールアドレスとパスワードで再認証
        await authRepository.signInWithEmail(
          currentUser.email!,
          currentPassword,
        );

        // 新しいパスワードに変更
        authRepository.updatePassword(newPassword);

        logger.i('changePassword: パスワード変更が完了しました');
      }, message: 'パスワード変更中...');

      // ユーザー情報を再取得してUIを更新
      try {
        await ref.read(userViewModelProvider.notifier).getUser();
      } catch (e) {
        logger.w('changePassword: ユーザー情報の再取得に失敗しました: $e');
      }

      // Refresh the state by calling build again
      ref.invalidateSelf();
    } on FirebaseAuthException catch (e) {
      logger.e(
        'changePassword: FirebaseAuthException - ${e.code} - ${e.message}',
      );
      String errorMessage;

      switch (e.code) {
        case 'wrong-password':
          errorMessage = '現在のパスワードが正しくありません';
        case 'weak-password':
          errorMessage = 'パスワードが弱すぎます。6文字以上の英数字で入力してください';
        case 'user-not-found':
          errorMessage = 'ユーザーが見つかりません';
        case 'user-disabled':
          errorMessage = 'アカウントが無効になっています';
        case 'too-many-requests':
          errorMessage = 'リクエストが多すぎます。しばらく時間をおいてから再度お試しください';
        case 'requires-recent-login':
          errorMessage = 'セキュリティのため、再度ログインしてください';
        default:
          errorMessage = 'パスワード変更に失敗しました: ${e.message}';
      }

      final appException = AuthenticationException(
        message: errorMessage,
        code: e.code,
        stackTrace: e.stackTrace,
      );
      rethrow;
    } on AppException catch (e, st) {
      logger.e('changePassword: AppException - ${e.message}', stackTrace: st);
      rethrow;
    } catch (e, st) {
      logger.e('changePassword: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// パスワード変更の状態をリセット
  void resetState() {
    ref.invalidateSelf();
  }
}
