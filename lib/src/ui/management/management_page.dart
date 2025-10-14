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

    final tabTitles = <String>['販売', '売上', '在庫'];

    // タブバーを作成
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        // AppBarを作成
        appBar: AppBar(
          // タイトルを設定
          title: Text(
            l10n.salesInformation,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          surfaceTintColor: Colors.transparent,
          // タブバーをAppBarの下に表示
          bottom: TabBar(
            tabs: tabTitles.map((title) => Tab(text: title)).toList(),
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.blue.shade600,
          ),
        ),
        body: TabBarView(
          children: [
            EarningsTab(
              eventId: eventId,
            ).build(context, GoRouterState.of(context)),
            SalesTab(
              eventId: eventId,
            ).build(context, GoRouterState.of(context)),
            StockTab(
              eventId: eventId,
            ).build(context, GoRouterState.of(context)),
          ],
        ),
      ),
    );
  }
}
