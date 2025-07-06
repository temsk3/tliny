import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      // エラーが発生した場合は何もしない
      // ログは出力しない（頻繁に発生する可能性があるため）
    }
  }

  /// ナビゲーションスタックに何かがあるかを確認する
  static bool canPop(BuildContext context) {
    try {
      return GoRouter.of(context).canPop();
    } on Exception catch (e) {
      return false;
    }
  }
}
