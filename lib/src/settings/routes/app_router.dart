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
  static FirebaseAnalytics? analytics =
      _isInTest ? null : FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver? observer =
      _isInTest ? null : FirebaseAnalyticsObserver(analytics: analytics!);

  static bool get _isInTest {
    if (kIsWeb) {
      return const bool.fromEnvironment('FLUTTER_TEST') ||
          (const String.fromEnvironment('TEST') == 'true');
    } else {
      // dart:ioを使用する場合は条件付きでimport
      try {
        // ignore: avoid_web_libraries_in_flutter
        return const bool.fromEnvironment('FLUTTER_TEST') ||
            (const String.fromEnvironment('TEST') == 'true') ||
            (const String.fromEnvironment('FLUTTER_TEST') == 'true');
      } catch (e) {
        return const bool.fromEnvironment('FLUTTER_TEST') ||
            (const String.fromEnvironment('TEST') == 'true');
      }
    }
  }

  @override
  GoRouter build() {
    return GoRouter(
      observers: observer != null ? [observer!] : [],
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: AppRoutes.topPage,
      routes: $appRoutes,
      // 遷移ページがないなどのエラーが発生した時に、このページに行く
      // errorPageBuilder: errorPageBuilder,
    );
  }
}
