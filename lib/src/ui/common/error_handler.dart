import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/exception/app_exception.dart';
import '../../utils/logger.dart';
import 'loading_screen.dart';

/// エラーの重要度レベル
enum ErrorSeverity {
  /// 軽微なエラー（スナックバーで表示）
  minor,

  /// 重要なエラー（ダイアログで表示）
  major,

  /// 致命的なエラー（ダイアログで表示、リトライ可能）
  critical,
}

/// エラーの種類
enum ErrorType {
  /// ネットワークエラー
  network,

  /// 認証エラー
  authentication,

  /// バリデーションエラー
  validation,

  /// 権限エラー
  permission,

  /// データベースエラー
  database,

  /// 決済エラー
  payment,

  /// 在庫不足エラー
  insufficientStock,

  /// 画像関連エラー
  image,

  /// ファイル形式エラー
  fileFormat,

  /// サーバーエラー
  server,

  /// タイムアウトエラー
  timeout,

  /// Cloud Functionsエラー
  cloudFunctions,

  /// その他のエラー
  general,
}

/// 統一されたエラーハンドリング機能を提供するユーティリティクラス
class ErrorHandler {
  /// エラーの種類を判定
  static ErrorType _getErrorType(Object error) {
    final errorString = error.toString().toLowerCase();

    // FirebaseFunctionsExceptionの処理
    if (error is FirebaseFunctionsException) {
      return ErrorType.cloudFunctions;
    }

    if (error is AppException) {
      if (error is NetworkException) return ErrorType.network;
      if (error is AuthenticationException) return ErrorType.authentication;
      if (error is ValidationException) return ErrorType.validation;
      if (error is PermissionException) return ErrorType.permission;
      if (error is DatabaseException) return ErrorType.database;
      if (error is PaymentException) return ErrorType.payment;
      if (error is CloudFunctionsException) return ErrorType.cloudFunctions;
    }

    // 文字列ベースの判定
    if (errorString.contains('less stock than the quantity') ||
        errorString.contains('insufficient stock')) {
      return ErrorType.insufficientStock;
    }

    if (errorString.contains('network') || errorString.contains('connection')) {
      return ErrorType.network;
    }

    if (errorString.contains('auth') || errorString.contains('unauthorized')) {
      return ErrorType.authentication;
    }

    if (errorString.contains('payment') || errorString.contains('stripe')) {
      return ErrorType.payment;
    }

    if (errorString.contains('server') || errorString.contains('500')) {
      return ErrorType.server;
    }

    if (errorString.contains('timeout')) {
      return ErrorType.timeout;
    }

    if (errorString.contains('imagecodecexception') ||
        errorString.contains('failed to decode image') ||
        errorString.contains('invalidstateerror') ||
        errorString.contains('track metadata')) {
      return ErrorType.image;
    }

    if (errorString.contains('heic') || errorString.contains('heic')) {
      return ErrorType.fileFormat;
    }

    return ErrorType.general;
  }

  /// エラーの重要度を判定
  static ErrorSeverity _getErrorSeverity(ErrorType errorType) {
    switch (errorType) {
      case ErrorType.network:
      case ErrorType.timeout:
      case ErrorType.image:
      case ErrorType.fileFormat:
      case ErrorType.validation:
      case ErrorType.authentication:
        return ErrorSeverity.minor;
      case ErrorType.permission:
      case ErrorType.insufficientStock:
        return ErrorSeverity.major;
      case ErrorType.database:
      case ErrorType.payment:
      case ErrorType.server:
      case ErrorType.cloudFunctions:
      case ErrorType.general:
        return ErrorSeverity.critical;
    }
  }

  /// エラーメッセージを取得（AppExceptionの場合はuserMessageを優先）
  static String getErrorMessage(Object error, AppLocalizations l10n) {
    // FirebaseFunctionsExceptionの処理
    if (error is FirebaseFunctionsException) {
      return _getFirebaseFunctionsErrorMessage(error, l10n);
    }

    if (error is AppException) {
      return error.userMessage;
    }

    final errorType = _getErrorType(error);

    switch (errorType) {
      case ErrorType.insufficientStock:
        return l10n.insufficientStock;
      case ErrorType.network:
        return l10n.networkError;
      case ErrorType.authentication:
        return l10n.authenticationError;
      case ErrorType.payment:
        return l10n.paymentError;
      case ErrorType.server:
        return l10n.serverError;
      case ErrorType.timeout:
        return l10n.timeoutError;
      case ErrorType.image:
        return l10n.imageLoadError;
      case ErrorType.fileFormat:
        return l10n.heicNotSupported;
      case ErrorType.validation:
        return l10n.validationError;
      case ErrorType.permission:
        return l10n.permissionError;
      case ErrorType.database:
        return l10n.databaseError;
      case ErrorType.cloudFunctions:
        return 'サーバー処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。';
      case ErrorType.general:
        return l10n.generalError;
    }
  }

