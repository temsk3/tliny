import 'package:flutter/material.dart';

import '../../data/model/exception/app_exception.dart';
import '../../utils/logger.dart';

/// エラーが発生した場合に表示する画面
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.e, this.st});

  /// エラーオブジェクト
  final Object e;

  /// スタックトレース
  final StackTrace? st;

  @override
  Widget build(BuildContext context) {
    // エラーログを出力
    logger.e(
      'ErrorScreen: build',
      time: DateTime.now(),
      error: e,
      stackTrace: st,
    );
    // AppExceptionならuserMessageを優先表示
    final message =
        e is AppException ? (e as AppException).userMessage : e.toString();
    return Scaffold(
      appBar: AppBar(title: const Text('エラー')),
      body: Center(
        child: ListView(
          // Use ListView
          shrinkWrap: true, // Important for ListView inside a Column
          children: [
            Padding(
              // Add padding for better visual separation
              padding: const EdgeInsets.all(16),
              child: Column(
                // Put the Text widgets inside a padded Column
                children: [
                  Text(
                    message,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  if (st != null)
                    Text(
                      st.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                ],
              ),
            ), // Add spacing here
            Padding(
              // Wrap the button in a Padding widget
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('ホームへ戻る'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
