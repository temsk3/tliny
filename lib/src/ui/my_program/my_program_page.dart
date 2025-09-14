import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../data/model/exception/app_exception.dart';
import '../../data/model/my_program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/common/error_handler.dart';
import '../../ui/common/main_body.dart';
import '../../ui/my_program/my_program_view_model.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';

/// マイプログラム画面
// @RoutePage()
class MyProgramPage extends HookConsumerWidget {
  const MyProgramPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // テーマを取得
    // final theme = ref.watch(appThemeProvider);
    // ローカリゼーションを取得
    final l10n = useL10n();
    // ルーターを取得
    // final appRoute = useRouter();

    // マイプログラムのステートを取得
    final state = ref.watch(myProgramViewModelProvider);
    // マイプログラムのViewModelを取得
    final viewModel = ref.watch(myProgramViewModelProvider.notifier);

    // マイプログラムのステートを監視し、ステートが更新されたらWidgetを再描画
    return AsyncValueButtonWidget(
      value: state,
      data: (data) {
        // Scaffoldを作成
        return Scaffold(
          // bodyにMainBodyWidgetを表示
          body: MainBodyWidget(
            // bodyにマイプログラムのリストを表示
            body:
                data.isNotEmpty
                    // マイプログラムのリストが空でない場合
                    ? Column(
                      // マイプログラムのリストを左寄せで表示
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // マイプログラムのリストをListView.builderで表示
                        ListView.builder(
                          // スクロールを禁止
                          physics: const NeverScrollableScrollPhysics(),
                          // リストの高さをコンテンツの高さに合わせる
                          shrinkWrap: true,
                          // リストのアイテム数を設定
                          itemCount: data.length,
                          // リストのアイテムを構築する関数
                          itemBuilder: (context, index) {
                            // マイプログラムのデータを取得
                            final myProgram = data[index];
                            // マイプログラムのIDを表示
                            return Text(myProgram.programId!);
                          },
                        ),
                      ],
                    )
                    // マイプログラムのリストが空の場合、空のコンテナを表示
                    : Container(),
          ),
          // フローティングアクションボタンを作成
          floatingActionButton: FloatingActionButton(
            heroTag: 'my_program_fab',
            // ボタンを押したときの処理
            onPressed: () {
              // エラー処理
              try {
                // マイプログラムを追加
                viewModel.addMyProgram(MyProgram.empty());
                // マイプログラムを追加したことをログ出力
                logger.d('Added my program');
              } on AppException catch (e, st) {
                logger.e(
                  'Failed to add my program AppException: ${e.message}',
                  stackTrace: st,
                );
                if (context.mounted) {
                  final l10n = AppLocalizations.of(context)!;
                  ErrorHandler.showError(
                    context,
                    e,
                    l10n,
                    errorContext: 'MyProgramPage_addProgram',
                  );
                }
              } on Exception catch (e, st) {
                logger.e(
                  'Failed to add my program Exception: $e',
                  stackTrace: st,
                );
                if (context.mounted) {
                  final l10n = AppLocalizations.of(context)!;
                  final appException = GeneralException(
                    message: 'マイプログラムの追加に失敗しました。',
                    stackTrace: st,
                  );
                  ErrorHandler.showError(
                    context,
                    appException,
                    l10n,
                    errorContext: 'MyProgramPage_addProgram',
                  );
                }
              }
            },
            // ボタンのアイコンを設定
            child: const Icon(Icons.qr_code),
          ),
        );
      },
    );
  }
}