  /// FirebaseFunctionsExceptionのエラーメッセージを取得
  static String _getFirebaseFunctionsErrorMessage(
    FirebaseFunctionsException error,
    AppLocalizations l10n,
  ) {
    // エラーコードに基づいてメッセージを決定
    switch (error.code) {
      case 'unauthenticated':
        return '認証が必要です。再度ログインしてください。';
      case 'permission-denied':
        return 'この操作を実行する権限がありません。';
      case 'not-found':
        return 'リクエストされたリソースが見つかりません。';
      case 'already-exists':
        return '既に存在するリソースです。';
      case 'resource-exhausted':
        return 'リソースが不足しています。しばらく時間をおいてから再度お試しください。';
      case 'cancelled':
        return '操作がキャンセルされました。';
      case 'internal':
        return 'サーバー内部エラーが発生しました。しばらく時間をおいてから再度お試しください。';
      case 'unimplemented':
        return 'この機能は現在利用できません。';
      case 'unavailable':
        return 'サービスが一時的に利用できません。しばらく時間をおいてから再度お試しください。';
      case 'deadline-exceeded':
        return 'リクエストがタイムアウトしました。しばらく時間をおいてから再度お試しください。';
      case 'invalid-argument':
        return '無効なリクエストです。入力内容を確認してください。';
      default:
        // エラーデータから詳細メッセージを取得
        final details = error.details;
        if (details != null) {
          try {
            Map<String, dynamic>? safeDetails;
            if (details is Map<String, dynamic>) {
              safeDetails = details;
            } else if (details is Map) {
              // LinkedMap<Object?, Object?>の場合の安全な変換
              final rawDetails = details;
              safeDetails = <String, dynamic>{};
              for (final entry in rawDetails.entries) {
                if (entry.key is String) {
                  safeDetails[entry.key as String] = entry.value;
                }
              }
            }

            if (safeDetails != null) {
              final message = safeDetails['message'] as String?;
              if (message != null && message.isNotEmpty) {
                return message;
              }
            }
          } catch (e) {
            // キャストに失敗した場合はデフォルトメッセージを使用
          }
        }
        return 'サーバー処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。';
    }
  }

  /// エラータイトルを取得
  static String getErrorTitle(ErrorType errorType, AppLocalizations l10n) {
    switch (errorType) {
      case ErrorType.insufficientStock:
        return l10n.insufficientStockTitle;
      case ErrorType.payment:
        return l10n.paymentErrorTitle;
      case ErrorType.network:
        return 'ネットワークエラー';
      case ErrorType.authentication:
        return '認証エラー';
      case ErrorType.validation:
        return '入力エラー';
      case ErrorType.permission:
        return '権限エラー';
      case ErrorType.database:
        return 'データベースエラー';
      case ErrorType.server:
        return 'サーバーエラー';
      case ErrorType.timeout:
        return 'タイムアウトエラー';
      case ErrorType.image:
        return '画像エラー';
      case ErrorType.fileFormat:
        return 'ファイル形式エラー';
      case ErrorType.cloudFunctions:
        return 'サーバーエラー';
      case ErrorType.general:
        return 'エラー';
    }
  }

