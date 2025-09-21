// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stripeRepository)
const stripeRepositoryProvider = StripeRepositoryProvider._();

final class StripeRepositoryProvider
    extends
        $FunctionalProvider<
          StripeRepository,
          StripeRepository,
          StripeRepository
        >
    with $Provider<StripeRepository> {
  const StripeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stripeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stripeRepositoryHash();

  @$internal
  @override
  $ProviderElement<StripeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StripeRepository create(Ref ref) {
    return stripeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StripeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StripeRepository>(value),
    );
  }
}

String _$stripeRepositoryHash() => r'863a23e680d4571974f5ded832e1137a11f3449d';
