import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../l10n/app_localizations.dart';
import 'settings/routes/app_router.dart';
import 'settings/theme/app_theme.dart';
import 'ui/common/loading_screen.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // SnackBarの表示を制御するためのグローバルキー
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final appTheme = AppTheme();
    final router = ref.watch(appRouterProvider);

    return ResponsiveSizer(
      builder:
          (context, orientation, screenType) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: appTheme.lightTheme.copyWith(
              snackBarTheme: const SnackBarThemeData(
                behavior: SnackBarBehavior.fixed,
              ),
            ),
            darkTheme: appTheme.darkTheme.copyWith(
              snackBarTheme: const SnackBarThemeData(
                behavior: SnackBarBehavior.fixed,
              ),
            ),
            themeMode: themeMode,
            locale: DevicePreview.locale(context),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            restorationScopeId: 'router',
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            scaffoldMessengerKey: scaffoldMessengerKey,
            builder: (context, child) {
              return Stack(children: [child!, const GlobalLoadingOverlay()]);
            },
          ),
    );
  }
}
