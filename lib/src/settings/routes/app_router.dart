import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'routes.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
class AppRouter extends _$AppRouter {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final observer = FirebaseAnalyticsObserver(analytics: analytics);
  @override
  GoRouter build() {
    return GoRouter(
      observers: [observer],
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: AppRoutes.topPage,
      routes: $appRoutes,
      // 遷移ページがないなどのエラーが発生した時に、このページに行く
      // errorPageBuilder: errorPageBuilder,
    );
  }
}
