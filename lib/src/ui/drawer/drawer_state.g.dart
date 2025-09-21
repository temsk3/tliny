// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'drawer_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getPackageInfo)
const getPackageInfoProvider = GetPackageInfoProvider._();

final class GetPackageInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<PackageInfo>,
          PackageInfo,
          FutureOr<PackageInfo>
        >
    with $FutureModifier<PackageInfo>, $FutureProvider<PackageInfo> {
  const GetPackageInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPackageInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPackageInfoHash();

  @$internal
  @override
  $FutureProviderElement<PackageInfo> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PackageInfo> create(Ref ref) {
    return getPackageInfo(ref);
  }
}

String _$getPackageInfoHash() => r'67d6f03cd2c138681113495028ce4199261bae0a';

@ProviderFor(userStreamState)
const userStreamStateProvider = UserStreamStateProvider._();

final class UserStreamStateProvider
    extends $FunctionalProvider<AsyncValue<User?>, User?, Stream<User?>>
    with $FutureModifier<User?>, $StreamProvider<User?> {
  const UserStreamStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userStreamStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userStreamStateHash();

  @$internal
  @override
  $StreamProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<User?> create(Ref ref) {
    return userStreamState(ref);
  }
}

String _$userStreamStateHash() => r'cc40adf3e2c73d8d377c993c79b31065a2ba2f7b';
