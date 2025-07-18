// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

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
  String get title => 'トリニィ';

  @override
  String get signUpNow => 'アカウントをお持ちでない場合  ';

  @override
  String get signUp => '新規登録';

  @override
  String get haveAnAccount => 'すでにアカウントをお持ちの場合  ';

  @override
  String get login => 'Login';

  @override
  String get mail => 'メール';

  @override
  String get mailAddress => 'メールアドレス';

  @override
  String get password => 'パスワード';

  @override
  String get register => '登録';

  @override
  String get update => '更新';

  @override
  String get delete => '削除';

  @override
  String get buy => '購入';

  @override
  String get quantity => '数量';

  @override
  String get product => '商品';

  @override
  String get productList => '商品一覧';

  @override
  String get productDetails => '商品詳細';

  @override
  String get event => 'イベント';

  @override
  String get eventList => 'イベント一覧';

  @override
  String get salesPeriod => '販売期間';

  @override
  String get periods => '開催期間';

  @override
  String get place => '開催場所';

  @override
  String get staffCode => 'スタッフ登録コード';

  @override
  String get favorite => 'お気に入り';

  @override
  String get cart => '買い物かご';

  @override
  String get ticket => 'チケット';

  @override
  String get ticketList => 'チケット一覧';

  @override
  String get email => 'メールアドレス';

  @override
  String get displayName => '表示名';

  @override
  String get name => '名前';

  @override
  String get phone => '電話番号';

  @override
  String get pleaseEnterSomeText => 'テキストを入力してください';

  @override
  String get pleaseEnterSomeNum => '数値を入力してください';

  @override
  String get edit => '編集';

  @override
  String get cancel => 'キャンセル';

  @override
  String get backButton => '戻る';

  @override
  String get message => 'メッセージ';

  @override
  String get pleaseEnterADateAfterTheSpecifiedDate => '指定した日付より後の日付を入力してください';

  @override
  String get eventName => '名称';

  @override
  String get detail => '詳細';

  @override
  String dateTime(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat(
      'yMMMEd Hm',
      localeName,
    );
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String date(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMEd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String time(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.Hm(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString';
  }

  @override
  String decimalPattern(int value) {
    final intl.NumberFormat valueNumberFormat = intl
        .NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }

  @override
  String currency(int value) {
    final intl.NumberFormat valueNumberFormat = intl
        .NumberFormat.simpleCurrency(locale: localeName);
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }

  @override
  String get validPeriod => '有効期間';

  @override
  String get code => 'コード';

  @override
  String get genre => 'ジャンル';

  @override
  String get goods => '物品';

  @override
  String get foods => '食品';

  @override
  String get others => 'その他';

  @override
  String get productName => '商品名';

  @override
  String get productDescription => '商品説明';

  @override
  String get stock => '在庫';

  @override
  String get price => '金額';

  @override
  String get purchaseHistory => '購入履歴';

  @override
  String get noPurchaseHistory => '購入履歴はありません';

  @override
  String get completion => '完了';

  @override
  String get outOfTerm => '販売期間外';

  @override
  String get awaitingPayment => '支払いを待っています。 支払い画面で支払いを完了して下さい。';

  @override
  String get openNewWindow => '支払い画面を開く';

  @override
  String get addToCart => '買物カゴに追加';

  @override
  String get addToCartQ => '買物カゴに追加しますか？';

  @override
  String get addedToCart => '買物カゴに追加されました';

  @override
  String get doYouWantToDeleteIt => '削除しますか？';

  @override
  String get processingData => 'データー処理中';

  @override
  String get handoverProcessQ => '引渡し処理を完了しますか？';

  @override
  String get handoverProcess => '引渡し処理';

  @override
  String get wouldYouLikeToRegisterAsAStaffMember => 'スタッフとして登録しますか？';

  @override
  String get confirm => '確認';

  @override
  String get theCodeIsWrong => 'コードが間違っています';

  @override
  String get thankYouForYourPurchase => 'ご購入いただきありがとうございます';

  @override
  String get processingInterrupted => '処理を中断しました';

  @override
  String get selectImage => '画像を選択';

  @override
  String get salesInformation => '販売情報';

  @override
  String get close => '閉じる';

  @override
  String get registered => '登録されました';

  @override
  String get notification => '通知';

  @override
  String get signIn => 'サインイン';

  @override
  String get signOut => 'サインアウト';

  @override
  String get memberSince => '登録日';

  @override
  String get lastUpdated => '最終更新';

  @override
  String get productListTitle => '商品一覧';

  @override
  String get noProductName => '商品名なし';

  @override
  String stockInfo(int stock) {
    return '在庫: $stock';
  }

  @override
  String addedToCartMessage(String productName) {
    return '$productNameをカートに追加しました';
  }

  @override
  String addToCartFailed(String error) {
    return 'カートへの追加に失敗しました: $error';
  }

  @override
  String get addToCartButton => 'カートに追加';

  @override
  String get outOfStock => '在庫切れ';

  @override
  String get noAvailableProducts => '購入可能な商品がありません';

  @override
  String get noProductsOnSale => '現在販売中の商品がありません';

  @override
  String get cartIsEmpty => 'カートが空です';

  @override
  String get pleaseAddProductsToCart => '商品をカートに追加してください';

  @override
  String get stockReductionNotice => '在庫減少のお知らせ';

  @override
  String stockReducedMessage(String productName) {
    return '「$productName」の在庫が減少しました。';
  }

  @override
  String currentQuantity(int quantity) {
    return '現在の数量: $quantity個';
  }

  @override
  String availableStock(int stock) {
    return '利用可能な在庫: $stock個';
  }

  @override
  String get specificCommercialCode => '特定商取引法に基づく表記';

  @override
  String get copyToClipboard => 'クリップボードにコピー';

  @override
  String get copiedToClipboard => 'クリップボードにコピーしました';

  @override
  String get adjustQuantityToStock => '数量を在庫数に調整します。';

  @override
  String get returnToHome => 'ホームへ戻る';

  @override
  String get processing => '処理中...';

  @override
  String get insufficientStock => '商品の在庫が不足しています。数量を調整してから再度お試しください。';

  @override
  String get networkError => 'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試しください。';

  @override
  String get authenticationError => '認証エラーが発生しました。再度ログインしてください。';

  @override
  String get paymentError => '決済処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。';

  @override
  String get serverError => 'サーバーエラーが発生しました。しばらく時間をおいてから再度お試しください。';

  @override
  String get timeoutError => '処理がタイムアウトしました。しばらく時間をおいてから再度お試しください。';

  @override
  String get imageLoadError => '画像の読み込みに失敗しました。別の画像をお試しください。';

  @override
  String get heicNotSupported =>
      'HEIC形式の画像は現在サポートされていません。JPEGまたはPNG形式の画像をお試しください。';

  @override
  String get generalError => 'エラーが発生しました。しばらく時間をおいてから再度お試しください。';

  @override
  String get retry => '再試行';

  @override
  String get productNotFound => '商品が見つかりません';

  @override
  String stockInsufficientMessage(int stock) {
    return '在庫が不足しています。数量を$stock個に調整しました。';
  }

  @override
  String unitPrice(String price) {
    return '単価: $price';
  }

  @override
  String subtotal(String price) {
    return '小計: $price';
  }

  @override
  String stockInfoShort(int stock) {
    return '在庫: $stock';
  }

  @override
  String get paymentErrorTitle => '決済エラー';

  @override
  String get insufficientStockTitle => '在庫不足';

  @override
  String get insufficientStockDetails => '以下の商品の在庫が不足しています：';

  @override
  String quantityAdjustment(int current, int available) {
    return '数量: $current → $available個';
  }

  @override
  String get adjustCartAndRetry => 'カートの数量を調整してから再度お試しください。';

  @override
  String get pleaseEnterEmail => 'メールアドレスを入力してください';

  @override
  String get pleaseEnterValidEmail => '有効なメールアドレスを入力してください';

  @override
  String get pleaseEnterPassword => 'パスワードを入力してください';

  @override
  String get passwordRequirements => 'パスワードは6文字以上の英数字である必要があります';

  @override
  String get passwordMinLength => 'パスワードは4文字以上でお願いします';

  @override
  String get passwordMaxLength => 'パスワードは72文字以下でお願いします';

  @override
  String get invalidKatakanaFormat => 'カタカナの形式が間違っています';

  @override
  String get katakanaAndNumbersOnly => 'カタカナと数字で入力してください';

  @override
  String get invalidRomanFormat => 'ローマ字の形式が間違っています';

  @override
  String get invalidEmailFormat => 'メールアドレスの形式が違います';

  @override
  String get invalidBirthDate => '生年月日の形式が違います';

  @override
  String get invalidPhoneNumber => '電話番号は10桁か11桁の数字でお願い致します';

  @override
  String get invalidPostalCode => '郵便番号はハイフン区切りの7桁の数字でお願い致します';

  @override
  String get eventPeriod => 'イベント開催期間';

  @override
  String get sellerName => '販売業社の名称';

  @override
  String get address => '所在地';

  @override
  String get phoneNumber => '電話番号';

  @override
  String get emailAddress => 'メールアドレス';

  @override
  String get operatorInCharge => '運営統括責任者';

  @override
  String get additionalFees => '追加手数料等の追加料金';

  @override
  String get returnPolicy => '交換および返品（返金ポリシー）';

  @override
  String get deliveryPeriod => '引渡時期';

  @override
  String get paymentMethods => '受け付け可能な決済手段';

  @override
  String get paymentPeriod => '決済期間';

  @override
  String get sellingPrice => '販売価格';

  @override
  String get disclosureOnRequest => '請求があったら遅滞なく開示します';

  @override
  String get noAdditionalFees => 'なし';

  @override
  String get customerReturnPolicy => '＜お客様都合の返品・交換の場合＞';

  @override
  String get beforeDelivery => '引渡し処理前の商品：メールにてお問い合わせください。';

  @override
  String get afterDelivery => '引渡し処理後の商品：原則、返品・交換はお受けしておりません。';

  @override
  String get defectiveProduct => '＜商品に不備がある場合＞';

  @override
  String get contactByEmail => 'メールにてご連絡ください。';

  @override
  String get creditCard => 'クレジットカード';

  @override
  String get creditCardProcessing => 'クレジットカード決済はただちに処理されます。';

  @override
  String get priceOnProductPage => '各商品ページに記載の金額';

  @override
  String get noEmail => 'メールアドレスなし';

  @override
  String get noName => '名前なし';

  @override
  String get priceLabel => '価格';

  @override
  String get ticketNotFound => 'チケットが見つかりません';

  @override
  String get error => 'エラー';

  @override
  String get errorDetails => 'エラー詳細';

  @override
  String get genreGoods => '物品';

  @override
  String get genreFoods => '食品';

  @override
  String get genreOthers => 'その他';

  @override
  String get changeEmail => 'メールアドレス変更';

  @override
  String get currentEmail => '現在のメールアドレス';

  @override
  String get newEmail => '新しいメールアドレス';

  @override
  String get confirmPassword => 'パスワード確認';

  @override
  String get changeEmailDescription => 'メールアドレスを変更するには、現在のパスワードを入力してください。';

  @override
  String get emailChangeSuccess =>
      'メールアドレス変更の確認メールを送信しました。新しいメールアドレスで確認メールを確認してください。';

  @override
  String get emailChangeError => 'メールアドレス変更に失敗しました';

  @override
  String get passwordRequired => 'パスワードを入力してください';

  @override
  String get passwordIncorrect => 'パスワードが正しくありません';

  @override
  String get emailAlreadyInUse => 'このメールアドレスは既に使用されています';

  @override
  String get emailChangeInProgress => 'メールアドレス変更処理中...';

  @override
  String get emailChangeCompleted => 'メールアドレス変更が完了しました';

  @override
  String get changePassword => 'パスワード変更';

  @override
  String get currentPassword => '現在のパスワード';

  @override
  String get newPassword => '新しいパスワード';

  @override
  String get confirmNewPassword => '新しいパスワード（確認）';

  @override
  String get changePasswordDescription => 'パスワードを変更するには、現在のパスワードを入力してください。';

  @override
  String get passwordChangeSuccess => 'パスワードが正常に変更されました。';

  @override
  String get passwordChangeError => 'パスワード変更に失敗しました';

  @override
  String get passwordMismatch => '新しいパスワードが一致しません';

  @override
  String get passwordTooWeak => 'パスワードが弱すぎます。6文字以上の英数字で入力してください';

  @override
  String get passwordChangeInProgress => 'パスワード変更処理中...';

  @override
  String get passwordChangeCompleted => 'パスワード変更が完了しました';
}
