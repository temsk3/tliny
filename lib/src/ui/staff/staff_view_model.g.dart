// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'staff_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StaffViewModel)
const staffViewModelProvider = StaffViewModelFamily._();

final class StaffViewModelProvider
    extends $AsyncNotifierProvider<StaffViewModel, List<Staff>> {
  const StaffViewModelProvider._({
    required StaffViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'staffViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$staffViewModelHash();

  @override
  String toString() {
    return r'staffViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StaffViewModel create() => StaffViewModel();

  @override
  bool operator ==(Object other) {
    return other is StaffViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$staffViewModelHash() => r'9c9847cc176c63a6b1164e097fdcfb1d4b29005c';

final class StaffViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          StaffViewModel,
          AsyncValue<List<Staff>>,
          List<Staff>,
          FutureOr<List<Staff>>,
          String
        > {
  const StaffViewModelFamily._()
    : super(
        retry: null,
        name: r'staffViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StaffViewModelProvider call(String programId) =>
      StaffViewModelProvider._(argument: programId, from: this);

  @override
  String toString() => r'staffViewModelProvider';
}

abstract class _$StaffViewModel extends $AsyncNotifier<List<Staff>> {
  late final _$args = ref.$arg as String;
  String get programId => _$args;

  FutureOr<List<Staff>> build(String programId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<Staff>>, List<Staff>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Staff>>, List<Staff>>,
              AsyncValue<List<Staff>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
