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
  const CheckoutCancelPage({super.key, required this.sessionId});

  /// チェックアウトセッションID
  final String? sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();

    // ローカリゼーションを取得
    final l10n = useL10n();

    // 画面表示後にキャンセル処理と画面遷移を実行
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (sessionId != null) {
        logger.d(
          'CheckoutCancelPage: sessionId=$sessionId',
          time: DateTime.now(),
        );
        try {
          // チェックアウトキャンセル処理を実行（awaitで完了を待つ）
          await ref
              .read(stripeCheckoutViewModelProvider.notifier)
              .cancelCheckout(sessionId!);

          logger.d(
            'CheckoutCancelPage: cancelCheckout completed successfully',
            time: DateTime.now(),
          );
        } on Exception catch (e, st) {
          // エラーが発生した場合、エラーログを出力
          logger.e(
            'CheckoutCancelPage: error=$e, stackTrace=$st',
            time: DateTime.now(),
          );
          // エラーメッセージを表示
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.processingInterrupted)));
          }
        } finally {
          // 成功・失敗に関わらず3秒後にカート画面へ遷移
          if (context.mounted) {
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                context.go(AppRoutes.cartPage);
              }
            });
          }
        }
      } else {
        // sessionIdがnullの場合は即座にカート画面へ遷移
        if (context.mounted) {
          context.go(AppRoutes.cartPage);
        }
      }
    });

    // キャンセル処理中の画面表示（ローディングインジケータは削除）
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.processingInterrupted,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Text('カート画面に戻ります...', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
