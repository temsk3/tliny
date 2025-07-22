import 'package:cloud_functions/cloud_functions.dart';

import '../../utils/logger.dart';
import '../model/exception/app_exception.dart';

/// Repository層のベースクラス
/// Cloud Functions呼び出しの共通処理を提供
abstract class BaseRepository {
  /// Cloud Functions を呼び出すためのヘルパー関数
  Future<T?> callFunction<T>(
    String functionName,
    Map<dynamic, dynamic> params, {
    String? context,
  }) async {
    logger.i(
      'BaseRepository.callFunction start - function: $functionName, params: $params',
    );

    try {
      final callable = getFunctions().httpsCallable(functionName);
      final result = await callable.call<T>(params);

      logger.i(
        'BaseRepository.callFunction success - function: $functionName, result: $result',
      );
      return result.data;
    } on FirebaseFunctionsException catch (e, st) {
      logger.e(
        'BaseRepository.callFunction FirebaseFunctionsException - function: $functionName, params: $params',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );

      // FirebaseFunctionsExceptionをAppExceptionに変換
      final appException = _convertFirebaseFunctionsException(
        e,
        context ?? functionName,
      );
      throw appException;
    } on Exception catch (e, st) {
      logger.e(
        'BaseRepository.callFunction Exception - function: $functionName, params: $params',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );

      // 一般的な例外をAppExceptionに変換
      final appException = _convertGeneralException(e, context ?? functionName);
      throw appException;
    }
  }

  /// FirebaseFunctionsExceptionをAppExceptionに変換
  CloudFunctionsException _convertFirebaseFunctionsException(
    FirebaseFunctionsException error,
    String context,
  ) {
    String message;
    String? code;

    // エラーコードに基づいてメッセージを決定
    switch (error.code) {
      case 'unauthenticated':
        message = '認証が必要です。再度ログインしてください。';
        code = 'AUTHENTICATION_REQUIRED';
      case 'permission-denied':
        message = 'この操作を実行する権限がありません。';
        code = 'PERMISSION_DENIED';
      case 'not-found':
        message = 'リクエストされたリソースが見つかりません。';
        code = 'NOT_FOUND';
      case 'already-exists':
        message = '既に存在するリソースです。';
        code = 'ALREADY_EXISTS';
      case 'resource-exhausted':
        message = 'リソースが不足しています。しばらく時間をおいてから再度お試しください。';
        code = 'RESOURCE_EXHAUSTED';
      case 'cancelled':
        message = '操作がキャンセルされました。';
        code = 'CANCELLED';
      case 'internal':
        message = 'サーバー内部エラーが発生しました。しばらく時間をおいてから再度お試しください。';
        code = 'INTERNAL_ERROR';
      case 'unimplemented':
        message = 'この機能は現在利用できません。';
        code = 'UNIMPLEMENTED';
      case 'unavailable':
        message = 'サービスが一時的に利用できません。しばらく時間をおいてから再度お試しください。';
        code = 'UNAVAILABLE';
      case 'deadline-exceeded':
        message = 'リクエストがタイムアウトしました。しばらく時間をおいてから再度お試しください。';
        code = 'DEADLINE_EXCEEDED';
      case 'invalid-argument':
        message = '無効なリクエストです。入力内容を確認してください。';
        code = 'INVALID_ARGUMENT';
      default:
        // エラーデータから詳細メッセージを取得
        final details = error.details;
        if (details != null && details is Map<String, dynamic>) {
          final detailMessage = details['message'] as String?;
          if (detailMessage != null && detailMessage.isNotEmpty) {
            message = detailMessage;
          } else {
            message = 'サーバー処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。';
          }
        } else {
          message = 'サーバー処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。';
        }
        code = error.code;
    }

    return CloudFunctionsException(
      message: message,
      code: code,
      details: error.details as Map<String, dynamic>?,
      stackTrace: StackTrace.current,
    );
  }

  /// 一般的な例外をAppExceptionに変換
  AppException _convertGeneralException(Exception error, String context) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('network') || errorString.contains('connection')) {
      return const NetworkException(
        message: 'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試しください。',
        code: 'NETWORK_ERROR',
      );
    }

    if (errorString.contains('timeout')) {
      return const NetworkException(
        message: 'リクエストがタイムアウトしました。しばらく時間をおいてから再度お試しください。',
        code: 'TIMEOUT_ERROR',
      );
    }

    if (errorString.contains('payment') || errorString.contains('stripe')) {
      return const PaymentException(
        message: '決済処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。',
        code: 'PAYMENT_ERROR',
      );
    }

    return GeneralException(
      message: '予期しないエラーが発生しました。しばらく時間をおいてから再度お試しください。',
      code: 'GENERAL_ERROR',
      stackTrace: StackTrace.current,
    );
  }

  /// Firebase Functionsインスタンスを取得
  FirebaseFunctions getFunctions();
}
