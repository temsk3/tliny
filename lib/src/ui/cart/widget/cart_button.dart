import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:tliny/src/ui/checkout/checkout_view_model.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/exception/app_exception.dart';
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
          value: ref.watch(programsStateProvider),
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
                    ).push<void>(context);
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

/// 全商品の購入ボタン
class AllPaymentButton extends HookWidget {
  const AllPaymentButton({super.key, required this.list});
  final List<Cart> list;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, child) {
        // 認証状態を取得
        final authState = ref.watch(authStateChangesProvider);
        final isAuthenticated =
            authState.hasValue && (authState.value ?? false);

        return AsyncValueButtonWidget(
          value: ref.watch(totalAmountProvider(list)),
          data: (value) {
            return ElevatedButton(
              onPressed: isAuthenticated ? () {} : null,
              child: Text(
                isAuthenticated ? l10n.currency(value) : l10n.pleaseLogin,
              ),
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
    this.ctx, {
    super.key,
    required this.list,
    required this.event,
  });

  final BuildContext ctx;
  final List<Cart> list;
  final Program event;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final eventId = event.id;
    final newList = list.where((e) => e.programId == eventId).toList();

    // 前回の値を保持するためのstate
    final previousValue = useState<int?>(null);

    // セールス期間のチェック
    final sales =
        event.salesStart != null &&
        event.salesStart!.isBefore(DateTime.now()) &&
        event.salesEnd != null &&
        event.salesEnd!.isAfter(DateTime.now());

    logger.d(
      'PaymentButton: eventId=$eventId, originalList.length=${list.length}, newList.length=${newList.length}, previousValue=${previousValue.value}',
    );

    return RepaintBoundary(
      child: HookConsumer(
        builder: (context, ref, child) {
          // 新しいAsyncNotifierProviderを使用
          final totalAmountAsync = ref.watch(
            totalAmountProvider(newList),
          );

          return totalAmountAsync.when(
            data: (value) {
              // 前回の値を更新（ビルド中にsetStateが呼ばれないよう条件を調整）
              if (previousValue.value == null || previousValue.value != value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (previousValue.value != value) {
                    previousValue.value = value;
                  }
                });
              }

              logger.d(
                'PaymentButton: value=$value, previousValue=${previousValue.value}',
              );

              // 在庫チェック
              return FutureBuilder<bool>(
                future: _checkStockAvailability(ref, newList),
                builder: (context, snapshot) {
                  final hasStockIssues = snapshot.data ?? false;

                  logger.d(
                    'PaymentButton: hasStockIssues=$hasStockIssues, sales=$sales, value=$value',
                  );

                  // 認証状態を取得
                  final authState = ref.watch(authStateChangesProvider);
                  final isAuthenticated =
                      authState.hasValue && (authState.value ?? false);

                  // 在庫不足、ローディング中、または未認証の場合はボタンを無効化
                  final isButtonEnabled =
                      sales &&
                      !hasStockIssues &&
                      !snapshot.connectionState.toString().contains(
                        'waiting',
                      ) &&
                      isAuthenticated;

                  logger.d(
                    'PaymentButton: value=$value, isAuthenticated=$isAuthenticated, isButtonEnabled=$isButtonEnabled',
                  );

                  return _buildButtonWithValue(
                    l10n,
                    value,
                    isAuthenticated,
                    isButtonEnabled,
                    hasStockIssues,
                    snapshot.connectionState.toString().contains('waiting'),
                    eventId,
                    newList,
                    event,
                    ctx,
                    ref,
                    sales,
                  );
                },
              );
            },
            loading: () {
              // ローディング中は前回の値を使用
              final displayValue = previousValue.value ?? 0;
              logger.d(
                'PaymentButton: ローディング中、前回の値を使用 displayValue=$displayValue',
              );

              return FutureBuilder<bool>(
                future: _checkStockAvailability(ref, newList),
                builder: (context, snapshot) {
                  final hasStockIssues = snapshot.data ?? false;

                  // 認証状態を取得
                  final authState = ref.watch(authStateChangesProvider);
                  final isAuthenticated =
                      authState.hasValue && (authState.value ?? false);

                  // 在庫不足、ローディング中、または未認証の場合はボタンを無効化
                  final isButtonEnabled =
                      sales &&
                      !hasStockIssues &&
                      !snapshot.connectionState.toString().contains(
                        'waiting',
                      ) &&
                      isAuthenticated;

                  return _buildButtonWithValue(
                    l10n,
                    displayValue,
                    isAuthenticated,
                    isButtonEnabled,
                    hasStockIssues,
                    snapshot.connectionState.toString().contains('waiting'),
                    eventId,
                    newList,
                    event,
                    ctx,
                    ref,
                    sales,
                  );
                },
              );
            },
            error: (error, stackTrace) {
              logger.e(
                'PaymentButton: totalAmountNotifierProvider error - $error',
                stackTrace: stackTrace,
              );
              // エラー時は前回の値を使用
              final displayValue = previousValue.value ?? 0;
              logger.d(
                'PaymentButton: エラー時、前回の値を使用 displayValue=$displayValue',
              );

              return FutureBuilder<bool>(
                future: _checkStockAvailability(ref, newList),
                builder: (context, snapshot) {
                  final hasStockIssues = snapshot.data ?? false;

                  // 認証状態を取得
                  final authState = ref.watch(authStateChangesProvider);
                  final isAuthenticated =
                      authState.hasValue && (authState.value ?? false);

                  // 在庫不足、ローディング中、または未認証の場合はボタンを無効化
                  final isButtonEnabled =
                      sales &&
                      !hasStockIssues &&
                      !snapshot.connectionState.toString().contains(
                        'waiting',
                      ) &&
                      isAuthenticated;

                  return _buildButtonWithValue(
                    l10n,
                    displayValue,
                    isAuthenticated,
                    isButtonEnabled,
                    hasStockIssues,
                    snapshot.connectionState.toString().contains('waiting'),
                    eventId,
                    newList,
                    event,
                    ctx,
                    ref,
                    sales,
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

          if (cart.quantity > productAsync.stock) {
            logger.d(
              '_checkStockAvailability: 在庫不足 - productId=$productId, cart.quantity=${cart.quantity}, stock=${productAsync.stock}',
            );
            return true; // 在庫不足あり
          }
        }
      }
      logger.d('_checkStockAvailability: 在庫充足');
      return false; // 在庫不足なし
    } on Exception catch (e) {
      logger.e('_checkStockAvailability: エラー - $e');
      return true; // エラー時は安全のため在庫不足とみなす
    }
  }

  /// 在庫不足エラー時のダイアログを表示する
  Future<void> _showStockInsufficientDialog(
    BuildContext context,
    AppLocalizations l10n,
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

          if (cart.quantity > product.stock) {
            stockIssues.add({
              'cart': cart,
              'product': product,
              'currentQuantity': cart.quantity,
              'availableStock': product.stock,
            });
          }
        }
      }

      if (stockIssues.isNotEmpty) {
        if (context.mounted) {
          await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(l10n.insufficientStockTitle),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.insufficientStockDetails,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              l10n.quantityAdjustment(
                                currentQuantity,
                                availableStock,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Text(
                      l10n.adjustCartAndRetry,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Text(l10n.ok),
                  ),
                ],
              );
            },
          );
        }
      }
    } on AppException catch (e, st) {
      logger.e(
        'PaymentButton: 在庫不足ダイアログ AppException - ${e.message}',
        stackTrace: st,
        time: DateTime.now(),
      );
      // エラーをアラートダイアログで表示
      if (context.mounted) {
        final l10n = AppLocalizations.of(context);
        if (l10n != null) {
          ErrorHandler.showError(
            context,
            e,
            l10n,
            errorContext: 'PaymentButton_stockDialog',
          );
        }
      }
    } on Exception catch (e, st) {
      logger.e(
        'PaymentButton: 在庫不足ダイアログ Exception - $e',
        stackTrace: st,
        time: DateTime.now(),
      );
      // エラーをアラートダイアログで表示
      if (context.mounted) {
        final l10n = AppLocalizations.of(context);
        if (l10n != null) {
          final appException = GeneralException(
            message: '在庫不足エラーが発生しました。カートの数量を確認してください。',
            stackTrace: st,
          );
          ErrorHandler.showError(
            context,
            appException,
            l10n,
            errorContext: 'PaymentButton_stockDialog',
          );
        }
      }
    }
  }

  /// ボタンの状態に応じて表示するウィジェットを生成する
  Widget _buildButtonWithValue(
    AppLocalizations l10n,
    int value,
    bool isAuthenticated,
    bool isButtonEnabled,
    bool hasStockIssues,
    bool isLoading,
    String? eventId,
    List<Cart> newList,
    Program event,
    BuildContext ctx,
    WidgetRef ref,
    bool sales,
  ) {
    return BaseElevatedButton(
      l10n: l10n,
      onPressed:
          isButtonEnabled
              ? () async {
                logger.d(
                  'PaymentButton: onPressed, eventId=$eventId, value=$value',
                  time: DateTime.now(),
                );

                try {
                  if (value == 0) {
                    await ref
                        .watch(stripeCheckoutViewModelProvider.notifier)
                        .freeOrderAndIssueTickets(ctx, newList, event);
                    return;
                  }
                  final result = await ref
                      .read(globalLoadingControllerProvider.notifier)
                      .guardFuture<bool>(() async {
                        // mountedチェックを追加
                        if (!ctx.mounted) {
                          return false;
                        }
                        return ref
                            .watch(stripeCheckoutViewModelProvider.notifier)
                            .getCheckoutPaymentLink(
                              // appRoute,
                              ctx,
                              eventId ?? '',
                            );
                      });
                  if (ctx.mounted && result) {
                    logger.d(
                      'PaymentButton: result=$result',
                      time: DateTime.now(),
                    );
                    // await appRoute.pop();
                    RouterUtils.safePop(ctx);
                  }
                } on AppException catch (e, st) {
                  logger.e(
                    'PaymentButton: AppException - ${e.message}',
                    time: DateTime.now(),
                    stackTrace: st,
                  );

                  // エラーをアラートダイアログで表示
                  if (ctx.mounted) {
                    final l10n = AppLocalizations.of(ctx)!;
                    ErrorHandler.showError(
                      ctx,
                      e,
                      l10n,
                      errorContext: 'PaymentButton',
                      onRetry: () async {
                        // 決済処理を再実行
                        try {
                          final result = await ref
                              .read(globalLoadingControllerProvider.notifier)
                              .guardFuture<bool>(() async {
                                if (!ctx.mounted) {
                                  return false;
                                }
                                return ref
                                    .watch(
                                      stripeCheckoutViewModelProvider.notifier,
                                    )
                                    .getCheckoutPaymentLink(ctx, eventId ?? '');
                              });
                          if (ctx.mounted && result) {
                            RouterUtils.safePop(ctx);
                          }
                        } on Exception catch (e) {
                          // 再実行時のエラーは無視
                          logger.d('PaymentButton: retry error ignored - $e');
                        }
                      },
                    );
                  }
                } on Exception catch (e, st) {
                  logger.e(
                    'PaymentButton: Exception - $e',
                    time: DateTime.now(),
                    stackTrace: st,
                  );

                  // 在庫不足エラーの場合の処理
                  if (e.toString().contains('less stock than the quantity')) {
                    if (ctx.mounted) {
                      await _showStockInsufficientDialog(
                        ctx,
                        l10n,
                        ref,
                        newList,
                      );
                    }
                  } else {
                    // その他のエラーは適切にユーザーに表示
                    if (ctx.mounted) {
                      final l10n = AppLocalizations.of(ctx)!;
                      final appException = GeneralException(
                        message: e.toString(),
                        stackTrace: st,
                      );
                      ErrorHandler.showError(
                        ctx,
                        appException,
                        l10n,
                        errorContext: 'PaymentButton',
                        onRetry: () async {
                          // 決済処理を再実行
                          try {
                            final result = await ref
                                .read(globalLoadingControllerProvider.notifier)
                                .guardFuture<bool>(() async {
                                  if (!ctx.mounted) {
                                    return false;
                                  }
                                  return ref
                                      .watch(
                                        stripeCheckoutViewModelProvider
                                            .notifier,
                                      )
                                      .getCheckoutPaymentLink(
                                        ctx,
                                        eventId ?? '',
                                      );
                                });
                            if (ctx.mounted && result) {
                              RouterUtils.safePop(ctx);
                            }
                          } on Exception catch (e) {
                            // 再実行時のエラーは無視
                            logger.d('PaymentButton: retry error ignored - $e');
                          }
                        },
                      );
                    }
                  }
                }
              }
              : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart, size: 16),
              const SizedBox(width: 4),
              Text(
                l10n.buy,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (hasStockIssues || !sales) ...[
            const SizedBox(height: 1),
            if (hasStockIssues)
              Text(
                '在庫不足',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            else if (!sales)
              Text(
                '販売期間外',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ],
      ),
    );
  }
}
