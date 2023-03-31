// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:stripe_sdk/stripe_sdk_ui.dart';

// import '../stripe_view_model.dart';

// class AddPaymentMethod extends ConsumerStatefulWidget {
//   const AddPaymentMethod({Key? key}) : super(key: key);

//   @override
//   _AddPaymentMethodState createState() => _AddPaymentMethodState();
// }

// class _AddPaymentMethodState extends ConsumerState<AddPaymentMethod> {
//   @override
//   void initState() {
//     super.initState();
//     ref.read(stripeViewModelProvider);
//   }

//   final StripeCard _cardData = StripeCard();
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   late Future<Map<String, dynamic>> setupIntent;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Add payment method'),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.save),
//               onPressed: () async {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (context) =>
//                           const Center(child: CircularProgressIndicator()));
//                   ref
//                       .watch(stripeViewModelProvider)
//                       .addPaymentMethod(context, _cardData);
//                   // var paymentMethod =
//                   //     await stripeApi.createPaymentMethodFromCard(_cardData);
//                   // paymentMethod = await stripeSession
//                   //     .attachPaymentMethod(paymentMethod['id']);
//                   // final createSetupIntentResponse = await glappenService
//                   //     .createSetupIntent(paymentMethod['id']);
//                   // Navigator.pop(context);

//                   // if (createSetupIntentResponse['status'] == 'succeeded') {
//                   //   Navigator.pop(context, true);
//                   //   return;
//                   // }
//                   // var setupIntent = await stripe.confirmSetupIntent(
//                   //     createSetupIntentResponse['client_secret']);

//                   // if (setupIntent['status'] == 'succeeded') {
//                   //   Navigator.pop(context, true);
//                   //   return;
//                   // }
//                 }
//               },
//             )
//           ],
//         ),
//         body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: CardForm(
//               card: _cardData,
//               formKey: _formKey,
//             )));
//   }
// }
