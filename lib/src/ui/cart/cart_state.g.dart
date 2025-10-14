// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalAmountNotifierHash() =>
    r'e551d23b5b4f29784aa698654282c37901882e1e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TotalAmountNotifier
    extends BuildlessAutoDisposeAsyncNotifier<int> {
  late final List<Cart> list;

  FutureOr<int> build(
    List<Cart> list,
  );
}

/// 合計金額を管理する AsyncNotifier（根本的解決版）
///
/// Copied from [TotalAmountNotifier].
@ProviderFor(TotalAmountNotifier)
const totalAmountNotifierProvider = TotalAmountNotifierFamily();

/// 合計金額を管理する AsyncNotifier（根本的解決版）
///
/// Copied from [TotalAmountNotifier].
class TotalAmountNotifierFamily extends Family<AsyncValue<int>> {
  /// 合計金額を管理する AsyncNotifier（根本的解決版）
  ///
  /// Copied from [TotalAmountNotifier].
  const TotalAmountNotifierFamily();

  /// 合計金額を管理する AsyncNotifier（根本的解決版）
  ///
  /// Copied from [TotalAmountNotifier].
  TotalAmountNotifierProvider call(
    List<Cart> list,
  ) {
    return TotalAmountNotifierProvider(
      list,
    );
  }

  @override
  TotalAmountNotifierProvider getProviderOverride(
    covariant TotalAmountNotifierProvider provider,
  ) {
    return call(
      provider.list,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'totalAmountNotifierProvider';
}

/// 合計金額を管理する AsyncNotifier（根本的解決版）
///
/// Copied from [TotalAmountNotifier].
class TotalAmountNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TotalAmountNotifier, int> {
  /// 合計金額を管理する AsyncNotifier（根本的解決版）
  ///
  /// Copied from [TotalAmountNotifier].
  TotalAmountNotifierProvider(
    List<Cart> list,
  ) : this._internal(
          () => TotalAmountNotifier()..list = list,
          from: totalAmountNotifierProvider,
          name: r'totalAmountNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$totalAmountNotifierHash,
          dependencies: TotalAmountNotifierFamily._dependencies,
          allTransitiveDependencies:
              TotalAmountNotifierFamily._allTransitiveDependencies,
          list: list,
        );

  TotalAmountNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
  }) : super.internal();

  final List<Cart> list;

  @override
  FutureOr<int> runNotifierBuild(
    covariant TotalAmountNotifier notifier,
  ) {
    return notifier.build(
      list,
    );
  }

  @override
  Override overrideWith(TotalAmountNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: TotalAmountNotifierProvider._internal(
        () => create()..list = list,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TotalAmountNotifier, int>
      createElement() {
    return _TotalAmountNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TotalAmountNotifierProvider && other.list == list;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TotalAmountNotifierRef on AutoDisposeAsyncNotifierProviderRef<int> {
  /// The parameter `list` of this provider.
  List<Cart> get list;
}

class _TotalAmountNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TotalAmountNotifier, int>
    with TotalAmountNotifierRef {
  _TotalAmountNotifierProviderElement(super.provider);

  @override
  List<Cart> get list => (origin as TotalAmountNotifierProvider).list;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
