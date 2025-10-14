import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tliny/l10n/app_localizations.dart';

AppLocalizations useL10n() {
  final context = useContext();
  final l10n = AppLocalizations.of(context);
  if (l10n == null) {
    throw StateError('AppLocalizations not found. Make sure MaterialApp has proper localization setup.');
  }
  return l10n;
}
