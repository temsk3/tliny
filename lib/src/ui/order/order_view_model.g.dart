// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'order_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OrderViewModel)
const orderViewModelProvider = OrderViewModelProvider._();

final class OrderViewModelProvider
    extends $AsyncNotifierProvider<OrderViewModel, List<Order>> {
  const OrderViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderViewModelHash();

  @$internal
  @override
  OrderViewModel create() => OrderViewModel();
}

String _$orderViewModelHash() => r'f7cccf4f9e87bc9110a509371e8787fdb9adc835';

abstract class _$OrderViewModel extends $AsyncNotifier<List<Order>> {
  FutureOr<List<Order>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Order>>, List<Order>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Order>>, List<Order>>,
              AsyncValue<List<Order>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
