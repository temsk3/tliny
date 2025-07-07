import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../cart/cart_view_model.dart';
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

          // カートの状態を強制的に再読み込み
          logger.d('CheckoutCancelPage: カートの状態を再読み込みします', time: DateTime.now());

          // CartViewModelの状態を無効化して再読み込み
          ref.invalidate(cartViewModelProvider);

          // 少し待ってからカートを再読み込み
          await Future.delayed(const Duration(milliseconds: 500));

          // カートを明示的に再読み込み
          await ref.read(cartViewModelProvider.notifier).readCart();

          logger.d('CheckoutCancelPage: カートの状態再読み込み完了', time: DateTime.now());
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
          // 成功・失敗に関わらず2秒後にカート画面へ遷移
          if (context.mounted) {
            Future.delayed(const Duration(seconds: 2), () {
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

    // フルスクリーンダイアログを表示
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.processingInterrupted,
                        style: Theme.of(
                          context,
                        ).textTheme.displayLarge?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'カート画面に戻ります...',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });

    // 空のScaffoldを返す（ダイアログが表示されるため）
    return const Scaffold(body: SizedBox.shrink());
  }
}
