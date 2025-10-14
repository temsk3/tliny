// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartRepositoryHash() => r'dc5f40f430d8fdc57240a0529f3651cff5214961';

/// See also [cartRepository].
@ProviderFor(cartRepository)
final cartRepositoryProvider = Provider<CartRepository>.internal(
  cartRepository,
  name: r'cartRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartRepositoryRef = ProviderRef<CartRepository>;
String _$cartStreamHash() => r'07a66d6a90ef5b68908868ffa45ef0240138f444';

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

/// See also [cartStream].
@ProviderFor(cartStream)
const cartStreamProvider = CartStreamFamily();

/// See also [cartStream].
class CartStreamFamily extends Family<AsyncValue<List<Cart>>> {
  /// See also [cartStream].
  const CartStreamFamily();

  /// See also [cartStream].
  CartStreamProvider call(
    String uid,
  ) {
    return CartStreamProvider(
      uid,
    );
  }

  @override
  CartStreamProvider getProviderOverride(
    covariant CartStreamProvider provider,
  ) {
    return call(
      provider.uid,
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
  String? get name => r'cartStreamProvider';
}

/// See also [cartStream].
class CartStreamProvider extends AutoDisposeStreamProvider<List<Cart>> {
  /// See also [cartStream].
  CartStreamProvider(
    String uid,
  ) : this._internal(
          (ref) => cartStream(
            ref as CartStreamRef,
            uid,
          ),
          from: cartStreamProvider,
          name: r'cartStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cartStreamHash,
          dependencies: CartStreamFamily._dependencies,
          allTransitiveDependencies:
              CartStreamFamily._allTransitiveDependencies,
          uid: uid,
        );

  CartStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    Stream<List<Cart>> Function(CartStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CartStreamProvider._internal(
        (ref) => create(ref as CartStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Cart>> createElement() {
    return _CartStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CartStreamProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CartStreamRef on AutoDisposeStreamProviderRef<List<Cart>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _CartStreamProviderElement
    extends AutoDisposeStreamProviderElement<List<Cart>> with CartStreamRef {
  _CartStreamProviderElement(super.provider);

  @override
  String get uid => (origin as CartStreamProvider).uid;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
