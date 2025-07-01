import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../utils/logger.dart';
import 'error_handler.dart';

/// 押下時に処理中の状態を表示する FloatingActionButton
class BaseFloatingActionButton extends HookWidget {
  const BaseFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.heroTag,
  });

  /// 押下時に実行されるコールバック関数
  final VoidCallback onPressed;

  /// ボタンに表示する子Widget
  final Widget child;

  /// Heroアニメーション用のタグ
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    // 処理中の状態を管理する useState
    final waiting = useState(false);
    return FloatingActionButton(
      heroTag: heroTag,
      // 処理中の場合は押下不可にする
      onPressed:
          waiting.value
              ? null
              : () async {
                // 処理開始時に true に設定
                waiting.value = true;
                logger.d(
                  'BaseFloatingActionButton: onPressed',
                  time: DateTime.now(),
                );
                try {
                  // コールバック関数を実行
                  onPressed();
                } on Exception catch (e, st) {
                  // エラーが発生した場合、エラーログを出力
                  logger.e(
                    'BaseFloatingActionButton: error=$e, stackTrace=$st',
                    time: DateTime.now(),
                  );
                  ErrorHandler.showErrorSnackBar(context, e);
                } finally {
                  // 処理終了時に false に設定
                  waiting.value = false;
                }
              },
      child: child,
    );
  }
}

/// 押下時に処理中の状態を表示する IconButton
class BaseIconButton extends HookWidget {
  const BaseIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
  });

  /// 押下時に実行されるコールバック関数
  final VoidCallback onPressed;

  /// ボタンに表示するアイコン
  final Icon icon;

  /// ツールチップのテキスト
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    // 処理中の状態を管理する useState
    final waiting = useState(false);
    return IconButton(
      icon: icon,
      tooltip: tooltip,
      // 処理中の場合は押下不可にする
      onPressed:
          waiting.value
              ? null
              : () async {
                // 処理開始時に true に設定
                waiting.value = true;
                logger.d('BaseIconButton: onPressed', time: DateTime.now());
                try {
                  // コールバック関数を実行
                  onPressed();
                } on Exception catch (e, st) {
                  // エラーが発生した場合、エラーログを出力
                  logger.e(
                    'BaseIconButton: error=$e, stackTrace=$st',
                    time: DateTime.now(),
                  );
                  ErrorHandler.showErrorSnackBar(context, e);
                } finally {
                  // 処理終了時に false に設定
                  waiting.value = false;
                }
              },
    );
  }
}

/// 押下時に処理中の状態を表示する ElevatedButton
class BaseElevatedButton extends HookWidget {
  const BaseElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  /// 押下時に実行されるコールバック関数
  final VoidCallback? onPressed;

  /// ボタンに表示する子Widget
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // 処理中の状態を管理する useState
    final waiting = useState(false);
    return ElevatedButton(
      // 処理中の場合は押下不可にする
      onPressed:
          waiting.value || onPressed == null
              ? null
              : () async {
                // 処理開始時に true に設定
                waiting.value = true;
                logger.d('BaseElevatedButton: onPressed', time: DateTime.now());
                try {
                  // コールバック関数を実行
                  onPressed!();
                } on Exception catch (e, st) {
                  // エラーが発生した場合、エラーログを出力
                  logger.e(
                    'BaseElevatedButton: error=$e, stackTrace=$st',
                    time: DateTime.now(),
                  );
                  ErrorHandler.showErrorSnackBar(context, e);
                } finally {
                  // 処理終了時に false に設定
                  waiting.value = false;
                }
              },
      child: child,
    );
  }
}
