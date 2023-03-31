import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/service/stripe/checkout/stripe_checkout.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
// import 'package:stripe_sdk/stripe_sdk_ui.dart';
import '../sample/sample_view_model.dart';

@RoutePage()
class Sample2Page extends HookConsumerWidget {
  const Sample2Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    // final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();

    // var screenSize = appMQ.size;

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(screenSize.width, 1000),
      //   child: Container(
      //     // color: Colors.blue,
      //     child: Padding(
      //       padding: const EdgeInsets.all(20),
      //       child: Row(
      //         children: [
      //           const Text('EXPLORE'),
      //           Expanded(
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 InkWell(
      //                   onTap: () {},
      //                   child: const Text(
      //                     'Discover',
      //                     style: TextStyle(color: Colors.black),
      //                   ),
      //                 ),
      //                 SizedBox(width: screenSize.width / 20),
      //                 InkWell(
      //                   onTap: () {},
      //                   child: const Text(
      //                     'Contact Us',
      //                     style: TextStyle(color: Colors.black),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           InkWell(
      //             onTap: () {},
      //             child: const Text(
      //               'Sign Up',
      //               style: TextStyle(color: Colors.black),
      //             ),
      //           ),
      //           SizedBox(
      //             width: screenSize.width / 50,
      //           ),
      //           InkWell(
      //             onTap: () {},
      //             child: const Text(
      //               'Login',
      //               style: TextStyle(color: Colors.black),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // const SizedBox(height: 200),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   // child: CardField(),
              // ),
              // const SizedBox(height: 200),
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: ElevatedButton(
              //     // onPressed: _handlePayPress,
              //     onPressed: () {},
              //     child: const Text('pay'),
              //   ),
              // ),
              // CardForm(card: StripeCard()),

              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  // onPressed: _handlePayPress,
                  onPressed: () {
                    redirectToCheckout(context);
                  },
                  child: const Text('pay'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  // onPressed: _handlePayPress,
                  onPressed: () {
                    ref
                        .read(sampleViewModelProvider)
                        .goUrl('http://www.google.co.jp');
                  },
                  child: const Text('account link'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  // onPressed: _handlePayPress,
                  onPressed: () {
                    ref.read(sampleViewModelProvider).checkoutSession();
                  },
                  child: const Text('checkout link'),
                ),
              ),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      appRoute.pop(const SampleRoute());
                    },
                    child: const Text('sample'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appRoute.pushNamed('/success');
                    },
                    child: const Text('success'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appRoute.pushNamed(
                        '/success?payment_intent_client_secret=123',
                      );
                    },
                    child: const Text('success/123'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appRoute.push(const StripeRoute());
                    },
                    child: const Text('stripe'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () async {},
          child: const Icon(Icons.add_sharp),
        ),
      ),
    );
  }
}


// Future<void> _handlePayPress() async {
//    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
//      //ダミーのカード情報
//      number: '4242424242424242',
//      expirationYear: 25,
//      expirationMonth: 03,
//      cvc: '111',
//    ));

  
//      // 1. 顧客の請求情報を収集する
//      final billingDetails = BillingDetails(
//        email: 'email@stripe.com',
//        phone: '+48888000888',
//        address: Address(
//          city: 'Houston',
//          country: 'US',
//          line1: '1459  Circle Drive',
//          line2: '',
//          state: 'Texas',
//          postalCode: '77063',
//        ),
//      ); // ダミー

//    // 2. お支払い方法の作成
//      final paymentMethod = await
//      Stripe.instance.createPaymentMethod(params:PaymentMethodParams.card(paymentMethodData: PaymentMethodData(billingDetails: billingDetails,),
//      ),);

//    // 3. APIを呼び出してPaymentIntentを取得
//     final paymentIntentResult = await createPaymentIntent();}

//      final kApiUrl = Uri.https('api.stripe.com', 'v1/payment_intents');

//   Future<Map<String, dynamic>> createPaymentIntent() async {
//    final secretKey = dotenv.get('STRIPE_SECRET');
//    final body = <String, dynamic>{
//      'amount': '2000',
//      'currency': 'jpy',
//      'payment_method_types[]': 'card',
//    };

//    final response = await http.post(
//      kApiUrl,
//      headers: {
//        'Authorization': 'Bearer $secretKey',
//        'Content-Type': 'application/x-www-form-urlencoded',
//      },
//      body: body,
//    );
//    final paymentIntent = jsonDecode(response.body);
//    return paymentIntent;
//  }
//  final confirmResult = await Stripe.instance.confirmPayment(
//        paymentIntentResult['client_secret'],
//        PaymentMethodParams.card(
//            billingDetails: billingDetails,
//            setupFutureUsage: PaymentIntentsFutureUsage.OffSession),
//      );