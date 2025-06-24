// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:logger/logger.dart';
// import 'package:tliny/src/ui/favorite/widget/favorite_card.dart';

// import '../common/asyncvalue_widget.dart';
// import '../common/main_body.dart';
// import 'favorite_view_model.dart';

// final logger = Logger();

// @RoutePage()
// class FavoritePage extends HookConsumerWidget {
//   const FavoritePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final theme = ref.watch(appThemeProvider);
//     // final l10n = useL10n();
//     // final appRoute = useRouter();
//     // final appMQ = useMediaQuery();
//     final state = ref.watch(favoriteViewModelProvider);
//     final viewModel = ref.watch(favoriteViewModelProvider.notifier);
//     return AsyncValueWidget(
//       value: state,
//       data: (data) {
//         return Scaffold(
//           body: MainBodyWidget(
//             width: 400,
//             body: data.isNotEmpty
//                 ? ListView.builder(
//                     padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     itemExtent: 100,
//                     itemCount: data.length,
//                     itemBuilder: (_, index) {
//                       final favorite = data[index];
//                       // return TicketCard(
//                       //   ticket: ticket,
//                       //   checkList: checkList,
//                       // );
//                       return FavoriteCard(favorite: favorite);
//                     },
//                   )
//                 : Container(),
//           ),
//           // floatingActionButton: FloatingActionButton(
//           //   onPressed: () {
//           //     // viewModel.addTicket(Ticket.empty());
//           //     appRoute.push(
//           //       CreateQRCodeRoute(
//           //         ticketList: checkList.state,
//           //       ),
//           //     );
//           //   },
//           //   child: const Icon(Icons.qr_code),
//           // ),
//         );
//       },
//     );
//   }
// }
