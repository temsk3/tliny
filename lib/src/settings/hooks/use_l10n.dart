import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tliny/l10n/app_localizations.dart';

AppLocalizations useL10n() {
  final context = useContext();
  final l10n = AppLocalizations.of(context);
  if (l10n == null) {
    if (kDebugMode) {
      // In debug mode, return a mock AppLocalizations for testing
      // This is a fallback that should only be used in test scenarios
      return _MockAppLocalizations();
    }
    throw StateError('AppLocalizations not found. Make sure MaterialApp has proper localization setup.');
  }
  return l10n;
}

// Mock AppLocalizations for testing
class _MockAppLocalizations extends AppLocalizations {
  _MockAppLocalizations() : super(const Locale('ja', ''));
  
  @override
  String get product => 'Product';
  
  @override
  String get price => 'Price';
  
  @override
  String get stock => 'Stock';
  
  @override
  String currency(int amount) => '¥$amount';
}
