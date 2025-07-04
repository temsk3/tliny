import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/checkout/checkout_view_model.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/program_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/routes/routes.dart';
import '../../../ui/cart/cart_view_model.dart';
import '../../../ui/common/asyncvalue_widget.dart';
import '../../../ui/common/error_handler.dart';
import '../../../ui/program/program_state.dart';
import '../../../utils/logger.dart';
import '../../../utils/router_utils.dart';
import '../../common/base_button_widget.dart';
import '../../common/loading_screen.dart';
import '../cart_state.dart';

/// 商品詳細画面への遷移ボタン
class ToProductDetailsTextButton extends HookWidget {
  const ToProductDetailsTextButton({super.key, required this.cart});
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();

    return Consumer(
      child: Text(l10n.productDetails),
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(programListStateProvider),
          data: (list) {
            logger.d(
              'ToProductDetailsTextButton: list=$list',
              time: DateTime.now(),
            );
            try {
              final program = list.firstWhere(
                (program) => program.id == cart.programId,
              );
              return TextButton(
                child: child!,
                onPressed: () {
                  logger.d(
                    'ToProductDetailsTextButton: program.id=${program.id}, cart.productId=${cart.productId}',
                    time: DateTime.now(),
                  );
                  if (program.id != null && cart.productId != null) {
                    ProductDetailsRoute(
                      programId: program.id!,
                      productId: cart.productId!,
                    ).push(context);
                  } else {
                    logger.e(
                      'ToProductDetailsTextButton: program.id or cart.productId is null. program.id=${program.id}, cart.productId=${cart.productId}',
                      time: DateTime.now(),
                    );
                  }
                },
              );
            } on Exception catch (e, st) {
              logger.e(
                'ToProductDetailsTextButton: error=$e, stackTrace=$st',
                time: DateTime.now(),
              );
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}

/// カートアイテム削除ボタン
class DeleteCartTextButton extends HookWidget {
  const DeleteCartTextButton({super.key, required this.cartId});
  final String cartId;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();

    return Consumer(
      child: Text(l10n.delete),
      builder: (context, ref, child) {
        final viewModel = ref.watch(cartViewModelProvider.notifier);
        return TextButton(
          child: child!,
          onPressed: () {
            logger.d(
              'DeleteCartTextButton: onPressed, cartId=$cartId',
              time: DateTime.now(),
            );
            viewModel.deleteCart(cartId);
          },
        );
      },
    );
  }
}

/// 数量増減ボタン
class PlusMinusButtons extends StatelessWidget {
  const PlusMinusButtons({
    super.key,
    required this.product,
    required this.addQuantity,
    required this.deleteQuantity,
    required this.text,
  });
  final Product product;
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}

/// 全商品購入ボタン
class AllPaymentButton extends HookWidget {
  const AllPaymentButton({super.key, required this.list});
  final List<Cart> list;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(totalAmountStateProvider(list)),
          data: (value) {
            return ElevatedButton(
              onPressed: () {},
              child: Text(l10n.currency(value)),
            );
          },
        );
      },
    );
  }
}

