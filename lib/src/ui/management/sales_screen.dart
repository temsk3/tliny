import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/repository/product_repository.dart';
import 'package:tliny/src/ui/management/management_state.dart';

import '../../data/model/order_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';

/// 販売画面
// @RoutePage()
class SalesScreen extends HookConsumerWidget {
  /// コンストラクタ
  const SalesScreen({super.key, required this.eventId});

  /// イベントID
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // テーマを取得
    // final theme = ref.watch(appThemeProvider);
    // ローカリゼーションを取得
    final l10n = useL10n();
    // ルーターを取得
    // final appRoute = useRouter();

    // 販売データを取得
    return AsyncValueWidget(
      value: ref.watch(managementStateProvider(eventId)),
      data: (orderList) {
        // null安全: orderListがnullなら空リストとして扱う
        final safeOrderList = orderList ?? <Order>[];
        // 商品リスト
        final productList = <SnapshotProduct>[];
        // 商品種類リスト
        final kindsList = <String>{};
        // 販売データリスト
        final salesData = <Map<String, dynamic>>[];

        // エラー処理
        try {
          // 注文ステータスが「注文済み」の注文リストを取得
          final data =
              safeOrderList
                  .where((element) => element.status == StatusType.order)
                  .toList();
          // 注文リストをログ出力
          logger.d(data);

          // 注文リストから商品リストを作成
          for (final order in data) {
            // null安全: snapshotProductsがnullならスキップ
            if (order.snapshotProducts != null) {
              productList.addAll(order.snapshotProducts!);
            }
          }

          // 商品リストから商品種類リストを作成
          for (final product in productList) {
            if (product.productId != null) {
              kindsList.add(product.productId.toString());
            }
          }

          // 商品種類リストから販売データリストを作成
          for (final element in kindsList) {
            // 商品種類に対応する商品リストを取得
            final result =
                productList
                    .where((product) => product.productId == element)
                    .toList();

            // 商品コード、商品名、販売数、金額を初期化
            var code = '';
            var name = '';
            var amount = 0;
            var quantity = 0;

            // 商品リストから販売数と金額を計算
            for (final element in result) {
              // null安全: quantity, priceがnullなら0として扱う
              final q = element.quantity ?? 0;
              final p = element.price ?? 0;
              amount += q * p;
              quantity += q;

              // 商品情報を取得
              if (element.productId != null) {
                final product =
                    ref.watch(productStreamProvider(element.productId!)).value;
                if (product != null) {
                  code = product.code?.toString() ?? '';
                  name = product.name?.toString() ?? '';
                }
              }
            }

            // 販売データリストに販売データを追加
            salesData.add({
              'code': code,
              'name': name,
              'quantity': quantity,
              'amount': amount,
            });
          }

          // 販売データリストを商品名で昇順ソート
          salesData.sort(
            (a, b) => a['name'].toString().compareTo(b['name'].toString()),
          );

          // 販売データリストを商品コードで昇順ソート
          salesData.sort(
            (a, b) => a['code'].toString().compareTo(b['code'].toString()),
          );
        } on Exception catch (e, st) {
          // エラーが発生した場合、エラーログを出力
          logger.e('Error', time: DateTime.now(), error: e, stackTrace: st);
        }

        // 販売データリストが空の場合、統一された空状態を表示
        if (salesData.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.point_of_sale_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '販売データがありません',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '商品が販売されると、ここに販売データが表示されます',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        // 販売データリストが空でない場合、洗練されたカードレイアウトを表示
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: salesData.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final sale = salesData[index];
            final salesLevel = _getSalesLevel(sale['quantity'] as int);

            return AnimatedContainer(
              duration: Duration(milliseconds: 300 + (index * 100)),
              curve: Curves.easeOutCubic,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ヘッダー部分
                        Row(
                          children: [
                            // 商品アイコン
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: salesLevel.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.point_of_sale,
                                color: salesLevel.color,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // 商品情報
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sale['name'].toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'コード: ${sale['code']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 販売ステータスバッジ
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: salesLevel.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: salesLevel.color.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                salesLevel.label,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: salesLevel.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // 販売詳細情報
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              // 販売数
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '販売数',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      l10n.decimalPattern(
                                        sale['quantity'] as int,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // 販売金額
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '販売金額',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      l10n.currency(sale['amount'] as int),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // 販売レベルを判定する関数
  SalesLevel _getSalesLevel(int quantity) {
    if (quantity >= 100) {
      return SalesLevel(label: '大ヒット', color: Colors.green);
    } else if (quantity >= 50) {
      return SalesLevel(label: '好調', color: Colors.blue);
    } else if (quantity >= 20) {
      return SalesLevel(label: '普通', color: Colors.orange);
    } else {
      return SalesLevel(label: '少ない', color: Colors.grey);
    }
  }
}

// 販売レベルを表すクラス
class SalesLevel {
  SalesLevel({required this.label, required this.color});
  final String label;
  final Color color;
}
