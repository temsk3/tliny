import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/l10n/app_localizations.dart';

import '../../data/model/cart_model.dart';
import '../../data/model/product_model.dart';
import '../../data/repository/program_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../cart/cart_state.dart';
import '../common/error_handler.dart';
import '../image/image_screen.dart';
import 'cart_view_model.dart';
import 'widget/cart_button.dart';
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
        logger.d('CartPage: data.length=${data.length}', time: DateTime.now());
        logger.d('CartPage: data details:', time: DateTime.now());
        for (final cart in data) {
          logger.d(
            '  - id: ${cart.id}, programId: "${cart.programId}", productId: ${cart.productId}, createdAt: ${cart.createdAt}',
            time: DateTime.now(),
          );
        }

        return Scaffold(
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
                            ErrorHandler.showErrorSnackBar(context, e, l10n);
                          }
                        }
                      },
                      child: GroupedListView<Cart, String>(
                        stickyHeaderBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        elements: data,
                        groupBy: (element) {
                          // programIdが空またはnullの場合は未分類
                          if (element.programId?.isEmpty != false) {
                            return '未分類';
                          }

                          // programIdを正規化（空白文字を除去）してグループ化
                          return element.programId!.trim();
                        },
                        groupComparator: (value1, value2) {
                          // 未分類グループは最後に表示
                          if (value1 == '未分類') return 1;
                          if (value2 == '未分類') return -1;

                          // シンプルな文字列比較
                          return value1.compareTo(value2);
                        },
                        itemComparator: (item1, item2) {
                          final a = item1.createdAt ?? DateTime(2000);
                          final b = item2.createdAt ?? DateTime(2000);
                          return a.compareTo(b);
                        },
                        useStickyGroupSeparators: true,
                        groupSeparatorBuilder:
                            (String value) => _buildGroupSeparator(
                              context,
                              ref,
                              l10n,
                              value,
                              data,
                            ),
                        itemBuilder: (context, element) {
                          return Dismissible(
                            key: Key(element.id!),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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

  Widget _buildGroupSeparator(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    String value,
    List<Cart> data,
  ) {
    // シンプルなprogramIdベースのグループ化（最適化済み）
    final groupCarts = useMemoized(() {
      return data.where((cart) {
        if (value == '未分類') {
          return cart.programId?.isEmpty != false;
        } else {
          // programIdを正規化して比較
          final normalizedCartProgramId = cart.programId?.trim() ?? '';
          final normalizedValue = value.trim();
          return normalizedCartProgramId == normalizedValue;
        }
      }).toList();
    }, [data, value]);

    // 「未分類」グループの場合
    if (value == '未分類') {
      return RepaintBoundary(
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 45,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.category_outlined,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '未分類',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, height: 1),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 90,
                  height: 60,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      '個別購入',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // イベント情報を取得
    final programAsync = ref.watch(programStreamProvider(value));

    return programAsync.when(
      data: (program) {
        final programCarts = groupCarts;
        return RepaintBoundary(
          child: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: PictureView(
                      picture: program.pictureURL,
                      index: 0,
                      height: 45,
                      width: 60,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            program.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 10,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 2),
                              Text(
                                l10n.periods,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                  fontSize: 9,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              _formatPeriod(
                                l10n,
                                program.eventFrom,
                                program.eventTo,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                                fontSize: 9,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80,
                    child: Consumer(
                      builder: (context, ref, _) {
                        final total = ref.watch(
                          totalAmountProvider(programCarts),
                        );
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 合計金額を上に表示
                            total.when(
                              data:
                                  (int value) => Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 70,
                                    ),
                                    child: Text(
                                      l10n.currency(value),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              loading:
                                  () => const SizedBox(
                                    width: 20,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                              error: (_, __) => const SizedBox(width: 20),
                            ),
                            const SizedBox(height: 4),
                            // ボタンを下に表示
                            PaymentButton(
                              context,
                              list: programCarts,
                              event: program,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () {
        return Container(
          height: 60,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: const Row(
            children: [
              SizedBox(
                width: 60,
                height: 45,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              SizedBox(width: 8),
              Expanded(child: Text('プログラム情報取得中...')),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        if (kDebugMode) {
          logger.e(
            'CartPage: groupSeparatorBuilder: error loading program for value="$value" - $error',
            time: DateTime.now(),
            stackTrace: stackTrace,
          );
        }
        return Container(
          height: 60,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.error, color: Colors.red),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'プログラム情報取得エラー',
                  style: TextStyle(color: Colors.red[600]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatPeriod(AppLocalizations l10n, DateTime? from, DateTime? to) {
    if (from != null && to != null) {
      return '${l10n.date(from)} 〜 ${l10n.date(to)}';
    } else if (from != null) {
      return l10n.date(from);
    } else if (to != null) {
      return l10n.date(to);
    }
    return '';
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
