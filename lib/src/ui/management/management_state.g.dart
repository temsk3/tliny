// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'management_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$managementStateHash() => r'a4931116516a3d1fd16a5ccb5a67ea9676b42981';

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

/// See also [managementState].
@ProviderFor(managementState)
const managementStateProvider = ManagementStateFamily();

/// See also [managementState].
class ManagementStateFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [managementState].
  const ManagementStateFamily();

  /// See also [managementState].
  ManagementStateProvider call(String eventId) {
    return ManagementStateProvider(eventId);
  }

  @override
  ManagementStateProvider getProviderOverride(
    covariant ManagementStateProvider provider,
  ) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'managementStateProvider';
}

/// See also [managementState].
class ManagementStateProvider extends AutoDisposeStreamProvider<List<Order>> {
  /// See also [managementState].
  ManagementStateProvider(String eventId)
    : this._internal(
        (ref) => managementState(ref as ManagementStateRef, eventId),
        from: managementStateProvider,
        name: r'managementStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$managementStateHash,
        dependencies: ManagementStateFamily._dependencies,
        allTransitiveDependencies:
            ManagementStateFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  ManagementStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    Stream<List<Order>> Function(ManagementStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ManagementStateProvider._internal(
        (ref) => create(ref as ManagementStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Order>> createElement() {
    return _ManagementStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ManagementStateProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ManagementStateRef on AutoDisposeStreamProviderRef<List<Order>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _ManagementStateProviderElement
    extends AutoDisposeStreamProviderElement<List<Order>>
    with ManagementStateRef {
  _ManagementStateProviderElement(super.provider);

  @override
  String get eventId => (origin as ManagementStateProvider).eventId;
}

String _$productsManagementStateHash() =>
    r'2cac642211350595b0edb0285895fc782ec9ef73';

/// See also [productsManagementState].
@ProviderFor(productsManagementState)
const productsManagementStateProvider = ProductsManagementStateFamily();

/// See also [productsManagementState].
class ProductsManagementStateFamily extends Family<AsyncValue<List<Product>>> {
  /// See also [productsManagementState].
  const ProductsManagementStateFamily();

  /// See also [productsManagementState].
  ProductsManagementStateProvider call(String eventId) {
    return ProductsManagementStateProvider(eventId);
  }

  @override
  ProductsManagementStateProvider getProviderOverride(
    covariant ProductsManagementStateProvider provider,
  ) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsManagementStateProvider';
}

/// See also [productsManagementState].
class ProductsManagementStateProvider
    extends AutoDisposeStreamProvider<List<Product>> {
  /// See also [productsManagementState].
  ProductsManagementStateProvider(String eventId)
    : this._internal(
        (ref) =>
            productsManagementState(ref as ProductsManagementStateRef, eventId),
        from: productsManagementStateProvider,
        name: r'productsManagementStateProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productsManagementStateHash,
        dependencies: ProductsManagementStateFamily._dependencies,
        allTransitiveDependencies:
            ProductsManagementStateFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  ProductsManagementStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    Stream<List<Product>> Function(ProductsManagementStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsManagementStateProvider._internal(
        (ref) => create(ref as ProductsManagementStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Product>> createElement() {
    return _ProductsManagementStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsManagementStateProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsManagementStateRef
    on AutoDisposeStreamProviderRef<List<Product>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _ProductsManagementStateProviderElement
    extends AutoDisposeStreamProviderElement<List<Product>>
    with ProductsManagementStateRef {
  _ProductsManagementStateProviderElement(super.provider);

  @override
  String get eventId => (origin as ProductsManagementStateProvider).eventId;
}

String _$allTicketStateHash() => r'70d949bdae1d80c6a258002e058c8541c4395ff7';

/// See also [allTicketState].
@ProviderFor(allTicketState)
final allTicketStateProvider = AutoDisposeStreamProvider<List<Ticket>>.internal(
  allTicketState,
  name: r'allTicketStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allTicketStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllTicketStateRef = AutoDisposeStreamProviderRef<List<Ticket>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
