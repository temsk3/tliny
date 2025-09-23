import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/model/exception/app_exception.dart';
import '../../utils/logger.dart';

part 'loading_screen.g.dart';

/// ローディング画面の使用方法
///
/// このアプリでは、ローディング画面の重複を避けるため、以下のルールに従ってください：
///
/// 1. **推奨方法**: GlobalLoadingController を使用
///    - アプリ全体で統一されたローディング状態を管理
///    - GlobalLoadingOverlay が自動的に表示される
///    - 使用方法: ref.read(globalLoadingControllerProvider.notifier).guardFuture(() => asyncFunction())
///
/// 2. **非推奨**: WidgetWithLoading の使用
///    - GlobalLoadingOverlay と重複する可能性がある
///    - 既存の互換性のため残しているが、新規開発では使用しない
///
/// 3. **AsyncValueWidget**: データ取得時のローディング表示
///    - 個別のデータ取得時のローディング表示に使用
///    - GlobalLoadingOverlay とは異なる用途
///
/// 4. **最小ローディング時間**: guardFutureWithMinDuration を使用
///    - 短時間の処理でも適切なローディング表示を確保
///    - ユーザー体験の向上

/// 全画面共通のローディング状態を管理するプロバイダー
@riverpod
class GlobalLoadingController extends _$GlobalLoadingController {
  @override
  bool build() => false;

  var _loadingMessage = '処理中...';

  /// ローディングメッセージを取得
  String get loadingMessage => _loadingMessage;

  /// ローディング状態を開始
  void startLoading([String? message]) {
    if (message != null) {
      _loadingMessage = message;
    }
    logger.d(
      'GlobalLoadingController: startLoading - $_loadingMessage',
      time: DateTime.now(),
    );
    state = true;
  }

  /// ローディング状態を終了
  void stopLoading() {
    logger.d('GlobalLoadingController: stopLoading', time: DateTime.now());
    state = false;
  }

  /// Future型の関数を実行中はローディングを表示する
  Future<T> guardFuture<T>(
    Future<T> Function() future, [
    String? message,
  ]) async {
    logger.d(
      'GlobalLoadingController: guardFuture start - ${message ?? "処理中..."}',
      time: DateTime.now(),
    );
    try {
      startLoading(message);
      final result = await future();
      stopLoading();
      return result;
    } on AppException catch (e, st) {
      logger.e(
        'GlobalLoadingController: guardFuture AppException - ${e.message}',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      stopLoading();
      // AppExceptionは適切に処理されているため、再スローする
      rethrow;
    } on Exception catch (e, st) {
      logger.e(
        'GlobalLoadingController: guardFuture Exception - $e',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      stopLoading();
      // 一般的な例外はGeneralExceptionに変換して再スロー
      // エラーを処理
      rethrow;
    }
  }

  /// 最小ローディング時間を設定してFuture型の関数を実行する
  Future<T> guardFutureWithMinDuration<T>(
    Future<T> Function() future, {
    Duration minDuration = const Duration(seconds: 1),
    String? message,
  }) async {
    logger.d(
      'GlobalLoadingController: guardFutureWithMinDuration start (minDuration: $minDuration, message: ${message ?? "処理中..."})',
      time: DateTime.now(),
    );

    final startTime = DateTime.now();

    try {
      startLoading(message);
      final result = await future();

      // 最小ローディング時間を確保
      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < minDuration) {
        final remaining = minDuration - elapsed;
        logger.d(
          'GlobalLoadingController: waiting for remaining time: $remaining',
          time: DateTime.now(),
        );
        await Future.delayed(remaining);
      }

      stopLoading();
      return result;
    } on AppException catch (e, st) {
      logger.e(
        'GlobalLoadingController: guardFutureWithMinDuration AppException - ${e.message}',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      stopLoading();
      // AppExceptionは適切に処理されているため、再スローする
      rethrow;
    } on Exception catch (e, st) {
      logger.e(
        'GlobalLoadingController: guardFutureWithMinDuration Exception - $e',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      stopLoading();
      // 一般的な例外はGeneralExceptionに変換して再スロー
      // エラーを処理
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
    final loadingController = ref.read(
      globalLoadingControllerProvider.notifier,
    );

    if (!isLoading) return const SizedBox.shrink();

    return Positioned.fill(
      child: ColoredBox(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: _LoadingContent(message: loadingController.loadingMessage),
          ),
        ),
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
  const _LoadingContent({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 3,
        ),
        const SizedBox(height: 20),
        Text(
          message ?? '処理中...',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
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
///
/// ⚠️ 非推奨: このWidgetはGlobalLoadingOverlayと重複する可能性があります。
/// アプリ全体でGlobalLoadingOverlayが使用されているため、このWidgetは不要です。
/// 代わりにGlobalLoadingControllerを使用してローディング状態を管理してください。
@Deprecated(
  'Use GlobalLoadingOverlay instead. This widget may cause duplicate loading screens.',
)
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
final isLoadingProvider =
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
    } on AppException catch (e, st) {
      logger.e(
        'IsLoadingController: guardFuture AppException - ${e.message}',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      state = false;
      // AppExceptionは適切に処理されているため、再スローする
      rethrow;
    } on Exception catch (e, st) {
      logger.e(
        'IsLoadingController: guardFuture Exception - $e',
        time: DateTime.now(),
        error: e,
        stackTrace: st,
      );
      state = false;
      // 一般的な例外はGeneralExceptionに変換して再スロー
      rethrow;
    }
  }
}
