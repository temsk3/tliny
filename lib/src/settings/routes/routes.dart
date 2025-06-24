import 'dart:core';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/model/product_model.dart';
import '../../data/model/program_model.dart';
import '../../ui/auth/sign_in.dart';
import '../../ui/auth/sign_up.dart';
import '../../ui/cart/cart_page.dart';
import '../../ui/checkout/checkout_cancel.dart';
import '../../ui/checkout/checkout_success_page.dart';
import '../../ui/home.dart';
import '../../ui/management/earnings_detail_screen.dart';
import '../../ui/management/earnings_screen.dart';
import '../../ui/management/management_page.dart';
import '../../ui/management/sales_screen.dart';
import '../../ui/management/stock_screen.dart';
import '../../ui/my_program/my_program_page.dart';
import '../../ui/order/order_page.dart';
import '../../ui/product/product_details_page.dart';
import '../../ui/product/product_edit_page.dart';
import '../../ui/product/product_list.dart';
import '../../ui/product/product_page.dart';
import '../../ui/program/program_details_page.dart';
import '../../ui/program/program_edit_page.dart';
import '../../ui/program/program_page.dart';
import '../../ui/terms/terms_page.dart';
import '../../ui/ticket/qr_code_display_page.dart';
import '../../ui/ticket/qr_code_scanner_page.dart';
import '../../ui/ticket/ticket_list_page.dart';
import '../../ui/ticket/ticket_pdf_page.dart';
import '../../ui/top/top_page.dart';
import '../../ui/usage_history/history_details.dart';
import '../../ui/usage_history/history_page.dart';
import '../../ui/user/user_edit_page.dart';
import '../../ui/user/user_page.dart';

part 'routes.g.dart';

// ********************************************************
// * Entrypoints
// * パスは定数にしてまとめておく
// ********************************************************
class AppRoutes {
  static const signInPage = '/sign-in';
  static const signUpPage = '/sign-up';
  // static const mainPage = '/';
  static const topPage = '/';
  static const myEventPage = 'my-event';
  static const eventPage = '/event';
  static const eventDetailPage = 'event-detail';
  static const eventEditPage = '/event-edit';
  static const productPage = '/product';
  static const productListTab = '/product-list';
  static const productDetailPage = '/product-detail';
  static const productEditPage = '/product-edit';
  static const scanPage = '/scan';
  static const cartPage = '/cart';
  static const ticketPage = '/ticket';
  static const qRCodeDisplayPage = '/qr-code';
  static const ticketPrintPage = '/ticket-print';
  static const checkoutSuccessPage = '/checkout-success/:sessionId';
  static const checkoutCancelPage = '/checkout-cancel/:sessionId';
  static const usageHistoryPage = '/usage-history';
  static const usageHistoryDetailPage = 'usage-history-detail';
  static const orderPage = '/order';
  static const userPage = '/user';
  static const userEditPage = 'user-edit';
  static const managementPage = '/management';
  static const earningsTab = 'earnings';
  static const earningsDetailPage = 'earnings-detail';
  static const salesTab = 'sales';
  static const stockTab = 'stock';
  static const termsPage = '/terms';
}

// ********************************************************
// *
// *
// ********************************************************

// ShellRoute用のKey
final _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

// ShellBranch用のKey
final _topNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'top',
);

final _cartNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'cart',
);

final _ticketNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'ticket',
);

final _authNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'auth',
);

final _managementNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'management');

// ********************************************************
// *
// *
// ********************************************************

class TopShellBranchData extends StatefulShellBranchData {
  const TopShellBranchData();
  static final GlobalKey<NavigatorState> $navigatorKey = _topNavigatorKey;
}

class CartShellBranchData extends StatefulShellBranchData {
  const CartShellBranchData();
  static final GlobalKey<NavigatorState> $navigatorKey = _cartNavigatorKey;
}

class TicketShellBranchData extends StatefulShellBranchData {
  const TicketShellBranchData();
  static final GlobalKey<NavigatorState> $navigatorKey = _ticketNavigatorKey;
}

class AuthShellBranchData extends StatefulShellBranchData {
  const AuthShellBranchData();
  static final GlobalKey<NavigatorState> $navigatorKey = _authNavigatorKey;
}

class ManagementShellBranchData extends StatefulShellBranchData {
  const ManagementShellBranchData();
  static final GlobalKey<NavigatorState> $navigatorKey =
      _managementNavigatorKey;
}

