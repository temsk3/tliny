import 'package:auto_route/auto_route.dart';

import 'app_route.gr.dart';

// part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: HomeRoute.page,
      children: [
        // Top
        AutoRoute(
          path: 'top',
          page: TopRoute.page,
        ),
        // Favorite
        AutoRoute(
          path: 'favorite',
          page: FavoriteRoute.page,
        ),
        // Cart
        AutoRoute(
          path: 'cart',
          page: CartRoute.page,
        ),
        // Ticket
        AutoRoute(
          path: 'ticket',
          page: TicketRoute.page,
        ),
        //
        //
        AutoRoute(
          path: 'event',
          page: ProgramRoute.page,
        ),
      ],
    ),
    AutoRoute(
      path: '/event/details',
      page: ProgramDetailsRoute.page,
      children: [
        AutoRoute(
          path: 'product',
          page: ProductListRoute.page,
        ),
      ],
    ),
    AutoRoute(
      path: '/event/edit',
      page: ProgramEditRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/product/details',
      page: ProductDetailsRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/product/edit',
      page: ProductEditRoute.page,
      fullscreenDialog: true,
    ),
    // Auth
    AutoRoute(
      path: '/sign-in',
      page: SignInRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/sign-up',
      page: SignUpRoute.page,
      fullscreenDialog: true,
    ),
    // QR
    AutoRoute(
      path: '/QR-Code',
      page: CreateQRCodeRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/QR-Scan',
      page: QRScanRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/qr_detail',
      page: QRDetailRoute.page,
      fullscreenDialog: true,
    ),
    // order
    AutoRoute(
      path: '/order',
      page: OrderRoute.page,
      fullscreenDialog: true,
    ),
    // AutoRoute(
    //   path: '/',
    //   page: HomeRoute.page,
    //   children: [
    //     RedirectRoute(path: '', redirectTo: 'top'),
    //     // AutoRoute(
    //     //   page: XxxStreamPage,
    //     // ),
    //     //Top
    //     AutoRoute(
    //       path: 'top',
    //       page: TopRoute.page,
    //     ),
    //     // Program
    //     // AutoRoute(
    //     //   name: 'ProgramsRouter',
    //     //   path: 'programs',
    //     //   page: EmptyRouterPage,
    //     //   // page: ProgramPage,
    //     //   children: [
    //     // RedirectRoute(path: '*', redirectTo: ''),
    // AutoRoute(
    //   path: '/events',
    //   page: ProgramRoute.page,
    // ),
    //     //   ],
    //     // ),
    //     // Cart
    //     AutoRoute(
    //       path: 'cart',
    //       page: CartRoute.page,
    //     ),
    //     // Ticket
    //     AutoRoute(
    //       path: 'ticket',
    //       page: TicketRoute.page,
    //     ),
    //     //
    //     // AutoRoute(
    //     //   page: SampleRoute.page,
    //     //   // initial: true,
    //     // ),
    //   ],
    // ),
    // UsageHistory

    AutoRoute(
      path: '/usage-history',
      page: UsageHistoryRoute.page,
      fullscreenDialog: true,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/usage-history/details',
      page: UsageHistoryDetailsRoute.page,
    ),
    AutoRoute(
      path: '/user',
      page: UserRoute.page,
      fullscreenDialog: true,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/user/user-edit',
      page: UserEditRoute.page,
    ),
    AutoRoute(
      path: '/staff',
      page: StaffRoute.page,
      fullscreenDialog: true,
    ),
    AutoRoute(
      path: '/staff/details',
      page: StaffDetailsRoute.page,
    ),
    //   ],
    // ),
    // // //
    // // //
    // // AutoRoute(
    // //   page: Sample2Page,
    // //   // initial: true,
    // // ),
    // // AutoRoute(
    // //   path: '/success',
    // //   page: SuccessPage,
    // // ),
    // // AutoRoute(
    // //   page: SignInPage,
    // // ),
    // // AutoRoute(
    // //   page: SignUpPage,
    // // ),
    // // AutoRoute(
    // //   initial: true,
    // //   path: '/stripe',
    // //   page: StripePage,
    // //   guards: [AuthGuard],
    // // ),
    // // AutoRoute(
    // //   path: '/account',
    // //   page: AccountPage,
    // // ),
    // // AutoRoute(
    // //   path: '/account/refresh',
    // //   page: AccountCompletePage,
    // // ),
    // // // AutoRoute(
    // // //   path: '/account/success',
    // // //   page: AccountCompletePage,
    // // // ),
    // // AutoRoute(
    // //   path: '/checkout',
    // //   page: CheckoutPage,
    // //   // children: [
    // //   // ],
    // // ),
    AutoRoute(
      path: '/checkout/success',
      page: CheckoutSuccessRoute.page,
    ),
    AutoRoute(
      path: '/checkout/cancel',
      page: CheckoutCancelRoute.page,
    ),
    // // AutoRoute(
    // //   path: '/payments',
    // //   page: PaymentPage,
    // // ),
    // // AutoRoute(
    // //   page: PaymentCheckoutPage,
    // //   fullscreenDialog: true,
    // // ),
    // // // CustomRoute(
    // // //   page: PaymentCheckoutPage,
    // // //   customRouteBuilder: modalSheetBuilder,
    // // // ),
    // // AutoRoute(
    // //   page: SetupIntentWithScaPage,
    // // ),
    // // AutoRoute(
    // //   page: InvoiceSettingPage,
    // //   fullscreenDialog: true,
    // // ),
    // // AutoRoute(
    // //   page: PaymentMethodPage,
    // // ),
    // // AutoRoute(
    // //   page: EditCustomerPage,
    // // ),
    // // AutoRoute(
    // //   path: '/3ds/complete',
    // //   page: IntentCompletePage,
    // // ),
  ];
}
// )
// class $AppRouter {}

// Route<T> modalSheetBuilder<T>(
//     BuildContext context, Widget child, CustomPage<T> page) {
//   return CupertinoModalBottomSheetRoute(
//     settings: page,
//     builder: (context) :> child,
//     expanded: true,
//   );
// }
