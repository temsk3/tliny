import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
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
              orderList
                  .where((element) => element.status == StatusType.order)
                  .toList();
          // 注文リストをログ出力
          logger.d(data);

          // 注文リストから商品リストを作成
          for (final order in data) {
            productList.addAll(order.snapshotProducts!);
          }

          // 商品リストから商品種類リストを作成
          for (final product in productList) {
            kindsList.add(product.productId.toString());
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
              amount += element.quantity! * element.price!;
              quantity += element.quantity!;

              // 商品情報を取得
              final product =
                  ref.watch(productStreamProvider(element.productId!)).value!;

              // 商品コードと商品名を設定
              code = product.code.toString();
              name = product.name.toString();
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

        // ヘッダー項目のWidgetを作成する関数
        Widget getTitleItemWidget(String label, double width) {
          return Container(
            width: width,
            height: 56,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }

        // ヘッダー項目のWidgetリストを作成する関数
        List<Widget> getTitleWidget() {
          return [
            getTitleItemWidget('コード', 150),
            getTitleItemWidget('商品名', 150),
            getTitleItemWidget('販売数', 80),
            getTitleItemWidget('金額', 100),
          ];
        }

        // 左側のカラムの行のWidgetを作成する関数
        Widget generateFirstColumnRow(BuildContext context, int index) {
          return Container(
            width: 150,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              salesData[index]['code'].toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        // 右側のカラムの行のWidgetを作成する関数
        Widget generateRightHandSideColumnRow(BuildContext context, int index) {
          return Row(
            children: <Widget>[
              // 商品名を表示
              Container(
                width: 150,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  salesData[index]['name'].toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 販売数を表示
              Container(
                width: 80,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  l10n.decimalPattern(salesData[index]['quantity'] as int),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 金額を表示
              Container(
                width: 100,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  l10n.currency(salesData[index]['amount'] as int),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        }

        // 販売データリストが空の場合、統一された空状態を表示
        return salesData.isEmpty
            ? Center(
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
                          color: Colors.grey.withOpacity(0.1),
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
            )
            // 販売データリストが空でない場合、HorizontalDataTableを表示
            : Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: HorizontalDataTable(
                // 左側のカラムの幅
                leftHandSideColumnWidth: 150,
                // 右側のカラムの幅
                rightHandSideColumnWidth: 350,
                // ヘッダーを固定するかどうか
                isFixedHeader: true,
                // ヘッダーのWidgetリスト
                headerWidgets: getTitleWidget(),
                // 左側のカラムの行のWidgetを作成する関数
                leftSideItemBuilder: generateFirstColumnRow,
                // 右側のカラムの行のWidgetを作成する関数
                rightSideItemBuilder: generateRightHandSideColumnRow,
                // 行の数
                itemCount: salesData.length,
                // 行間の区切り線
                rowSeparatorWidget: Divider(
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1,
                  thickness: 0,
                ),
                // 左側のカラムの背景色
                leftHandSideColBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                // 右側のカラムの背景色
                rightHandSideColBackgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
              ),
            );
      },
    );
  }
}
