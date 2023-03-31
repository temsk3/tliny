// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartRepositoryHash() => r'ff0b37228775edfc1dabc396150ff981b85c2fa5';

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
String _$cartStreamHash() => r'd66263d2d09a416333873564280d84cd8a572ac3';

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

typedef CartStreamRef = AutoDisposeStreamProviderRef<List<Cart>>;

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
    this.uid,
  ) : super.internal(
          (ref) => cartStream(
            ref,
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
        );

  final String uid;

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
