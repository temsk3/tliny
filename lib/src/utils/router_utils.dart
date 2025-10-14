import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'logger.dart';

/// GoRouterの安全なナビゲーション操作を提供するユーティリティクラス
class RouterUtils {
  /// 安全にpop操作を実行する
  /// ナビゲーションスタックに何もない場合は何もしない
  static void safePop(BuildContext context) {
    try {
      if (context.mounted && GoRouter.of(context).canPop()) {
        context.pop();
      }
    } on Exception catch (e) {
      // 開発環境ではログ出力を有効にする
      if (kDebugMode) {
        logger.w(
          'RouterUtils.safePop: Navigation error - $e',
          time: DateTime.now(),
        );
      }
      // エラーが発生した場合は何もしない
    }
  }

  /// ナビゲーションスタックに何かがあるかを確認する
  static bool canPop(BuildContext context) {
    try {
      return GoRouter.of(context).canPop();
    } on Exception catch (e) {
      // 開発環境ではログ出力を有効にする
      if (kDebugMode) {
        logger.w(
          'RouterUtils.canPop: Navigation check error - $e',
          time: DateTime.now(),
        );
      }
      return false;
    }
  }
}
