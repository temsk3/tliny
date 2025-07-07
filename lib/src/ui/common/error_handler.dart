import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/exception/app_exception.dart';
import '../../utils/logger.dart';
import 'loading_screen.dart';

/// 統一されたエラーハンドリング機能を提供するユーティリティクラス
class ErrorHandler {
  /// エラーメッセージを取得（AppExceptionの場合はuserMessageを優先）
  static String getErrorMessage(Object error, AppLocalizations l10n) {
    if (error is AppException) {
      return error.userMessage;
    }

    // Functionsエラーの場合の専用処理
    final errorString = error.toString();

    // 在庫不足エラー
    if (errorString.contains('less stock than the quantity')) {
      return l10n.insufficientStock;
    }

    // ネットワークエラー
    if (errorString.contains('network') || errorString.contains('connection')) {
      return l10n.networkError;
    }

    // 認証エラー
    if (errorString.contains('auth') || errorString.contains('unauthorized')) {
      return l10n.authenticationError;
    }

    // 決済エラー
    if (errorString.contains('payment') || errorString.contains('stripe')) {
      return l10n.paymentError;
    }

    // サーバーエラー
    if (errorString.contains('server') || errorString.contains('500')) {
      return l10n.serverError;
    }

    // タイムアウトエラー
    if (errorString.contains('timeout')) {
      return l10n.timeoutError;
    }

    // 画像関連エラー
    if (errorString.contains('ImageCodecException') ||
        errorString.contains('Failed to decode image') ||
        errorString.contains('InvalidStateError') ||
        errorString.contains('track metadata')) {
      return l10n.imageLoadError;
    }

    // ファイル形式エラー
    if (errorString.contains('heic') || errorString.contains('HEIC')) {
      return l10n.heicNotSupported;
    }

    // その他のエラー
    return l10n.generalError;
  }

  /// エラーをログに記録
  static void logError(
    Object error,
    StackTrace? stackTrace, {
    String? context,
  }) {
    logger.e(
      'ErrorHandler: ${context ?? 'Unknown error'}',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// エラーをスナックバーで表示
  static void showErrorSnackBar(
    BuildContext context,
    Object error,
    AppLocalizations l10n,
  ) {
    final message = getErrorMessage(error, l10n);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: l10n.close,
          textColor: Theme.of(context).colorScheme.onError,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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

    return showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title ?? l10n.generalError),
            content: Text(message),
            actions: [
              if (onRetry != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onRetry();
                  },
                  child: Text(l10n.retry),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.close),
              ),
            ],
          ),
    );
  }

  /// 成功メッセージをスナックバーで表示
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 情報メッセージをスナックバーで表示
  static void showInfoSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
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
    } on AppException catch (e, st) {
      if (showLoading) {
        loadingController.stopLoading();
      }

      ErrorHandler.logError(e, st, context: errorContext);
      ErrorHandler.showErrorSnackBar(context, e, l10n);
      return null;
    } on Exception catch (e, st) {
      if (showLoading) {
        loadingController.stopLoading();
      }

      ErrorHandler.logError(e, st, context: errorContext);
      ErrorHandler.showErrorDialog(
        context,
        e,
        l10n,
        title: errorContext ?? 'エラー',
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
        ErrorHandler.logError(error, stackTrace, context: errorContext);
        ErrorHandler.showErrorSnackBar(context, error, l10n);
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
        ErrorHandler.logError(error, stackTrace, context: errorContext);
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
