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
          factory: $TopRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'my-event',
              factory: $MyProgramRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: CartShellBranchData.$navigatorKey,
      routes: [
        GoRouteData.$route(path: '/cart', factory: $CartRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: TicketShellBranchData.$navigatorKey,
      routes: [
        GoRouteData.$route(path: '/ticket', factory: $TicketRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: SnsShellBranchData.$navigatorKey,
      routes: [GoRouteData.$route(path: '/sns', factory: $SnsRoute._fromState)],
    ),
  ],
);

extension $AppShellRouteExtension on AppShellRoute {
  static AppShellRoute _fromState(GoRouterState state) => const AppShellRoute();
}

mixin $TopRoute on GoRouteData {
  static TopRoute _fromState(GoRouterState state) => TopRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MyProgramRoute on GoRouteData {
  static MyProgramRoute _fromState(GoRouterState state) => MyProgramRoute();

  @override
  String get location => GoRouteData.$location('/my-event');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $CartRoute on GoRouteData {
  static CartRoute _fromState(GoRouterState state) => CartRoute();

  @override
  String get location => GoRouteData.$location('/cart');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TicketRoute on GoRouteData {
  static TicketRoute _fromState(GoRouterState state) => TicketRoute();

  @override
  String get location => GoRouteData.$location('/ticket');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SnsRoute on GoRouteData {
  static SnsRoute _fromState(GoRouterState state) => SnsRoute();

  @override
  String get location => GoRouteData.$location('/sns');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsMessagesRoute => GoRouteData.$route(
  path: '/sns/messages',
  factory: $SnsMessagesRoute._fromState,
);

mixin $SnsMessagesRoute on GoRouteData {
  static SnsMessagesRoute _fromState(GoRouterState state) =>
      const SnsMessagesRoute();

  @override
  String get location => GoRouteData.$location('/sns/messages');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsChatRoute =>
    GoRouteData.$route(path: '/sns/chat', factory: $SnsChatRoute._fromState);

mixin $SnsChatRoute on GoRouteData {
  static SnsChatRoute _fromState(GoRouterState state) => SnsChatRoute(
    conversationId: state.uri.queryParameters['conversation-id']!,
    otherUserId: state.uri.queryParameters['other-user-id']!,
    otherUserName: state.uri.queryParameters['other-user-name']!,
    otherUserPhotoUrl: state.uri.queryParameters['other-user-photo-url'],
  );

  SnsChatRoute get _self => this as SnsChatRoute;

  @override
  String get location => GoRouteData.$location(
    '/sns/chat',
    queryParams: {
      'conversation-id': _self.conversationId,
      'other-user-id': _self.otherUserId,
      'other-user-name': _self.otherUserName,
      if (_self.otherUserPhotoUrl != null)
        'other-user-photo-url': _self.otherUserPhotoUrl,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsProfileRoute => GoRouteData.$route(
  path: '/sns/profile',
  factory: $SnsProfileRoute._fromState,
);

mixin $SnsProfileRoute on GoRouteData {
  static SnsProfileRoute _fromState(GoRouterState state) =>
      SnsProfileRoute(userId: state.uri.queryParameters['user-id']!);

  SnsProfileRoute get _self => this as SnsProfileRoute;

  @override
  String get location => GoRouteData.$location(
    '/sns/profile',
    queryParams: {'user-id': _self.userId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $snsSearchRoute => GoRouteData.$route(
  path: '/sns/search',
  factory: $SnsSearchRoute._fromState,
);

mixin $SnsSearchRoute on GoRouteData {
  static SnsSearchRoute _fromState(GoRouterState state) =>
      const SnsSearchRoute();

  @override
  String get location => GoRouteData.$location('/sns/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInRoute =>
    GoRouteData.$route(path: '/sign-in', factory: $SignInRoute._fromState);

mixin $SignInRoute on GoRouteData {
  static SignInRoute _fromState(GoRouterState state) => const SignInRoute();

  @override
  String get location => GoRouteData.$location('/sign-in');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute =>
    GoRouteData.$route(path: '/sign-up', factory: $SignUpRoute._fromState);

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => SignUpRoute();

  @override
  String get location => GoRouteData.$location('/sign-up');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $checkoutSuccessRoute => GoRouteData.$route(
  path: '/checkout-success',
  factory: $CheckoutSuccessRoute._fromState,
);

mixin $CheckoutSuccessRoute on GoRouteData {
  static CheckoutSuccessRoute _fromState(GoRouterState state) =>
      const CheckoutSuccessRoute();

  @override
  String get location => GoRouteData.$location('/checkout-success');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $checkoutCancelRoute => GoRouteData.$route(
  path: '/checkout-cancel',
  factory: $CheckoutCancelRoute._fromState,
);

mixin $CheckoutCancelRoute on GoRouteData {
  static CheckoutCancelRoute _fromState(GoRouterState state) =>
      const CheckoutCancelRoute();

  @override
  String get location => GoRouteData.$location('/checkout-cancel');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $secretEventRoute => GoRouteData.$route(
  path: '/secret/:secretUrl',
  factory: $SecretEventRoute._fromState,
);

mixin $SecretEventRoute on GoRouteData {
  static SecretEventRoute _fromState(GoRouterState state) =>
      SecretEventRoute(secretUrl: state.pathParameters['secretUrl']!);

  SecretEventRoute get _self => this as SecretEventRoute;

  @override
  String get location =>
      GoRouteData.$location('/secret/${Uri.encodeComponent(_self.secretUrl)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $programRoute => GoRouteData.$route(
  path: '/event',
  factory: $ProgramRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'event-detail',
      factory: $ProgramDetailRoute._fromState,
    ),
  ],
);

mixin $ProgramRoute on GoRouteData {
  static ProgramRoute _fromState(GoRouterState state) => const ProgramRoute();

  @override
  String get location => GoRouteData.$location('/event');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProgramDetailRoute on GoRouteData {
  static ProgramDetailRoute _fromState(GoRouterState state) =>
      ProgramDetailRoute($extra: state.extra as Program);

  ProgramDetailRoute get _self => this as ProgramDetailRoute;

  @override
  String get location => GoRouteData.$location('/event/event-detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $programEditRoute => GoRouteData.$route(
  path: '/event-edit',
  factory: $ProgramEditRoute._fromState,
);

mixin $ProgramEditRoute on GoRouteData {
  static ProgramEditRoute _fromState(GoRouterState state) =>
      ProgramEditRoute($extra: state.extra as Program);

  ProgramEditRoute get _self => this as ProgramEditRoute;

  @override
  String get location => GoRouteData.$location('/event-edit');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $productRoute =>
    GoRouteData.$route(path: '/product', factory: $ProductRoute._fromState);

mixin $ProductRoute on GoRouteData {
  static ProductRoute _fromState(GoRouterState state) =>
      ProductRoute($extra: state.extra as Program);

  ProductRoute get _self => this as ProductRoute;

  @override
  String get location => GoRouteData.$location('/product');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $productListTab => GoRouteData.$route(
  path: '/product-list',
  factory: $ProductListTab._fromState,
);

mixin $ProductListTab on GoRouteData {
  static ProductListTab _fromState(GoRouterState state) =>
      ProductListTab($extra: state.extra as (Program, GenreType?));

  ProductListTab get _self => this as ProductListTab;

  @override
  String get location => GoRouteData.$location('/product-list');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $productDetailsRoute => GoRouteData.$route(
  path: '/product-detail',
  factory: $ProductDetailsRoute._fromState,
);

mixin $ProductDetailsRoute on GoRouteData {
  static ProductDetailsRoute _fromState(GoRouterState state) =>
      ProductDetailsRoute(
        programId: state.uri.queryParameters['program-id']!,
        productId: state.uri.queryParameters['product-id']!,
      );

  ProductDetailsRoute get _self => this as ProductDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/product-detail',
    queryParams: {'program-id': _self.programId, 'product-id': _self.productId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $productEditRoute => GoRouteData.$route(
  path: '/product-edit',
  factory: $ProductEditRoute._fromState,
);

mixin $ProductEditRoute on GoRouteData {
  static ProductEditRoute _fromState(GoRouterState state) =>
      ProductEditRoute($extra: state.extra as (Program, Product));

  ProductEditRoute get _self => this as ProductEditRoute;

  @override
  String get location => GoRouteData.$location('/product-edit');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $qRCodeScannerRoute =>
    GoRouteData.$route(path: '/scan', factory: $QRCodeScannerRoute._fromState);

mixin $QRCodeScannerRoute on GoRouteData {
  static QRCodeScannerRoute _fromState(GoRouterState state) =>
      QRCodeScannerRoute(
        currentEventID: state.uri.queryParameters['current-event-i-d']!,
      );

  QRCodeScannerRoute get _self => this as QRCodeScannerRoute;

  @override
  String get location => GoRouteData.$location(
    '/scan',
    queryParams: {'current-event-i-d': _self.currentEventID},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qRCodeDisplayRoute => GoRouteData.$route(
  path: '/qr-code',
  factory: $QRCodeDisplayRoute._fromState,
);

mixin $QRCodeDisplayRoute on GoRouteData {
  static QRCodeDisplayRoute _fromState(GoRouterState state) =>
      QRCodeDisplayRoute(uuid: state.uri.queryParameters['uuid']!);

  QRCodeDisplayRoute get _self => this as QRCodeDisplayRoute;

  @override
  String get location =>
      GoRouteData.$location('/qr-code', queryParams: {'uuid': _self.uuid});

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $ticketPdfRoute => GoRouteData.$route(
  path: '/ticket-print',
  factory: $TicketPdfRoute._fromState,
);

mixin $TicketPdfRoute on GoRouteData {
  static TicketPdfRoute _fromState(GoRouterState state) =>
      const TicketPdfRoute();

  @override
  String get location => GoRouteData.$location('/ticket-print');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $usageHistoryRoute => GoRouteData.$route(
  path: '/usage-history',
  factory: $UsageHistoryRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'usage-history-detail',
      factory: $UsageHistoryDetailsRoute._fromState,
    ),
  ],
);

mixin $UsageHistoryRoute on GoRouteData {
  static UsageHistoryRoute _fromState(GoRouterState state) =>
      const UsageHistoryRoute();

  @override
  String get location => GoRouteData.$location('/usage-history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UsageHistoryDetailsRoute on GoRouteData {
  static UsageHistoryDetailsRoute _fromState(GoRouterState state) =>
      UsageHistoryDetailsRoute($extra: state.extra as List<String>);

  UsageHistoryDetailsRoute get _self => this as UsageHistoryDetailsRoute;

  @override
  String get location =>
      GoRouteData.$location('/usage-history/usage-history-detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $orderRoute =>
    GoRouteData.$route(path: '/order', factory: $OrderRoute._fromState);

mixin $OrderRoute on GoRouteData {
  static OrderRoute _fromState(GoRouterState state) => const OrderRoute();

  @override
  String get location => GoRouteData.$location('/order');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userRoute => GoRouteData.$route(
  path: '/user',
  factory: $UserRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'user-edit', factory: $UserEditRoute._fromState),
  ],
);

mixin $UserRoute on GoRouteData {
  static UserRoute _fromState(GoRouterState state) => const UserRoute();

  @override
  String get location => GoRouteData.$location('/user');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UserEditRoute on GoRouteData {
  static UserEditRoute _fromState(GoRouterState state) =>
      UserEditRoute(uid: state.uri.queryParameters['uid']!);

  UserEditRoute get _self => this as UserEditRoute;

  @override
  String get location =>
      GoRouteData.$location('/user/user-edit', queryParams: {'uid': _self.uid});

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $managementRoute => GoRouteData.$route(
  path: '/management',
  factory: $ManagementRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'earnings',
      factory: $EarningsTab._fromState,
      routes: [
        GoRouteData.$route(
          path: 'earnings-detail',
          factory: $EarningsDetailRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(path: 'sales', factory: $SalesTab._fromState),
    GoRouteData.$route(path: 'stock', factory: $StockTab._fromState),
  ],
);

mixin $ManagementRoute on GoRouteData {
  static ManagementRoute _fromState(GoRouterState state) =>
      ManagementRoute(eventId: state.uri.queryParameters['event-id']!);

  ManagementRoute get _self => this as ManagementRoute;

  @override
  String get location => GoRouteData.$location(
    '/management',
    queryParams: {'event-id': _self.eventId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EarningsTab on GoRouteData {
  static EarningsTab _fromState(GoRouterState state) =>
      EarningsTab(eventId: state.uri.queryParameters['event-id']!);

  EarningsTab get _self => this as EarningsTab;

  @override
  String get location => GoRouteData.$location(
    '/management/earnings',
    queryParams: {'event-id': _self.eventId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EarningsDetailRoute on GoRouteData {
  static EarningsDetailRoute _fromState(GoRouterState state) =>
      EarningsDetailRoute(
        eventId: state.uri.queryParameters['event-id']!,
        productId: state.uri.queryParameters['product-id']!,
        productName: state.uri.queryParameters['product-name']!,
      );

  EarningsDetailRoute get _self => this as EarningsDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/management/earnings/earnings-detail',
    queryParams: {
      'event-id': _self.eventId,
      'product-id': _self.productId,
      'product-name': _self.productName,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SalesTab on GoRouteData {
  static SalesTab _fromState(GoRouterState state) =>
      SalesTab(eventId: state.uri.queryParameters['event-id']!);

  SalesTab get _self => this as SalesTab;

  @override
  String get location => GoRouteData.$location(
    '/management/sales',
    queryParams: {'event-id': _self.eventId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $StockTab on GoRouteData {
  static StockTab _fromState(GoRouterState state) =>
      StockTab(eventId: state.uri.queryParameters['event-id']!);

  StockTab get _self => this as StockTab;

  @override
  String get location => GoRouteData.$location(
    '/management/stock',
    queryParams: {'event-id': _self.eventId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $termsRoute =>
    GoRouteData.$route(path: '/terms', factory: $TermsRoute._fromState);

mixin $TermsRoute on GoRouteData {
  static TermsRoute _fromState(GoRouterState state) =>
      TermsRoute(uid: state.uri.queryParameters['uid']!);

  TermsRoute get _self => this as TermsRoute;

  @override
  String get location =>
      GoRouteData.$location('/terms', queryParams: {'uid': _self.uid});

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $ownerDetailRoute => GoRouteData.$route(
  path: '/owner-detail',
  factory: $OwnerDetailRoute._fromState,
);

mixin $OwnerDetailRoute on GoRouteData {
  static OwnerDetailRoute _fromState(GoRouterState state) =>
      OwnerDetailRoute(ownerId: state.uri.queryParameters['owner-id']!);

  OwnerDetailRoute get _self => this as OwnerDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/owner-detail',
    queryParams: {'owner-id': _self.ownerId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
