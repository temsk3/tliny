import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/settings/routes/routes.dart';
import 'package:tliny/src/ui/product/product_list.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../common/main_body.dart';
import 'program_view_model.dart';
import 'widget/program_button.dart';

// final logger = Logger();

// @RoutePage()
class ProgramDetailsPage extends HookConsumerWidget {
  const ProgramDetailsPage({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appMediaQuery = useMediaQuery();
    // final state = ref.watch(programStateProvider(program.id.toString()));
    // final state = ref.watch(programViewModelProvider);
    final viewModel = ref.watch(programViewModelProvider.notifier);
    // final asyncValue = ref.watch(productListStreamProvider);

    // final DateFormat dateFormatter =
    //     DateFormat.yMMMEd(Localizations.localeOf(context).toString());

    // final bazaar = bazaarEvent;
    // final supported = ref.watch(supporterListStreamProvider(bazaar.id));
    // final owner = useState<bool>(ref.watch(editProgramButtonStateProvider(program)));
    // final supporter = useState<bool>(false);
    // final authState = ref.watch(authStateProvider);
    // authState.whenData(
    //   (data) {
    //     if (data != null) {
    //       if (data.uid == bazaar.organizer) {
    //         owner.value = true;
    //       } else {
    //         supported.whenData(
    //           (values) {
    //             // supporter.value = value.contains(data.uid);
    //             for (var value in values) {
    //               if (value.uid == data.uid && value.isActive == true) {
    //                 supporter.value = true;
    //               }
    //             }
    //           },
    //         );
    //       }
    //     } else {
    //       owner.value = false;
    //       supporter.value = false;
    //     }
    //   },
    // );
    const boxShadow = BoxShadow(
      // color: Color.fromARGB(255, 0, 0, 0),
      blurRadius: 10,
      spreadRadius: 30,
      blurStyle: BlurStyle.solid,
    );

    // return AsyncValueWidget(
    //   value: state,
    //   data: (data) {
    //     logger.d(data);
    // final data = value;
    // final data = value.programList
    //     .where((element) => element.id == program.id)
    //     .toList();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(program.name!),
        actions: [
          AddStaffIconButton(program: program),
          QRCodeScanIconButton(program: program),
          EditProgramIconButton(program: program),
          DeleteProgramIconButton(program: program),
          FavoriteProgramIconButton(programId: program.id!),
          TermIconButton(program: program),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ProductEditRoute(
                $extra: (program, Product.empty()),
              ).push(context);
            },
            tooltip: '商品を追加',
          ),
        ],
      ),
      body: SafeArea(
        child: MainBodyWidget(
          body: DefaultTabController(
            length: 4,
            child: NestedScrollView(
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) {
                return <Widget>[
                  _headerSection(context, program.message!),
                  _tabSection(context),
                ];
              },
              body: TabBarView(
                children: [
                  ProductListPage(program: program),
                  ProductListPage(program: program, genre: GenreType.foods),
                  ProductListPage(program: program, genre: GenreType.goods),
                  ProductListPage(program: program, genre: GenreType.others),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 80), // SnackBar用のスペース
      //   child: AddProductFloatingActionButton(
      //     program: program,
      //     onPressed: () {
      //       ProductEditRoute($extra: (program, Product.empty())).push(context);
      //     },
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

//header部分
Widget _headerSection(BuildContext context, String message) {
  return SliverList(
    delegate: SliverChildListDelegate([
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 65),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          // height: 65,
          child: Text(
            message,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
    ]),
  );
}

//TabBar部分
Widget _tabSection(BuildContext context) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: _StickyTabBarDelegate(
      tabBar: TabBar(
        // labelColor: Colors.black,
        labelColor: Theme.of(context).colorScheme.onSurface,
        tabs: const [
          Tab(text: '全品'),
          Tab(text: '食品'),
          Tab(text: '物品'),
          Tab(text: 'その他'),
        ],
      ),
    ),
  );
}

//SliverPersistentHeaderDelegateを継承したTabBarを作る
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _StickyTabBarDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
