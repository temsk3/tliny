import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tliny/firebase_options.dart';
import 'package:tliny/src/app.dart';
import 'package:tliny/src/settings/routes/app_router.dart';

class MockL10n {
  String get scanQrCodes => 'Scan QR Codes';
}

T useL10n<T>() {
  return MockL10n() as T;
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('QR Code Scanner Page displays scanned data correctly',
      (WidgetTester tester) async {
    final appRouter = AppRouter(); // AppRouterインスタンスを作成

    await tester.pumpWidget(
      ProviderScope(
        child: MyApp(), // MyAppを使用
      ),
    );

    // 初期状態の確認
    await tester.pumpAndSettle();
    expect(find.text('Scan QR Codes'), findsOneWidget);
    expect(find.byType(MobileScanner), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);

    // 偽のバーコードデータを生成
    const fakeBarcode = Barcode(
      rawValue: 'fake-qr-code-data',
      format: BarcodeFormat.qrCode,
    );
    const fakeCapture = BarcodeCapture(barcodes: [fakeBarcode]);

    // MobileScannerのonDetectコールバックを呼び出す
    final mobileScannerFinder = find.byType(MobileScanner);
    final mobileScannerWidget =
        tester.widget<MobileScanner>(mobileScannerFinder);

    try {
      mobileScannerWidget.onDetect!(fakeCapture);
    } catch (e) {
      fail('onDetect threw an exception: $e');
    }

    // 状態の再描画
    await tester.pumpAndSettle();

    // ListTileが表示されていることを確認
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('fake-qr-code-data'), findsOneWidget);
  });
}
