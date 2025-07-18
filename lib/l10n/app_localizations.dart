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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
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

  /// No description provided for @productListTitle.
  ///
  /// In ja, this message translates to:
  /// **'商品一覧'**
  String get productListTitle;

  /// No description provided for @noProductName.
  ///
  /// In ja, this message translates to:
  /// **'商品名なし'**
  String get noProductName;

  /// 在庫情報
  ///
  /// In ja, this message translates to:
  /// **'在庫: {stock}'**
  String stockInfo(int stock);

  /// カートに追加されたメッセージ
  ///
  /// In ja, this message translates to:
  /// **'{productName}をカートに追加しました'**
  String addedToCartMessage(String productName);

  /// カート追加失敗メッセージ
  ///
  /// In ja, this message translates to:
  /// **'カートへの追加に失敗しました: {error}'**
  String addToCartFailed(String error);

  /// No description provided for @addToCartButton.
  ///
  /// In ja, this message translates to:
  /// **'カートに追加'**
  String get addToCartButton;

  /// No description provided for @outOfStock.
  ///
  /// In ja, this message translates to:
  /// **'在庫切れ'**
  String get outOfStock;

  /// No description provided for @noAvailableProducts.
  ///
  /// In ja, this message translates to:
  /// **'購入可能な商品がありません'**
  String get noAvailableProducts;

  /// No description provided for @noProductsOnSale.
  ///
  /// In ja, this message translates to:
  /// **'現在販売中の商品がありません'**
  String get noProductsOnSale;

  /// No description provided for @cartIsEmpty.
  ///
  /// In ja, this message translates to:
  /// **'カートが空です'**
  String get cartIsEmpty;

  /// No description provided for @pleaseAddProductsToCart.
  ///
  /// In ja, this message translates to:
  /// **'商品をカートに追加してください'**
  String get pleaseAddProductsToCart;

  /// No description provided for @stockReductionNotice.
  ///
  /// In ja, this message translates to:
  /// **'在庫減少のお知らせ'**
  String get stockReductionNotice;

  /// 在庫減少メッセージ
  ///
  /// In ja, this message translates to:
  /// **'「{productName}」の在庫が減少しました。'**
  String stockReducedMessage(String productName);

  /// 現在の数量メッセージ
  ///
  /// In ja, this message translates to:
  /// **'現在の数量: {quantity}個'**
  String currentQuantity(int quantity);

  /// 利用可能な在庫メッセージ
  ///
  /// In ja, this message translates to:
  /// **'利用可能な在庫: {stock}個'**
  String availableStock(int stock);

  /// No description provided for @specificCommercialCode.
  ///
  /// In ja, this message translates to:
  /// **'特定商取引法に基づく表記'**
  String get specificCommercialCode;

  /// No description provided for @copyToClipboard.
  ///
  /// In ja, this message translates to:
  /// **'クリップボードにコピー'**
  String get copyToClipboard;

  /// No description provided for @copiedToClipboard.
  ///
  /// In ja, this message translates to:
  /// **'クリップボードにコピーしました'**
  String get copiedToClipboard;

  /// No description provided for @adjustQuantityToStock.
  ///
  /// In ja, this message translates to:
  /// **'数量を在庫数に調整します。'**
  String get adjustQuantityToStock;

  /// No description provided for @returnToHome.
  ///
  /// In ja, this message translates to:
  /// **'ホームへ戻る'**
  String get returnToHome;

  /// No description provided for @processing.
  ///
  /// In ja, this message translates to:
  /// **'処理中...'**
  String get processing;

  /// No description provided for @insufficientStock.
  ///
  /// In ja, this message translates to:
  /// **'商品の在庫が不足しています。数量を調整してから再度お試しください。'**
  String get insufficientStock;

  /// No description provided for @networkError.
  ///
  /// In ja, this message translates to:
  /// **'ネットワークエラーが発生しました。インターネット接続を確認してから再度お試しください。'**
  String get networkError;

  /// No description provided for @authenticationError.
  ///
  /// In ja, this message translates to:
  /// **'認証エラーが発生しました。再度ログインしてください。'**
  String get authenticationError;

  /// No description provided for @paymentError.
  ///
  /// In ja, this message translates to:
  /// **'決済処理でエラーが発生しました。しばらく時間をおいてから再度お試しください。'**
  String get paymentError;

  /// No description provided for @serverError.
  ///
  /// In ja, this message translates to:
  /// **'サーバーエラーが発生しました。しばらく時間をおいてから再度お試しください。'**
  String get serverError;

  /// No description provided for @timeoutError.
  ///
  /// In ja, this message translates to:
  /// **'処理がタイムアウトしました。しばらく時間をおいてから再度お試しください。'**
  String get timeoutError;

  /// No description provided for @imageLoadError.
  ///
  /// In ja, this message translates to:
  /// **'画像の読み込みに失敗しました。別の画像をお試しください。'**
  String get imageLoadError;

  /// No description provided for @heicNotSupported.
  ///
  /// In ja, this message translates to:
  /// **'HEIC形式の画像は現在サポートされていません。JPEGまたはPNG形式の画像をお試しください。'**
  String get heicNotSupported;

  /// No description provided for @generalError.
  ///
  /// In ja, this message translates to:
  /// **'エラーが発生しました。しばらく時間をおいてから再度お試しください。'**
  String get generalError;

  /// No description provided for @retry.
  ///
  /// In ja, this message translates to:
  /// **'再試行'**
  String get retry;

  /// No description provided for @productNotFound.
  ///
  /// In ja, this message translates to:
  /// **'商品が見つかりません'**
  String get productNotFound;

  /// 在庫不足メッセージ
  ///
  /// In ja, this message translates to:
  /// **'在庫が不足しています。数量を{stock}個に調整しました。'**
  String stockInsufficientMessage(int stock);

  /// 単価メッセージ
  ///
  /// In ja, this message translates to:
  /// **'単価: {price}'**
  String unitPrice(String price);

  /// 小計メッセージ
  ///
  /// In ja, this message translates to:
  /// **'小計: {price}'**
  String subtotal(String price);

  /// 短い在庫情報
  ///
  /// In ja, this message translates to:
  /// **'在庫: {stock}'**
  String stockInfoShort(int stock);

  /// No description provided for @paymentErrorTitle.
  ///
  /// In ja, this message translates to:
  /// **'決済エラー'**
  String get paymentErrorTitle;

  /// No description provided for @insufficientStockTitle.
  ///
  /// In ja, this message translates to:
  /// **'在庫不足'**
  String get insufficientStockTitle;

  /// No description provided for @insufficientStockDetails.
  ///
  /// In ja, this message translates to:
  /// **'以下の商品の在庫が不足しています：'**
  String get insufficientStockDetails;

  /// 数量調整メッセージ
  ///
  /// In ja, this message translates to:
  /// **'数量: {current} → {available}個'**
  String quantityAdjustment(int current, int available);

  /// No description provided for @adjustCartAndRetry.
  ///
  /// In ja, this message translates to:
  /// **'カートの数量を調整してから再度お試しください。'**
  String get adjustCartAndRetry;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスを入力してください'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In ja, this message translates to:
  /// **'有効なメールアドレスを入力してください'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In ja, this message translates to:
  /// **'パスワードを入力してください'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordRequirements.
  ///
  /// In ja, this message translates to:
  /// **'パスワードは6文字以上の英数字である必要があります'**
  String get passwordRequirements;

  /// No description provided for @passwordMinLength.
  ///
  /// In ja, this message translates to:
  /// **'パスワードは4文字以上でお願いします'**
  String get passwordMinLength;

  /// No description provided for @passwordMaxLength.
  ///
  /// In ja, this message translates to:
  /// **'パスワードは72文字以下でお願いします'**
  String get passwordMaxLength;

  /// No description provided for @invalidKatakanaFormat.
  ///
  /// In ja, this message translates to:
  /// **'カタカナの形式が間違っています'**
  String get invalidKatakanaFormat;

  /// No description provided for @katakanaAndNumbersOnly.
  ///
  /// In ja, this message translates to:
  /// **'カタカナと数字で入力してください'**
  String get katakanaAndNumbersOnly;

  /// No description provided for @invalidRomanFormat.
  ///
  /// In ja, this message translates to:
  /// **'ローマ字の形式が間違っています'**
  String get invalidRomanFormat;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスの形式が違います'**
  String get invalidEmailFormat;

  /// No description provided for @invalidBirthDate.
  ///
  /// In ja, this message translates to:
  /// **'生年月日の形式が違います'**
  String get invalidBirthDate;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In ja, this message translates to:
  /// **'電話番号は10桁か11桁の数字でお願い致します'**
  String get invalidPhoneNumber;

  /// No description provided for @invalidPostalCode.
  ///
  /// In ja, this message translates to:
  /// **'郵便番号はハイフン区切りの7桁の数字でお願い致します'**
  String get invalidPostalCode;

  /// No description provided for @eventPeriod.
  ///
  /// In ja, this message translates to:
  /// **'イベント開催期間'**
  String get eventPeriod;

  /// No description provided for @sellerName.
  ///
  /// In ja, this message translates to:
  /// **'販売業社の名称'**
  String get sellerName;

  /// No description provided for @address.
  ///
  /// In ja, this message translates to:
  /// **'所在地'**
  String get address;

  /// No description provided for @phoneNumber.
  ///
  /// In ja, this message translates to:
  /// **'電話番号'**
  String get phoneNumber;

  /// No description provided for @emailAddress.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス'**
  String get emailAddress;

  /// No description provided for @operatorInCharge.
  ///
  /// In ja, this message translates to:
  /// **'運営統括責任者'**
  String get operatorInCharge;

  /// No description provided for @additionalFees.
  ///
  /// In ja, this message translates to:
  /// **'追加手数料等の追加料金'**
  String get additionalFees;

  /// No description provided for @returnPolicy.
  ///
  /// In ja, this message translates to:
  /// **'交換および返品（返金ポリシー）'**
  String get returnPolicy;

  /// No description provided for @deliveryPeriod.
  ///
  /// In ja, this message translates to:
  /// **'引渡時期'**
  String get deliveryPeriod;

  /// No description provided for @paymentMethods.
  ///
  /// In ja, this message translates to:
  /// **'受け付け可能な決済手段'**
  String get paymentMethods;

  /// No description provided for @paymentPeriod.
  ///
  /// In ja, this message translates to:
  /// **'決済期間'**
  String get paymentPeriod;

  /// No description provided for @sellingPrice.
  ///
  /// In ja, this message translates to:
  /// **'販売価格'**
  String get sellingPrice;

  /// No description provided for @disclosureOnRequest.
  ///
  /// In ja, this message translates to:
  /// **'請求があったら遅滞なく開示します'**
  String get disclosureOnRequest;

  /// No description provided for @noAdditionalFees.
  ///
  /// In ja, this message translates to:
  /// **'なし'**
  String get noAdditionalFees;

  /// No description provided for @customerReturnPolicy.
  ///
  /// In ja, this message translates to:
  /// **'＜お客様都合の返品・交換の場合＞'**
  String get customerReturnPolicy;

  /// No description provided for @beforeDelivery.
  ///
  /// In ja, this message translates to:
  /// **'引渡し処理前の商品：メールにてお問い合わせください。'**
  String get beforeDelivery;

  /// No description provided for @afterDelivery.
  ///
  /// In ja, this message translates to:
  /// **'引渡し処理後の商品：原則、返品・交換はお受けしておりません。'**
  String get afterDelivery;

  /// No description provided for @defectiveProduct.
  ///
  /// In ja, this message translates to:
  /// **'＜商品に不備がある場合＞'**
  String get defectiveProduct;

  /// No description provided for @contactByEmail.
  ///
  /// In ja, this message translates to:
  /// **'メールにてご連絡ください。'**
  String get contactByEmail;

  /// No description provided for @creditCard.
  ///
  /// In ja, this message translates to:
  /// **'クレジットカード'**
  String get creditCard;

  /// No description provided for @creditCardProcessing.
  ///
  /// In ja, this message translates to:
  /// **'クレジットカード決済はただちに処理されます。'**
  String get creditCardProcessing;

  /// No description provided for @priceOnProductPage.
  ///
  /// In ja, this message translates to:
  /// **'各商品ページに記載の金額'**
  String get priceOnProductPage;

  /// No description provided for @noEmail.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスなし'**
  String get noEmail;

  /// No description provided for @noName.
  ///
  /// In ja, this message translates to:
  /// **'名前なし'**
  String get noName;

  /// No description provided for @priceLabel.
  ///
  /// In ja, this message translates to:
  /// **'価格'**
  String get priceLabel;

  /// No description provided for @ticketNotFound.
  ///
  /// In ja, this message translates to:
  /// **'チケットが見つかりません'**
  String get ticketNotFound;

  /// No description provided for @error.
  ///
  /// In ja, this message translates to:
  /// **'エラー'**
  String get error;

  /// No description provided for @errorDetails.
  ///
  /// In ja, this message translates to:
  /// **'エラー詳細'**
  String get errorDetails;

  /// No description provided for @genreGoods.
  ///
  /// In ja, this message translates to:
  /// **'物品'**
  String get genreGoods;

  /// No description provided for @genreFoods.
  ///
  /// In ja, this message translates to:
  /// **'食品'**
  String get genreFoods;

  /// No description provided for @genreOthers.
  ///
  /// In ja, this message translates to:
  /// **'その他'**
  String get genreOthers;

  /// No description provided for @changeEmail.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス変更'**
  String get changeEmail;

  /// No description provided for @currentEmail.
  ///
  /// In ja, this message translates to:
  /// **'現在のメールアドレス'**
  String get currentEmail;

  /// No description provided for @newEmail.
  ///
  /// In ja, this message translates to:
  /// **'新しいメールアドレス'**
  String get newEmail;

  /// No description provided for @confirmPassword.
  ///
  /// In ja, this message translates to:
  /// **'パスワード確認'**
  String get confirmPassword;

  /// No description provided for @changeEmailDescription.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレスを変更するには、現在のパスワードを入力してください。'**
  String get changeEmailDescription;

  /// No description provided for @emailChangeSuccess.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス変更の確認メールを送信しました。新しいメールアドレスで確認メールを確認してください。'**
  String get emailChangeSuccess;

  /// No description provided for @emailChangeError.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス変更に失敗しました'**
  String get emailChangeError;

  /// No description provided for @passwordRequired.
  ///
  /// In ja, this message translates to:
  /// **'パスワードを入力してください'**
  String get passwordRequired;

  /// No description provided for @passwordIncorrect.
  ///
  /// In ja, this message translates to:
  /// **'パスワードが正しくありません'**
  String get passwordIncorrect;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In ja, this message translates to:
  /// **'このメールアドレスは既に使用されています'**
  String get emailAlreadyInUse;

  /// No description provided for @emailChangeInProgress.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス変更処理中...'**
  String get emailChangeInProgress;

  /// No description provided for @emailChangeCompleted.
  ///
  /// In ja, this message translates to:
  /// **'メールアドレス変更が完了しました'**
  String get emailChangeCompleted;

  /// No description provided for @changePassword.
  ///
  /// In ja, this message translates to:
  /// **'パスワード変更'**
  String get changePassword;

  /// No description provided for @currentPassword.
  ///
  /// In ja, this message translates to:
  /// **'現在のパスワード'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In ja, this message translates to:
  /// **'新しいパスワード'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In ja, this message translates to:
  /// **'新しいパスワード（確認）'**
  String get confirmNewPassword;

  /// No description provided for @changePasswordDescription.
  ///
  /// In ja, this message translates to:
  /// **'パスワードを変更するには、現在のパスワードを入力してください。'**
  String get changePasswordDescription;

  /// No description provided for @passwordChangeSuccess.
  ///
  /// In ja, this message translates to:
  /// **'パスワードが正常に変更されました。'**
  String get passwordChangeSuccess;

  /// No description provided for @passwordChangeError.
  ///
  /// In ja, this message translates to:
  /// **'パスワード変更に失敗しました'**
  String get passwordChangeError;

  /// No description provided for @passwordMismatch.
  ///
  /// In ja, this message translates to:
  /// **'新しいパスワードが一致しません'**
  String get passwordMismatch;

  /// No description provided for @passwordTooWeak.
  ///
  /// In ja, this message translates to:
  /// **'パスワードが弱すぎます。6文字以上の英数字で入力してください'**
  String get passwordTooWeak;

  /// No description provided for @passwordChangeInProgress.
  ///
  /// In ja, this message translates to:
  /// **'パスワード変更処理中...'**
  String get passwordChangeInProgress;

  /// No description provided for @passwordChangeCompleted.
  ///
  /// In ja, this message translates to:
  /// **'パスワード変更が完了しました'**
  String get passwordChangeCompleted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
