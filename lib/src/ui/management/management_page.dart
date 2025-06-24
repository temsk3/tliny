import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';

/// イベント管理画面
class ManagementPage extends HookConsumerWidget {
  /// コンストラクタ
  const ManagementPage(this.eventId, {super.key});

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

    final _tabTitles = <String>['販売', '売上', '在庫'];

    // タブバーを作成
    return DefaultTabController(
      length: _tabTitles.length,
      child: Scaffold(
          // AppBarを作成
          appBar: AppBar(
            // タイトルを設定
            title: Text(l10n.salesInformation),
            // タブバーをAppBarの下に表示
            bottom: TabBar(
              tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
            ),
          ),
          body: TabBarView(
            children: [
              EarningsTab(eventId: eventId)
                  .build(context, GoRouterState.of(context)),
              SalesTab(eventId: eventId)
                  .build(context, GoRouterState.of(context)),
              StockTab(eventId: eventId)
                  .build(context, GoRouterState.of(context)),
            ],
          )),
    );
  }
}
