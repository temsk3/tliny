import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tliny/l10n/app_localizations.dart';

AppLocalizations? useL10n() {
  final context = useContext();
  return AppLocalizations.of(context);
}
