// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'cart_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cartRepository)
const cartRepositoryProvider = CartRepositoryProvider._();

final class CartRepositoryProvider
    extends $FunctionalProvider<CartRepository, CartRepository, CartRepository>
    with $Provider<CartRepository> {
  const CartRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartRepositoryHash();

  @$internal
  @override
  $ProviderElement<CartRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CartRepository create(Ref ref) {
    return cartRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartRepository>(value),
    );
  }
}

String _$cartRepositoryHash() => r'dc5f40f430d8fdc57240a0529f3651cff5214961';

@ProviderFor(cartStream)
const cartStreamProvider = CartStreamFamily._();

final class CartStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Cart>>,
          List<Cart>,
          Stream<List<Cart>>
        >
    with $FutureModifier<List<Cart>>, $StreamProvider<List<Cart>> {
  const CartStreamProvider._({
    required CartStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cartStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cartStreamHash();

  @override
  String toString() {
    return r'cartStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Cart>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Cart>> create(Ref ref) {
    final argument = this.argument as String;
    return cartStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CartStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cartStreamHash() => r'07a66d6a90ef5b68908868ffa45ef0240138f444';

final class CartStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Cart>>, String> {
  const CartStreamFamily._()
    : super(
        retry: null,
        name: r'cartStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CartStreamProvider call(String uid) =>
      CartStreamProvider._(argument: uid, from: this);

  @override
  String toString() => r'cartStreamProvider';
}
