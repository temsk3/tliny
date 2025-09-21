// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'user_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserViewModel)
const userViewModelProvider = UserViewModelProvider._();

final class UserViewModelProvider
    extends $AsyncNotifierProvider<UserViewModel, User> {
  const UserViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userViewModelHash();

  @$internal
  @override
  UserViewModel create() => UserViewModel();
}

String _$userViewModelHash() => r'd7f88db41210a930a0ca756aed7ce478c02d0d64';

abstract class _$UserViewModel extends $AsyncNotifier<User> {
  FutureOr<User> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<User>, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<User>, User>,
              AsyncValue<User>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
