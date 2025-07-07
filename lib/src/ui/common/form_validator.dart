import '../../../l10n/app_localizations.dart';
import '../../utils/logger.dart';

/// フォームのバリデーションを行うクラス
class FormValidator {
  /// メールアドレスのバリデーションを行う
  ///
  /// 引数:
  ///   value: バリデーション対象のメールアドレス
  ///   l10n: 多言語対応オブジェクト
  ///
  /// 戻り値:
  ///   バリデーションエラーメッセージ (エラーがある場合)
  ///   null (エラーがない場合)
  static String? validateEmail(String? value, AppLocalizations l10n) {
    logger.d('validateEmail: value=$value', time: DateTime.now());
    try {
      if (value == null || value.isEmpty) {
        return l10n.pleaseEnterEmail;
      } else if (!RegExp(
        r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(value)) {
        return l10n.pleaseEnterValidEmail;
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
  ///   l10n: 多言語対応オブジェクト
  ///
  /// 戻り値:
  ///   バリデーションエラーメッセージ (エラーがある場合)
  ///   null (エラーがない場合)
  static String? validatePassword(String? value, AppLocalizations l10n) {
    logger.d('validatePassword: value=$value', time: DateTime.now());
    try {
      if (value == null || value.isEmpty) {
        return l10n.pleaseEnterPassword;
      } else if (!RegExp(r'^[a-zA-Z0-9]{6,}$').hasMatch(value)) {
        return l10n.passwordRequirements;
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
