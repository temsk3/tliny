import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/exception/app_exception.dart';
import '../../utils/logger.dart';
import 'loading_screen.dart';

/// 統一されたエラーハンドリング機能を提供するユーティリティクラス
class ErrorHandler {
  /// エラーメッセージを取得（AppExceptionの場合はuserMessageを優先）
  static String getErrorMessage(Object error) {
    if (error is AppException) {
      return error.userMessage;
    }

    // Functionsエラーの場合の専用処理
    final errorString = error.toString();

    // 在庫不足エラー
    if (errorString.contains('less stock than the quantity')) {
      return '商品の在庫が不足しています。数量を調整してから再度お試しください。';
    }

    // ネットワークエラー
    if (errorString.contains('network') || errorString.contains('connection')) {
      return 'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試しください。';
    }

    // 認証エラー
    if (errorString.contains('auth') || errorString.contains('unauthorized')) {
      return '認証エラーが発生しました。再度ログインしてください。';
    }

    // 決済エラー
    if (errorString.contains('payment') || errorString.contains('stripe')) {
      return '決済処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。';
    }

    // サーバーエラー
    if (errorString.contains('server') || errorString.contains('500')) {
      return 'サーバーエラーが発生しました。しばらく時間をおいてから再度お試しください。';
    }

    // タイムアウトエラー
    if (errorString.contains('timeout')) {
      return '処理がタイムアウトしました。しばらく時間をおいてから再度お試しください。';
    }

    // 画像関連エラー
    if (errorString.contains('ImageCodecException') ||
        errorString.contains('Failed to decode image') ||
        errorString.contains('InvalidStateError') ||
        errorString.contains('track metadata')) {
      return '画像の読み込みに失敗しました。別の画像をお試しください。';
    }

    // ファイル形式エラー
    if (errorString.contains('heic') || errorString.contains('HEIC')) {
      return 'HEIC形式の画像は現在サポートされていません。JPEGまたはPNG形式の画像をお試しください。';
    }

    // その他のエラー
    return 'エラーが発生しました。しばらく時間をおいてから再度お試しください。';
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
  static void showErrorSnackBar(BuildContext context, Object error) {
    final message = getErrorMessage(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: '閉じる',
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
    Object error, {
    String? title,
    VoidCallback? onRetry,
  }) async {
    final message = getErrorMessage(error);

    return showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title ?? 'エラー'),
            content: Text(message),
            actions: [
              if (onRetry != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onRetry();
                  },
                  child: const Text('再試行'),
                ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('閉じる'),
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
      ErrorHandler.showErrorSnackBar(context, e);
      return null;
    } on Exception catch (e, st) {
      if (showLoading) {
        loadingController.stopLoading();
      }

      ErrorHandler.logError(e, st, context: errorContext);
      ErrorHandler.showErrorDialog(
        context,
        e,
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
  void handleError(BuildContext context, {String? errorContext}) {
    whenOrNull(
      error: (error, stackTrace) {
        ErrorHandler.logError(error, stackTrace, context: errorContext);
        ErrorHandler.showErrorSnackBar(context, error);
      },
    );
  }

  /// エラーが発生した場合のダイアログ表示
  void handleErrorWithDialog(
    BuildContext context, {
    String? errorContext,
    String? title,
    VoidCallback? onRetry,
  }) {
    whenOrNull(
      error: (error, stackTrace) {
        ErrorHandler.logError(error, stackTrace, context: errorContext);
        ErrorHandler.showErrorDialog(
          context,
          error,
          title: title ?? errorContext ?? 'エラー',
          onRetry: onRetry,
        );
      },
    );
  }
}
