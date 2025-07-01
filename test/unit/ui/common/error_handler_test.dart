import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/model/exception/app_exception.dart';
import 'package:tliny/src/ui/common/error_handler.dart';
import 'package:tliny/src/ui/common/loading_screen.dart';

void main() {
  group('ErrorHandler Tests', () {
    group('getErrorMessage', () {
      test('AppExceptionの場合はuserMessageを返す', () {
        const exception = DatabaseException(message: 'データベースエラー');
        final message = ErrorHandler.getErrorMessage(exception);
        expect(message, equals('データベースエラー'));
      });

      test('通常のExceptionの場合はtoStringを返す', () {
        final exception = Exception('通常のエラー');
        final message = ErrorHandler.getErrorMessage(exception);
        expect(message, equals('Exception: 通常のエラー'));
      });

      test('文字列の場合はそのまま返す', () {
        const error = '文字列エラー';
        final message = ErrorHandler.getErrorMessage(error);
        expect(message, equals('文字列エラー'));
      });
    });

    group('showErrorSnackBar', () {
      testWidgets('AppExceptionの場合はuserMessageを表示', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        const exception = DatabaseException(
                          message: 'データベースエラー',
                        );
                        ErrorHandler.showErrorSnackBar(context, exception);
                      },
                      child: const Text('Test'),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(find.text('データベースエラー'), findsOneWidget);
        expect(find.text('閉じる'), findsOneWidget);
      });

      testWidgets('通常のExceptionの場合はtoStringを表示', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        final exception = Exception('通常のエラー');
                        ErrorHandler.showErrorSnackBar(context, exception);
                      },
                      child: const Text('Test'),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(find.text('Exception: 通常のエラー'), findsOneWidget);
        expect(find.text('閉じる'), findsOneWidget);
      });
    });

    group('showSuccessSnackBar', () {
      testWidgets('成功メッセージを表示', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        ErrorHandler.showSuccessSnackBar(context, '成功しました');
                      },
                      child: const Text('Test'),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(find.text('成功しました'), findsOneWidget);
      });
    });

    group('showInfoSnackBar', () {
      testWidgets('情報メッセージを表示', (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        ErrorHandler.showInfoSnackBar(context, '情報メッセージ');
                      },
                      child: const Text('Test'),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Test'));
        await tester.pump();

        expect(find.text('情報メッセージ'), findsOneWidget);
      });
    });
  });

  group('ErrorHandlingMixin Tests', () {
    testWidgets('executeWithErrorHandling - 成功時', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            globalLoadingControllerProvider.overrideWith(
              TestGlobalLoadingController.new,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return const TestWidget();
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Success Test'));
      await tester.pumpAndSettle();

      expect(find.text('成功: テスト完了'), findsOneWidget);
    });

    testWidgets('executeWithErrorHandling - AppException時', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            globalLoadingControllerProvider.overrideWith(
              TestGlobalLoadingController.new,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return const TestWidget();
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('AppException Test'));
      await tester.pumpAndSettle();

      expect(find.text('データベースエラー'), findsOneWidget);
    });

    testWidgets('executeWithErrorHandling - 通常のException時', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            globalLoadingControllerProvider.overrideWith(
              TestGlobalLoadingController.new,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return const TestWidget();
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Exception Test'));
      await tester.pumpAndSettle();

      // ダイアログが表示されることを確認
      expect(find.text('テスト処理'), findsOneWidget);
      expect(find.text('Exception: 通常のエラー'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);
      expect(find.text('閉じる'), findsOneWidget);
    });
  });
}

/// テスト用のGlobalLoadingController
class TestGlobalLoadingController extends GlobalLoadingController {
  @override
  void startLoading() {
    // テストでは何もしない
  }

  @override
  void stopLoading() {
    // テストでは何もしない
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with ErrorHandlingMixin {
  String? result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (result != null) Text(result!),
        ElevatedButton(
          onPressed: () async {
            final result = await executeWithErrorHandling(
              context,
              () async {
                await Future.delayed(const Duration(milliseconds: 100));
                return 'テスト完了';
              },
              errorContext: 'テスト処理',
              showLoading: false, // テストではローディングを無効化
            );
            if (result != null) {
              setState(() {
                this.result = '成功: $result';
              });
            }
          },
          child: const Text('Success Test'),
        ),
        ElevatedButton(
          onPressed: () async {
            await executeWithErrorHandling(
              context,
              () async {
                await Future.delayed(const Duration(milliseconds: 100));
                throw const DatabaseException(message: 'データベースエラー');
              },
              errorContext: 'テスト処理',
              showLoading: false, // テストではローディングを無効化
            );
          },
          child: const Text('AppException Test'),
        ),
        ElevatedButton(
          onPressed: () async {
            await executeWithErrorHandling(
              context,
              () async {
                await Future.delayed(const Duration(milliseconds: 100));
                throw Exception('通常のエラー');
              },
              errorContext: 'テスト処理',
              showLoading: false, // テストではローディングを無効化
              onRetry: () {
                // 再試行処理
              },
            );
          },
          child: const Text('Exception Test'),
        ),
      ],
    );
  }
}
