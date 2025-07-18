import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/exception/app_exception.dart';
import '../../utils/logger.dart';
import 'error_handler.dart';
import 'error_screen.dart';

/// 非同期処理の結果に応じて異なるWidgetを表示するWidget
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});

  /// 非同期処理の結果
  final AsyncValue<T> value;

  /// データが取得できた場合に表示するWidget
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      // データが取得できた場合
      data: data,
      // 処理中の場合
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      // エラーが発生した場合
      error: (error, stackTrace) {
        logger.e(
          'AsyncValueWidget: error=$error, stackTrace=$stackTrace',
          time: DateTime.now(),
        );

        // ErrorHandlerでエラーを表示
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            final l10n = AppLocalizations.of(context);
            if (l10n != null) {
              ErrorHandler.showError(
                context,
                error,
                l10n,
                errorContext: 'AsyncValueWidget',
              );
            }
          }
        });

        return ErrorScreen(e: error, st: stackTrace);
      },
    );
  }
}

/// 非同期処理の結果に応じて異なるWidgetを表示するWidget (ボタン用)
class AsyncValueButtonWidget<T> extends StatelessWidget {
  const AsyncValueButtonWidget({
    super.key,
    required this.value,
    required this.data,
  });

  /// 非同期処理の結果
  final AsyncValue<T> value;

  /// データが取得できた場合に表示するWidget
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      // データが取得できた場合
      data: data,
      // 処理中の場合
      loading: () {
        return const Center(
          child: SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator(),
          ),
        );
      },
      // エラーが発生した場合
      error: (error, stackTrace) {
        logger.e(
          'AsyncValueButtonWidget: error=$error, stackTrace=$stackTrace',
          time: DateTime.now(),
        );

        // nullエラーの場合は空のウィジェットを返す
        if (error.toString().contains('Unexpected null value') ||
            error.toString().contains('null')) {
          return const SizedBox.shrink();
        }

        // ErrorHandlerでエラーを表示
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            final l10n = AppLocalizations.of(context);
            if (l10n != null) {
              ErrorHandler.showError(
                context,
                error,
                l10n,
                errorContext: 'AsyncValueButtonWidget',
              );
            }
          }
        });

        final message =
            error is AppException ? error.userMessage : error.toString();
        return Center(child: Text(message));
      },
    );
  }
}
