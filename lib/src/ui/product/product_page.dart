import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/routes/routes.dart';

class ProductPage extends HookConsumerWidget {
  const ProductPage(this.program, {super.key});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: <Tab>[
                  const Tab(text: 'All Item'),
                  Tab(text: GenreType.foods.name),
                  Tab(text: GenreType.goods.name),
                  Tab(text: GenreType.others.name),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductListTab($extra: (program, null))
                .build(context, GoRouterState.of(context)),
            ProductListTab($extra: (program, GenreType.foods))
                .build(context, GoRouterState.of(context)),
            ProductListTab($extra: (program, GenreType.goods))
                .build(context, GoRouterState.of(context)),
            ProductListTab($extra: (program, GenreType.others))
                .build(context, GoRouterState.of(context)),
          ],
        ),
      ),
    );
  }
}
