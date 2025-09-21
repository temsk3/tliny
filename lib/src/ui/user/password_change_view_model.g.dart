// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'password_change_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// パスワード変更を管理する ViewModel

@ProviderFor(PasswordChangeViewModel)
const passwordChangeViewModelProvider = PasswordChangeViewModelProvider._();

/// パスワード変更を管理する ViewModel
final class PasswordChangeViewModelProvider
    extends $AsyncNotifierProvider<PasswordChangeViewModel, void> {
  /// パスワード変更を管理する ViewModel
  const PasswordChangeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordChangeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordChangeViewModelHash();

  @$internal
  @override
  PasswordChangeViewModel create() => PasswordChangeViewModel();
}

String _$passwordChangeViewModelHash() =>
    r'a41e6df96112b7ddf45ddf0a72c248b3f748f1e9';

/// パスワード変更を管理する ViewModel

abstract class _$PasswordChangeViewModel extends $AsyncNotifier<void> {
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
