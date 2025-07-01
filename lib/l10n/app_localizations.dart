import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ja, this message translates to:
  /// **'TLINY'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In ja, this message translates to:
  /// **'ホーム'**
  String get home;

  /// No description provided for @hello.
  ///
  /// In ja, this message translates to:
  /// **'こんにちは'**
  String get hello;

  /// No description provided for @profile.
  ///
  /// In ja, this message translates to:
  /// **'ユーザー情報'**
  String get profile;

  /// No description provided for @usageHistory.
  ///
  /// In ja, this message translates to:
  /// **'チケット使用履歴'**
  String get usageHistory;

  /// No description provided for @ok.
  ///
  /// In ja, this message translates to:
  /// **'ok'**
  String get ok;

  /// No description provided for @yes.
  ///
  /// In ja, this message translates to:
  /// **'yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ja, this message translates to:
  /// **'no'**
  String get no;

  /// No description provided for @title.
  ///
  /// In ja, this message translates to:
  /// **'トリニィ'**
  String get title;

  /// No description provided for @signUpNow.
  ///
  /// In ja, this message translates to:
  /// **'アカウントをお持ちでない場合  '**
  String get signUpNow;

  /// No description provided for @signUp.
  ///
  /// In ja, this message translates to:
  /// **'新規登録'**
  String get signUp;

  /// No description provided for @haveAnAccount.
  ///
  /// In ja, this message translates to:
  /// **'すでにアカウントをお持ちの場合  '**
  String get haveAnAccount;

  /// No description provided for @login.
  ///
  /// In ja, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @mail.
  ///
  /// In ja, this message translates to:
  /// **'メール'**
  String get mail;

  /// No description provided for @mailAddress.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス'**
  String get mailAddress;

  /// No description provided for @password.
  ///
  /// In ja, this message translates to:
  /// **'パスワード'**
  String get password;

  /// No description provided for @register.
  ///
  /// In ja, this message translates to:
  /// **'登録'**
  String get register;

  /// No description provided for @update.
  ///
  /// In ja, this message translates to:
  /// **'更新'**
  String get update;

  /// No description provided for @delete.
  ///
  /// In ja, this message translates to:
  /// **'削除'**
  String get delete;

  /// No description provided for @buy.
  ///
  /// In ja, this message translates to:
  /// **'購入'**
  String get buy;

  /// No description provided for @quantity.
  ///
  /// In ja, this message translates to:
  /// **'数量'**
  String get quantity;

  /// No description provided for @product.
  ///
  /// In ja, this message translates to:
  /// **'商品'**
  String get product;

  /// No description provided for @productList.
  ///
  /// In ja, this message translates to:
  /// **'商品一覧'**
  String get productList;

  /// No description provided for @productDetails.
  ///
  /// In ja, this message translates to:
  /// **'商品詳細'**
  String get productDetails;

  /// No description provided for @event.
  ///
  /// In ja, this message translates to:
  /// **'イベント'**
  String get event;

  /// No description provided for @eventList.
  ///
  /// In ja, this message translates to:
  /// **'イベント一覧'**
  String get eventList;

  /// No description provided for @salesPeriod.
  ///
  /// In ja, this message translates to:
  /// **'販売期間'**
  String get salesPeriod;

  /// No description provided for @periods.
  ///
  /// In ja, this message translates to:
  /// **'開催期間'**
  String get periods;

  /// No description provided for @place.
  ///
  /// In ja, this message translates to:
  /// **'開催場所'**
  String get place;

  /// No description provided for @staffCode.
  ///
  /// In ja, this message translates to:
  /// **'スタッフ登録コード'**
  String get staffCode;

  /// No description provided for @favorite.
  ///
  /// In ja, this message translates to:
  /// **'お気に入り'**
  String get favorite;

  /// No description provided for @cart.
  ///
  /// In ja, this message translates to:
  /// **'買い物かご'**
  String get cart;

  /// No description provided for @ticket.
  ///
  /// In ja, this message translates to:
  /// **'チケット'**
  String get ticket;

  /// No description provided for @ticketList.
  ///
  /// In ja, this message translates to:
  /// **'チケット一覧'**
  String get ticketList;

  /// No description provided for @email.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス'**
  String get email;

  /// No description provided for @displayName.
  ///
  /// In ja, this message translates to:
  /// **'表示名'**
  String get displayName;

  /// No description provided for @name.
  ///
  /// In ja, this message translates to:
  /// **'名前'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In ja, this message translates to:
  /// **'電話番号'**
  String get phone;

  /// No description provided for @pleaseEnterSomeText.
  ///
  /// In ja, this message translates to:
  /// **'テキストを入力してください'**
  String get pleaseEnterSomeText;

  /// No description provided for @pleaseEnterSomeNum.
  ///
  /// In ja, this message translates to:
  /// **'数値を入力してください'**
  String get pleaseEnterSomeNum;

  /// No description provided for @edit.
  ///
  /// In ja, this message translates to:
  /// **'編集'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @backButton.
  ///
  /// In ja, this message translates to:
  /// **'戻る'**
  String get backButton;

  /// No description provided for @message.
  ///
  /// In ja, this message translates to:
  /// **'メッセージ'**
  String get message;

  /// No description provided for @pleaseEnterADateAfterTheSpecifiedDate.
  ///
  /// In ja, this message translates to:
  /// **'指定した日付より後の日付を入力してください'**
  String get pleaseEnterADateAfterTheSpecifiedDate;

  /// No description provided for @eventName.
  ///
  /// In ja, this message translates to:
  /// **'名称'**
  String get eventName;

  /// No description provided for @detail.
  ///
  /// In ja, this message translates to:
  /// **'詳細'**
  String get detail;

  /// date parameter
  ///
  /// In ja, this message translates to:
  /// **'{date}'**
  String dateTime(DateTime date);

  /// date parameter
  ///
  /// In ja, this message translates to:
  /// **'{date}'**
  String date(DateTime date);

  /// date parameter
  ///
  /// In ja, this message translates to:
  /// **'{date}'**
  String time(DateTime date);

  /// DecimalPattern
  ///
  /// In ja, this message translates to:
  /// **'{value}'**
  String decimalPattern(int value);

  /// Currency
  ///
  /// In ja, this message translates to:
  /// **'{value}'**
  String currency(int value);

  /// No description provided for @validPeriod.
  ///
  /// In ja, this message translates to:
  /// **'有効期間'**
  String get validPeriod;

  /// No description provided for @code.
  ///
  /// In ja, this message translates to:
  /// **'コード'**
  String get code;

  /// No description provided for @genre.
  ///
  /// In ja, this message translates to:
  /// **'ジャンル'**
  String get genre;

  /// No description provided for @goods.
  ///
  /// In ja, this message translates to:
  /// **'物品'**
  String get goods;

  /// No description provided for @foods.
  ///
  /// In ja, this message translates to:
  /// **'食品'**
  String get foods;

  /// No description provided for @others.
  ///
  /// In ja, this message translates to:
  /// **'その他'**
  String get others;

  /// No description provided for @productName.
  ///
  /// In ja, this message translates to:
  /// **'商品名'**
  String get productName;

  /// No description provided for @productDescription.
  ///
  /// In ja, this message translates to:
  /// **'商品説明'**
  String get productDescription;

  /// No description provided for @stock.
  ///
  /// In ja, this message translates to:
  /// **'在庫'**
  String get stock;

  /// No description provided for @price.
  ///
  /// In ja, this message translates to:
  /// **'金額'**
  String get price;

  /// No description provided for @purchaseHistory.
  ///
  /// In ja, this message translates to:
  /// **'購入履歴'**
  String get purchaseHistory;

  /// No description provided for @noPurchaseHistory.
  ///
  /// In ja, this message translates to:
  /// **'購入履歴はありません'**
  String get noPurchaseHistory;

  /// No description provided for @completion.
  ///
  /// In ja, this message translates to:
  /// **'完了'**
  String get completion;

  /// No description provided for @outOfTerm.
  ///
  /// In ja, this message translates to:
  /// **'販売期間外'**
  String get outOfTerm;

  /// No description provided for @awaitingPayment.
  ///
  /// In ja, this message translates to:
  /// **'支払いを待っています。 支払い画面で支払いを完了して下さい。'**
  String get awaitingPayment;

  /// No description provided for @openNewWindow.
  ///
  /// In ja, this message translates to:
  /// **'支払い画面を開く'**
  String get openNewWindow;

  /// No description provided for @addToCart.
  ///
  /// In ja, this message translates to:
  /// **'買物カゴに追加'**
  String get addToCart;

  /// No description provided for @addToCartQ.
  ///
  /// In ja, this message translates to:
  /// **'買物カゴに追加しますか？'**
  String get addToCartQ;

  /// No description provided for @addedToCart.
  ///
  /// In ja, this message translates to:
  /// **'買物カゴに追加されました'**
  String get addedToCart;

  /// No description provided for @doYouWantToDeleteIt.
  ///
  /// In ja, this message translates to:
  /// **'削除しますか？'**
  String get doYouWantToDeleteIt;

  /// No description provided for @processingData.
  ///
  /// In ja, this message translates to:
  /// **'データー処理中'**
  String get processingData;

  /// No description provided for @handoverProcessQ.
  ///
  /// In ja, this message translates to:
  /// **'引渡し処理を完了しますか？'**
  String get handoverProcessQ;

  /// No description provided for @handoverProcess.
  ///
  /// In ja, this message translates to:
  /// **'引渡し処理'**
  String get handoverProcess;

  /// No description provided for @wouldYouLikeToRegisterAsAStaffMember.
  ///
  /// In ja, this message translates to:
  /// **'スタッフとして登録しますか？'**
  String get wouldYouLikeToRegisterAsAStaffMember;

  /// No description provided for @confirm.
  ///
  /// In ja, this message translates to:
  /// **'確認'**
  String get confirm;

  /// No description provided for @theCodeIsWrong.
  ///
  /// In ja, this message translates to:
  /// **'コードが間違っています'**
  String get theCodeIsWrong;

  /// No description provided for @thankYouForYourPurchase.
  ///
  /// In ja, this message translates to:
  /// **'ご購入いただきありがとうございます'**
  String get thankYouForYourPurchase;

  /// No description provided for @processingInterrupted.
  ///
  /// In ja, this message translates to:
  /// **'処理を中断しました'**
  String get processingInterrupted;

  /// No description provided for @selectImage.
  ///
  /// In ja, this message translates to:
  /// **'画像を選択'**
  String get selectImage;

  /// No description provided for @salesInformation.
  ///
  /// In ja, this message translates to:
  /// **'販売情報'**
  String get salesInformation;

  /// No description provided for @close.
  ///
  /// In ja, this message translates to:
  /// **'閉じる'**
  String get close;

  /// No description provided for @registered.
  ///
  /// In ja, this message translates to:
  /// **'登録されました'**
  String get registered;

  /// No description provided for @notification.
  ///
  /// In ja, this message translates to:
  /// **'通知'**
  String get notification;

  /// No description provided for @signIn.
  ///
  /// In ja, this message translates to:
  /// **'サインイン'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In ja, this message translates to:
  /// **'サインアウト'**
  String get signOut;

  /// No description provided for @memberSince.
  ///
  /// In ja, this message translates to:
  /// **'登録日'**
  String get memberSince;

  /// No description provided for @lastUpdated.
  ///
  /// In ja, this message translates to:
  /// **'最終更新'**
  String get lastUpdated;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
