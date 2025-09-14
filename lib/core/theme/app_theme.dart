import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';

/// アプリケーションテーマ
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// ライトテーマ
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      dividerTheme: _dividerTheme,
      iconTheme: _iconTheme,
      navigationBarTheme: _navigationBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      snackBarTheme: _snackBarTheme,
      dialogTheme: _dialogTheme,
      bottomSheetTheme: _bottomSheetTheme,
      switchTheme: _switchTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
      sliderTheme: _sliderTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      tabBarTheme: _tabBarTheme,
      dataTableTheme: _dataTableTheme,
      tooltipTheme: _tooltipTheme,
      pageTransitionsTheme: _pageTransitionsTheme,
    );
  }

  /// ダークテーマ
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      dividerTheme: _dividerTheme,
      iconTheme: _iconTheme,
      navigationBarTheme: _navigationBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      snackBarTheme: _snackBarTheme,
      dialogTheme: _dialogTheme,
      bottomSheetTheme: _bottomSheetTheme,
      switchTheme: _switchTheme,
      checkboxTheme: _checkboxTheme,
      radioTheme: _radioTheme,
      sliderTheme: _sliderTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      tabBarTheme: _tabBarTheme,
      dataTableTheme: _dataTableTheme,
      tooltipTheme: _tooltipTheme,
      pageTransitionsTheme: _pageTransitionsTheme,
    );
  }

  // =============================================================================
  // Color Schemes
  // =============================================================================

  /// ライトカラースキーム
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6366F1), // Indigo
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE0E7FF),
    onPrimaryContainer: Color(0xFF1E1B4B),
    secondary: Color(0xFF10B981), // Emerald
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD1FAE5),
    onSecondaryContainer: Color(0xFF064E3B),
    tertiary: Color(0xFFF59E0B), // Amber
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFEF3C7),
    onTertiaryContainer: Color(0xFF78350F),
    error: Color(0xFFEF4444), // Red
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF7F1D1D),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF1F2937),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1F2937),
    surfaceVariant: Color(0xFFF3F4F6),
    onSurfaceVariant: Color(0xFF6B7280),
    outline: Color(0xFFD1D5DB),
    outlineVariant: Color(0xFFE5E7EB),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF1F2937),
    onInverseSurface: Color(0xFFF9FAFB),
    inversePrimary: Color(0xFFC7D2FE),
    surfaceTint: Color(0xFF6366F1),
  );

  /// ダークカラースキーム
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF818CF8), // Indigo
    onPrimary: Color(0xFF1E1B4B),
    primaryContainer: Color(0xFF3730A3),
    onPrimaryContainer: Color(0xFFE0E7FF),
    secondary: Color(0xFF34D399), // Emerald
    onSecondary: Color(0xFF064E3B),
    secondaryContainer: Color(0xFF065F46),
    onSecondaryContainer: Color(0xFFD1FAE5),
    tertiary: Color(0xFFFBBF24), // Amber
    onTertiary: Color(0xFF78350F),
    tertiaryContainer: Color(0xFF92400E),
    onTertiaryContainer: Color(0xFFFEF3C7),
    error: Color(0xFFF87171), // Red
    onError: Color(0xFF7F1D1D),
    errorContainer: Color(0xFF991B1B),
    onErrorContainer: Color(0xFFFEE2E2),
    background: Color(0xFF111827),
    onBackground: Color(0xFFF9FAFB),
    surface: Color(0xFF111827),
    onSurface: Color(0xFFF9FAFB),
    surfaceVariant: Color(0xFF374151),
    onSurfaceVariant: Color(0xFFD1D5DB),
    outline: Color(0xFF6B7280),
    outlineVariant: Color(0xFF4B5563),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFF9FAFB),
    onInverseSurface: Color(0xFF1F2937),
    inversePrimary: Color(0xFF6366F1),
    surfaceTint: Color(0xFF818CF8),
  );

  // =============================================================================
  // Text Theme
  // =============================================================================

  /// テキストテーマ
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.22,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.50,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
    ),
  );

  // =============================================================================
  // Component Themes
  // =============================================================================

  /// AppBar テーマ
  static const AppBarTheme _appBarTheme = AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 1,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
  );

  /// ElevatedButton テーマ
  static final ElevatedButtonThemeData _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.largePadding,
        vertical: AppConstants.defaultPadding,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  /// OutlinedButton テーマ
  static final OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.largePadding,
        vertical: AppConstants.defaultPadding,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  /// TextButton テーマ
  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
    ),
  );

  /// InputDecoration テーマ
  static final InputDecorationTheme _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      borderSide: const BorderSide(width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      borderSide: const BorderSide(width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      borderSide: const BorderSide(width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      borderSide: const BorderSide(width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      borderSide: const BorderSide(width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppConstants.defaultPadding,
      vertical: AppConstants.defaultPadding,
    ),
    hintStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
  );

  /// Card テーマ
  static final CardTheme _cardTheme = CardTheme(
    elevation: AppConstants.defaultElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
    ),
    margin: const EdgeInsets.all(AppConstants.smallPadding),
  );

  /// Chip テーマ
  static final ChipThemeData _chipTheme = ChipThemeData(
    backgroundColor: Colors.transparent,
    selectedColor: Colors.transparent,
    disabledColor: Colors.transparent,
    labelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppConstants.smallPadding,
      vertical: AppConstants.smallPadding / 2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
    ),
  );

  /// Divider テーマ
  static const DividerThemeData _dividerTheme = DividerThemeData(
    thickness: 1,
    space: 1,
  );

  /// Icon テーマ
  static const IconThemeData _iconTheme = IconThemeData(
    size: 24,
  );

  /// NavigationBar テーマ
  static const NavigationBarThemeData _navigationBarTheme = NavigationBarThemeData(
    elevation: 2,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  );

  /// BottomNavigationBar テーマ
  static const BottomNavigationBarThemeData _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    elevation: 8,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFF6366F1),
    unselectedItemColor: Color(0xFF6B7280),
  );

  /// FloatingActionButton テーマ
  static const FloatingActionButtonThemeData _floatingActionButtonTheme = FloatingActionButtonThemeData(
    elevation: AppConstants.largeElevation,
    shape: CircleBorder(),
  );

  /// SnackBar テーマ
  static const SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppConstants.defaultBorderRadius)),
    ),
  );

  /// Dialog テーマ
  static final DialogTheme _dialogTheme = DialogTheme(
    elevation: AppConstants.largeElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.largeBorderRadius),
    ),
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),
    contentTextStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
  );

  /// BottomSheet テーマ
  static final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    elevation: AppConstants.largeElevation,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConstants.largeBorderRadius),
      ),
    ),
  );

  /// Switch テーマ
  static const SwitchThemeData _switchTheme = SwitchThemeData(
    thumbColor: MaterialStatePropertyAll(Color(0xFF6366F1)),
    trackColor: MaterialStatePropertyAll(Color(0xFFE5E7EB)),
  );

  /// Checkbox テーマ
  static const CheckboxThemeData _checkboxTheme = CheckboxThemeData(
    fillColor: MaterialStatePropertyAll(Color(0xFF6366F1)),
  );

  /// Radio テーマ
  static const RadioThemeData _radioTheme = RadioThemeData(
    fillColor: MaterialStatePropertyAll(Color(0xFF6366F1)),
  );

  /// Slider テーマ
  static const SliderThemeData _sliderTheme = SliderThemeData(
    activeTrackColor: Color(0xFF6366F1),
    inactiveTrackColor: Color(0xFFE5E7EB),
    thumbColor: Color(0xFF6366F1),
    overlayColor: Color(0x1F6366F1),
  );

  /// ProgressIndicator テーマ
  static const ProgressIndicatorThemeData _progressIndicatorTheme = ProgressIndicatorThemeData(
    color: Color(0xFF6366F1),
    linearTrackColor: Color(0xFFE5E7EB),
  );

  /// TabBar テーマ
  static const TabBarTheme _tabBarTheme = TabBarTheme(
    labelColor: Color(0xFF6366F1),
    unselectedLabelColor: Color(0xFF6B7280),
    indicatorColor: Color(0xFF6366F1),
  );

  /// DataTable テーマ
  static const DataTableThemeData _dataTableTheme = DataTableThemeData(
    headingTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
    ),
    dataTextStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.1,
    ),
  );

  /// Tooltip テーマ
  static const TooltipThemeData _tooltipTheme = TooltipThemeData(
    decoration: BoxDecoration(
      color: Color(0xFF1F2937),
      borderRadius: BorderRadius.all(Radius.circular(AppConstants.smallBorderRadius)),
    ),
    textStyle: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  /// PageTransitions テーマ
  static const PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}

/// テーマモードプロバイダー
@riverpod
ThemeMode themeMode(ThemeModeRef ref) {
  return ThemeMode.system;
}