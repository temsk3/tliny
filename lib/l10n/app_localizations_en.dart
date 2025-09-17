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
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return '$valueString';
  }

  @override
  String currency(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.simpleCurrency(locale: localeName);
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
  String get specificCommercialCode => 'Specified Commercial Transaction Act';

  @override
  String get copyToClipboard => 'Copy to clipboard';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

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
  String get pleaseLogin => 'Please log in';

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

  @override
  String get sellerName => 'Seller Name';

  @override
  String get address => 'Address';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get operatorInCharge => 'Operator in Charge';

  @override
  String get additionalFees => 'Additional Fees';

  @override
  String get returnPolicy => 'Return and Exchange Policy';

  @override
  String get deliveryPeriod => 'Delivery Period';

  @override
  String get paymentMethods => 'Accepted Payment Methods';

  @override
  String get paymentPeriod => 'Payment Period';

  @override
  String get sellingPrice => 'Selling Price';

  @override
  String get disclosureOnRequest =>
      'Will be disclosed without delay upon request';

  @override
  String get noAdditionalFees => 'None';

  @override
  String get customerReturnPolicy =>
      '＜For customer-initiated returns/exchanges＞';

  @override
  String get beforeDelivery =>
      'Before delivery processing: Please contact us by email.';

  @override
  String get afterDelivery =>
      'After delivery processing: Returns/exchanges are generally not accepted.';

  @override
  String get defectiveProduct => '＜For defective products＞';

  @override
  String get contactByEmail => 'Please contact us by email.';

  @override
  String get creditCard => 'Credit Card';

  @override
  String get creditCardProcessing =>
      'Credit card payments are processed immediately.';

  @override
  String get priceOnProductPage => 'Price listed on each product page';

  @override
  String get noEmail => 'No Email';

  @override
  String get noName => 'No Name';

  @override
  String get priceLabel => 'Price';

  @override
  String get ticketNotFound => 'Ticket not found';

  @override
  String get error => 'Error';

  @override
  String get errorDetails => 'Error Details';

  @override
  String get genreGoods => 'Goods';

  @override
  String get genreFoods => 'Foods';

  @override
  String get genreOthers => 'Others';

  @override
  String get changeEmail => 'Change Email Address';

  @override
  String get currentEmail => 'Current Email Address';

  @override
  String get newEmail => 'New Email Address';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get changeEmailDescription =>
      'To change your email address, please enter your current password.';

  @override
  String get emailChangeSuccess =>
      'Email change confirmation email has been sent. Please check the confirmation email at your new email address.';

  @override
  String get emailChangeError => 'Failed to change email address';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get passwordIncorrect => 'Password is incorrect';

  @override
  String get emailAlreadyInUse => 'This email address is already in use';

  @override
  String get emailChangeInProgress => 'Email change in progress...';

  @override
  String get emailChangeCompleted => 'Email address change completed';

  @override
  String get changePassword => 'Change Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get changePasswordDescription =>
      'To change your password, please enter your current password.';

  @override
  String get passwordChangeSuccess => 'Password has been changed successfully.';

  @override
  String get passwordChangeError => 'Failed to change password';

  @override
  String get passwordMismatch => 'New passwords do not match';

  @override
  String get passwordTooWeak =>
      'Password is too weak. Please enter at least 6 alphanumeric characters';

  @override
  String get passwordChangeInProgress => 'Password change in progress...';

  @override
  String get passwordChangeCompleted => 'Password change completed';

  @override
  String get scanQrCodes => 'Scan QR Codes';

  @override
  String get scannedTickets => 'Scanned Tickets';

  @override
  String scannedTicketsCount(int count) {
    return 'Scanned Tickets ($count)';
  }

  @override
  String usedTickets(int count) {
    return '$count Used';
  }

  @override
  String get noTicketsScannedYet => 'No tickets scanned yet';

  @override
  String get scanQrCodesToSeeTickets => 'Scan QR codes to see tickets here';

  @override
  String get unknownTicket => 'Unknown Ticket';

  @override
  String get used => 'Used';

  @override
  String get unused => 'Unused';

  @override
  String get invalidQrCodeFormat => 'Invalid QR code format.';

  @override
  String failedToDecryptQrCode(String error) {
    return 'Failed to decrypt QR code: $error';
  }

  @override
  String get accessDeniedWrongEvent => 'Access denied: Wrong event.';

  @override
  String get ticketScannedSuccessfully => 'Ticket scanned successfully.';

  @override
  String failedToProcessQrCode(String error) {
    return 'Failed to process QR code: $error';
  }

  @override
  String get scannedTicketsTitle => 'Scanned Tickets';

  @override
  String get confirmAction => 'Confirm Action';

  @override
  String get markTicketsAsUsed =>
      'Do you want to mark the scanned ticket as used?';

  @override
  String get ticketsUpdatedSuccessfully => 'Tickets updated successfully.';

  @override
  String get ticketUpdateError => 'Ticket Update Error';

  @override
  String get qrScannerOperationError => 'QR Scanner Operation Error';

  @override
  String get terms => 'Terms of Service';

  @override
  String get sellerRegistration => 'Seller Registration';

  @override
  String get sellerFeature => 'Seller Feature';

  @override
  String get sellerDescription =>
      'To sell products as a seller, please complete the following steps.';

  @override
  String get registerUpdateSeller => 'Register/Update Seller';

  @override
  String get manageSite => 'Management Site';

  @override
  String get manageSiteDescription =>
      'If you want to check sales information, please use the button below to go to the management site.';

  @override
  String get pleasePurchaseNewTicket => 'Please purchase a new ticket';

  @override
  String get showExpiredOrPurchaseNewTicket =>
      'Show expired tickets or purchase a new ticket';

  @override
  String get noCode => 'No code';

  @override
  String get noGenre => 'No Genre';

  @override
  String get noDesc => 'No Description';

  @override
  String get validationError =>
      'There is an error in the input. Please check and try again.';

  @override
  String get permissionError =>
      'You do not have sufficient permissions. Please contact the administrator.';

  @override
  String get databaseError =>
      'A database error has occurred. Please try again later.';

  @override
  String get searchEvent => 'Search Event';

  @override
  String get createEvent => 'Create Event';

  @override
  String get searchText => 'Search Text';

  @override
  String get noTickets => 'No tickets available';

  @override
  String get noAvailableTickets => 'No available tickets';

  @override
  String get purchasedTicketsDisplayedHere =>
      'Purchased tickets will be displayed here';

  @override
  String get hideExpired => 'Hide expired';

  @override
  String get showExpired => 'Show expired';

  @override
  String get sortByEventName => 'Sort by Event Name';

  @override
  String get sortByEventDate => 'Sort by Event Date';

  @override
  String get generatePdf => 'Generate PDF';

  @override
  String get displayQrCode => 'Display QR Code';

  @override
  String get expiredTicket => 'Expired Ticket';

  @override
  String get myEvent => 'My Event';

  @override
  String get non => 'None';
}
