// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'profile_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileViewModel)
const profileViewModelProvider = ProfileViewModelFamily._();

final class ProfileViewModelProvider
    extends $AsyncNotifierProvider<ProfileViewModel, ProfileState> {
  const ProfileViewModelProvider._({
    required ProfileViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'profileViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$profileViewModelHash();

  @override
  String toString() {
    return r'profileViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProfileViewModel create() => ProfileViewModel();

  @override
  bool operator ==(Object other) {
    return other is ProfileViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$profileViewModelHash() => r'12a37011972c973e925d7a890330f345a93359f6';

final class ProfileViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ProfileViewModel,
          AsyncValue<ProfileState>,
          ProfileState,
          FutureOr<ProfileState>,
          String
        > {
  const ProfileViewModelFamily._()
    : super(
        retry: null,
        name: r'profileViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProfileViewModelProvider call(String userId) =>
      ProfileViewModelProvider._(argument: userId, from: this);

  @override
  String toString() => r'profileViewModelProvider';
}

abstract class _$ProfileViewModel extends $AsyncNotifier<ProfileState> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  FutureOr<ProfileState> build(String userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ProfileState>, ProfileState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileState>, ProfileState>,
              AsyncValue<ProfileState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