/// イベントごとの購入ボタン
class PaymentButton extends HookWidget {
  const PaymentButton(
    // this.appRoute,
    this.ctx, {
    super.key,
    required this.list,
    required this.event,
    // required this.eventId,
  });
  // final StackRouter appRoute;
  final BuildContext ctx;
  final List<Cart> list;
  final Program event;
  // final String eventId;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final eventId = event.id;
    final newList = list.where((e) => e.programId == eventId).toList();
    var sales = true;
    if (event.salesStart == null ||
        event.salesStart!.isAfter(DateTime.now()) ||
        event.salesEnd == null ||
        event.salesEnd!.isBefore(DateTime.now())) {
      sales = false;
    } else {
      sales = true;
    }
    return RepaintBoundary(
      child: Consumer(
        builder: (context, ref, child) {
          return AsyncValueButtonWidget(
            value: ref.watch(totalAmountStateProvider(newList)),
            data: (value) {
              // 在庫チェック
              return FutureBuilder<bool>(
                future: _checkStockAvailability(ref, newList),
                builder: (context, snapshot) {
                  final hasStockIssues = snapshot.data ?? false;

                  logger.d(
                    'PaymentButton: hasStockIssues=$hasStockIssues, sales=$sales, value=$value',
                  );

                  // 在庫不足またはローディング中はボタンを無効化
                  final isButtonEnabled =
                      sales &&
                      !hasStockIssues &&
                      !snapshot.connectionState.toString().contains('waiting');

                  return BaseElevatedButton(
                    onPressed:
                        sales
                            ? () async {
                              logger.d(
                                'PaymentButton: onPressed, eventId=$eventId, value=$value',
                                time: DateTime.now(),
                              );

                              try {
                                final result = await ref
                                    .read(
                                      globalLoadingControllerProvider.notifier,
                                    )
                                    .guardFuture<bool>(() async {
                                      // mountedチェックを追加
                                      if (!context.mounted) {
                                        return false;
                                      }
                                      return ref
                                          .watch(
                                            stripeCheckoutViewModelProvider
                                                .notifier,
                                          )
                                          .getCheckoutPaymentLink(
                                            // appRoute,
                                            ctx,
                                            eventId!,
                                          );
                                    });
                                if (context.mounted && result) {
                                  logger.d(
                                    'PaymentButton: result=$result',
                                    time: DateTime.now(),
                                  );
                                  // await appRoute.pop();
                                  RouterUtils.safePop(ctx);
                                }
                              } catch (e) {
                                logger.e(
                                  'PaymentButton: 決済エラー - $e',
                                  time: DateTime.now(),
                                );

                                // 在庫不足エラーの場合の処理
                                if (e.toString().contains(
                                  'less stock than the quantity',
                                )) {
                                  if (context.mounted) {
                                    await _showStockInsufficientDialog(
                                      ctx,
                                      ref,
                                      newList,
                                    );
                                  }
                                } else {
                                  // その他のエラーは適切にユーザーに表示
                                  if (context.mounted) {
                                    ErrorHandler.showErrorDialog(
                                      ctx,
                                      e,
                                      title: '決済エラー',
                                      onRetry: () {
                                        // 再試行時は同じ処理を実行
                                        Navigator.of(ctx).pop();
                                        // ボタンのonPressedを再実行するためのトリガー
                                        // 実際の再実行はユーザーが再度ボタンを押す必要がある
                                      },
                                    );
                                  }
                                }
                              }
                            }
                            : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.buy),
                        Text(l10n.currency(value)),
                        if (hasStockIssues)
                          Text(
                            '在庫不足',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (snapshot.connectionState.toString().contains(
                          'waiting',
                        ))
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  /// 在庫の可用性をチェックする（リアルタイム更新対応）
  Future<bool> _checkStockAvailability(
    WidgetRef ref,
    List<Cart> cartList,
  ) async {
    try {
      for (final cart in cartList) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          final productId = cart.productDocRef!.split('/').last;
          // リアルタイムで商品データを取得
          final productAsync =
              await ref
                  .read(productRepositoryProvider)
                  .watchProduct(productId)
                  .first;

          if (cart.quantity > (productAsync.stock ?? 0)) {
            logger.d(
              '_checkStockAvailability: 在庫不足 - productId=$productId, cart.quantity=${cart.quantity}, stock=${productAsync.stock}',
            );
            return true; // 在庫不足あり
          }
        }
      }
      logger.d('_checkStockAvailability: 在庫充足');
      return false; // 在庫不足なし
    } catch (e) {
      logger.e('_checkStockAvailability: エラー - $e');
      return true; // エラー時は安全のため在庫不足とみなす
    }
  }

  /// 在庫調整を実行し、調整後の決済継続可否を返す
  Future<bool> _handleStockAdjustment(
    BuildContext context,
    WidgetRef ref,
    List<Cart> cartList,
  ) async {
    try {
      // 在庫不足の商品を特定
      final stockIssues = <Map<String, dynamic>>[];

      for (final cart in cartList) {
        if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
          final productId = cart.productDocRef!.split('/').last;
          final product =
              await ref
                  .read(productRepositoryProvider)
                  .watchProduct(productId)
                  .first;

          if (cart.quantity > (product.stock ?? 0)) {
            stockIssues.add({
              'cart': cart,
              'product': product,
              'currentQuantity': cart.quantity,
              'availableStock': product.stock ?? 0,
            });
          }
        }
      }

      if (stockIssues.isEmpty) {
        return true; // 在庫不足なし
      }

      // 在庫調整の確認ダイアログを表示
      final shouldAdjust = await _showStockAdjustmentDialog(
        context,
        stockIssues,
      );

      if (shouldAdjust) {
        // 在庫調整を実行
        final cartViewModel = ref.read(cartViewModelProvider.notifier);
        final uidAsyncValue = ref.read(userIdProvider);
        final uid = uidAsyncValue.value;

        if (uid != null) {
          for (final issue in stockIssues) {
            final cart = issue['cart'] as Cart;
            final availableStock = issue['availableStock'] as int;

            await cartViewModel.updateCartOptimized(
              uid,
              cart.copyWith(quantity: availableStock),
            );
          }
        }
      }

      return shouldAdjust;
    } catch (e) {
      logger.e('_handleStockAdjustment: エラー - $e');
      return false; // エラー時は処理を中断
    }
  }

  /// 在庫調整の確認ダイアログを表示する
  Future<bool> _showStockAdjustmentDialog(
    BuildContext context,
    List<Map<String, dynamic>> stockIssues,
  ) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.info, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('在庫調整が必要です'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '以下の商品の在庫が不足しています：',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...stockIssues.map((issue) {
                    final product = issue['product'] as Product;
                    final currentQuantity = issue['currentQuantity'] as int;
                    final availableStock = issue['availableStock'] as int;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '・${product.name}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text('  数量: $currentQuantity → $availableStock個'),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  const Text(
                    '数量を調整して決済を続行しますか？',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // キャンセル
                  },
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // 調整して続行
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('調整して続行'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// 在庫不足エラー時のダイアログを表示する
  Future<void> _showStockInsufficientDialog(
    BuildContext context,
    WidgetRef ref,
    List<Cart> cartList,
  ) async {
    // 在庫不足の商品を特定
    final stockIssues = <Map<String, dynamic>>[];

    for (final cart in cartList) {
      if (cart.productDocRef != null && cart.productDocRef!.isNotEmpty) {
        final productId = cart.productDocRef!.split('/').last;
        final product =
            await ref
                .read(productRepositoryProvider)
                .watchProduct(productId)
                .first;

        if (cart.quantity > (product.stock ?? 0)) {
          stockIssues.add({
            'cart': cart,
            'product': product,
            'currentQuantity': cart.quantity,
            'availableStock': product.stock ?? 0,
          });
        }
      }
    }

    if (stockIssues.isNotEmpty) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 8),
                Text('在庫不足エラー'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '以下の商品の在庫が不足しています：',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...stockIssues.map((issue) {
                  final product = issue['product'] as Product;
                  final currentQuantity = issue['currentQuantity'] as int;
                  final availableStock = issue['availableStock'] as int;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '・${product.name}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text('  数量: $currentQuantity → $availableStock個'),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                const Text(
                  'カートの数量を調整してから再度お試しください。',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
