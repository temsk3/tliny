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
  String get salesPeriod => 'Sales Period';

  @override
  String get periods => 'Event Period';

  @override
  String get place => 'Venue';

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

  @override
  String get productListTitle => 'Product List';

  @override
  String get noProductName => 'No product name';

  @override
  String stockInfo(int stock) {
    return 'Stock: $stock';
  }

  @override
  String addedToCartMessage(String productName) {
    return '$productName has been added to cart';
  }

  @override
  String addToCartFailed(String error) {
    return 'Failed to add to cart: $error';
  }

  @override
  String get addToCartButton => 'Add to Cart';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get noAvailableProducts => 'No available products';

  @override
  String get noProductsOnSale => 'No products currently on sale';

  @override
  String get cartIsEmpty => 'Cart is empty';

  @override
  String get pleaseAddProductsToCart => 'Please add products to cart';

  @override
  String get stockReductionNotice => 'Stock Reduction Notice';

  @override
  String stockReducedMessage(String productName) {
    return 'Stock for \"$productName\" has been reduced.';
  }

  @override
  String currentQuantity(int quantity) {
    return 'Current quantity: $quantity';
  }

  @override
  String availableStock(int stock) {
    return 'Available stock: $stock';
  }

  @override
  String get adjustQuantityToStock =>
      'Quantity will be adjusted to stock level.';

  @override
  String get returnToHome => 'Return to Home';

  @override
  String get processing => 'Processing...';

  @override
  String get insufficientStock =>
      'Insufficient stock. Please adjust the quantity and try again.';

  @override
  String get networkError =>
      'Network error occurred. Please check your internet connection and try again.';

  @override
  String get authenticationError =>
      'Authentication error occurred. Please log in again.';

  @override
  String get paymentError =>
      'Payment processing error occurred. Please try again later.';

  @override
  String get serverError => 'Server error occurred. Please try again later.';

  @override
  String get timeoutError => 'Request timed out. Please try again later.';

  @override
  String get imageLoadError =>
      'Failed to load image. Please try another image.';

  @override
  String get heicNotSupported =>
      'HEIC format images are not currently supported. Please use JPEG or PNG format.';

  @override
  String get generalError => 'An error occurred. Please try again later.';

  @override
  String get retry => 'Retry';

  @override
  String get productNotFound => 'Product not found';

  @override
  String stockInsufficientMessage(int stock) {
    return 'Insufficient stock. Quantity adjusted to $stock.';
  }

  @override
  String unitPrice(String price) {
    return 'Unit price: $price';
  }

  @override
  String subtotal(String price) {
    return 'Subtotal: $price';
  }

  @override
  String stockInfoShort(int stock) {
    return 'Stock: $stock';
  }

  @override
  String get paymentErrorTitle => 'Payment Error';

  @override
  String get insufficientStockTitle => 'Insufficient Stock';

  @override
  String get insufficientStockDetails =>
      'The following products have insufficient stock:';

  @override
  String quantityAdjustment(int current, int available) {
    return 'Quantity: $current → $available';
  }

  @override
  String get adjustCartAndRetry =>
      'Please adjust the cart quantity and try again.';

  @override
  String get pleaseEnterEmail => 'Please enter email address';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email address';

  @override
  String get pleaseEnterPassword => 'Please enter password';

  @override
  String get passwordRequirements =>
      'Password must be at least 6 characters of alphanumeric characters';

  @override
  String get passwordMinLength => 'Password must be at least 4 characters';

  @override
  String get passwordMaxLength => 'Password must be 72 characters or less';

  @override
  String get invalidKatakanaFormat => 'Invalid katakana format';

  @override
  String get katakanaAndNumbersOnly => 'Please enter katakana and numbers only';

  @override
  String get invalidRomanFormat => 'Invalid roman format';

  @override
  String get invalidEmailFormat => 'Invalid email address format';

  @override
  String get invalidBirthDate => 'Invalid birth date format';

  @override
  String get invalidPhoneNumber => 'Phone number must be 10 or 11 digits';

  @override
  String get invalidPostalCode => 'Postal code must be 7 digits with hyphen';

  @override
  String get eventPeriod => 'Event Period';
}
