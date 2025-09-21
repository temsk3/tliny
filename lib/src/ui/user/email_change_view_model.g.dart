// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'email_change_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// メールアドレス変更を管理する ViewModel

@ProviderFor(EmailChangeViewModel)
const emailChangeViewModelProvider = EmailChangeViewModelProvider._();

/// メールアドレス変更を管理する ViewModel
final class EmailChangeViewModelProvider
    extends $AsyncNotifierProvider<EmailChangeViewModel, void> {
  /// メールアドレス変更を管理する ViewModel
  const EmailChangeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailChangeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailChangeViewModelHash();

  @$internal
  @override
  EmailChangeViewModel create() => EmailChangeViewModel();
}

String _$emailChangeViewModelHash() =>
    r'9477263aa084956332e24b4f2464d7f56e5b092d';

/// メールアドレス変更を管理する ViewModel

abstract class _$EmailChangeViewModel extends $AsyncNotifier<void> {
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
