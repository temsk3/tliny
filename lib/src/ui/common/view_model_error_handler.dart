import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/exception/app_exception.dart';
import '../../utils/logger.dart';
import 'error_handler.dart';
import 'loading_screen.dart';

/// ViewModel層でのエラーハンドリングを統一するためのユーティリティクラス
class ViewModelErrorHandler {
  /// 非同期処理のエラーハンドリング
  static Future<T?> handleAsyncOperation<T>(
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

      logger.e(
        'ViewModelErrorHandler.handleAsyncOperation AppException - context: $errorContext',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );

      ErrorHandler.showError(
        context,
        e,
        l10n,
        errorContext: errorContext,
        onRetry: onRetry,
      );
      return null;
    } on Exception catch (e, st) {
      if (showLoading) {
        loadingController.stopLoading();
      }

      logger.e(
        'ViewModelErrorHandler.handleAsyncOperation Exception - context: $errorContext',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );

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

  /// AsyncValueのエラーハンドリング
  static void handleAsyncValueError(
    BuildContext context,
    AsyncValue<dynamic> asyncValue, {
    String? errorContext,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    asyncValue.whenOrNull(
      error: (error, stackTrace) {
        logger.e(
          'ViewModelErrorHandler.handleAsyncValueError - context: $errorContext',
          time: DateTime.now(),
          error: error,
          stackTrace: stackTrace,
        );

        ErrorHandler.showError(
          context,
          error,
          l10n,
          errorContext: errorContext,
          onRetry: onRetry,
        );
      },
    );
  }

  /// AsyncValueのエラーをダイアログで表示
  static void handleAsyncValueErrorWithDialog(
    BuildContext context,
    AsyncValue<dynamic> asyncValue, {
    String? errorContext,
    String? title,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    asyncValue.whenOrNull(
      error: (error, stackTrace) {
        logger.e(
          'ViewModelErrorHandler.handleAsyncValueErrorWithDialog - context: $errorContext',
          time: DateTime.now(),
          error: error,
          stackTrace: stackTrace,
        );

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

  /// エラーをログに記録してUIに表示
  static void logAndShowError(
    BuildContext context,
    Object error,
    StackTrace? stackTrace, {
    String? errorContext,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    logger.e(
      'ViewModelErrorHandler.logAndShowError - context: $errorContext',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );

    ErrorHandler.showError(
      context,
      error,
      l10n,
      errorContext: errorContext,
      onRetry: onRetry,
    );
  }

  /// エラーをログに記録してダイアログで表示
  static void logAndShowErrorDialog(
    BuildContext context,
    Object error,
    StackTrace? stackTrace, {
    String? errorContext,
    String? title,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    logger.e(
      'ViewModelErrorHandler.logAndShowErrorDialog - context: $errorContext',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );

    ErrorHandler.showErrorDialog(
      context,
      error,
      l10n,
      title: title ?? errorContext ?? 'エラー',
      onRetry: onRetry,
    );
  }
}

/// ViewModel層でのエラーハンドリング用のミックスイン
mixin ViewModelErrorHandlingMixin {
  /// 非同期処理のエラーハンドリング
  Future<T?> executeWithErrorHandling<T>(
    BuildContext context,
    Future<T> Function() operation, {
    String? errorContext,
    VoidCallback? onRetry,
    bool showLoading = true,
    required AppLocalizations l10n,
  }) {
    return ViewModelErrorHandler.handleAsyncOperation(
      context,
      operation,
      errorContext: errorContext,
      onRetry: onRetry,
      showLoading: showLoading,
      l10n: l10n,
    );
  }

  /// AsyncValueのエラーハンドリング
  void handleAsyncValueError(
    BuildContext context,
    AsyncValue<dynamic> asyncValue, {
    String? errorContext,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    ViewModelErrorHandler.handleAsyncValueError(
      context,
      asyncValue,
      errorContext: errorContext,
      onRetry: onRetry,
      l10n: l10n,
    );
  }

  /// エラーをログに記録してUIに表示
  void logAndShowError(
    BuildContext context,
    Object error,
    StackTrace? stackTrace, {
    String? errorContext,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    ViewModelErrorHandler.logAndShowError(
      context,
      error,
      stackTrace,
      errorContext: errorContext,
      onRetry: onRetry,
      l10n: l10n,
    );
  }
}

/// AsyncValueのエラーハンドリング拡張
extension AsyncValueErrorHandlingExtension<T> on AsyncValue<T> {
  /// エラーが発生した場合の処理
  void handleError(
    BuildContext context, {
    String? errorContext,
    VoidCallback? onRetry,
    required AppLocalizations l10n,
  }) {
    ViewModelErrorHandler.handleAsyncValueError(
      context,
      this,
      errorContext: errorContext,
      onRetry: onRetry,
      l10n: l10n,
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
    ViewModelErrorHandler.handleAsyncValueErrorWithDialog(
      context,
      this,
      errorContext: errorContext,
      title: title,
      onRetry: onRetry,
      l10n: l10n,
    );
  }
}
