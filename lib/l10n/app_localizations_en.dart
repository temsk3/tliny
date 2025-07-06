// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TLINY';

  @override
  String get home => 'Home';

  @override
  String get hello => 'Hello';

  @override
  String get profile => 'Profile';

  @override
  String get usageHistory => 'Ticket usage history';

  @override
  String get ok => 'ok';

  @override
  String get yes => 'yes';

  @override
  String get no => 'no';

  @override
  String get title => 'TLINY';

  @override
  String get signUpNow => 'Don\'t have an account?  ';

  @override
  String get signUp => 'SignUp';

  @override
  String get haveAnAccount => 'Already have an account  ';

  @override
  String get login => 'Login';

  @override
  String get mail => 'Mail';

  @override
  String get mailAddress => 'Mail Address';

  @override
  String get password => 'Password';

  @override
  String get register => 'register';

  @override
  String get update => 'Update';

  @override
  String get delete => 'Delete';

  @override
  String get buy => 'Buy';

  @override
  String get quantity => 'Quantity';

  @override
  String get product => 'Product';

  @override
  String get productList => 'Product List';

  @override
  String get productDetails => 'Product Details';

  @override
  String get event => 'Event';

  @override
  String get eventList => 'Event List';

  @override
  String get salesPeriod => '販売期間';

  @override
  String get periods => '開催期間';

  @override
  String get place => '開催場所';

  @override
  String get staffCode => 'Staff register Code';

  @override
  String get favorite => 'Favorite';

  @override
  String get cart => 'Cart';

  @override
  String get ticket => 'Ticket';

  @override
  String get ticketList => 'Ticket List';

  @override
  String get email => 'E-mail';

  @override
  String get displayName => 'Display Name';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get pleaseEnterSomeText => 'Please enter some text';

  @override
  String get pleaseEnterSomeNum => 'Please enter some number';

  @override
  String get edit => 'Edit';

  @override
  String get cancel => 'Cancel';

  @override
  String get backButton => 'back';

  @override
  String get message => 'message';

  @override
  String get pleaseEnterADateAfterTheSpecifiedDate =>
      'Please enter a date after the specified date';

  @override
  String get eventName => 'Name';

  @override
  String get detail => 'Detail';

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
  String get validPeriod => 'valid period';

  @override
  String get code => 'code';

  @override
  String get genre => 'genre';

  @override
  String get goods => 'goods';

  @override
  String get foods => 'foods';

  @override
  String get others => 'others';

  @override
  String get productName => 'Product Name';

  @override
  String get productDescription => 'Product Description';

  @override
  String get stock => 'stock';

  @override
  String get price => 'price';

  @override
  String get purchaseHistory => 'Purchase History';

  @override
  String get noPurchaseHistory => 'No Purchase History';

  @override
  String get completion => 'Completion';

  @override
  String get outOfTerm => 'Out of term';

  @override
  String get awaitingPayment =>
      'awaiting payment. Complete the payment in the window that opens.';

  @override
  String get openNewWindow => 'Open new window';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get addToCartQ => 'Add to cart?';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String get doYouWantToDeleteIt => 'Do you want to delete it?';

  @override
  String get processingData => 'Processing Data';

  @override
  String get handoverProcessQ =>
      'Do you want to complete the handover process?';

  @override
  String get handoverProcess => 'Handover process';

  @override
  String get wouldYouLikeToRegisterAsAStaffMember =>
      'Would you like to register as a staff member?';

  @override
  String get confirm => 'confirm';

  @override
  String get theCodeIsWrong => 'the code is wrong';

  @override
  String get thankYouForYourPurchase => 'Thank you for your purchase';

  @override
  String get processingInterrupted => 'Processing interrupted.';

  @override
  String get selectImage => 'select image';

  @override
  String get salesInformation => 'Sales information';

  @override
  String get close => 'close';

  @override
  String get registered => 'Registered';

  @override
  String get notification => 'Notification';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get memberSince => 'Member Since';

  @override
  String get lastUpdated => 'Last Updated';
}
