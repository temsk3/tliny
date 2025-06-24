// HookWidgetで使用するカスタムHook
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

SnackBarController useSnackBar() {
  final context = useContext();
  return SnackBarController(context: context);
}

// スナックバーを出すクラス
class SnackBarController {
  SnackBarController({required this.context});
  final BuildContext context;

  void showAlertSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(message)),
    );
  }

  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.green, content: Text(message)),
    );
  }
}
