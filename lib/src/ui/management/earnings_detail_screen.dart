import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/ui/common/main_body.dart';

import '../../data/model/ticket_model.dart';
import '../../data/repository/program_repository.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';
import 'management_state.dart';

// @RoutePage()
class EarningsDetailScreen extends HookConsumerWidget {
  const EarningsDetailScreen({
    super.key,
    required this.eventId,
    required this.productId,
    required this.productName,
  });
  final String eventId;
  final String productId;
  final String productName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final l10n = useL10n();
    return AsyncValueWidget(
      value: ref.watch(allTicketStateProvider),
      data: (data) {
        // チケットリストを初期化
        var orderList = <Ticket>[];
        // ログインユーザーのIDを取得
        final userId = ref.watch(userIdProvider).value;
        // ログインユーザーのIDが取得できた場合
        if (userId != null) {
          // イベント情報を取得
          final event = ref.watch(ProgramStreamProvider(eventId)).value;
          // イベント情報が取得できた場合
          if (event != null) {
            // イベント主催者とログインユーザーが異なる場合
            if (event.organizerId != userId) {
              // ログインユーザーが購入したチケットのみ取得
              orderList =
                  data
                      .where(
                        (element) =>
                            element.productId == productId &&
                            element.register == userId,
                      )
                      .toList();
            } else {
              // イベント主催者の場合、すべてのチケットを取得
              orderList =
                  data
                      .where((element) => element.productId == productId)
                      .toList();
            }
            // 購入日時で降順ソート
            orderList.sort(
              (a, b) => b.purchaseTime!.compareTo(a.purchaseTime!),
            );
            // 所有者IDで昇順ソート
            orderList.sort((a, b) => a.ownerId!.compareTo(b.ownerId!));
            // 所有者名で昇順ソート
            orderList.sort((a, b) => a.ownerName!.compareTo(b.ownerName!));
          }
        }
        // チケットリストをログ出力
        logger.d(orderList);

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
            getTitleItemWidget('ステータス', 80),
            getTitleItemWidget('受取者', 100),
            getTitleItemWidget('受付者', 100),
            getTitleItemWidget('引渡し時間', 100),
          ];
        }

        // 左側のカラムの行のWidgetを作成する関数
        Widget generateFirstColumnRow(BuildContext context, int index) {
          return Container(
            width: 80,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.center,
            child:
                orderList[index].isUsed
                    ? const Icon(Icons.check_circle_outline)
                    : const Text(''),
          );
        }

        // 右側のカラムの行のWidgetを作成する関数
        Widget generateRightHandSideColumnRow(BuildContext context, int index) {
          return Row(
            children: <Widget>[
              // 受取者の名前を表示
              Container(
                width: 100,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  orderList[index].ownerName.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 受付者の名前を表示
              Container(
                width: 100,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  orderList[index].registerName.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 引渡し日時を表示
              Container(
                width: 100,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  orderList[index].deletedAt.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text(productName)),
          body: MainBodyWidget(
            body:
                orderList.isEmpty
                    ? Container()
                    : Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      child: HorizontalDataTable(
                        leftHandSideColumnWidth: 80,
                        rightHandSideColumnWidth: 300,
                        isFixedHeader: true,
                        headerWidgets: getTitleWidget(),
                        leftSideItemBuilder: generateFirstColumnRow,
                        rightSideItemBuilder: generateRightHandSideColumnRow,
                        itemCount: orderList.length,
                        rowSeparatorWidget: Divider(
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1,
                          thickness: 0,
                        ),
                        leftHandSideColBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        rightHandSideColBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
          ),
        );
      },
    );
  }
}
