// HookWidgetで使用するカスタムHook
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../ui/common/error_handler.dart';

SnackBarController useSnackBar() {
  final context = useContext();
  return SnackBarController(context: context);
}

// スナックバーを出すクラス
class SnackBarController {
  SnackBarController({required this.context});
  final BuildContext context;

  void showAlertSnackBar(String message) {
    // ErrorHandlerを使うように統一
    ErrorHandler.showWarningSnackBar(context, message);
  }

  void showSuccessSnackBar(String message) {
    ErrorHandler.showSuccessSnackBar(context, message);
  }
}
