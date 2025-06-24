import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/logger.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

/// 非同期処理の結果に応じて異なるWidgetを表示するWidget
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
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
    logger.d('AsyncValueWidget: build', time: DateTime.now());
    return value.when(
      // データが取得できた場合
      data: data,
      // 処理中の場合
      loading: () {
        logger.d('AsyncValueWidget: loading', time: DateTime.now());
        return const LoadingScreen();
      },
      // エラーが発生した場合
      error: (error, stackTrace) {
        logger.e('AsyncValueWidget: error=$error, stackTrace=$stackTrace',
            time: DateTime.now());
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
    logger.d('AsyncValueButtonWidget: build', time: DateTime.now());
    return value.when(
      // データが取得できた場合
      data: data,
      // 処理中の場合
      loading: () {
        logger.d('AsyncValueButtonWidget: loading', time: DateTime.now());
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
        logger.e('AsyncValueButtonWidget: error=$error, stackTrace=$stackTrace',
            time: DateTime.now());
        return Center(child: Text(error.toString()));
      },
    );
  }
}
