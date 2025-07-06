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
}
