// HookWidgetで使用するカスタムHook
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tliny/l10n/app_localizations.dart';
import 'package:tliny/src/ui/common/error_handler.dart';

DialogController useDialog() {
  final context = useContext();
  return DialogController(context: context);
}

// スナックバーを出すクラス
class DialogController {
  DialogController({required this.context});
  final BuildContext context;

  void showErrorDialog(String title, String content) {
    // ErrorHandlerを使うように統一
    ErrorHandler.showErrorDialog(
      context,
      Exception(content),
      AppLocalizations.of(context)!,
      title: title,
    );
  }

  void showSuccessDialog(String title, String content) {
    ErrorHandler.showSuccessSnackBar(context, content);
  }
}
