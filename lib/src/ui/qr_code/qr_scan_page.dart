import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/settings/routes/app_route.gr.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import 'widget/qr_scanner_widget.dart';

String password = dotenv.get('QR_PASSWORD');

final qrContentsProvider = StateProvider<dynamic>((ref) {
  return '[k22i7OYNp1S9O0AtxB15, huQmPBzJg7FzyDHR4Kmg]';
});

@RoutePage()
class QRScanPage extends HookConsumerWidget {
  const QRScanPage({
    super.key,
    // required this.eventName,
  });
  // final String eventName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    final isScaned = useState(true);

    final size = appMediaQuery.size;
    final shortestSide = size.shortestSide;

    return Scaffold(
      appBar: AppBar(title: const Text('QRコード読み取り')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                //flagをfalseにして、読み取ったときの処理がストップしないようにする
                isScaned.value = false;
              },
              child: const Text('読み取り開始'),
            ),
            !isScaned.value
                // !isScaned.
                ? Padding(
                    padding: EdgeInsets.all(shortestSide * 0.05),
                    child: SizedBox(
                      width: shortestSide * 0.6,
                      height: shortestSide * 0.6,
                      child: BarcodeScannerWidget(
                        (String code) async {
                          if (isScaned.value) {
                            //ストップを掛けなければ永遠にカメラが止まらず、スキャンしてしまう。
                            //1度スキャンしたらflagをtrueにしてflagがtrueの場合は処理をストップする
                            return;
                          }
                          isScaned.value = true;
                          final contents = code.split('-');
                          final eventId = contents[0];
                          if (contents.length <= 2 || contents[2] != password) {
                            //パスワードや、urlのバリデーションを設定することで、
                            //別のQRコードを読み取ったときにエラーページに行くようにする
                            await Navigator.of(context)
                                .pushNamed('/error', arguments: '無効なQRコードです');
                          }
                          ref.read(qrContentsProvider.notifier).state =
                              json.decode(code);
                          await appRoute.push(QRDetailRoute(eventId: eventId));
                        },
                      ),
                    ),
                  )
                : const Text('読み取り開始ボタンを押して下さい')
          ],
        ),
      ),
    );
  }
}
