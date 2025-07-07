import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/model/exception/app_exception.dart';
import 'package:tliny/src/ui/common/error_handler.dart';
import 'package:tliny/src/ui/common/loading_screen.dart';

import '../../../utils/test_helpers.dart';

void main() {
  group('ErrorHandler Tests', () {
    group('getErrorMessage', () {
      test('AppExceptionの場合はuserMessageを返す', () {
        const exception = DatabaseException(message: 'データベースエラー');
        final l10n = TestHelpers.createMockL10n();
        final message = ErrorHandler.getErrorMessage(exception, l10n);
        expect(message, equals('データベースエラー'));
      });

      test('通常のExceptionの場合はtoStringを返す', () {
        final exception = Exception('通常のエラー');
        final l10n = TestHelpers.createMockL10n();
        final message = ErrorHandler.getErrorMessage(exception, l10n);
        expect(message, equals('Exception: 通常のエラー'));
      });

      test('文字列の場合はそのまま返す', () {
        const error = '文字列エラー';
        final l10n = TestHelpers.createMockL10n();
        final message = ErrorHandler.getErrorMessage(error, l10n);
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
                        final l10n = TestHelpers.createMockL10n();
                        ErrorHandler.showErrorSnackBar(
                          context,
                          exception,
                          l10n,
                        );
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
                        final l10n = TestHelpers.createMockL10n();
                        ErrorHandler.showErrorSnackBar(
                          context,
                          exception,
                          l10n,
                        );
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

      expect(find.text('エラー'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);
    });
  });
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> with ErrorHandlingMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final l10n = TestHelpers.createMockL10n();
            await executeWithErrorHandling(context, () async {
              await Future.delayed(const Duration(milliseconds: 100));
              return 'テスト完了';
            }, l10n: l10n);
            if (mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('成功: テスト完了')));
            }
          },
          child: const Text('Success Test'),
        ),
        ElevatedButton(
          onPressed: () async {
            final l10n = TestHelpers.createMockL10n();
            await executeWithErrorHandling(context, () async {
              await Future.delayed(const Duration(milliseconds: 100));
              throw const DatabaseException(message: 'データベースエラー');
            }, l10n: l10n);
          },
          child: const Text('AppException Test'),
        ),
        ElevatedButton(
          onPressed: () async {
            final l10n = TestHelpers.createMockL10n();
            await executeWithErrorHandling(context, () async {
              await Future.delayed(const Duration(milliseconds: 100));
              throw Exception('通常のエラー');
            }, l10n: l10n);
          },
          child: const Text('Exception Test'),
        ),
      ],
    );
  }
}

class TestGlobalLoadingController implements GlobalLoadingController {
  @override
  void startLoading() {}

  @override
  void stopLoading() {}
}
