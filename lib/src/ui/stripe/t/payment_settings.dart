// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stripe_sdk/stripe_sdk.dart';

// import 'add_payment_method.dart';
// import 'confirm_purchase_screen.dart';

// final paymentMethodsProvider =
//     StateNotifierProvider.autoDispose<PaymentMethods, PaymentMethodsData>(
//         (ref) => PaymentMethods());

// final defaultPaymentMethodProvider = StateNotifierProvider.autoDispose<
//     DefaultPaymentMethod,
//     DefaultPaymentMethodData>((ref) => DefaultPaymentMethod());

// class PaymentSettings extends ConsumerWidget {
//   PaymentSettings({super.key});
//   final TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final paymentMethods = ref.watch(paymentMethodsProvider.notifier);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Payment settings"),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.add),
//               onPressed: () async {
//                 final added = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const AddPaymentMethod()));
//                 if (added == true) await paymentMethods.refresh();
//               },
//             )
//           ],
//         ),
//         body: const SafeArea(child: PaymentMethodsList())
//         //  ChangeNotifierProvider(
//         //     builder: (_) => DefaultPaymentMethod(),
//         //     child: PaymentMethodsList())
//         );
//   }
// }

// @immutable
// class PaymentMethodsData {
//   const PaymentMethodsData(this.paymentMethods);
//   final List<PaymentMethod?>? paymentMethods;
// }

// class PaymentMethods extends StateNotifier<PaymentMethodsData> {
//   PaymentMethods() : super(const PaymentMethodsData(null)) {
//     refresh();
//   }
//   List<PaymentMethod> paymentMethods = [];
//   late Future<List<PaymentMethod>> paymentMethodsFuture;

//   Future<void> refresh() {
//     final session = CustomerSession.instance;
//     return session.listPaymentMethods().then((value) {
//       final List listData = value['data'] ?? <PaymentMethod>[];
//       if (listData.isEmpty) {
//         paymentMethods = [];
//       } else {
//         paymentMethods = listData
//             .map((item) => PaymentMethod(
//                 item['id'], item['card']['last4'], item['card']['brand']))
//             .toList();
//       }
//     });
//   }
// }

// @immutable
// class DefaultPaymentMethodData {
//   const DefaultPaymentMethodData(this.paymentMethodId);
//   final String? paymentMethodId;
// }

// class DefaultPaymentMethod extends StateNotifier<DefaultPaymentMethodData> {
//   DefaultPaymentMethod() : super(const DefaultPaymentMethodData(null)) {
//     init();
//   }
//   String paymentMethodId = "";

//   static const String defaultPaymentMethod = 'defaultPaymentMethod';
//   final uid = FirebaseAuth.instance.currentUser?.uid ?? 'test';

//   init() async {
//     state = await FirebaseFirestore.instance
//         .collection('/v/1/stripe_customers')
//         .doc(uid)
//         .get()
//         .then((event) => event.get(defaultPaymentMethod));
//   }

//   set(String newPaymentMethod) async {
//     await FirebaseFirestore.instance
//         .collection('/v/1/stripe_customers')
//         .doc(uid)
//         .update({defaultPaymentMethod: newPaymentMethod});

//     state = newPaymentMethod as DefaultPaymentMethodData;
//   }
// }

// class PaymentMethodsList extends ConsumerWidget {
//   const PaymentMethodsList({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final stripeSession = CustomerSession.instance;
//     final paymentMethods = ref.watch(paymentMethodsProvider.notifier);
//     final listData = paymentMethods.paymentMethods;
//     final defaultPaymentMethod =
//         ref.watch(defaultPaymentMethodProvider.notifier);
//     if (listData == null) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     return RefreshIndicator(
//       onRefresh: () => paymentMethods.refresh(),
//       child: buildListView(listData, stripeSession, defaultPaymentMethod,
//           paymentMethods, context),
//     );
//   }

//   Widget buildListView(
//       List<PaymentMethod> listData,
//       CustomerSession stripeSession,
//       DefaultPaymentMethod defaultPaymentMethod,
//       PaymentMethods paymentMethods,
//       BuildContext rootContext) {
//     if (listData.isEmpty) {
//       return ListView();
//     } else {
//       return ListView.builder(
//           itemCount: listData.length,
//           itemBuilder: (context, index) {
//             final card = listData[index];
//             return ListTile(
//               onLongPress: () async {
//                 showDialog(
//                     context: rootContext,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text("Delete card"),
//                         content: const Text("Do you want to delete this card?"),
//                         actions: <Widget>[
//                           ElevatedButton(
//                             child: const Text("No"),
//                             onPressed: () => Navigator.pop(rootContext),
//                           ),
//                           ElevatedButton(
//                               child: const Text("Yes"),
//                               onPressed: () async {
//                                 Navigator.pop(rootContext);
//                                 showDialog(
//                                     context: rootContext,
//                                     barrierDismissible: false,
//                                     builder: (context) => const Center(
//                                         child: CircularProgressIndicator()));
//                                 final result = await stripeSession
//                                     .detachPaymentMethod(card.id);
//                                 Navigator.pop(rootContext);
//                                 await paymentMethods.refresh();
//                                 ScaffoldMessenger.of(rootContext)
//                                     .showSnackBar(const SnackBar(
//                                   content: Text(
//                                       'Payment method successfully deleted.'),
//                                 ));
//                               })
//                         ],
//                       );
//                     });
//               },
//               onTap: () => defaultPaymentMethod.set(card.id),
//               subtitle: Text(card.last4),
//               title: Text(card.brand),
//               leading: const Icon(Icons.credit_card),
//               trailing: card.id == defaultPaymentMethod.paymentMethodId
//                   ? const Icon(Icons.check_circle)
//                   : null,
//             );
//           });
//     }
//   }
// }
