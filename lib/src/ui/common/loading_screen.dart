import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/logger.dart';

/// ロード中の画面を表示するWidget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

/// Widgetをロード中のダイアログで覆うWidget
class WidgetWithLoading extends ConsumerWidget {
  const WidgetWithLoading({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        // isLoadingProviderがtrueの場合、LoadingDialogを表示
        if (ref.watch(isLoadingProvider)) const LoadingDialog(),
      ],
    );
  }
}

/// ロード中の状態を管理するStateNotifierProvider
final AutoDisposeStateNotifierProvider<IsLoadingController, bool>
    isLoadingProvider =
    StateNotifierProvider.autoDispose<IsLoadingController, bool>(
  (ref) => IsLoadingController(),
);

/// ロード中の状態を管理するStateNotifier
class IsLoadingController extends StateNotifier<bool> {
  IsLoadingController() : super(false);

  // Future型の関数を実行中はLoadingDialogを表示する
  // Future<T>にすることで色々な関数で利用できる
  Future<T> guardFuture<T>(Future<T> Function() future) async {
    logger.d('guardFuture: start', time: DateTime.now());
    try {
      // ロード中状態に設定
      state = true;
      // Future型の関数を呼び出し、結果を取得
      final result = await future();
      // ロード終了状態に設定
      state = false;
      // 結果を返す
      return result;
    } on Exception catch (e, st) {
      // エラーが発生した場合、エラーログを出力
      logger.e('guardFuture: error=$e, stackTrace=$st', time: DateTime.now());
      // ロード終了状態に設定
      state = false;
      // エラーを再スロー
      rethrow;
    }
  }
}

/// ロード中に表示するダイアログ
class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // ダイアログの部分だけ色入れたいので
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              // Gap(20),
              Text('...処理中'),
            ],
          ),
        ),
      ),
    );
  }
}
