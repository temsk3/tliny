// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 合計金額を管理する AsyncNotifier（根本的解決版）

@ProviderFor(TotalAmountNotifier)
const totalAmountProvider = TotalAmountNotifierFamily._();

/// 合計金額を管理する AsyncNotifier（根本的解決版）
final class TotalAmountNotifierProvider
    extends $AsyncNotifierProvider<TotalAmountNotifier, int> {
  /// 合計金額を管理する AsyncNotifier（根本的解決版）
  const TotalAmountNotifierProvider._({
    required TotalAmountNotifierFamily super.from,
    required List<Cart> super.argument,
  }) : super(
         retry: null,
         name: r'totalAmountProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$totalAmountNotifierHash();

  @override
  String toString() {
    return r'totalAmountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TotalAmountNotifier create() => TotalAmountNotifier();

  @override
  bool operator ==(Object other) {
    return other is TotalAmountNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$totalAmountNotifierHash() =>
    r'e551d23b5b4f29784aa698654282c37901882e1e';

/// 合計金額を管理する AsyncNotifier（根本的解決版）

final class TotalAmountNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TotalAmountNotifier,
          AsyncValue<int>,
          int,
          FutureOr<int>,
          List<Cart>
        > {
  const TotalAmountNotifierFamily._()
    : super(
        retry: null,
        name: r'totalAmountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 合計金額を管理する AsyncNotifier（根本的解決版）

  TotalAmountNotifierProvider call(List<Cart> list) =>
      TotalAmountNotifierProvider._(argument: list, from: this);

  @override
  String toString() => r'totalAmountProvider';
}

/// 合計金額を管理する AsyncNotifier（根本的解決版）

abstract class _$TotalAmountNotifier extends $AsyncNotifier<int> {
  late final _$args = ref.$arg as List<Cart>;
  List<Cart> get list => _$args;

  FutureOr<int> build(List<Cart> list);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// カート合計金額を管理するプロバイダー

@ProviderFor(TotalAmountNotifierProvider)
const totalAmountNotifierProviderProvider =
    TotalAmountNotifierProviderFamily._();

/// カート合計金額を管理するプロバイダー
final class TotalAmountNotifierProviderProvider
    extends $NotifierProvider<TotalAmountNotifierProvider, int> {
  /// カート合計金額を管理するプロバイダー
  const TotalAmountNotifierProviderProvider._({
    required TotalAmountNotifierProviderFamily super.from,
    required List<Cart> super.argument,
  }) : super(
         retry: null,
         name: r'totalAmountNotifierProviderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$totalAmountNotifierProviderHash();

  @override
  String toString() {
    return r'totalAmountNotifierProviderProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TotalAmountNotifierProvider create() => TotalAmountNotifierProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TotalAmountNotifierProviderProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$totalAmountNotifierProviderHash() =>
    r'4fcaf596bca8fae9fd63d01d6ac48a9147ba578b';

/// カート合計金額を管理するプロバイダー

final class TotalAmountNotifierProviderFamily extends $Family
    with
        $ClassFamilyOverride<
          TotalAmountNotifierProvider,
          int,
          int,
          int,
          List<Cart>
        > {
  const TotalAmountNotifierProviderFamily._()
    : super(
        retry: null,
        name: r'totalAmountNotifierProviderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// カート合計金額を管理するプロバイダー

  TotalAmountNotifierProviderProvider call(List<Cart> carts) =>
      TotalAmountNotifierProviderProvider._(argument: carts, from: this);

  @override
  String toString() => r'totalAmountNotifierProviderProvider';
}

/// カート合計金額を管理するプロバイダー

abstract class _$TotalAmountNotifierProvider extends $Notifier<int> {
  late final _$args = ref.$arg as List<Cart>;
  List<Cart> get carts => _$args;

  int build(List<Cart> carts);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
