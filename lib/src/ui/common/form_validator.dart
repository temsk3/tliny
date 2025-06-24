import '../../utils/logger.dart';

/// フォームのバリデーションを行うクラス
class FormValidator {
  /// メールアドレスのバリデーションを行う
  ///
  /// 引数:
  ///   value: バリデーション対象のメールアドレス
  ///
  /// 戻り値:
  ///   バリデーションエラーメッセージ (エラーがある場合)
  ///   null (エラーがない場合)
  static String? validateEmail(String? value) {
    logger.d('validateEmail: value=$value', time: DateTime.now());
    try {
      if (value == null || value.isEmpty) {
        return 'メールアドレスを入力してください';
      } else if (!RegExp(
        r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(value)) {
        return '有効なメールアドレスを入力してください';
      }
      return null;
    } on Exception catch (e, st) {
      logger.e('validateEmail: error=$e, stackTrace=$st', time: DateTime.now());
      rethrow;
    }
  }

  /// パスワードのバリデーションを行う
  ///
  /// 引数:
  ///   value: バリデーション対象のパスワード
  ///
  /// 戻り値:
  ///   バリデーションエラーメッセージ (エラーがある場合)
  ///   null (エラーがない場合)
  static String? validatePassword(String? value) {
    logger.d('validatePassword: value=$value', time: DateTime.now());
    try {
      if (value == null || value.isEmpty) {
        return 'パスワードを入力してください';
      } else if (!RegExp(r'^[a-zA-Z0-9]{6,}$').hasMatch(value)) {
        return 'パスワードは6文字以上の英数字である必要があります';
      }
      return null;
    } on Exception catch (e, st) {
      logger.e(
        'validatePassword: error=$e, stackTrace=$st',
        time: DateTime.now(),
      );
      rethrow;
    }
  }
}
