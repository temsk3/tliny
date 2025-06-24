import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/repository/product_repository.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_media_query.dart';
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
    final l10n = useL10n();
    // ルーターを取得
    // final appRoute = useRouter();
    // メディアクエリを取得
    final appMediaQuery = useMediaQuery();

    // 現在日時を取得
    final now = DateTime.now();
    // 通貨フォーマッターを作成
    final formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    // 商品の詳細情報を取得
    final state = ref.watch(productDocStreamProvider(cart.productDocRef!));
    // カートの ViewModel を取得
    final viewModel = ref.watch(cartViewModelProvider.notifier);

    return AsyncValueButtonWidget<Product>(
      value: state,
      data: (product) {
        logger.d('CartCard: data=$product', time: DateTime.now());
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                // 商品画像を表示
                leading: PictureView(
                  picture: product.pictureURL,
                  index: 0,
                ),
                // 商品名を表示
                title: Text(product.name.toString()),
                // 商品の説明を表示
                subtitle: Text(product.desc.toString()),
                // 商品の数量を表示
                trailing: Text('${l10n.quantity} : ${cart.quantity}'),
              ),
              // 商品詳細へのボタンと削除ボタンを表示
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: ToProductDetailsTextButton(product: product),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DeleteCartTextButton(cartId: cart.id.toString()),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
