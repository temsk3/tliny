// HookWidgetで使用するカスタムHook
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

DialogController useDialog() {
  final context = useContext();
  return DialogController(context: context);
}

// スナックバーを出すクラス
class DialogController {
  DialogController({required this.context});
  final BuildContext context;

  void showErrorDialog(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(title), content: Text(content));
      },
    );
  }

  void showSuccessDialog(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(title), content: Text(content));
      },
    );
  }
}
