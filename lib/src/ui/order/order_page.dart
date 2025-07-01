// /Users/keizo/development/tliny/lib/src/ui/order/order_page.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/repository/program_repository.dart';

import '../../data/model/order_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';
import '../common/main_body.dart';
import 'order_view_model.dart';

// @RoutePage()
class OrderPage extends HookConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(orderViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.purchaseHistory),
        centerTitle: true,
        elevation: 1,
      ),
      body: MainBodyWidget(
        width: 600, // Increased width for better readability
        body: AsyncValueWidget(
          value: state,
          data: (list) {
            logger.d('OrderPage build: 全注文数=${list.length}');

            // 購入済み注文のみ取得
            final data =
                list
                    .where((element) => element.status == StatusType.order)
                    .toList();
            logger.d('OrderPage build: 購入済み注文数=${data.length}');

            // 購入日時で降順ソート
            if (data.isNotEmpty) {
              data.sort((a, b) => -a.purchaseTime!.compareTo(b.purchaseTime!));
            }
            logger.d('OrderPage build: 表示対象注文数=${data.length}');

            return data.isNotEmpty
                ? ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: data.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(
                        height: 16,
                      ), // Add spacing between cards
                  itemBuilder: (context, index) {
                    final order = data[index];
                    return OrderCard(order: order);
                  },
                )
                : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noPurchaseHistory,
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
          },
        ),
      ),
    );
  }
}

class OrderCard extends HookConsumerWidget {
  const OrderCard({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    var amount = 0;

    // 購入金額を計算
    if (order.snapshotProducts != null) {
      for (final element in order.snapshotProducts!) {
        final sum = (element.price ?? 0) * (element.quantity ?? 0);
        amount += sum;
      }
    }

    logger.d(
      'OrderCard build: orderId=${order.id}, eventId=${order.eventId}, amount=$amount',
    );

    // eventIdがnullの場合はエラー表示
    if (order.eventId == null) {
      logger.e('OrderCard: eventIdがnullです orderId=${order.id}');
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text('イベント情報が見つかりません', style: TextStyle(color: Colors.red)),
        ),
      );
    }

    return AsyncValueWidget(
      value: ref.watch(programFutureProvider(order.eventId!)),
      data: (data) {
        return data != null
            ? Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // プログラム名を表示
                    Text(
                      data.name.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 購入日時と金額を表示
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.date(order.purchaseTime!)} ${l10n.time(order.purchaseTime!)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          l10n.currency(amount),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    // 購入した商品一覧を表示
                    order.snapshotProducts != null &&
                            order.snapshotProducts!.isNotEmpty
                        ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.snapshotProducts!.length,
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final product = order.snapshotProducts![index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // 商品名を表示
                                  Expanded(
                                    child: Text(
                                      product.name.toString(),
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // 商品価格と数量を表示
                                  Text(
                                    '${l10n.currency(product.price ?? 0)} x ${product.quantity ?? 0}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            )
            : Container();
      },
    );
  }
}
