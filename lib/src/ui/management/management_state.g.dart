// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'management_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(managementState)
const managementStateProvider = ManagementStateFamily._();

final class ManagementStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Order>>,
          List<Order>,
          Stream<List<Order>>
        >
    with $FutureModifier<List<Order>>, $StreamProvider<List<Order>> {
  const ManagementStateProvider._({
    required ManagementStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'managementStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$managementStateHash();

  @override
  String toString() {
    return r'managementStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Order>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Order>> create(Ref ref) {
    final argument = this.argument as String;
    return managementState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ManagementStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$managementStateHash() => r'a4931116516a3d1fd16a5ccb5a67ea9676b42981';

final class ManagementStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Order>>, String> {
  const ManagementStateFamily._()
    : super(
        retry: null,
        name: r'managementStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ManagementStateProvider call(String eventId) =>
      ManagementStateProvider._(argument: eventId, from: this);

  @override
  String toString() => r'managementStateProvider';
}

@ProviderFor(productsManagementState)
const productsManagementStateProvider = ProductsManagementStateFamily._();

final class ProductsManagementStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Product>>,
          List<Product>,
          Stream<List<Product>>
        >
    with $FutureModifier<List<Product>>, $StreamProvider<List<Product>> {
  const ProductsManagementStateProvider._({
    required ProductsManagementStateFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productsManagementStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productsManagementStateHash();

  @override
  String toString() {
    return r'productsManagementStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Product>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Product>> create(Ref ref) {
    final argument = this.argument as String;
    return productsManagementState(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsManagementStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productsManagementStateHash() =>
    r'2cac642211350595b0edb0285895fc782ec9ef73';

final class ProductsManagementStateFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Product>>, String> {
  const ProductsManagementStateFamily._()
    : super(
        retry: null,
        name: r'productsManagementStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductsManagementStateProvider call(String eventId) =>
      ProductsManagementStateProvider._(argument: eventId, from: this);

  @override
  String toString() => r'productsManagementStateProvider';
}

@ProviderFor(allTicketState)
const allTicketStateProvider = AllTicketStateProvider._();

final class AllTicketStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ticket>>,
          List<Ticket>,
          Stream<List<Ticket>>
        >
    with $FutureModifier<List<Ticket>>, $StreamProvider<List<Ticket>> {
  const AllTicketStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTicketStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTicketStateHash();

  @$internal
  @override
  $StreamProviderElement<List<Ticket>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Ticket>> create(Ref ref) {
    return allTicketState(ref);
  }
}

String _$allTicketStateHash() => r'70d949bdae1d80c6a258002e058c8541c4395ff7';
