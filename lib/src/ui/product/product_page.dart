import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/routes/app_route.gr.dart';
import '../../settings/theme/app_theme.dart';

@RoutePage()
class ProductPage extends HookConsumerWidget {
  const ProductPage(this.program, {super.key});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return AutoTabsRouter.tabBar(
      routes: [
        ProductListRoute(program: program),
        ProductListRoute(program: program, genre: GenreType.foods),
        ProductListRoute(program: program, genre: GenreType.goods),
        ProductListRoute(program: program, genre: GenreType.others),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // title: Text(
            //   program.message!,
            //   style: theme.textTheme.h10,
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            // toolbarHeight: 96,
            // centerTitle: false,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  controller: controller,
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
          // body: MainBodyWidget(body: child),
          body: child,
          // body: CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       title: Text(program.name!),
          //       automaticallyImplyLeading: false,
          //       flexibleSpace: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           TabBar(
          //             controller: controller,
          //             tabs: <Tab>[
          //               const Tab(text: 'All Item'),
          //               Tab(text: GenreType.foods.name),
          //               Tab(text: GenreType.goods.name),
          //               Tab(text: GenreType.others.name),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     child
          //     // SliverToBoxAdapter(
          //     //   child: child,
          //     // )
          //   ],
          // ),
        );
      },
    );
    //     },
    //   );
  }
}
