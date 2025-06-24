// import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';
import 'management_state.dart';

// @RoutePage()
class EarningsScreen extends HookConsumerWidget {
  const EarningsScreen({super.key, required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    return AsyncValueWidget(
      value: ref.watch(productsManagementStateProvider(eventId)),
      data: (data) {
        // アクティブな商品リストを取得
        final productList =
            data.where((product) => product.isActive == true).toList();
        // 商品名を昇順でソート
        productList
            .sort((a, b) => a.name.toString().compareTo(b.name.toString()));
        // 商品コードを昇順でソート
        productList
            .sort((a, b) => a.code.toString().compareTo(b.code.toString()));

        // 商品リストが空でない場合
        if (productList.isNotEmpty) {
          // 商品リストを表示するListView.builderを作成
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            physics: const AlwaysScrollableScrollPhysics(),
            itemExtent: 100,
            itemCount: productList.length,
            itemBuilder: (_, index) {
              // 商品を取得
              final product = productList[index];
              // 商品の詳細画面に遷移するListTileを作成
              return ListTile(
                title: Text(product.code.toString()),
                subtitle: Text(product.name.toString()),
                onTap: () {
                  try {
                    // 商品の詳細画面に遷移
                    // appRoute.push(
                    EarningsDetailRoute(
                      eventId: eventId,
                      productId: product.id.toString(),
                      productName: product.name.toString(),
                      // ),
                    ).push(context);
                  } on Exception catch (e) {
                    // エラーが発生した場合、エラーログを出力
                    logger
                        .e('Failed to navigate to earnings detail screen: $e');
                  }
                },
              );
            },
          );
        } else {
          // 商品リストが空の場合、空のコンテナを表示
          return Container();
        }
      },
    );
  }
}
