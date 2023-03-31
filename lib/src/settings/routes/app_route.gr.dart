// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i41;
import 'package:flutter/material.dart' as _i42;
import 'package:tliny/src/data/model/product_model.dart' as _i44;
import 'package:tliny/src/data/model/program_model.dart' as _i43;
import 'package:tliny/src/data/model/staff_model.dart' as _i45;
import 'package:tliny/src/ui/auth/sign_in.dart' as _i5;
import 'package:tliny/src/ui/auth/sign_up.dart' as _i6;
import 'package:tliny/src/ui/cart/cart_page.dart' as _i22;
import 'package:tliny/src/ui/checkout/checkout_cancel.dart' as _i15;
import 'package:tliny/src/ui/checkout/checkout_success_page.dart' as _i14;
import 'package:tliny/src/ui/favorite/favorite_page.dart' as _i7;
import 'package:tliny/src/ui/home.dart' as _i2;
import 'package:tliny/src/ui/my_program/my_program_page.dart' as _i16;
import 'package:tliny/src/ui/order/order_page.dart' as _i40;
import 'package:tliny/src/ui/product/product_details_page.dart' as _i10;
import 'package:tliny/src/ui/product/product_edit_page.dart' as _i12;
import 'package:tliny/src/ui/product/product_list.dart' as _i13;
import 'package:tliny/src/ui/product/product_page.dart' as _i11;
import 'package:tliny/src/ui/program/program_details_page.dart' as _i20;
import 'package:tliny/src/ui/program/program_edit_page.dart' as _i19;
import 'package:tliny/src/ui/program/program_page.dart' as _i21;
import 'package:tliny/src/ui/qr_code/qr_code_page.dart' as _i26;
import 'package:tliny/src/ui/qr_code/qr_detail.dart' as _i28;
import 'package:tliny/src/ui/qr_code/qr_scan_page.dart' as _i27;
import 'package:tliny/src/ui/sample/sample/sample_page.dart' as _i18;
import 'package:tliny/src/ui/sample/sample/sample_page2.dart' as _i17;
import 'package:tliny/src/ui/staff/staff_details_page.dart' as _i24;
import 'package:tliny/src/ui/staff/staff_page.dart' as _i25;
import 'package:tliny/src/ui/stripe/account/account_complete_page.dart' as _i37;
import 'package:tliny/src/ui/stripe/account/account_page.dart' as _i38;
import 'package:tliny/src/ui/stripe/checkout/checkout_page.dart' as _i33;
import 'package:tliny/src/ui/stripe/customer/edit_customer_page.dart' as _i39;
import 'package:tliny/src/ui/stripe/payment_intent/payment_checkout_page.dart'
    as _i29;
import 'package:tliny/src/ui/stripe/payment_intent/payment_page.dart' as _i30;
import 'package:tliny/src/ui/stripe/payment_method/payment_method.dart' as _i32;
import 'package:tliny/src/ui/stripe/setup_intent/card_page.dart' as _i36;
import 'package:tliny/src/ui/stripe/setup_intent/intent_complete_page.dart'
    as _i34;
import 'package:tliny/src/ui/stripe/setup_intent/setup_intent_with_sca.dart'
    as _i35;
import 'package:tliny/src/ui/stripe/stripe_page.dart' as _i31;
import 'package:tliny/src/ui/ticket/ticket_page.dart' as _i23;
import 'package:tliny/src/ui/top/top_page.dart' as _i1;
import 'package:tliny/src/ui/usage_history/history_details.dart' as _i4;
import 'package:tliny/src/ui/usage_history/history_page.dart' as _i3;
import 'package:tliny/src/ui/user/user_edit_page.dart' as _i8;
import 'package:tliny/src/ui/user/user_page.dart' as _i9;

