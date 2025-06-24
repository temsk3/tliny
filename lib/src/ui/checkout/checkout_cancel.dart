import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import 'checkout_view_model.dart';

/// チェックアウトキャンセル画面
class CheckoutCancelPage extends HookConsumerWidget {
  const CheckoutCancelPage({
    super.key,
    required this.sessionId,
  });

  /// チェックアウトセッションID
  final String? sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();

    // ローカリゼーションを取得
    final l10n = useL10n();
    // ルーターを取得
    // final appRoute = useRouter();

    // チェックアウトセッションIDが null でない場合、キャンセル処理を実行
    if (sessionId != null) {
      logger.d('CheckoutCancelPage: sessionId=$sessionId',
          time: DateTime.now());
      try {
        // チェックアウトキャンセル処理を実行
        ref
            .watch(stripeCheckoutViewModelProvider.notifier)
            .cancelCheckout(sessionId!);
        // ホーム画面へ遷移
        // appRoute.replace(const HomeRoute());
        context.go(AppRoutes.topPage);
      } on Exception catch (e, st) {
        // エラーが発生した場合、エラーログを出力
        logger.e('CheckoutCancelPage: error=$e, stackTrace=$st',
            time: DateTime.now());
        // エラーメッセージを表示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.processingInterrupted),
          ),
        );
      }
    }

    // キャンセル処理中の画面表示
    return Scaffold(
      body: Center(
        child: Text(
          l10n.processingInterrupted,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