  /// エラーをログに記録
  static void logError(
    Object error,
    StackTrace? stackTrace, {
    String? context,
  }) {
    final errorType = _getErrorType(error);
    final severity = _getErrorSeverity(errorType);

    // FirebaseFunctionsExceptionの詳細ログ
    if (error is FirebaseFunctionsException) {
      logger.e(
        'ErrorHandler: ${context ?? 'FirebaseFunctionsException'} - Type: $errorType, Severity: $severity, Code: ${error.code}, Details: ${error.details}',
        time: DateTime.now(),
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      logger.e(
        'ErrorHandler: ${context ?? 'Unknown error'} - Type: $errorType, Severity: $severity',
        time: DateTime.now(),
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// エラーを適切な方法で表示
  static void showError(
    BuildContext context,
    Object error,
    AppLocalizations l10n, {
    String? errorContext,
    VoidCallback? onRetry,
  }) {
    final errorType = _getErrorType(error);
    final severity = _getErrorSeverity(errorType);

    logError(error, null, context: errorContext);

    switch (severity) {
      case ErrorSeverity.minor:
        showErrorSnackBar(context, error, l10n);
      case ErrorSeverity.major:
      case ErrorSeverity.critical:
        showErrorDialog(
          context,
          error,
          l10n,
          title: getErrorTitle(errorType, l10n),
          onRetry: onRetry,
        );
    }
  }

  /// エラーをスナックバーで表示
  static void showErrorSnackBar(
    BuildContext context,
    Object error,
    AppLocalizations l10n,
  ) {
    final message = getErrorMessage(error, l10n);
    final errorType = _getErrorType(error);

    Color backgroundColor;
    IconData icon;

    switch (errorType) {
      case ErrorType.network:
      case ErrorType.timeout:
        backgroundColor = Colors.orange;
        icon = Icons.wifi_off;
      case ErrorType.validation:
        backgroundColor = Colors.blue;
        icon = Icons.info;
      case ErrorType.authentication:
        backgroundColor = Colors.red;
        icon = Icons.lock;
      case ErrorType.image:
      case ErrorType.fileFormat:
        backgroundColor = Colors.orange;
        icon = Icons.image_not_supported;
      case ErrorType.cloudFunctions:
        backgroundColor = Colors.red;
        icon = Icons.cloud_off;
      default:
        backgroundColor = Theme.of(context).colorScheme.error;
        icon = Icons.error;
    }

    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: l10n.close,
          textColor: Colors.white,
          onPressed: () {
            if (context.mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// エラーをダイアログで表示
  static Future<void> showErrorDialog(
    BuildContext context,
    Object error,
    AppLocalizations l10n, {
    String? title,
    VoidCallback? onRetry,
  }) async {
    final message = getErrorMessage(error, l10n);
    final errorType = _getErrorType(error);
    final severity = _getErrorSeverity(errorType);

    IconData icon;
    Color iconColor;

    switch (errorType) {
      case ErrorType.authentication:
        icon = Icons.lock;
        iconColor = Colors.orange;
      case ErrorType.permission:
        icon = Icons.block;
        iconColor = Colors.red;
      case ErrorType.payment:
        icon = Icons.payment;
        iconColor = Colors.red;
      case ErrorType.insufficientStock:
        icon = Icons.inventory;
        iconColor = Colors.orange;
      case ErrorType.database:
      case ErrorType.server:
      case ErrorType.cloudFunctions:
        icon = Icons.error;
        iconColor = Colors.red;
      default:
        icon = Icons.error;
        iconColor = Colors.red;
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 8),
                Expanded(child: Text(title ?? getErrorTitle(errorType, l10n))),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message),
                if (severity == ErrorSeverity.critical) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'このエラーが繰り返し発生する場合は、アプリを再起動するか、しばらく時間をおいてから再度お試しください。',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
                // FirebaseFunctionsExceptionの場合は詳細情報を表示
                if (error is FirebaseFunctionsException) ...[
                  const SizedBox(height: 16),
                  const Text(
                    '詳細情報:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'エラーコード: ${error.code}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  if (error.details != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'エラー詳細: ${error.details}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ],
              ],
            ),
            actions: [
              if (onRetry != null)
                TextButton(
                  onPressed: () {
                    if (context.mounted) Navigator.of(context).pop();
                    onRetry();
                  },
                  child: Text(l10n.retry),
                ),
              TextButton(
                onPressed: () {
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: Text(l10n.close),
              ),
            ],
          ),
    );
  }

  /// 成功メッセージをスナックバーで表示
  static Future<SnackBarClosedReason> showSuccessSnackBar(
    BuildContext context,
    String message,
  ) {
    if (!context.mounted) return Future.value(SnackBarClosedReason.remove);
    final controller = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
    return controller.closed;
  }

  /// 情報メッセージをスナックバーで表示
  static void showInfoSnackBar(BuildContext context, String message) {
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 警告メッセージをスナックバーで表示
  static void showWarningSnackBar(BuildContext context, String message) {
    if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// エラーハンドリング付きの非同期処理を実行するミックスイン
mixin ErrorHandlingMixin {
  /// エラーハンドリング付きで非同期処理を実行
  Future<T?> executeWithErrorHandling<T>(
    BuildContext context,
    Future<T> Function() operation, {
    String? errorContext,
    VoidCallback? onRetry,
    bool showLoading = true,
    required AppLocalizations l10n,
  }) async {
    final loadingController = GlobalLoadingController();

    try {
      if (showLoading) {
        loadingController.startLoading();
      }

      final result = await operation();

      if (showLoading) {
        loadingController.stopLoading();
      }

      return result;
    } on AppException catch (e) {
      if (showLoading) {
        loadingController.stopLoading();
      }

      ErrorHandler.showError(
        context,
        e,
        l10n,
        errorContext: errorContext,
        onRetry: onRetry,
      );
      return null;
    } on Exception catch (e) {
      if (showLoading) {
        loadingController.stopLoading();
      }

      ErrorHandler.showError(
        context,
        e,
        l10n,
        errorContext: errorContext,
        onRetry: onRetry,
      );
      return null;
    }
  }
}

/// エラーハンドリング付きのプロバイダー拡張
extension ErrorHandlingProviderExtension<T> on AsyncValue<T> {
  /// エラーが発生した場合の処理
  void handleError(
    BuildContext context, {
    String? errorContext,
    required AppLocalizations l10n,
  }) {
    whenOrNull(
      error: (error, stackTrace) {
        ErrorHandler.showError(
          context,
          error,
          l10n,
          errorContext: errorContext,
        );
      },
    );
  }

  /// エラーが発生した場合のダイアログ表示
  void handleErrorWithDialog(
    BuildContext context, {
    String? errorContext,
    String? title,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    whenOrNull(
      error: (error, stackTrace) {
        ErrorHandler.showErrorDialog(
          context,
          error,
          l10n,
          title: title ?? errorContext ?? 'エラー',
          onRetry: onRetry,
        );
      },
    );
  }
}

/// エラー表示用のウィジェット
class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget({
    super.key,
    required this.error,
    required this.l10n,
    this.onRetry,
    this.showRetryButton = true,
  });

  final Object error;
  final AppLocalizations l10n;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  @override
  Widget build(BuildContext context) {
    final errorType = ErrorHandler._getErrorType(error);
    final message = ErrorHandler.getErrorMessage(error, l10n);

    IconData icon;
    Color iconColor;

    switch (errorType) {
      case ErrorType.network:
        icon = Icons.wifi_off;
        iconColor = Colors.orange;
      case ErrorType.authentication:
        icon = Icons.lock;
        iconColor = Colors.orange;
      case ErrorType.payment:
        icon = Icons.payment;
        iconColor = Colors.red;
      case ErrorType.insufficientStock:
        icon = Icons.inventory;
        iconColor = Colors.orange;
      default:
        icon = Icons.error;
        iconColor = Colors.red;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: iconColor),
            const SizedBox(height: 16),
            Text(
              ErrorHandler.getErrorTitle(errorType, l10n),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: iconColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// ErrorHandlerのカスタムフック
/// React Hooks風のAPIでErrorHandlerを使用できるようにする
ErrorHandlerController useErrorHandler() {
  final context = useContext();
  return ErrorHandlerController(context: context);
}

/// ErrorHandlerのコントローラークラス
/// 直感的なメソッド名でエラーハンドリングを提供
class ErrorHandlerController {
  ErrorHandlerController({required this.context});
  final BuildContext context;

  /// エラーを適切な方法で表示
  void showError(Object error, {String? errorContext, VoidCallback? onRetry}) {
    final l10n = AppLocalizations.of(context)!;
    ErrorHandler.showError(
      context,
      error,
      l10n,
      errorContext: errorContext,
      onRetry: onRetry,
    );
  }

  /// エラーをスナックバーで表示
  void showErrorSnackBar(Object error) {
    final l10n = AppLocalizations.of(context)!;
    ErrorHandler.showErrorSnackBar(context, error, l10n);
  }

  /// エラーをダイアログで表示
  void showErrorDialog(Object error, {String? title, VoidCallback? onRetry}) {
    final l10n = AppLocalizations.of(context)!;
    ErrorHandler.showErrorDialog(
      context,
      error,
      l10n,
      title: title,
      onRetry: onRetry,
    );
  }

  /// 成功メッセージをスナックバーで表示
  void showSuccessSnackBar(String message) {
    ErrorHandler.showSuccessSnackBar(context, message);
  }

  /// 警告メッセージをスナックバーで表示
  void showWarningSnackBar(String message) {
    ErrorHandler.showWarningSnackBar(context, message);
  }

  /// 情報メッセージをスナックバーで表示
  void showInfoSnackBar(String message) {
    ErrorHandler.showInfoSnackBar(context, message);
  }

  /// 非同期処理をエラーハンドリング付きで実行
  Future<T?> executeWithErrorHandling<T>(
    Future<T> Function() operation, {
    String? errorContext,
    VoidCallback? onRetry,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final loadingController = GlobalLoadingController();

    try {
      loadingController.startLoading();
      final result = await operation();
      loadingController.stopLoading();
      return result;
    } on AppException catch (e) {
      loadingController.stopLoading();
      ErrorHandler.showError(
        context,
        e,
        l10n,
        errorContext: errorContext,
        onRetry: onRetry,
      );
      return null;
    } on Exception catch (e) {
      loadingController.stopLoading();
      ErrorHandler.showError(
        context,
        e,
        l10n,
        errorContext: errorContext,
        onRetry: onRetry,
      );
      return null;
    }
  }
}