abstract class $AppRouter extends _i41.RootStackRouter {
  $AppRouter([_i42.GlobalKey<_i42.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i41.PageFactory> pagesMap = {
    TopRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.TopPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    UsageHistoryRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.UsageHistoryPage(),
      );
    },
    UsageHistoryDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UsageHistoryDetailsRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.UsageHistoryDetailsPage(
          key: args.key,
          list: args.list,
        ),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SignInPage(
          key: args.key,
          onSigninCallback: args.onSigninCallback,
        ),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SignUpPage(),
      );
    },
    FavoriteRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.FavoritePage(),
      );
    },
    UserEditRoute.name: (routeData) {
      final args = routeData.argsAs<UserEditRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.UserEditPage(
          key: args.key,
          uid: args.uid,
        ),
      );
    },
    UserRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.UserPage(),
      );
    },
    ProductDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailsRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.ProductDetailsPage(
          key: args.key,
          program: args.program,
          product: args.product,
        ),
      );
    },
    ProductRoute.name: (routeData) {
      final args = routeData.argsAs<ProductRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.ProductPage(
          args.program,
          key: args.key,
        ),
      );
    },
    ProductEditRoute.name: (routeData) {
      final args = routeData.argsAs<ProductEditRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ProductEditPage(
          key: args.key,
          program: args.program,
          product: args.product,
        ),
      );
    },
    ProductListRoute.name: (routeData) {
      final args = routeData.argsAs<ProductListRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.ProductListPage(
          key: args.key,
          program: args.program,
          genre: args.genre,
        ),
      );
    },
    CheckoutSuccessRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CheckoutSuccessRouteArgs>(
          orElse: () => CheckoutSuccessRouteArgs(
              sessionId: queryParams.optString('session_id')));
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.CheckoutSuccessPage(
          key: args.key,
          sessionId: args.sessionId,
        ),
      );
    },
    CheckoutCancelRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CheckoutCancelRouteArgs>(
          orElse: () => CheckoutCancelRouteArgs(
              sessionId: queryParams.optString('session_id')));
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.CheckoutCancelPage(
          key: args.key,
          sessionId: args.sessionId,
        ),
      );
    },
    MyProgramRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.MyProgramPage(),
      );
    },
    Sample2Route.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.Sample2Page(),
      );
    },
    SampleRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.SamplePage(),
      );
    },
    ProgramEditRoute.name: (routeData) {
      final args = routeData.argsAs<ProgramEditRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.ProgramEditPage(
          key: args.key,
          program: args.program,
        ),
      );
    },
    ProgramDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ProgramDetailsRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.ProgramDetailsPage(
          key: args.key,
          program: args.program,
        ),
      );
    },
    ProgramRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.ProgramPage(),
      );
    },
    CartRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.CartPage(),
      );
    },
    TicketRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.TicketPage(),
      );
    },
    StaffDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<StaffDetailsRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.StaffDetailsPage(
          key: args.key,
          programId: args.programId,
          staff: args.staff,
        ),
      );
    },
    StaffRoute.name: (routeData) {
      final args = routeData.argsAs<StaffRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.StaffPage(
          key: args.key,
          programId: args.programId,
        ),
      );
    },
    CreateQRCodeRoute.name: (routeData) {
      final args = routeData.argsAs<CreateQRCodeRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.CreateQRCodePage(
          key: args.key,
          eventId: args.eventId,
          ticketList: args.ticketList,
        ),
      );
    },
    QRScanRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.QRScanPage(),
      );
    },
    QRDetailRoute.name: (routeData) {
      final args = routeData.argsAs<QRDetailRouteArgs>();
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.QRDetailPage(
          key: args.key,
          eventId: args.eventId,
        ),
      );
    },
    PaymentCheckoutRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.PaymentCheckoutPage(),
      );
    },
    PaymentRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.PaymentPage(),
      );
    },
    StripeRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.StripePage(),
      );
    },
    PaymentMethodRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.PaymentMethodPage(),
      );
    },
    CheckoutRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.CheckoutPage(),
      );
    },
    IntentCompleteRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<IntentCompleteRouteArgs>(
          orElse: () => IntentCompleteRouteArgs(
              clientSecret:
                  queryParams.optString('payment_intent_client_secret')));
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i34.IntentCompletePage(
          key: args.key,
          clientSecret: args.clientSecret,
        ),
      );
    },
    SetupIntentWithScaRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.SetupIntentWithScaPage(),
      );
    },
    InvoiceSettingRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.InvoiceSettingPage(),
      );
    },
    AccountCompleteRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.AccountCompletePage(),
      );
    },
    AccountRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.AccountPage(),
      );
    },
    EditCustomerRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i39.EditCustomerPage(),
      );
    },
    OrderRoute.name: (routeData) {
      return _i41.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i40.OrderPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.TopPage]
