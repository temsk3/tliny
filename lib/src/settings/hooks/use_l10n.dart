// import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

AppLocalizations useL10n() {
  final context = useContext();
  return AppLocalizations.of(context);
}
