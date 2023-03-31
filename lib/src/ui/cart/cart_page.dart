import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/repository/program_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/common/main_body.dart';
import 'cart_view_model.dart';
import 'widget/cart_button.dart';
import 'widget/cart_card.dart';

final logger = Logger();

@RoutePage()
class CartPage extends HookConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    // final authState = ref.watch(authViewModelProvider);
    // final uid = authState?.uid;

    final state = ref.watch(cartViewModelProvider);
    final viewModel = ref.watch(cartViewModelProvider.notifier);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        // logger.d(data);
        return Scaffold(
          body: MainBodyWidget(
            body: data.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      // viewModel.readCart(userId: userId);
                      // ref.refresh(cartViewModelProvider);
                    },
                    // child: Column(
                    //   children: [
                    //     // const Text("amount:"),
                    //     PaymentButton(list: data),
                    //     Expanded(
                    // child: ListView.builder(
                    //   physics: const AlwaysScrollableScrollPhysics(),
                    //   // itemExtent: 100,
                    //   itemCount: data.length,
                    //   itemBuilder: (_, index) {
                    //     final cart = data[index];
                    //     return Dismissible(
                    //       key: UniqueKey(),
                    //       onDismissed: (direction) => {
                    //         logger.d('Dismissible'),
                    //         viewModel.deleteCart(cart.id.toString()),
                    //         // if (direction ==
                    //         //     DismissDirection.endToStart)
                    //         //   {
                    //         // 右から左
                    //         // logger.d('DismissibleEndToStart'),
                    //         // }
                    //       },
                    //       background: const ColoredBox(
                    //         color: Colors.red,
                    //         child:
                    //             Icon(Icons.delete, color: Colors.white),
                    //       ),
                    //       child: CartCard(cart: cart),
                    //     );
                    //   },
                    // ),
                    child: GroupedListView(
                      elements: data,
                      groupBy: (element) => element.programId!,
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      itemComparator: (item1, item2) =>
                          item1.productId!.compareTo(item2.productId!),
                      // order: GroupedListOrder.DESC,
                      useStickyGroupSeparators: true,
                      groupSeparatorBuilder: (String value) {
                        //   return Padding(
                        //     padding: const EdgeInsets.all(8),
                        //     child: Text(
                        //       value,
                        //       textAlign: TextAlign.center,
                        //       style: const TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   );
                        // },
                        // groupHeaderBuilder: (element) {
                        final programAsyncValue = ref.watch(
                          ProgramStreamProvider(value),
                          // ProgramStreamProvider(element.programId!),
                        );
                        // logger.d(programAsyncValue);
                        final program = programAsyncValue.value;
                        if (program == null) {
                          return const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                program.name!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Flexible(
                                child: PaymentButton(
                                  appRoute, context,
                                  list: data,
                                  eventId: value,
                                  // eventId: element.programId!,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // itemBuilder: (context, cart) {
                      //   return CartCard(cart: cart);
                      // },
                      indexedItemBuilder: (context, element, index) {
                        logger
                          ..d(element)
                          ..d(index);
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) => {
                            logger.d('Dismissible'),
                            viewModel.deleteCart(element.id.toString()),
                            // if (direction ==
                            //     DismissDirection.endToStart)
                            //   {
                            // 右から左
                            // logger.d('DismissibleEndToStart'),
                            // }
                          },
                          background: const ColoredBox(
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: CartCard(cart: element),
                        );
                      },
                    ),
                    //     ),
                    //   ],
                    // ),
                  )
                : Container(),
          ),
        );
      },
    );
  }
}
