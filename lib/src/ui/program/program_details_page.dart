import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/routes/app_route.gr.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/product/product_page.dart';
import '../../ui/program/program_state.dart';
import '../common/main_body.dart';
import '../product/widget/product_button.dart';
import 'program_view_model.dart';
import 'widget/program_button.dart';

final logger = Logger();

@RoutePage()
class ProgramDetailsPage extends HookConsumerWidget {
  const ProgramDetailsPage({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(programListStateProvider);
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
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(program.name!),
        actions: [
          AddStaffIconButton(program: program),
          QRCodeScanIconButton(program: program),
          EditProgramIconButton(program: program),
          DeleteProgramIconButton(program: program),
          FavoriteProgramIconButton(programId: program.id!),
        ],
      ),
      // backgroundColor: theme.appColors.background,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     Visibility(
      //       visible: owner.value,
      //       child: IconButton(
      //           onPressed: () async {
      //             // appRoute.pop();
      //             var result = await customShowDialog(
      //               context,
      //               'delete',
      //               'Do you want to delete it?',
      //             );
      //             if (result) {
      //               ScaffoldMessenger.of(context).showSnackBar(
      //                 SnackBar(
      //                   // backgroundColor: theme.appColors.error,
      //                   content: Text('Processing Data',
      //                       style: theme.textTheme.h30
      //                       // .copyWith(color: theme.appColors.onError),
      //                       ),
      //                 ),
      //               );
      //               viewModel.deleteBazaar(
      //                 bazaarId: bazaar.id.toString(),
      //               );
      //               appRoute.popUntilRoot();
      //             } else {}
      //           },
      //           icon: const Icon(
      //             Icons.delete,
      //             shadows: [
      //               BoxShadow(
      //                 color: Color.fromARGB(255, 0, 0, 0),
      //                 blurRadius: 10,
      //                 spreadRadius: 30.0,
      //                 blurStyle: BlurStyle.solid,
      //               ),
      //             ],
      //           )),
      //     ),
      //     Visibility(
      //       visible: owner.value,
      //       child: IconButton(
      //           onPressed: () async {
      //             appRoute.push(BazaarEditRoute(index: index));
      //           },
      //           icon: const Icon(
      //             Icons.edit,
      //             shadows: [
      //               BoxShadow(
      //                 color: Color.fromARGB(255, 0, 0, 0),
      //                 blurRadius: 10,
      //                 spreadRadius: 30.0,
      //                 blurStyle: BlurStyle.solid,
      //               ),
      //             ],
      //           )),
      //     ),
      //   ],
      //   title: Text(
      //     bazaar.name.toString(),
      //     // style: theme.textTheme.h50,
      //     style: const TextStyle(
      //       shadows: [
      //         BoxShadow(
      //           color: Color.fromARGB(255, 0, 0, 0),
      //           blurRadius: 10,
      //           spreadRadius: 30.0,
      //           blurStyle: BlurStyle.solid,
      //         ),
      //       ],
      //     ),
      //   ),
      //   centerTitle: true,
      //   toolbarHeight: 100,
      //   flexibleSpace: bazaar.pictureURL != null
      //       ? Container(
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //                 image: NetworkImage(bazaar.pictureURL as String),
      //                 fit: BoxFit.cover),
      //           ),
      //           child: Container(
      //             decoration: const BoxDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment.topCenter,
      //                 end: Alignment.bottomCenter,
      //                 stops: [0.5, 0.7, 0.95],
      //                 colors: [
      //                   Colors.white12,
      //                   Colors.white54,
      //                   Colors.white70,
      //                 ],
      //               ),
      //             ),
      //           ),
      //         )
      //       : null,
      // ),
      body: MainBodyWidget(
        // child: SingleChildScrollView(
        body:
            // CustomScrollView(
            //   slivers: [
            // SliverAppBar(
            //   automaticallyImplyLeading: false,
            //   // actions: [
            //   //   // Expanded(
            //   //   //   flex: 1,
            //   //   //   child:
            //   //   DeleteProgramIconButton(
            //   //     onPressed: () async {
            //   //       var result = await showConfirmDialog(
            //   //         context,
            //   //         appRoute,
            //   //         cancelText: l10n.no,
            //   //         decisionText: l10n.yes,
            //   //         message: 'Do you want to delete it?',
            //   //         title: 'delete',
            //   //       );
            //   //       if (result) {
            //   //         ScaffoldMessenger.of(context).showSnackBar(
            //   //           SnackBar(
            //   //             content: Text('Processing Data',
            //   //                 style: theme.textTheme.h30),
            //   //           ),
            //   //         );
            //   //         viewModel.deleteProgram(
            //   //           program.id.toString(),
            //   //         );
            //   //         appRoute.popUntilRoot();
            //   //       }
            //   //     },
            //   //     icon: Icon(
            //   //       Icons.delete,
            //   //       shadows: [boxShadow],
            //   //     ),
            //   //     program: program,
            //   //   ),
            //   //   // ),
            //   //   // Expanded(
            //   //   //   flex: 1,
            //   //   // child:
            //   //   EditProgramIconButton(
            //   //     onPressed: () async {
            //   //       appRoute.push(ProgramEditRoute(program: program));
            //   //     },
            //   //     icon: Icon(
            //   //       Icons.edit,
            //   //       shadows: [boxShadow],
            //   //     ),
            //   //     program: program,
            //   //   ),
            //   //   // ),
            //   // ],
            //   centerTitle: true,
            //   expandedHeight: program.pictureURL != null
            //       ? 100 + kToolbarHeight
            //       : kToolbarHeight,
            //   floating: false,
            //   pinned: true,
            //   snap: false,
            //   elevation: 2,
            //   flexibleSpace: FlexibleSpaceBar(
            //     title: Text(
            //       program.name.toString(),
            //       style: TextStyle(
            //         shadows: [boxShadow],
            //       ),
            //     ),
            //     titlePadding: const EdgeInsets.all(8),
            //     collapseMode: CollapseMode.pin,
            //     centerTitle: true,
            //     background: program.pictureURL != null
            //         ? Container(
            //             decoration: BoxDecoration(
            //               image: DecorationImage(
            //                   image: CachedNetworkImageProvider(
            //                     program.pictureURL as String,
            //                   ),
            //                   fit: BoxFit.cover),
            //             ),
            //             child: Container(
            //               decoration: const BoxDecoration(
            //                 gradient: LinearGradient(
            //                   begin: Alignment.topCenter,
            //                   end: Alignment.bottomCenter,
            //                   stops: [0.5, 0.7, 0.95],
            //                   colors: [
            //                     Colors.white12,
            //                     Colors.white54,
            //                     Colors.white70,
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           )
            //         // ? Image(
            //         //     fit: BoxFit.cover,
            //         //     image: CachedNetworkImageProvider(
            //         //       bazaar.pictureURL as String,
            //         //     ),
            //         //   )
            //         : null,
            //   ),
            // ),
            // SliverToBoxAdapter(
            //     child: Row(children: [
            //   ElevatedButton(
            //       onPressed: () {
            //         appRoute
            //             .push(ProductEditRoute(product: Product.empty()));
            //       },
            //       child: const Text("product")),
            //   ElevatedButton(
            //       onPressed: () {
            //         appRoute
            //             .push(ProgramEditRoute(program: Program.empty()));
            //       },
            //       child: const Text("program")),
            // ])),
            //       Row(children: [
            // Column(
            //   //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Padding(
            //       padding: EdgeInsets.symmetric(vertical: 5.0),
            //     ),
            //     Visibility(
            //       visible: true,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           //
            //           const Spacer(),
            //           Text('status:', style: theme.textTheme.h30),
            //           const Spacer(),
            //           Visibility(
            //             visible: true,
            //             child: ElevatedButton(
            //               style: ElevatedButton.styleFrom(),
            //               onPressed: () {
            //                 // appRoute.push(
            //                 // SupporterRoute(bazaarId: bazaar.id));
            //               },
            //               child: Text('supporter', style: theme.textTheme.h30),
            //             ),
            //           ),
            //           const Spacer(),
            //           ElevatedButton(
            //             style: ElevatedButton.styleFrom(),
            //             onPressed: () {
            //               // appRoute.push(OrderRoute(bazaar: bazaar.id));
            //             },
            //             child: Text('order', style: theme.textTheme.h30),
            //           ),
            //           const Spacer(),
            //           ElevatedButton(
            //             style: ElevatedButton.styleFrom(),
            //             onPressed: () {
            //               // appRoute.push(
            //               // SalesStatusRoute(bazaar: bazaar.id));
            //             },
            //             child: Text('sales', style: theme.textTheme.h30),
            //           ),
            //           const Spacer(),
            //           ElevatedButton(
            //             style: ElevatedButton.styleFrom(),
            //             onPressed: () {
            //               // appRoute.push(
            //               //     ProductStatusRoute(bazaar: bazaar.id));
            //             },
            //             child: Text('product', style: theme.textTheme.h30),
            //           ),
            //           const Spacer(),
            //         ],
            //       ),
            //     ),
            //     const Padding(
            //       padding: EdgeInsets.symmetric(vertical: 5.0),
            //     ),
            //     Text(
            //         '${l10n.salesPeriod}：${l10n.dataTime(program.salesStart as DateTime)}〜${l10n.dataTime(program.salesEnd as DateTime)}'),
            //     const Padding(
            //       padding: EdgeInsets.symmetric(vertical: 5.0),
            //     ),
            //     Text('${l10n.place}：${program.place}'),
            //     const Padding(
            //       padding: EdgeInsets.symmetric(vertical: 5.0),
            //     ),
            //   ],
            // ),
            // ),
            // const ProductPage()
            //   Consumer(
            // builder: (context, ref, child) {
            //   return AsyncValueWidget(
            //     value: ref.watch(
            //         productStateProvider(ProductSearchElement(null, null))),
            //     data: (data) {
            //       return
            //   AutoTabsRouter.tabBar(
            // routes: [
            //   ProductListRoute(
            //       program: program,
            //       element: ProductQueryParameter(program.id, null)),
            //   ProductListRoute(
            //       program: program,
            //       element: ProductQueryParameter(program.id, 'food')),
            //   ProductListRoute(
            //       program: program,
            //       element: ProductQueryParameter(program.id, 'goods')),
            //   ProductListRoute(
            //       program: program,
            //       element: ProductQueryParameter(program.id, 'others')),
            // ],
            // builder: (context, child, controller) {
            //   return Scaffold(
            //     appBar: AppBar(
            //       automaticallyImplyLeading: false,
            //       flexibleSpace: Column(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           TabBar(
            //             controller: controller,
            //             tabs: const <Tab>[
            //               Tab(text: 'All Item'),
            //               Tab(text: 'Foods'),
            //               Tab(text: 'Goods'),
            //               Tab(text: 'Others'),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //     body: child,
            //   );
            // },
            //   // );
            //   //       },
            //   //     );
            //   //   },
            // ),
            // ],
            //   ),
            // ],
            // ),
            Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                program.message!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(child: ProductPage(program)),
          ],
        ),
      ),
      // backgroundColor: theme.appColors.background,
      floatingActionButton: AddProductFloatingActionButton(
        program: program,
        onPressed: () {
          appRoute.push(
            ProductEditRoute(
              program: program,
              product: Product.empty(),
            ),
          );
        },
      ),
      //   );
      // },
    );
  }
}
