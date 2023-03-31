// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'payment_settings.dart';

// class ConfirmPurchaseResult {
//   final String paymentMethod;
//   final int numTickets;

//   const ConfirmPurchaseResult(this.paymentMethod, this.numTickets);
// }

// class ConfirmPurchase extends ConsumerStatefulWidget {
//   const ConfirmPurchase({super.key});

//   @override
//   _ConfirmPurchaseState createState() => _ConfirmPurchaseState();
// }

// class _ConfirmPurchaseState extends ConsumerState<ConfirmPurchase> {
//   int count = 1;
//   late String paymentMethod;

//   @override
//   void initState() {
//     super.initState();
//     ref.read(defaultPaymentMethodProvider);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final loc = AppLocalizations.of(context);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Spacer(
//               flex: 2,
//             ),
//             // ignore: prefer_const_constructors
//             Text(
//               'confirmPurchase.title',
//               style: const TextStyle(
//                 fontSize: 24,
//               ),
//             ),
//             const Spacer(
//               flex: 3,
//             ),
//             Row(
//               children: <Widget>[
//                 const Text("Kjøp "),
//                 NumberPicker(
//                   value: count,
//                   onChanged: (value) => setState(() {
//                     count = value;
//                   }),
//                 ),
//                 const Text("garderobeplass"),
//               ],
//             ),
//             const Spacer(
//               flex: 3,
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               child: Text("Betalingsmetode"),
//             ),
//             PaymentMethodSelector(
//               selectedPaymentMethod: paymentMethod,
//               onChanged: (method) => setState(() {
//                 paymentMethod = method;
//               }),
//             ),
//             const Spacer(
//               flex: 3,
//             ),
//             const Text('confirmPurchase.body'),
//             const Spacer(
//               flex: 2,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 ElevatedButton(
//                   child: const Text("Avbryt"),
//                   onPressed: () {
//                     Navigator.of(context).pop(null);
//                   },
//                 ),
//                 ElevatedButton(
//                   child: const Text("Neste"),
//                   onPressed: () {
//                     Navigator.of(context)
//                         .pop(ConfirmPurchaseResult(paymentMethod, count));
//                   },
//                 )
//               ],
//             ),
//             const Spacer(
//               flex: 1,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PaymentMethod {
//   final String id;
//   final String last4;
//   final String brand;

//   PaymentMethod(this.id, this.last4, this.brand);
// }

// class PaymentMethodSelector extends ConsumerWidget {
//   const PaymentMethodSelector(
//       {Key? key, required this.selectedPaymentMethod, required this.onChanged})
//       : super(key: key);

//   final String selectedPaymentMethod;
//   final void Function(String) onChanged;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final paymentMethods = ref.watch(paymentMethodsProvider);

//     final method = paymentMethods.paymentMethods?.singleWhere(
//         (item) => item?.id == selectedPaymentMethod,
//         orElse: () => null);
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(),
//       ),
//       child: DropdownButton(
//         underline: null,
//         isExpanded: true,
//         value: method?.id,
//         items: paymentMethods.paymentMethods
//             ?.map((item) => DropdownMenuItem(
//                   value: item?.id,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text("**** **** **** ${item?.last4}"),
//                   ),
//                 ))
//             .toList(),
//         onChanged: (value) => onChanged(value.toString()),
//       ),
//     );
//   }
// }

// class NumberPicker extends StatelessWidget {
//   const NumberPicker({
//     Key? key,
//     required this.value,
//     required this.onChanged,
//   }) : super(key: key);

//   final void Function(int value) onChanged;
//   final int value;

//   @override
//   Widget build(BuildContext context) => Row(
//         children: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.arrow_left),
//             onPressed: () {
//               if (value > 1) onChanged(value - 1);
//             },
//           ),
//           Text(value.toString()),
//           IconButton(
//             icon: const Icon(Icons.arrow_right),
//             onPressed: () {
//               if (value < 10) onChanged(value + 1);
//             },
//           ),
//         ],
//       );
// }
