import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'settings/routes/app_route.dart';
import 'settings/theme/app_theme.dart';

class MyApp extends HookConsumerWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final appRouter = useMemoized(() => _appRouter);
    // final authGuard = ref.watch(authGuardProvider);
    // final appRouter = useMemoized(() => AppRouter(authGuard: authGuard));

    return ResponsiveSizer(
      builder: (context, orientation, screenType) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        theme: theme.data,
        darkTheme: AppTheme.dark().data,
        themeMode: themeMode,
        locale: DevicePreview.locale(context),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: appRouter.config(
          navigatorObservers: () => [
            observer,
          ],
        ),
        // routeInformationParser: appRouter.defaultRouteParser(),
        // routerDelegate: appRouter.delegate(
        //   navigatorObservers: () => [
        //     observer,
        //   ],
        // ),
      ),
    );
  }
}
