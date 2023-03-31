// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:logger/logger.dart';

// import '../../../settings/hooks/use_router.dart';
// import '../../../settings/routes/app_route.gr.dart';
// import 'checkout_view_model.dart';

// final logger = Logger();

// const email = 'temsk3@gmail.com';
// const organizerId = 'RDDJIcocSwIFrZq7Ym6KrrN5xQhE';
// const orderId = 'testOrder';
// const lineItems = [
//   {
//     'price': 'price_1M66hmLwja1iacqrMqWAGahx',
//     // 'price': 'price_1MUKFSPtsvfIDR9DrAkLSkSm',
//     // 'price': "price_1MWqbrPo1pjwLqm09J3fy350",
//     'quantity': 1,
//   },
// ];

// @RoutePage()
// class CheckoutPage extends HookConsumerWidget {
//   const CheckoutPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appRoute = useRouter();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkout'),
//       ),
//       body: SafeArea(
//         // child: Center(
//         child:
//             //  Column(children: [
//             //
//             ListView(
//           children: <Widget>[
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     appRoute.pop(const StripeRoute());
//                   },
//                   child: const Text('pop'),
//                 ),
//               ],
//             ),
//             Card(
//               child: ListTile(
//                 title: const Text('checkout setup link'),
//                 onTap: () => ref
//                     .read(stripeCheckoutViewModelProvider)
//                     .getCheckoutSetupLink(email),
//               ),
//             ),
//             Card(
//               child: ListTile(
//                 title: const Text('checkout payment link'),
//                 onTap: () => ref
//                     .read(stripeCheckoutViewModelProvider)
//                     .getCheckoutPaymentLink(
//                       appRoute,
//                       context,
//                       organizerId,
//                       orderId,
//                       lineItems,
//                     ),
//               ),
//             ),
//             // ]),
//           ],
//         ),
//         // ),
//       ),
//     );
//   }
// }
