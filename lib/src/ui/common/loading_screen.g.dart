// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'loading_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$globalLoadingControllerHash() =>
    r'f3a834df415dd1641fb703868b17976df5d2f523';

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
///
/// Copied from [GlobalLoadingController].
@ProviderFor(GlobalLoadingController)
final globalLoadingControllerProvider =
    AutoDisposeNotifierProvider<GlobalLoadingController, bool>.internal(
  GlobalLoadingController.new,
  name: r'globalLoadingControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$globalLoadingControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GlobalLoadingController = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