// ********************************************************
// * RouteData
// * GoRouteDataをそれぞれ設定
// ********************************************************

@TypedStatefulShellRoute<AppShellRoute>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<TopShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TopRoute>(
          path: AppRoutes.topPage,
          routes: [TypedGoRoute<MyProgramRoute>(path: AppRoutes.myEventPage)],
        ),
      ],
    ),
    TypedStatefulShellBranch<CartShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<CartRoute>(path: AppRoutes.cartPage),
      ],
    ),
    TypedStatefulShellBranch<TicketShellBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<TicketRoute>(path: AppRoutes.ticketPage),
      ],
    ),
  ],
)
class AppShellRoute extends StatefulShellRouteData {
  const AppShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigatorShell,
  ) {
    return HomePage(navigationShell: navigatorShell);
  }
}

// TOPレベルのパスには、@TypedGoRouteをつける

// @TypedGoRoute<AccountPageRoute>(path: AppRoutes.accountPage, routes: [
//   TypedGoRoute<AccountDetailPageRoute>(path: AppRoutes.accountDetailPage)
// ])
// class AccountPageRoute extends GoRouteData {
//   const AccountPageRoute();
//   @override
//   Page<void> buildPage(BuildContext context, GoRouterState state) =>
//       MaterialPage<Object>(
//         fullscreenDialog: true,
//         key: state.pageKey,
//         child: const AccountPage(),
//       );
// }

// ネストしたルートがある場合は、`@TypedGoRouteのroutes`に記載

class TopRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const TopPage();
}

class MyProgramRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MyProgramPage();
}

class CartRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const CartPage();
}

class TicketRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TicketListPage();
}

@TypedGoRoute<SignInRoute>(
  path: AppRoutes.signInPage,
  // routes: [
  //   TypedGoRoute<SignUpRoute>(path: AppRoutes.signUpPage),
  // ],
)
class SignInRoute extends GoRouteData {
  const SignInRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;
  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}

@TypedGoRoute<SignUpRoute>(path: AppRoutes.signUpPage)
class SignUpRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}

@TypedGoRoute<CheckoutSuccessRoute>(path: AppRoutes.checkoutSuccessPage)
class CheckoutSuccessRoute extends GoRouteData {
  const CheckoutSuccessRoute({required this.sessionId});
  final String sessionId;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CheckoutSuccessPage(sessionId: sessionId);
}

@TypedGoRoute<CheckoutCancelRoute>(path: AppRoutes.checkoutCancelPage)
class CheckoutCancelRoute extends GoRouteData {
  const CheckoutCancelRoute({required this.sessionId});
  final String sessionId;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CheckoutCancelPage(sessionId: sessionId);
}

// TOPレベルでない場合は、`@TypedGoRoute`をつけない
@TypedGoRoute<ProgramRoute>(
  path: AppRoutes.eventPage,
  routes: [TypedGoRoute<ProgramDetailRoute>(path: AppRoutes.eventDetailPage)],
)
class ProgramRoute extends GoRouteData {
  const ProgramRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProgramPage();
}

@immutable
class ProgramDetailRoute extends GoRouteData {
  const ProgramDetailRoute({required this.$extra});
  final Program $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProgramDetailsPage(program: $extra);
}

@TypedGoRoute<ProgramEditRoute>(path: AppRoutes.eventEditPage)
class ProgramEditRoute extends GoRouteData {
  const ProgramEditRoute({required this.$extra});
  final Program $extra;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProgramEditPage(program: $extra);
}

@TypedGoRoute<ProductRoute>(path: AppRoutes.productPage)
class ProductRoute extends GoRouteData {
  const ProductRoute({required this.$extra});
  final Program $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProductPage($extra);
}

@TypedGoRoute<ProductListTab>(path: AppRoutes.productListTab)
class ProductListTab extends GoRouteData {
  const ProductListTab({required this.$extra});
  final (Program, GenreType?) $extra;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProductListPage(program: $extra.$1, genre: $extra.$2);
}

@TypedGoRoute<ProductDetailsRoute>(path: AppRoutes.productDetailPage)
class ProductDetailsRoute extends GoRouteData {
  const ProductDetailsRoute({required this.$extra});
  final (Program, Product) $extra;

