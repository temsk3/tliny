import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import '../../settings/hooks/use_l10n.dart';
import '../common/asyncvalue_widget.dart';
import 'management_state.dart';

/// 在庫画面
// @RoutePage()
class StockScreen extends HookConsumerWidget {
  /// コンストラクタ
  const StockScreen({super.key, required this.eventId});

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

    // 商品リストを取得
    return AsyncValueWidget(
      value: ref.watch(productsManagementStateProvider(eventId)),
      data: (data) {
        // アクティブな商品リストを取得
        final productList =
            data.where((product) => product.isActive == true).toList();
        // 商品名を昇順でソート
        productList.sort(
          (a, b) => a.name.toString().compareTo(b.name.toString()),
        );
        // 商品コードを昇順でソート
        productList.sort(
          (a, b) => a.code.toString().compareTo(b.code.toString()),
        );

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
            getTitleItemWidget('在庫数', 80),
            getTitleItemWidget('金額', 80),
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
              productList[index].code.toString(),
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
                  productList[index].name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 在庫数を表示
              Container(
                width: 80,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  l10n.decimalPattern(productList[index].stock),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 金額を表示
              Container(
                width: 80,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  l10n.currency(productList[index].price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        }

        // 商品リストが空の場合、統一された空状態を表示
        return productList.isEmpty
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
                      Icons.inventory_2_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '在庫データがありません',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '商品が登録されると、ここに在庫データが表示されます',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
            // 商品リストが空でない場合、HorizontalDataTableを表示
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
                itemCount: productList.length,
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
