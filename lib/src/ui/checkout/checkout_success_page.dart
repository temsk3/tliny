import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/settings/routes/routes.dart';

import '../../settings/hooks/use_l10n.dart';
import '../common/main_body.dart';

/// チェックアウト成功画面
class CheckoutSuccessPage extends HookConsumerWidget {
  const CheckoutSuccessPage({super.key, required this.sessionId});

  /// チェックアウトセッションID
  final String? sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();

    // ローカリゼーションを取得
    final l10n = useL10n();

    return Scaffold(
      body: MainBodyWidget(
        width: 400,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 購入完了メッセージを表示
              Text(
                l10n.thankYouForYourPurchase,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 32),
              // ホーム画面へ戻るボタンを表示
              ElevatedButton(
                onPressed:
                    () =>
                    // appRoute.replace(const HomeRoute()),
                    context.go(AppRoutes.topPage),
                child: Text(l10n.backButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
