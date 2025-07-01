import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger.dart';

part 'loading_screen.g.dart';

/// 全画面共通のローディング状態を管理するプロバイダー
@riverpod
class GlobalLoadingController extends _$GlobalLoadingController {
  @override
  bool build() => false;

  /// ローディング状態を開始
  void startLoading() {
    logger.d('GlobalLoadingController: startLoading', time: DateTime.now());
    state = true;
  }

  /// ローディング状態を終了
  void stopLoading() {
    logger.d('GlobalLoadingController: stopLoading', time: DateTime.now());
    state = false;
  }

  /// Future型の関数を実行中はローディングを表示する
  Future<T> guardFuture<T>(Future<T> Function() future) async {
    logger.d(
      'GlobalLoadingController: guardFuture start',
      time: DateTime.now(),
    );
    try {
      startLoading();
      final result = await future();
      stopLoading();
      return result;
    } on Exception catch (e, st) {
      logger.e(
        'GlobalLoadingController: guardFuture error=$e, stackTrace=$st',
        time: DateTime.now(),
      );
      stopLoading();
      rethrow;
    }
  }
}

/// 全画面ローディングオーバーレイ
class GlobalLoadingOverlay extends ConsumerWidget {
  const GlobalLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(globalLoadingControllerProvider);

    if (!isLoading) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: const Center(child: _LoadingContent()),
      ),
    );
  }
}

/// ローディングダイアログ
class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const _LoadingContent(),
      ),
    );
  }
}

/// ローディングコンテンツ（共通部分）
class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(
          '処理中...',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

/// シンプルなローディング画面
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: _LoadingContent());
  }
}

/// Widgetをローディングダイアログで覆うWidget（既存の互換性のため）
class WidgetWithLoading extends ConsumerWidget {
  const WidgetWithLoading({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        if (ref.watch(globalLoadingControllerProvider)) const LoadingDialog(),
      ],
    );
  }
}

/// 既存の互換性のためのプロバイダー（非推奨）
@Deprecated('Use globalLoadingControllerProvider instead')
final AutoDisposeStateNotifierProvider<IsLoadingController, bool>
isLoadingProvider =
    StateNotifierProvider.autoDispose<IsLoadingController, bool>(
      (ref) => IsLoadingController(),
    );

/// 既存の互換性のためのコントローラー（非推奨）
@Deprecated('Use GlobalLoadingController instead')
class IsLoadingController extends StateNotifier<bool> {
  IsLoadingController() : super(false);

  Future<T> guardFuture<T>(Future<T> Function() future) async {
    logger.d('IsLoadingController: guardFuture start', time: DateTime.now());
    try {
      state = true;
      final result = await future();
      state = false;
      return result;
    } on Exception catch (e, st) {
      logger.e(
        'IsLoadingController: guardFuture error=$e, stackTrace=$st',
        time: DateTime.now(),
      );
      state = false;
      rethrow;
    }
  }
}
