@JS()
library stripe;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:js/js.dart';

Future<void> redirectToCheckout(BuildContext _) async {
  await dotenv.load(fileName: ".env");
  final publishableKey = dotenv.get('STRIPE_PUBLIC');
  final stripe = Stripe(publishableKey);
  stripe.redirectToCheckout(CheckoutOptions(
    lineItems: [
      LineItem(price: "price_1M66DdLwja1iacqrMZ9EW0fW", quantity: 1),
      LineItem(price: "price_1M66hmLwja1iacqrMqWAGahx", quantity: 2),
    ],
    mode: 'payment',
    successUrl: 'http://localhost:58274/#/success',
    cancelUrl: 'http://localhost:58274/#/',
  ));
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
