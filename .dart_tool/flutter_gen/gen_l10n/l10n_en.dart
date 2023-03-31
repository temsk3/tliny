import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get signUpNow => 'アカウントをお持ちでない場合  ';

  @override
  String get signUp => 'SignUp';

  @override
  String get haveAnAccount => 'すでにアカウントをお持ちの場合  ';

  @override
  String get login => 'Login';

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
  String get edit => 'Edit';

  @override
  String get cancel => 'Cancel';

  @override
  String get message => 'message';

  @override
  String get pleaseEnterADateAfterTheSpecifiedDate => 'Please enter a date after the specified date';

  @override
  String get eventName => 'Name';

  @override
  String get detail => 'Detail';

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
