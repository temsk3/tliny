import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/cart/widget/cart_button.dart';

import '../../data/model/cart_model.dart';
import '../../data/repository/program_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../common/loading_screen.dart';
import '../image/image_screen.dart';
import 'cart_view_model.dart';
import 'widget/cart_card.dart';

/// カート画面
// @RoutePage()
class CartPage extends HookConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // テーマを取得
    // final theme = ref.watch(appThemeProvider);
    // ローカリゼーションを取得
    final l10n = useL10n();
    // ルーターを取得
    // final appRoute = useRouter();
    // メディアクエリを取得
    final appMediaQuery = useMediaQuery();

    // カートの状態を取得
    final cartState = ref.watch(cartViewModelProvider);
    // カートの ViewModel を取得
    final cartViewModel = ref.watch(cartViewModelProvider.notifier);

    return AsyncValueWidget<List<Cart>>(
      value: cartState,
      data: (data) {
        logger.d('CartPage: data=$data', time: DateTime.now());
        return WidgetWithLoading(
          child: Scaffold(
            body: MainBodyWidget(
              width: 400,
              body: data.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        logger.d('CartPage: onRefresh', time: DateTime.now());
                        try {
                          await cartViewModel.readCart();
                        } on Exception catch (e, st) {
                          logger.e(
                              'CartPage: onRefresh: error=$e, stackTrace=$st',
                              time: DateTime.now());
                        }
                      },
                      child: GroupedListView<Cart, String>(
                        stickyHeaderBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        elements: data,
                        groupBy: (element) => element.programId!,
                        groupComparator: (value1, value2) =>
                            value2.compareTo(value1),
                        itemComparator: (item1, item2) =>
                            item1.productId!.compareTo(item2.productId!),
                        useStickyGroupSeparators: true,
                        groupSeparatorBuilder: (String value) {
                          logger.d(
                              'CartPage: groupSeparatorBuilder: value=$value',
                              time: DateTime.now());
                          final program =
                              ref.watch(programStreamProvider(value)).value;
                          if (program == null) {
                            return Container();
                          }
                          return SizedBox(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PictureView(
                                    picture: program.pictureURL,
                                    index: 0,
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text(
                                            program.name.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              '${l10n.date(program.eventFrom!)}〜${l10n.date(program.eventTo!)}',
                                              // style: theme.textTheme.h10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: PaymentButton(
                                      // appRoute,
                                      context,
                                      list: data,
                                      event: program,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        indexedItemBuilder: (context, element, index) {
                          logger.d(
                              'CartPage: indexedItemBuilder: element=$element, index=$index',
                              time: DateTime.now());
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) => {
                              logger.d('CartPage: onDismissed',
                                  time: DateTime.now()),
                              cartViewModel.deleteCart(element.id.toString()),
                            },
                            background: const ColoredBox(
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.delete, color: Colors.white),
                                  Icon(Icons.delete, color: Colors.white),
                                ],
                              ),
                            ),
                            child: CartCard(cart: element),
                          );
                        },
                      ),
                    )
                  : Container(),
            ),
          ),
        );
      },
    );
  }
}
