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

/// Cloud Functions関連のエラー
class CloudFunctionsException extends AppException {
  const CloudFunctionsException({
    required super.message,
    super.code,
    this.details,
    super.stackTrace,
  });

  /// エラーの詳細情報
  final Map<String, dynamic>? details;

  /// ファンクション側のエラーコードを取得
  String? get functionCode => details?['code'] as String?;

  /// ファンクション側のエラーメッセージを取得
  String? get functionMessage => details?['message'] as String?;

  /// ファンクション側のエラー詳細を取得
  Map<String, dynamic>? get functionDetails {
    if (details == null) return null;

    try {
      final detailsData = details!['details'];
      if (detailsData is Map<String, dynamic>) {
        return detailsData;
      } else if (detailsData is Map) {
        // LinkedMap<Object?, Object?>の場合の安全な変換
        final rawDetails = detailsData;
        final safeDetails = <String, dynamic>{};
        for (final entry in rawDetails.entries) {
          if (entry.key is String) {
            safeDetails[entry.key as String] = entry.value;
          }
        }
        return safeDetails;
      }
    } catch (e) {
      // キャストに失敗した場合はnullを返す
    }
    return null;
  }

  @override
  String get userMessage {
    // ファンクション側から詳細なエラーメッセージが提供されている場合はそれを使用
    if (functionMessage != null && functionMessage!.isNotEmpty) {
      return functionMessage!;
    }
    return message;
  }
}

/// その他の一般的なエラー
class GeneralException extends AppException {
  const GeneralException({
    required super.message,
    super.code,
    super.stackTrace,
  });
}
