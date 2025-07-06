import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/product_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/common/main_body.dart';
import '../common/loading_screen.dart';
import '../image/image_screen.dart';
import '../product/product_view_model.dart';
import 'cart_view_model.dart';

/// 購入可能な商品一覧画面
class AvailableProductsPage extends HookConsumerWidget {
  const AvailableProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();

    // 商品の状態を取得
    final productsState = ref.watch(productViewModelProvider);
    // カートの ViewModel を取得
    final cartViewModel = ref.watch(cartViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('${l10n.product}一覧')),
      body: MainBodyWidget(
        width: 400,
        body: WidgetWithLoading(
          child: AsyncValueWidget<List<Product>>(
            value: productsState,
            data: (products) {
              // 購入可能な商品のみをフィルタリング
              final availableProducts =
                  products.where((product) {
                    // 在庫がある商品のみ
                    if (product.stock <= 0) {
                      return false;
                    }

                    // 商品がアクティブな商品のみ
                    if (product.isActive != true) {
                      return false;
                    }

                    // 販売期間内の商品のみ
                    final now = DateTime.now();
                    if (product.salesStart != null &&
                        product.salesEnd != null) {
                      if (now.isBefore(product.salesStart!) ||
                          now.isAfter(product.salesEnd!)) {
                        return false;
                      }
                    }

                    return true;
                  }).toList();

              if (availableProducts.isEmpty) {
                return _buildEmptyProductsWidget(context, l10n);
              }

              return RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(productViewModelProvider);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: availableProducts.length,
                  itemBuilder: (context, index) {
                    final product = availableProducts[index];
                    return _buildProductCard(
                      context,
                      product,
                      cartViewModel,
                      ref,
                      l10n,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    Product product,
    CartViewModel cartViewModel,
    WidgetRef ref,
    dynamic l10n,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 商品画像
            if (product.pictureURL.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: PictureView(picture: product.pictureURL, index: 0),
                ),
              ),

            const SizedBox(height: 12),

            // 商品名
            Text(
              product.name ?? '商品名なし',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // 商品説明
            if (product.desc?.isNotEmpty == true)
              Text(
                product.desc!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

            const SizedBox(height: 12),

            // 価格と在庫情報
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '¥${product.price}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  '在庫: ${product.stock}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // カートに追加ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    product.stock > 0
                        ? () async {
                          try {
                            // カートに追加（既存のメソッドを使用）
                            await cartViewModel.cart(
                              1, // quantity
                              product.id!, // productId
                              product.eventId ?? '', // programId
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name}をカートに追加しました'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } on Exception catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('カートへの追加に失敗しました: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                        : null,
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(product.stock > 0 ? 'カートに追加' : '在庫切れ'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyProductsWidget(BuildContext context, dynamic l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            '購入可能な商品がありません',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '現在販売中の商品がありません',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
