import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../ui/common/asyncvalue_widget.dart';
import '../../../utils/logger.dart';
import '../../image/image_screen.dart';
import '../cart_view_model.dart';
import 'cart_button.dart';

/// カート内の商品アイテムを表示するWidget
class CartCard extends HookConsumerWidget {
  const CartCard({super.key, required this.cart});

  /// カートアイテム
  final Cart cart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // テーマを取得
    // final theme = ref.watch(appThemeProvider);
    // ローカリゼーションを取得
    // // final l10n = useL10n();
    // ルーターを取得
    // final appRoute = useRouter();
    // メディアクエリを取得
    // final appMediaQuery = useMediaQuery();

    // 現在日時を取得
    // final now = DateTime.now();
    // 通貨フォーマッターを作成
    final formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    // 商品IDを抽出
    final productId =
        cart.productDocRef != null && cart.productDocRef!.isNotEmpty
            ? cart.productDocRef!.split('/').last
            : null;

    // 商品データを取得（リアルタイム更新対応）
    final state =
        productId != null
            ? ref.watch(productStreamProvider(productId))
            : const AsyncValue<Product?>.data(null);

    // カートの ViewModel を取得
    final viewModel = ref.watch(cartViewModelProvider.notifier);

    // 数量変更コールバックをメモ化してリビルドを最適化
    final decreaseQuantity = useMemoized(() {
      return () async {
        final uidAsyncValue = ref.read(userIdProvider);
        final uid = uidAsyncValue.value;
        if (uid != null && cart.quantity > 1) {
          final newQuantity = cart.quantity - 1;
          await viewModel.updateCartOptimized(
            uid,
            cart.copyWith(quantity: newQuantity),
          );
        }
      };
    }, [cart.quantity, cart.id]);

    final increaseQuantity = useMemoized(() {
      return () async {
        final uidAsyncValue = ref.read(userIdProvider);
        final uid = uidAsyncValue.value;
        if (uid != null) {
          final newQuantity = cart.quantity + 1;
          await viewModel.updateCartOptimized(
            uid,
            cart.copyWith(quantity: newQuantity),
          );
        }
      };
    }, [cart.quantity, cart.id]);

    // 在庫不足時の確認ダイアログと自動調整をAsyncValueWidgetの外で実行
    useEffect(() {
      state.whenData((product) {
        if (product != null) {
          final stock = product.stock;
          final isStockInsufficient = cart.quantity > stock;

          logger.d(
            'CartCard: useEffect - cart.quantity=${cart.quantity}, stock=$stock, isStockInsufficient=$isStockInsufficient',
          );

          if (isStockInsufficient && stock > 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              // 確認ダイアログを表示
              final shouldAdjust = await _showStockAdjustmentDialog(
                context,
                product,
                cart.quantity,
                stock,
              );

              if (shouldAdjust) {
                final uidAsyncValue = ref.read(userIdProvider);
                final uid = uidAsyncValue.value;
                if (uid != null) {
                  logger.d(
                    'CartCard: 在庫調整実行 - cartId=${cart.id}, quantity=${cart.quantity} → $stock',
                  );
                  await viewModel.updateCartOptimized(
                    uid,
                    cart.copyWith(quantity: stock),
                  );
                }
              }
            });
          }
        }
      });
      return null;
    }, [state, cart.quantity, productId]); // productIdも依存関係に追加

    return AsyncValueButtonWidget<Product?>(
      value: state,
      data: (product) {
        logger.d('CartCard: data=$product', time: DateTime.now());
        if (product == null) {
          return const Card(child: ListTile(title: Text('商品が見つかりません')));
        }

        // 単価と小計を計算
        final unitPrice = product.price;
        final subtotal = unitPrice * cart.quantity;
        final stock = product.stock;

        // 在庫不足チェック
        final isStockInsufficient = cart.quantity > stock;
        final adjustedQuantity = isStockInsufficient ? stock : cart.quantity;

        return RepaintBoundary(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 在庫不足警告
                  if (isStockInsufficient)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.orange.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.orange.shade700,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '在庫が不足しています。数量を$stock個に調整しました。',
                              style: TextStyle(
                                color: Colors.orange.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  // 商品の基本情報
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 商品画像
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: PictureView(
                            picture: product.pictureURL,
                            index: 0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // 商品情報
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 商品名
                            Text(
                              product.name.toString(),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // 価格情報（固定幅で表示位置を統一）
                            Row(
                              children: [
                                // 単価（固定幅）
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    '単価: ${formatter.format(unitPrice)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey[700]),
                                  ),
                                ),
                                // 小計（固定幅）
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    '小計: ${formatter.format(subtotal)}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // 数量変更ボタン
                            Row(
                              children: [
                                // 減らすボタン
                                IconButton(
                                  onPressed:
                                      adjustedQuantity > 1
                                          ? decreaseQuantity
                                          : null,
                                  icon: const Icon(Icons.remove),
                                  iconSize: 20,
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                ),
                                // 数量表示
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$adjustedQuantity',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // 増やすボタン
                                IconButton(
                                  onPressed:
                                      adjustedQuantity < stock
                                          ? increaseQuantity
                                          : null,
                                  icon: const Icon(Icons.add),
                                  iconSize: 20,
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // 在庫情報（在庫不足時は赤色で表示）
                                Text(
                                  '在庫: $stock',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        isStockInsufficient
                                            ? Colors.red.shade700
                                            : Colors.grey[600],
                                    fontWeight:
                                        isStockInsufficient
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // アクションボタン
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ToProductDetailsTextButton(cart: cart),
                      DeleteCartTextButton(cartId: cart.id.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 在庫減少の通知ダイアログを表示する
  Future<bool> _showStockAdjustmentDialog(
    BuildContext context,
    Product product,
    int currentQuantity,
    int availableStock,
  ) async {
    try {
      return await showDialog<bool?>(
            context: context,
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
    } on Exception catch (e, st) {
      logger.e(
        'CartCard: 在庫調整ダイアログエラー - $e',
        stackTrace: st,
        time: DateTime.now(),
      );
      // エラーが発生した場合は調整する（trueを返す）
      return true;
    }
  }
}

// 商品データを取得するStreamProvider（リアルタイム更新対応）
Stream<Product?> productStream(Ref ref, String productId) {
  return ref.watch(productRepositoryProvider).watchProduct(productId);
}
