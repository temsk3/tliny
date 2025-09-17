import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:tliny/src/data/model/cart_model.dart';
import 'package:tliny/src/data/model/product_model.dart';
import 'package:tliny/src/data/model/user_model.dart';
import 'package:tliny/src/data/model/usage_history_model.dart';
import 'package:tliny/src/ui/usage_history/history_view_model.dart';

/// テスト用のAppLocalizationsモック
class MockAppLocalizations extends AppLocalizations {
  MockAppLocalizations() : super('ja');

  @override
  String get close => '閉じる';
  
  @override
  String get retry => '再試行';
  
  @override
  String get generalError => 'エラー';
  
  @override
  String get timeoutError => 'タイムアウトエラー';
  
  @override
  String get imageLoadError => '画像読み込みエラー';
  
  @override
  String get heicNotSupported => 'HEIC形式はサポートされていません';
  
  @override
  String get networkError => 'ネットワークエラー';
  
  @override
  String get serverError => 'サーバーエラー';
  
  @override
  String get databaseError => 'データベースエラー';
  
  @override
  String get authenticationError => '認証エラー';
  
  @override
  String get validationError => 'バリデーションエラー';
  
  @override
  String get permissionError => '権限エラー';
  
  @override
  String get unknownError => '不明なエラー';

  // すべての抽象メソッドのデフォルト実装
  @override
  String get appTitle => 'TLINY';
  
  @override
  String get home => 'ホーム';
  
  @override
  String get hello => 'こんにちは';
  
  @override
  String get profile => 'ユーザー情報';
  
  @override
  String get usageHistory => 'チケット使用履歴';
  
  @override
  String get ok => 'ok';
  
  @override
  String get yes => 'yes';
  
  @override
  String get no => 'no';
  
  @override
  String get title => 'タイトル';
  
  @override
  String get fileNotFoundError => 'ファイルが見つかりません';
  
  @override
  String get insufficientStock => '在庫が不足しています';
  
  @override
  String get paymentError => '決済エラー';
  
  @override
  String get insufficientStockTitle => '在庫不足';
  
  @override
  String get paymentErrorTitle => '決済エラー';

  // noSuchMethodを使用してすべての未実装メソッドに対応
  @override
  dynamic noSuchMethod(Invocation invocation) {
    // getterの場合はデフォルト文字列を返す
    if (invocation.isGetter) {
      return 'Mock String';
    }
    // メソッドの場合もデフォルト文字列を返す
    return 'Mock String';
  }
}

/// テスト用のヘルパー関数群
class TestHelpers {
  /// テスト用のProviderContainerを作成
  static ProviderContainer createTestContainer({
    List<Override> overrides = const [],
  }) {
    return ProviderContainer(overrides: overrides);
  }

  /// テスト用のWidgetを作成（L10nプロバイダー付き）
  static Widget createTestWidget({
    required Widget child,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: child,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

  /// テスト用のAppLocalizationsを作成
  static MockAppLocalizations createMockL10n() {
    return MockAppLocalizations();
  }

  /// テスト用のProductを作成
  static Product createTestProduct({
    String? id,
    String? name,
    int? price,
    String? desc,
    List<String>? pictureURL,
  }) {
    return Product.empty().copyWith(
      id: id ?? 'test-product-id',
      name: name ?? 'Test Product',
      price: price ?? 1000,
      desc: desc ?? 'Test description',
      pictureURL: pictureURL ?? ['https://example.com/image.jpg'],
    );
  }

  /// テスト用のUserを作成
  static User createTestUser({
    String? id,
    String? displayName,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? 'test-user-id',
      displayName: displayName ?? 'Test User',
      name: name ?? 'Test Name',
      email: email ?? 'test@example.com',
      phoneNumber: phoneNumber ?? '+810000000000',
    );
  }

  /// テスト用のCartを作成
  static Cart createTestCart({
    String? id,
    int? quantity,
    String? productId,
    String? programId,
  }) {
    return Cart(
      id: id ?? 'test-cart-id',
      quantity: quantity ?? 1,
      productId: productId ?? 'test-product-id',
      programId: programId ?? 'test-program-id',
    );
  }

  /// 非同期処理の完了を待機
  static Future<void> waitForAsync(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  /// 特定のウィジェットが表示されるまで待機
  static Future<void> waitForWidget(WidgetTester tester, Finder finder) async {
    await tester.pumpAndSettle();
    expect(finder, findsOneWidget);
  }

  /// 特定のテキストが表示されるまで待機
  static Future<void> waitForText(WidgetTester tester, String text) async {
    await tester.pumpAndSettle();
    expect(find.text(text), findsOneWidget);
  }

  /// エラー状態をシミュレート
  static Exception createTestException(String message) {
    return Exception(message);
  }

  /// テスト用の画像URLを作成
  static String createTestImageUrl(String filename) {
    return 'https://example.com/images/$filename';
  }

  /// テスト用の価格フォーマット
  static String formatPrice(int price) {
    return '¥${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  /// テスト用の日付を作成
  static DateTime createTestDate({
    int year = 2024,
    int month = 1,
    int day = 1,
  }) {
    return DateTime(year, month, day);
  }

  /// テスト用のUUIDを作成
  static String createTestUuid() {
    return 'test-uuid-${DateTime.now().millisecondsSinceEpoch}';
  }
}

/// テスト用の定数
class TestConstants {
  static const testUserId = 'test-user-id';
  static const testProductId = 'test-product-id';
  static const testProgramId = 'test-program-id';
  static const testEmail = 'test@example.com';
  static const testPassword = 'password123';
  static const testDisplayName = 'Test User';
  static const testProductName = 'Test Product';
  static const testPrice = 1000;
  static const testDescription = 'Test description';
  static const testImageUrl = 'https://example.com/image.jpg';
}

/// テスト用のUsageHistoryViewModelモック
class MockUsageHistoryViewModel extends UsageHistoryViewModel {
  final List<UsageHistory> _data;
  final Exception? _error;

  MockUsageHistoryViewModel(this._data) : _error = null;

  MockUsageHistoryViewModel.error(this._error) : _data = [];

  @override
  Future<List<UsageHistory>> build() async {
    if (_error != null) {
      throw _error!;
    }
    return _data;
  }
}
