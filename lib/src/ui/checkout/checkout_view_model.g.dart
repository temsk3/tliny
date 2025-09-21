// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'checkout_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StripeCheckoutViewModel)
const stripeCheckoutViewModelProvider = StripeCheckoutViewModelProvider._();

final class StripeCheckoutViewModelProvider
    extends $AsyncNotifierProvider<StripeCheckoutViewModel, void> {
  const StripeCheckoutViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stripeCheckoutViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stripeCheckoutViewModelHash();

  @$internal
  @override
  StripeCheckoutViewModel create() => StripeCheckoutViewModel();
}

String _$stripeCheckoutViewModelHash() =>
    r'69443d8499ee13e3d966bc63fb228880ba03a514';

abstract class _$StripeCheckoutViewModel extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