  // static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  // Widget build(BuildContext context, GoRouterState state) =>
  //     ProductDetailsPage(program: $extra.$1, product: $extra.$2);
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage<Object>(
        fullscreenDialog: true,
        key: state.pageKey,
        child: ProductDetailsPage(program: $extra.$1, product: $extra.$2),
      );
}

@TypedGoRoute<ProductEditRoute>(path: AppRoutes.productEditPage)
class ProductEditRoute extends GoRouteData {
  const ProductEditRoute({required this.$extra});
  final (Program, Product) $extra;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ProductEditPage(program: $extra.$1, product: $extra.$2);
}

@TypedGoRoute<QRCodeScannerRoute>(path: AppRoutes.scanPage)
class QRCodeScannerRoute extends GoRouteData {
  const QRCodeScannerRoute({required this.currentEventID});
  final String currentEventID;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      QRCodeScannerPage(currentEventID: currentEventID);
}

@TypedGoRoute<QRCodeDisplayRoute>(path: AppRoutes.qRCodeDisplayPage)
class QRCodeDisplayRoute extends GoRouteData {
  const QRCodeDisplayRoute({required this.uuid});
  final String uuid;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      QRCodeDisplayPage(uuid: uuid);
}

@TypedGoRoute<TicketPdfRoute>(path: AppRoutes.ticketPrintPage)
class TicketPdfRoute extends GoRouteData {
  const TicketPdfRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TicketPdfPage();
}

@TypedGoRoute<UsageHistoryRoute>(
  path: AppRoutes.usageHistoryPage,
  routes: [
    TypedGoRoute<UsageHistoryDetailsRoute>(
      path: AppRoutes.usageHistoryDetailPage,
    ),
  ],
)
class UsageHistoryRoute extends GoRouteData {
  const UsageHistoryRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UsageHistoryPage();
}

@immutable
class UsageHistoryDetailsRoute extends GoRouteData {
  const UsageHistoryDetailsRoute({required this.$extra});
  final List<String> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      UsageHistoryDetailsPage(list: $extra);
}

@TypedGoRoute<OrderRoute>(path: AppRoutes.orderPage)
class OrderRoute extends GoRouteData {
  const OrderRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const OrderPage();
}

@TypedGoRoute<UserRoute>(
  path: AppRoutes.userPage,
  routes: [TypedGoRoute<UserEditRoute>(path: AppRoutes.userEditPage)],
)
class UserRoute extends GoRouteData {
  const UserRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const UserPage();
}

@immutable
class UserEditRoute extends GoRouteData {
  const UserEditRoute({required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      UserEditPage(uid: uid);
}

@TypedGoRoute<ManagementRoute>(
  path: AppRoutes.managementPage,
  routes: [
    TypedGoRoute<EarningsTab>(
      path: AppRoutes.earningsTab,
      routes: [
        TypedGoRoute<EarningsDetailRoute>(path: AppRoutes.earningsDetailPage),
      ],
    ),
    TypedGoRoute<SalesTab>(path: AppRoutes.salesTab),
    TypedGoRoute<StockTab>(path: AppRoutes.stockTab),
  ],
)
class ManagementRoute extends GoRouteData {
  const ManagementRoute({required this.eventId});
  final String eventId;

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ManagementPage(eventId);
}

@immutable
class EarningsTab extends GoRouteData {
  const EarningsTab({required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EarningsScreen(eventId: eventId);
}

@immutable
class EarningsDetailRoute extends GoRouteData {
  const EarningsDetailRoute({
    required this.eventId,
    required this.productId,
    required this.productName,
  });
  final String eventId;
  final String productId;
  final String productName;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      EarningsDetailScreen(
        eventId: eventId,
        productId: productId,
        productName: productName,
      );
}

@immutable
class SalesTab extends GoRouteData {
  const SalesTab({required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SalesScreen(eventId: eventId);
}

@immutable
class StockTab extends GoRouteData {
  const StockTab({required this.eventId});
  final String eventId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      StockScreen(eventId: eventId);
}

@TypedGoRoute<TermsRoute>(path: AppRoutes.termsPage)
class TermsRoute extends GoRouteData {
  const TermsRoute({required this.uid});
  final String uid;

  // static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  // Widget build(BuildContext context, GoRouterState state) =>
  //     TermsPage(uid: uid);
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage<Object>(
        fullscreenDialog: true,
        key: state.pageKey,
        child: TermsPage(uid: uid),
      );
}
