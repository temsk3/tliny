// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $appShellRoute,
      $snsMessagesRoute,
      $snsChatRoute,
      $snsProfileRoute,
      $snsSearchRoute,
      $signInRoute,
      $signUpRoute,
      $checkoutSuccessRoute,
      $checkoutCancelRoute,
      $secretEventRoute,
      $programRoute,
      $programEditRoute,
      $productRoute,
      $productListTab,
      $productDetailsRoute,
      $productEditRoute,
      $qRCodeScannerRoute,
      $qRCodeDisplayRoute,
      $ticketPdfRoute,
      $usageHistoryRoute,
      $orderRoute,
      $userRoute,
      $managementRoute,
      $termsRoute,
      $ownerDetailRoute,
    ];

RouteBase get $appShellRoute => StatefulShellRouteData.$route(
      factory: $AppShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          navigatorKey: TopShellBranchData.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/',
              factory: $TopRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'my-event',
                  factory: $MyProgramRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: CartShellBranchData.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/cart',
              factory: $CartRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: TicketShellBranchData.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/ticket',
              factory: $TicketRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: SnsShellBranchData.$navigatorKey,
          routes: [
            GoRouteData.$route(
              path: '/sns',
              factory: $SnsRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $AppShellRouteExtension on AppShellRoute {
  static AppShellRoute _fromState(GoRouterState state) => const AppShellRoute();
}

extension $TopRouteExtension on TopRoute {
  static TopRoute _fromState(GoRouterState state) => TopRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MyProgramRouteExtension on MyProgramRoute {
  static MyProgramRoute _fromState(GoRouterState state) => MyProgramRoute();

  String get location => GoRouteData.$location(
        '/my-event',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CartRouteExtension on CartRoute {
  static CartRoute _fromState(GoRouterState state) => CartRoute();

  String get location => GoRouteData.$location(
        '/cart',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TicketRouteExtension on TicketRoute {
  static TicketRoute _fromState(GoRouterState state) => TicketRoute();

  String get location => GoRouteData.$location(
        '/ticket',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SnsRouteExtension on SnsRoute {
  static SnsRoute _fromState(GoRouterState state) => SnsRoute();

  String get location => GoRouteData.$location(
        '/sns',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsMessagesRoute => GoRouteData.$route(
      path: '/sns/messages',
      factory: $SnsMessagesRouteExtension._fromState,
    );

extension $SnsMessagesRouteExtension on SnsMessagesRoute {
  static SnsMessagesRoute _fromState(GoRouterState state) =>
      const SnsMessagesRoute();

  String get location => GoRouteData.$location(
        '/sns/messages',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsChatRoute => GoRouteData.$route(
      path: '/sns/chat',
      factory: $SnsChatRouteExtension._fromState,
    );

extension $SnsChatRouteExtension on SnsChatRoute {
  static SnsChatRoute _fromState(GoRouterState state) => SnsChatRoute(
        conversationId: state.uri.queryParameters['conversation-id']!,
        otherUserId: state.uri.queryParameters['other-user-id']!,
        otherUserName: state.uri.queryParameters['other-user-name']!,
        otherUserPhotoUrl: state.uri.queryParameters['other-user-photo-url'],
      );

  String get location => GoRouteData.$location(
        '/sns/chat',
        queryParams: {
          'conversation-id': conversationId,
          'other-user-id': otherUserId,
          'other-user-name': otherUserName,
          if (otherUserPhotoUrl != null)
            'other-user-photo-url': otherUserPhotoUrl,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsProfileRoute => GoRouteData.$route(
      path: '/sns/profile',
      factory: $SnsProfileRouteExtension._fromState,
    );

extension $SnsProfileRouteExtension on SnsProfileRoute {
  static SnsProfileRoute _fromState(GoRouterState state) => SnsProfileRoute(
        userId: state.uri.queryParameters['user-id']!,
      );

  String get location => GoRouteData.$location(
        '/sns/profile',
        queryParams: {
          'user-id': userId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsSearchRoute => GoRouteData.$route(
      path: '/sns/search',
      factory: $SnsSearchRouteExtension._fromState,
    );

extension $SnsSearchRouteExtension on SnsSearchRoute {
  static SnsSearchRoute _fromState(GoRouterState state) =>
      const SnsSearchRoute();

  String get location => GoRouteData.$location(
        '/sns/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInRoute => GoRouteData.$route(
      path: '/sign-in',
      factory: $SignInRouteExtension._fromState,
    );

extension $SignInRouteExtension on SignInRoute {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  String get location => GoRouteData.$location(
        '/sign-in',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute => GoRouteData.$route(
      path: '/sign-up',
      factory: $SignUpRouteExtension._fromState,
    );

extension $SignUpRouteExtension on SignUpRoute {
  static SignUpRoute _fromState(GoRouterState state) => SignUpRoute();

  String get location => GoRouteData.$location(
        '/sign-up',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $checkoutSuccessRoute => GoRouteData.$route(
      path: '/checkout-success',
      factory: $CheckoutSuccessRouteExtension._fromState,
    );

extension $CheckoutSuccessRouteExtension on CheckoutSuccessRoute {
  static CheckoutSuccessRoute _fromState(GoRouterState state) =>
      const CheckoutSuccessRoute();

  String get location => GoRouteData.$location(
        '/checkout-success',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $checkoutCancelRoute => GoRouteData.$route(
      path: '/checkout-cancel',
      factory: $CheckoutCancelRouteExtension._fromState,
    );

extension $CheckoutCancelRouteExtension on CheckoutCancelRoute {
  static CheckoutCancelRoute _fromState(GoRouterState state) =>
      const CheckoutCancelRoute();

  String get location => GoRouteData.$location(
        '/checkout-cancel',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $secretEventRoute => GoRouteData.$route(
      path: '/secret/:secretUrl',
      factory: $SecretEventRouteExtension._fromState,
    );

extension $SecretEventRouteExtension on SecretEventRoute {
  static SecretEventRoute _fromState(GoRouterState state) => SecretEventRoute(
        secretUrl: state.pathParameters['secretUrl']!,
      );

  String get location => GoRouteData.$location(
        '/secret/${Uri.encodeComponent(secretUrl)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $programRoute => GoRouteData.$route(
      path: '/event',
      factory: $ProgramRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'event-detail',
          factory: $ProgramDetailRouteExtension._fromState,
        ),
      ],
    );

extension $ProgramRouteExtension on ProgramRoute {
  static ProgramRoute _fromState(GoRouterState state) => const ProgramRoute();

  String get location => GoRouteData.$location(
        '/event',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProgramDetailRouteExtension on ProgramDetailRoute {
  static ProgramDetailRoute _fromState(GoRouterState state) =>
      ProgramDetailRoute(
        $extra: state.extra as Program,
      );

  String get location => GoRouteData.$location(
        '/event/event-detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $programEditRoute => GoRouteData.$route(
      path: '/event-edit',
      factory: $ProgramEditRouteExtension._fromState,
    );

extension $ProgramEditRouteExtension on ProgramEditRoute {
  static ProgramEditRoute _fromState(GoRouterState state) => ProgramEditRoute(
        $extra: state.extra as Program,
      );

  String get location => GoRouteData.$location(
        '/event-edit',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $productRoute => GoRouteData.$route(
      path: '/product',
      factory: $ProductRouteExtension._fromState,
    );

extension $ProductRouteExtension on ProductRoute {
  static ProductRoute _fromState(GoRouterState state) => ProductRoute(
        $extra: state.extra as Program,
      );

  String get location => GoRouteData.$location(
        '/product',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $productListTab => GoRouteData.$route(
      path: '/product-list',
      factory: $ProductListTabExtension._fromState,
    );

extension $ProductListTabExtension on ProductListTab {
  static ProductListTab _fromState(GoRouterState state) => ProductListTab(
        $extra: state.extra as (Program, GenreType?),
      );

  String get location => GoRouteData.$location(
        '/product-list',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $productDetailsRoute => GoRouteData.$route(
      path: '/product-detail',
      factory: $ProductDetailsRouteExtension._fromState,
    );

extension $ProductDetailsRouteExtension on ProductDetailsRoute {
  static ProductDetailsRoute _fromState(GoRouterState state) =>
      ProductDetailsRoute(
        programId: state.uri.queryParameters['program-id']!,
        productId: state.uri.queryParameters['product-id']!,
      );

  String get location => GoRouteData.$location(
        '/product-detail',
        queryParams: {
          'program-id': programId,
          'product-id': productId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $productEditRoute => GoRouteData.$route(
      path: '/product-edit',
      factory: $ProductEditRouteExtension._fromState,
    );

extension $ProductEditRouteExtension on ProductEditRoute {
  static ProductEditRoute _fromState(GoRouterState state) => ProductEditRoute(
        $extra: state.extra as (Program, Product),
      );

  String get location => GoRouteData.$location(
        '/product-edit',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $qRCodeScannerRoute => GoRouteData.$route(
      path: '/scan',
      factory: $QRCodeScannerRouteExtension._fromState,
    );

extension $QRCodeScannerRouteExtension on QRCodeScannerRoute {
  static QRCodeScannerRoute _fromState(GoRouterState state) =>
      QRCodeScannerRoute(
        currentEventID: state.uri.queryParameters['current-event-i-d']!,
      );

  String get location => GoRouteData.$location(
        '/scan',
        queryParams: {
          'current-event-i-d': currentEventID,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qRCodeDisplayRoute => GoRouteData.$route(
      path: '/qr-code',
      factory: $QRCodeDisplayRouteExtension._fromState,
    );

extension $QRCodeDisplayRouteExtension on QRCodeDisplayRoute {
  static QRCodeDisplayRoute _fromState(GoRouterState state) =>
      QRCodeDisplayRoute(
        uuid: state.uri.queryParameters['uuid']!,
      );

  String get location => GoRouteData.$location(
        '/qr-code',
        queryParams: {
          'uuid': uuid,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $ticketPdfRoute => GoRouteData.$route(
      path: '/ticket-print',
      factory: $TicketPdfRouteExtension._fromState,
    );

extension $TicketPdfRouteExtension on TicketPdfRoute {
  static TicketPdfRoute _fromState(GoRouterState state) =>
      const TicketPdfRoute();

  String get location => GoRouteData.$location(
        '/ticket-print',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $usageHistoryRoute => GoRouteData.$route(
      path: '/usage-history',
      factory: $UsageHistoryRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'usage-history-detail',
          factory: $UsageHistoryDetailsRouteExtension._fromState,
        ),
      ],
    );

extension $UsageHistoryRouteExtension on UsageHistoryRoute {
  static UsageHistoryRoute _fromState(GoRouterState state) =>
      const UsageHistoryRoute();

  String get location => GoRouteData.$location(
        '/usage-history',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UsageHistoryDetailsRouteExtension on UsageHistoryDetailsRoute {
  static UsageHistoryDetailsRoute _fromState(GoRouterState state) =>
      UsageHistoryDetailsRoute(
        $extra: state.extra as List<String>,
      );

  String get location => GoRouteData.$location(
        '/usage-history/usage-history-detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $orderRoute => GoRouteData.$route(
      path: '/order',
      factory: $OrderRouteExtension._fromState,
    );

extension $OrderRouteExtension on OrderRoute {
  static OrderRoute _fromState(GoRouterState state) => const OrderRoute();

  String get location => GoRouteData.$location(
        '/order',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userRoute => GoRouteData.$route(
      path: '/user',
      factory: $UserRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'user-edit',
          factory: $UserEditRouteExtension._fromState,
        ),
      ],
    );

extension $UserRouteExtension on UserRoute {
  static UserRoute _fromState(GoRouterState state) => const UserRoute();

  String get location => GoRouteData.$location(
        '/user',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserEditRouteExtension on UserEditRoute {
  static UserEditRoute _fromState(GoRouterState state) => UserEditRoute(
        uid: state.uri.queryParameters['uid']!,
      );

  String get location => GoRouteData.$location(
        '/user/user-edit',
        queryParams: {
          'uid': uid,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $managementRoute => GoRouteData.$route(
      path: '/management',
      factory: $ManagementRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'earnings',
          factory: $EarningsTabExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'earnings-detail',
              factory: $EarningsDetailRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: 'sales',
          factory: $SalesTabExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'stock',
          factory: $StockTabExtension._fromState,
        ),
      ],
    );

extension $ManagementRouteExtension on ManagementRoute {
  static ManagementRoute _fromState(GoRouterState state) => ManagementRoute(
        eventId: state.uri.queryParameters['event-id']!,
      );

  String get location => GoRouteData.$location(
        '/management',
        queryParams: {
          'event-id': eventId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EarningsTabExtension on EarningsTab {
  static EarningsTab _fromState(GoRouterState state) => EarningsTab(
        eventId: state.uri.queryParameters['event-id']!,
      );

  String get location => GoRouteData.$location(
        '/management/earnings',
        queryParams: {
          'event-id': eventId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EarningsDetailRouteExtension on EarningsDetailRoute {
  static EarningsDetailRoute _fromState(GoRouterState state) =>
      EarningsDetailRoute(
        eventId: state.uri.queryParameters['event-id']!,
        productId: state.uri.queryParameters['product-id']!,
        productName: state.uri.queryParameters['product-name']!,
      );

  String get location => GoRouteData.$location(
        '/management/earnings/earnings-detail',
        queryParams: {
          'event-id': eventId,
          'product-id': productId,
          'product-name': productName,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SalesTabExtension on SalesTab {
  static SalesTab _fromState(GoRouterState state) => SalesTab(
        eventId: state.uri.queryParameters['event-id']!,
      );

  String get location => GoRouteData.$location(
        '/management/sales',
        queryParams: {
          'event-id': eventId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StockTabExtension on StockTab {
  static StockTab _fromState(GoRouterState state) => StockTab(
        eventId: state.uri.queryParameters['event-id']!,
      );

  String get location => GoRouteData.$location(
        '/management/stock',
        queryParams: {
          'event-id': eventId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $termsRoute => GoRouteData.$route(
      path: '/terms',
      factory: $TermsRouteExtension._fromState,
    );

extension $TermsRouteExtension on TermsRoute {
  static TermsRoute _fromState(GoRouterState state) => TermsRoute(
        uid: state.uri.queryParameters['uid']!,
      );

  String get location => GoRouteData.$location(
        '/terms',
        queryParams: {
          'uid': uid,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $ownerDetailRoute => GoRouteData.$route(
      path: '/owner-detail',
      factory: $OwnerDetailRouteExtension._fromState,
    );

extension $OwnerDetailRouteExtension on OwnerDetailRoute {
  static OwnerDetailRoute _fromState(GoRouterState state) => OwnerDetailRoute(
        ownerId: state.uri.queryParameters['owner-id']!,
      );

  String get location => GoRouteData.$location(
        '/owner-detail',
        queryParams: {
          'owner-id': ownerId,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
