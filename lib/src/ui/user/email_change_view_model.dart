import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';
import 'user_view_model.dart';

part 'email_change_view_model.g.dart';

/// メールアドレス変更を管理する ViewModel
@riverpod
class EmailChangeViewModel extends _$EmailChangeViewModel {
  late final AuthRepository authRepository = ref.watch(authRepositoryProvider);
  late final UserRepository userRepository = ref.watch(userRepositoryProvider);

  @override
  FutureOr<void> build() {
    // 初期状態
    return null;
  }

  /// 現在のユーザーのメールアドレスを取得
  String? getCurrentEmail() {
    try {
      final user = authRepository.getCurrentUser();
      return user?.email;
    } on Exception catch (e, st) {
      logger.e('getCurrentEmail: error=$e', stackTrace: st);
      return null;
    }
  }

  /// パスワードを確認してメールアドレスを変更する
  Future<void> changeEmail(String newEmail, String password) async {
    logger.d('changeEmail: newEmail=$newEmail');

    try {
      final loading = ref.read(globalLoadingControllerProvider.notifier);
      await loading.guardFuture(() async {
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
        await authRepository.signInWithEmail(currentUser.email!, password);

        // メールアドレス変更の確認メールを送信
        await authRepository.updateEmail(newEmail);

        // Firestoreのユーザードキュメントも更新
        try {
          final currentUserData = await userRepository.readUser(
            currentUser.uid,
          );
          final updatedUser = currentUserData.copyWith(email: newEmail);
          await userRepository.updateUser(updatedUser);
          logger.i('changeEmail: Firestoreのユーザードキュメントを更新しました');
        } catch (e) {
          logger.w('changeEmail: Firestoreの更新に失敗しましたが、認証の更新は完了しています: $e');
          // Firestoreの更新に失敗しても認証の更新は完了しているため、エラーを投げない
        }

        logger.i('changeEmail: メールアドレス変更の確認メールを送信しました');
      });

      // ユーザー情報を再取得してUIを更新
      try {
        await ref.read(userViewModelProvider.notifier).getUser();
      } catch (e) {
        logger.w('changeEmail: ユーザー情報の再取得に失敗しました: $e');
      }

      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e) {
      logger.e('changeEmail: FirebaseAuthException - ${e.code} - ${e.message}');
      String errorMessage;

      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'パスワードが正しくありません';
        case 'email-already-in-use':
          errorMessage = 'このメールアドレスは既に使用されています';
        case 'invalid-email':
          errorMessage = '無効なメールアドレスです';
        case 'user-not-found':
          errorMessage = 'ユーザーが見つかりません';
        case 'user-disabled':
          errorMessage = 'アカウントが無効になっています';
        case 'too-many-requests':
          errorMessage = 'リクエストが多すぎます。しばらく時間をおいてから再度お試しください';
        default:
          errorMessage = 'メールアドレス変更に失敗しました: ${e.message}';
      }

      final appException = AuthenticationException(
        message: errorMessage,
        code: e.code,
        stackTrace: e.stackTrace,
      );
      state = AsyncValue.error(
        appException,
        e.stackTrace ?? StackTrace.current,
      );
      rethrow;
    } on AppException catch (e, st) {
      logger.e('changeEmail: AppException - ${e.message}', stackTrace: st);
      state = AsyncValue.error(e, st);
      rethrow;
    } catch (e, st) {
      logger.e('changeEmail: Exception - $e', stackTrace: st);
      final appException = GeneralException(
        message: e.toString(),
        stackTrace: st,
      );
      state = AsyncValue.error(appException, st);
      rethrow;
    }
  }

  /// メールアドレス変更の状態をリセット
  void resetState() {
    state = const AsyncValue.data(null);
  }
}