class TopRoute extends _i41.PageRouteInfo<void> {
  const TopRoute({List<_i41.PageRouteInfo>? children})
      : super(
          TopRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i41.PageRouteInfo<void> {
  const HomeRoute({List<_i41.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i3.UsageHistoryPage]
class UsageHistoryRoute extends _i41.PageRouteInfo<void> {
  const UsageHistoryRoute({List<_i41.PageRouteInfo>? children})
      : super(
          UsageHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsageHistoryRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i4.UsageHistoryDetailsPage]
class UsageHistoryDetailsRoute
    extends _i41.PageRouteInfo<UsageHistoryDetailsRouteArgs> {
  UsageHistoryDetailsRoute({
    _i42.Key? key,
    required List<String> list,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          UsageHistoryDetailsRoute.name,
          args: UsageHistoryDetailsRouteArgs(
            key: key,
            list: list,
          ),
          initialChildren: children,
        );

  static const String name = 'UsageHistoryDetailsRoute';

  static const _i41.PageInfo<UsageHistoryDetailsRouteArgs> page =
      _i41.PageInfo<UsageHistoryDetailsRouteArgs>(name);
}

class UsageHistoryDetailsRouteArgs {
  const UsageHistoryDetailsRouteArgs({
    this.key,
    required this.list,
  });

  final _i42.Key? key;

  final List<String> list;

  @override
  String toString() {
    return 'UsageHistoryDetailsRouteArgs{key: $key, list: $list}';
  }
}

/// generated route for
/// [_i5.SignInPage]
class SignInRoute extends _i41.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i42.Key? key,
    required dynamic Function(bool) onSigninCallback,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(
            key: key,
            onSigninCallback: onSigninCallback,
          ),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const _i41.PageInfo<SignInRouteArgs> page =
      _i41.PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({
    this.key,
    required this.onSigninCallback,
  });

  final _i42.Key? key;

  final dynamic Function(bool) onSigninCallback;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key, onSigninCallback: $onSigninCallback}';
  }
}

/// generated route for
/// [_i6.SignUpPage]
class SignUpRoute extends _i41.PageRouteInfo<void> {
  const SignUpRoute({List<_i41.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i7.FavoritePage]
class FavoriteRoute extends _i41.PageRouteInfo<void> {
  const FavoriteRoute({List<_i41.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i8.UserEditPage]
class UserEditRoute extends _i41.PageRouteInfo<UserEditRouteArgs> {
  UserEditRoute({
    _i42.Key? key,
    required String uid,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          UserEditRoute.name,
          args: UserEditRouteArgs(
            key: key,
            uid: uid,
          ),
          initialChildren: children,
        );

  static const String name = 'UserEditRoute';

  static const _i41.PageInfo<UserEditRouteArgs> page =
      _i41.PageInfo<UserEditRouteArgs>(name);
}

class UserEditRouteArgs {
  const UserEditRouteArgs({
    this.key,
    required this.uid,
  });

  final _i42.Key? key;

  final String uid;

  @override
  String toString() {
    return 'UserEditRouteArgs{key: $key, uid: $uid}';
  }
}

/// generated route for
/// [_i9.UserPage]
class UserRoute extends _i41.PageRouteInfo<void> {
  const UserRoute({List<_i41.PageRouteInfo>? children})
      : super(
          UserRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ProductDetailsPage]
class ProductDetailsRoute extends _i41.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i42.Key? key,
    required _i43.Program program,
    required _i44.Product product,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            program: program,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static const _i41.PageInfo<ProductDetailsRouteArgs> page =
      _i41.PageInfo<ProductDetailsRouteArgs>(name);
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.program,
    required this.product,
  });

  final _i42.Key? key;

  final _i43.Program program;

  final _i44.Product product;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, program: $program, product: $product}';
  }
}

/// generated route for
/// [_i11.ProductPage]
class ProductRoute extends _i41.PageRouteInfo<ProductRouteArgs> {
  ProductRoute({
    required _i43.Program program,
    _i42.Key? key,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          ProductRoute.name,
          args: ProductRouteArgs(
            program: program,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductRoute';

  static const _i41.PageInfo<ProductRouteArgs> page =
      _i41.PageInfo<ProductRouteArgs>(name);
}

class ProductRouteArgs {
  const ProductRouteArgs({
    required this.program,
    this.key,
  });

  final _i43.Program program;

  final _i42.Key? key;

  @override
  String toString() {
    return 'ProductRouteArgs{program: $program, key: $key}';
  }
}

/// generated route for
/// [_i12.ProductEditPage]
class ProductEditRoute extends _i41.PageRouteInfo<ProductEditRouteArgs> {
  ProductEditRoute({
    _i42.Key? key,
    required _i43.Program program,
    required _i44.Product product,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          ProductEditRoute.name,
          args: ProductEditRouteArgs(
            key: key,
            program: program,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductEditRoute';

  static const _i41.PageInfo<ProductEditRouteArgs> page =
      _i41.PageInfo<ProductEditRouteArgs>(name);
}

class ProductEditRouteArgs {
  const ProductEditRouteArgs({
    this.key,
    required this.program,
    required this.product,
  });

  final _i42.Key? key;

  final _i43.Program program;

  final _i44.Product product;

  @override
  String toString() {
    return 'ProductEditRouteArgs{key: $key, program: $program, product: $product}';
  }
}

/// generated route for
/// [_i13.ProductListPage]
class ProductListRoute extends _i41.PageRouteInfo<ProductListRouteArgs> {
  ProductListRoute({
    _i42.Key? key,
    required _i43.Program program,
    _i44.GenreType? genre,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          ProductListRoute.name,
          args: ProductListRouteArgs(
            key: key,
            program: program,
            genre: genre,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductListRoute';

  static const _i41.PageInfo<ProductListRouteArgs> page =
      _i41.PageInfo<ProductListRouteArgs>(name);
}

class ProductListRouteArgs {
  const ProductListRouteArgs({
    this.key,
    required this.program,
    this.genre,
  });

  final _i42.Key? key;

  final _i43.Program program;

  final _i44.GenreType? genre;

  @override
  String toString() {
    return 'ProductListRouteArgs{key: $key, program: $program, genre: $genre}';
  }
}

/// generated route for
/// [_i14.CheckoutSuccessPage]
class CheckoutSuccessRoute
    extends _i41.PageRouteInfo<CheckoutSuccessRouteArgs> {
  CheckoutSuccessRoute({
    _i42.Key? key,
    required String? sessionId,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          CheckoutSuccessRoute.name,
          args: CheckoutSuccessRouteArgs(
            key: key,
            sessionId: sessionId,
          ),
          rawQueryParams: {'session_id': sessionId},
          initialChildren: children,
        );

  static const String name = 'CheckoutSuccessRoute';

  static const _i41.PageInfo<CheckoutSuccessRouteArgs> page =
      _i41.PageInfo<CheckoutSuccessRouteArgs>(name);
}

class CheckoutSuccessRouteArgs {
  const CheckoutSuccessRouteArgs({
    this.key,
    required this.sessionId,
  });

  final _i42.Key? key;

  final String? sessionId;

  @override
  String toString() {
    return 'CheckoutSuccessRouteArgs{key: $key, sessionId: $sessionId}';
  }
}

/// generated route for
/// [_i15.CheckoutCancelPage]
class CheckoutCancelRoute extends _i41.PageRouteInfo<CheckoutCancelRouteArgs> {
  CheckoutCancelRoute({
    _i42.Key? key,
    required String? sessionId,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          CheckoutCancelRoute.name,
          args: CheckoutCancelRouteArgs(
            key: key,
            sessionId: sessionId,
          ),
          rawQueryParams: {'session_id': sessionId},
          initialChildren: children,
        );

  static const String name = 'CheckoutCancelRoute';

  static const _i41.PageInfo<CheckoutCancelRouteArgs> page =
      _i41.PageInfo<CheckoutCancelRouteArgs>(name);
}

class CheckoutCancelRouteArgs {
  const CheckoutCancelRouteArgs({
    this.key,
    required this.sessionId,
  });

  final _i42.Key? key;

  final String? sessionId;

  @override
  String toString() {
    return 'CheckoutCancelRouteArgs{key: $key, sessionId: $sessionId}';
  }
}

/// generated route for
/// [_i16.MyProgramPage]
class MyProgramRoute extends _i41.PageRouteInfo<void> {
  const MyProgramRoute({List<_i41.PageRouteInfo>? children})
      : super(
          MyProgramRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProgramRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i17.Sample2Page]
class Sample2Route extends _i41.PageRouteInfo<void> {
  const Sample2Route({List<_i41.PageRouteInfo>? children})
      : super(
          Sample2Route.name,
          initialChildren: children,
        );

  static const String name = 'Sample2Route';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i18.SamplePage]
class SampleRoute extends _i41.PageRouteInfo<void> {
  const SampleRoute({List<_i41.PageRouteInfo>? children})
      : super(
          SampleRoute.name,
          initialChildren: children,
        );

  static const String name = 'SampleRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i19.ProgramEditPage]
class ProgramEditRoute extends _i41.PageRouteInfo<ProgramEditRouteArgs> {
  ProgramEditRoute({
    _i42.Key? key,
    required _i43.Program program,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          ProgramEditRoute.name,
          args: ProgramEditRouteArgs(
            key: key,
            program: program,
          ),
          initialChildren: children,
        );

  static const String name = 'ProgramEditRoute';

  static const _i41.PageInfo<ProgramEditRouteArgs> page =
      _i41.PageInfo<ProgramEditRouteArgs>(name);
}

class ProgramEditRouteArgs {
  const ProgramEditRouteArgs({
    this.key,
    required this.program,
  });

  final _i42.Key? key;

  final _i43.Program program;

  @override
  String toString() {
    return 'ProgramEditRouteArgs{key: $key, program: $program}';
  }
}

/// generated route for
/// [_i20.ProgramDetailsPage]
class ProgramDetailsRoute extends _i41.PageRouteInfo<ProgramDetailsRouteArgs> {
  ProgramDetailsRoute({
    _i42.Key? key,
    required _i43.Program program,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          ProgramDetailsRoute.name,
          args: ProgramDetailsRouteArgs(
            key: key,
            program: program,
          ),
          initialChildren: children,
        );

  static const String name = 'ProgramDetailsRoute';

  static const _i41.PageInfo<ProgramDetailsRouteArgs> page =
      _i41.PageInfo<ProgramDetailsRouteArgs>(name);
}

class ProgramDetailsRouteArgs {
  const ProgramDetailsRouteArgs({
    this.key,
    required this.program,
  });

  final _i42.Key? key;

  final _i43.Program program;

  @override
  String toString() {
    return 'ProgramDetailsRouteArgs{key: $key, program: $program}';
  }
}

/// generated route for
/// [_i21.ProgramPage]
class ProgramRoute extends _i41.PageRouteInfo<void> {
  const ProgramRoute({List<_i41.PageRouteInfo>? children})
      : super(
          ProgramRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProgramRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i22.CartPage]
class CartRoute extends _i41.PageRouteInfo<void> {
  const CartRoute({List<_i41.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i23.TicketPage]
class TicketRoute extends _i41.PageRouteInfo<void> {
  const TicketRoute({List<_i41.PageRouteInfo>? children})
      : super(
          TicketRoute.name,
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i24.StaffDetailsPage]
class StaffDetailsRoute extends _i41.PageRouteInfo<StaffDetailsRouteArgs> {
  StaffDetailsRoute({
    _i42.Key? key,
    required String programId,
    required _i45.Staff staff,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          StaffDetailsRoute.name,
          args: StaffDetailsRouteArgs(
            key: key,
            programId: programId,
            staff: staff,
          ),
          initialChildren: children,
        );

  static const String name = 'StaffDetailsRoute';

  static const _i41.PageInfo<StaffDetailsRouteArgs> page =
      _i41.PageInfo<StaffDetailsRouteArgs>(name);
}

class StaffDetailsRouteArgs {
  const StaffDetailsRouteArgs({
    this.key,
    required this.programId,
    required this.staff,
  });

  final _i42.Key? key;

  final String programId;

  final _i45.Staff staff;

  @override
  String toString() {
    return 'StaffDetailsRouteArgs{key: $key, programId: $programId, staff: $staff}';
  }
}

/// generated route for
/// [_i25.StaffPage]
class StaffRoute extends _i41.PageRouteInfo<StaffRouteArgs> {
  StaffRoute({
    _i42.Key? key,
    required String programId,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          StaffRoute.name,
          args: StaffRouteArgs(
            key: key,
            programId: programId,
          ),
          initialChildren: children,
        );

  static const String name = 'StaffRoute';

  static const _i41.PageInfo<StaffRouteArgs> page =
      _i41.PageInfo<StaffRouteArgs>(name);
}

class StaffRouteArgs {
  const StaffRouteArgs({
    this.key,
    required this.programId,
  });

  final _i42.Key? key;

  final String programId;

  @override
  String toString() {
    return 'StaffRouteArgs{key: $key, programId: $programId}';
  }
}

/// generated route for
/// [_i26.CreateQRCodePage]
class CreateQRCodeRoute extends _i41.PageRouteInfo<CreateQRCodeRouteArgs> {
  CreateQRCodeRoute({
    _i42.Key? key,
    required String eventId,
    required Set<String> ticketList,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          CreateQRCodeRoute.name,
          args: CreateQRCodeRouteArgs(
            key: key,
            eventId: eventId,
            ticketList: ticketList,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateQRCodeRoute';

  static const _i41.PageInfo<CreateQRCodeRouteArgs> page =
      _i41.PageInfo<CreateQRCodeRouteArgs>(name);
}

class CreateQRCodeRouteArgs {
  const CreateQRCodeRouteArgs({
    this.key,
    required this.eventId,
    required this.ticketList,
  });

  final _i42.Key? key;

  final String eventId;

  final Set<String> ticketList;

  @override
  String toString() {
    return 'CreateQRCodeRouteArgs{key: $key, eventId: $eventId, ticketList: $ticketList}';
  }
}

/// generated route for
/// [_i27.QRScanPage]
class QRScanRoute extends _i41.PageRouteInfo<void> {
  const QRScanRoute({List<_i41.PageRouteInfo>? children})
      : super(
          QRScanRoute.name,
          initialChildren: children,
        );

  static const String name = 'QRScanRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i28.QRDetailPage]
class QRDetailRoute extends _i41.PageRouteInfo<QRDetailRouteArgs> {
  QRDetailRoute({
    _i42.Key? key,
    required String eventId,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          QRDetailRoute.name,
          args: QRDetailRouteArgs(
            key: key,
            eventId: eventId,
          ),
          initialChildren: children,
        );

  static const String name = 'QRDetailRoute';

  static const _i41.PageInfo<QRDetailRouteArgs> page =
      _i41.PageInfo<QRDetailRouteArgs>(name);
}

class QRDetailRouteArgs {
  const QRDetailRouteArgs({
    this.key,
    required this.eventId,
  });

  final _i42.Key? key;

  final String eventId;

  @override
  String toString() {
    return 'QRDetailRouteArgs{key: $key, eventId: $eventId}';
  }
}

/// generated route for
/// [_i29.PaymentCheckoutPage]
class PaymentCheckoutRoute extends _i41.PageRouteInfo<void> {
  const PaymentCheckoutRoute({List<_i41.PageRouteInfo>? children})
      : super(
          PaymentCheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentCheckoutRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i30.PaymentPage]
class PaymentRoute extends _i41.PageRouteInfo<void> {
  const PaymentRoute({List<_i41.PageRouteInfo>? children})
      : super(
          PaymentRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i31.StripePage]
class StripeRoute extends _i41.PageRouteInfo<void> {
  const StripeRoute({List<_i41.PageRouteInfo>? children})
      : super(
          StripeRoute.name,
          initialChildren: children,
        );

  static const String name = 'StripeRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i32.PaymentMethodPage]
class PaymentMethodRoute extends _i41.PageRouteInfo<void> {
  const PaymentMethodRoute({List<_i41.PageRouteInfo>? children})
      : super(
          PaymentMethodRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentMethodRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i33.CheckoutPage]
class CheckoutRoute extends _i41.PageRouteInfo<void> {
  const CheckoutRoute({List<_i41.PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i34.IntentCompletePage]
class IntentCompleteRoute extends _i41.PageRouteInfo<IntentCompleteRouteArgs> {
  IntentCompleteRoute({
    _i42.Key? key,
    required String? clientSecret,
    List<_i41.PageRouteInfo>? children,
  }) : super(
          IntentCompleteRoute.name,
          args: IntentCompleteRouteArgs(
            key: key,
            clientSecret: clientSecret,
          ),
          rawQueryParams: {'payment_intent_client_secret': clientSecret},
          initialChildren: children,
        );

  static const String name = 'IntentCompleteRoute';

  static const _i41.PageInfo<IntentCompleteRouteArgs> page =
      _i41.PageInfo<IntentCompleteRouteArgs>(name);
}

class IntentCompleteRouteArgs {
  const IntentCompleteRouteArgs({
    this.key,
    required this.clientSecret,
  });

  final _i42.Key? key;

  final String? clientSecret;

  @override
  String toString() {
    return 'IntentCompleteRouteArgs{key: $key, clientSecret: $clientSecret}';
  }
}

/// generated route for
/// [_i35.SetupIntentWithScaPage]
class SetupIntentWithScaRoute extends _i41.PageRouteInfo<void> {
  const SetupIntentWithScaRoute({List<_i41.PageRouteInfo>? children})
      : super(
          SetupIntentWithScaRoute.name,
          initialChildren: children,
        );

  static const String name = 'SetupIntentWithScaRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i36.InvoiceSettingPage]
class InvoiceSettingRoute extends _i41.PageRouteInfo<void> {
  const InvoiceSettingRoute({List<_i41.PageRouteInfo>? children})
      : super(
          InvoiceSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'InvoiceSettingRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i37.AccountCompletePage]
class AccountCompleteRoute extends _i41.PageRouteInfo<void> {
  const AccountCompleteRoute({List<_i41.PageRouteInfo>? children})
      : super(
          AccountCompleteRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountCompleteRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i38.AccountPage]
class AccountRoute extends _i41.PageRouteInfo<void> {
  const AccountRoute({List<_i41.PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i39.EditCustomerPage]
class EditCustomerRoute extends _i41.PageRouteInfo<void> {
  const EditCustomerRoute({List<_i41.PageRouteInfo>? children})
      : super(
          EditCustomerRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditCustomerRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}

/// generated route for
/// [_i40.OrderPage]
class OrderRoute extends _i41.PageRouteInfo<void> {
  const OrderRoute({List<_i41.PageRouteInfo>? children})
      : super(
          OrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderRoute';

  static const _i41.PageInfo<void> page = _i41.PageInfo<void>(name);
}
