import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:tliny/src/ui/cart/widget/cart_button.dart';

import '../../data/model/cart_model.dart';
import '../../data/model/product_model.dart';
import '../../data/repository/program_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../common/error_handler.dart';
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

    // カートの状態を取得
    final cartState = ref.watch(cartViewModelProvider);
    // カートの ViewModel を取得
    final cartViewModel = ref.watch(cartViewModelProvider.notifier);

    // カートデータが読み込まれた後に在庫調整を実行
    useEffect(() {
      if (cartState.value != null && cartState.value!.isNotEmpty) {
        logger.d('CartPage: useEffect - 在庫調整を実行します', time: DateTime.now());
        WidgetsBinding.instance.addPostFrameCallback((_) {
          cartViewModel.adjustCartForStock(
            showConfirmationDialog: (product, currentQuantity, availableStock) {
              return _showStockAdjustmentDialog(
                context,
                product,
                currentQuantity,
                availableStock,
              );
            },
          );
        });
      }
      return null;
    }, [cartState.value?.length]); // カートの数が変更された時に実行

    return AsyncValueWidget<List<Cart>>(
      value: cartState,
      data: (data) {
        logger.d('CartPage: data=$data', time: DateTime.now());

        return WidgetWithLoading(
          child: Scaffold(
            body: MainBodyWidget(
              width: 400,
              body:
                  data.isNotEmpty
                      ? RefreshIndicator(
                        onRefresh: () async {
                          logger.d('CartPage: onRefresh', time: DateTime.now());
                          try {
                            await cartViewModel.readCart();
                            // リフレッシュ時にも在庫調整を実行
                            await cartViewModel.adjustCartForStock(
                              showConfirmationDialog: (
                                product,
                                currentQuantity,
                                availableStock,
                              ) {
                                return _showStockAdjustmentDialog(
                                  context,
                                  product,
                                  currentQuantity,
                                  availableStock,
                                );
                              },
                            );
                          } on Exception catch (e, st) {
                            logger.e(
                              'CartPage: onRefresh: error=$e, stackTrace=$st',
                              time: DateTime.now(),
                            );
                            // エラーをユーザーに表示
                            if (context.mounted) {
                              ErrorHandler.showErrorSnackBar(context, e);
                            }
                          }
                        },
                        child: GroupedListView<Cart, String>(
                          stickyHeaderBackgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          elements: data,
                          groupBy: (element) => element.programId!,
                          groupComparator:
                              (value1, value2) => value2.compareTo(value1),
                          itemComparator:
                              (item1, item2) =>
                                  item1.productId!.compareTo(item2.productId!),
                          useStickyGroupSeparators: true,
                          groupSeparatorBuilder: (String value) {
                            logger.d(
                              'CartPage: groupSeparatorBuilder: value=$value',
                              time: DateTime.now(),
                            );
                            final program =
                                ref.watch(programStreamProvider(value)).value;
                            if (program == null) {
                              return Container();
                            }

                            // このプログラムに属するカートアイテムのみを抽出
                            final programCarts =
                                data
                                    .where((cart) => cart.programId == value)
                                    .toList();

                            return RepaintBoundary(
                              child: SizedBox(
                                height: 70,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    12,
                                    12,
                                    4,
                                  ),
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
                                                  '${l10n.date(program.eventFrom!)}'
                                                  '〜${l10n.date(program.eventTo!)}',
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
                                          list:
                                              programCarts, // 該当プログラムのカートのみを渡す
                                          event: program,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          indexedItemBuilder: (context, element, index) {
                            logger.d(
                              'CartPage: indexedItemBuilder: '
                              'element=$element, index=$index',
                              time: DateTime.now(),
                            );
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed:
                                  (direction) => {
                                    logger.d(
                                      'CartPage: onDismissed',
                                      time: DateTime.now(),
                                    ),
                                    cartViewModel.deleteCart(
                                      element.id.toString(),
                                    ),
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
                      : _buildEmptyCartWidget(context, l10n),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyCartWidget(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            'カートが空です',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '商品をカートに追加してください',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 在庫減少の通知ダイアログを表示する
  Future<bool> _showStockAdjustmentDialog(
    BuildContext context,
    Product product,
    int currentQuantity,
    int availableStock,
  ) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false, // ダイアログ外タップで閉じない
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('在庫減少のお知らせ'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '「${product.name}」の在庫が減少しました。',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('現在の数量: $currentQuantity個'),
                  Text('利用可能な在庫: $availableStock個'),
                  const SizedBox(height: 8),
                  const Text(
                    '数量を在庫数に調整します。',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // 調整する
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        ) ??
        true; // ダイアログがキャンセルされた場合もtrueを返す（調整する）
  }
}
