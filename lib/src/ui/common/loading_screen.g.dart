// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'loading_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(GlobalLoadingController)
const globalLoadingControllerProvider = GlobalLoadingControllerProvider._();

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
final class GlobalLoadingControllerProvider
    extends $NotifierProvider<GlobalLoadingController, bool> {
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
  const GlobalLoadingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalLoadingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalLoadingControllerHash();

  @$internal
  @override
  GlobalLoadingController create() => GlobalLoadingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

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

abstract class _$GlobalLoadingController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
