import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

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
  String get edit => '編集';

  @override
  String get cancel => 'キャンセル';

  @override
  String get message => 'メッセージ';

  @override
  String get pleaseEnterADateAfterTheSpecifiedDate => '指定した日付より後の日付を入力してください';

  @override
  String get eventName => '名称';

  @override
  String get detail => '詳細';

  @override
  String dataTime(DateTime date) {
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
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }

  @override
  String currency(int value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.simpleCurrency(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }
}
