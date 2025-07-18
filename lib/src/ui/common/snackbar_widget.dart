import 'package:flutter/material.dart';

/// スナックバーを表示する関数
/// 非推奨: 直接ErrorHandler.showSuccessSnackBar等を使ってください。
SnackBar snackBar(Color? color, {required String text}) {
  // 非推奨: 直接ErrorHandlerを使うこと
  // ここでは従来通りSnackBarを返すだけ
  return SnackBar(
    content: Row(
      children: [
        Icon(Icons.check, color: color ?? Colors.green),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(color: color ?? Colors.green)),
      ],
    ),
    backgroundColor: color ?? Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );
}
