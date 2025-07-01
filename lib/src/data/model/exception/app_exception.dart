/// アプリケーション全体で使用する統一的な例外クラス
abstract class AppException implements Exception {
  const AppException({required this.message, this.code, this.stackTrace});

  /// エラーメッセージ
  final String message;

  /// エラーコード
  final String? code;

  /// スタックトレース
  final StackTrace? stackTrace;

  /// ユーザーフレンドリーなエラーメッセージを取得
  String get userMessage => message;

  @override
  String toString() => userMessage;
}

/// ネットワーク関連のエラー
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// 認証関連のエラー
class AuthenticationException extends AppException {
  const AuthenticationException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// バリデーション関連のエラー
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    this.field,
    super.stackTrace,
  });

  /// バリデーションエラーが発生したフィールド
  final String? field;
}

/// 権限関連のエラー
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// データベース関連のエラー
class DatabaseException extends AppException {
  const DatabaseException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// 決済関連のエラー
class PaymentException extends AppException {
  const PaymentException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}

/// その他の一般的なエラー
class GeneralException extends AppException {
  const GeneralException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}
