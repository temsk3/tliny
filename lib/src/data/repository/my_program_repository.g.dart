// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'my_program_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myProgramRepository)
const myProgramRepositoryProvider = MyProgramRepositoryProvider._();

final class MyProgramRepositoryProvider
    extends
        $FunctionalProvider<
          MyProgramRepository,
          MyProgramRepository,
          MyProgramRepository
        >
    with $Provider<MyProgramRepository> {
  const MyProgramRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProgramRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProgramRepositoryHash();

  @$internal
  @override
  $ProviderElement<MyProgramRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MyProgramRepository create(Ref ref) {
    return myProgramRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MyProgramRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MyProgramRepository>(value),
    );
  }
}

String _$myProgramRepositoryHash() =>
    r'4e6ccbc6bdb16b3a9dfd1aa8c6066512743d374a';

@ProviderFor(myProgramExistsStream)
const myProgramExistsStreamProvider = MyProgramExistsStreamFamily._();

final class MyProgramExistsStreamProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const MyProgramExistsStreamProvider._({
    required MyProgramExistsStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'myProgramExistsStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$myProgramExistsStreamHash();

  @override
  String toString() {
    return r'myProgramExistsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as String;
    return myProgramExistsStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MyProgramExistsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myProgramExistsStreamHash() =>
    r'7a24eab920d71080e7ce80ec2b389aed9aec8011';

final class MyProgramExistsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, String> {
  const MyProgramExistsStreamFamily._()
    : super(
        retry: null,
        name: r'myProgramExistsStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MyProgramExistsStreamProvider call(String programId) =>
      MyProgramExistsStreamProvider._(argument: programId, from: this);

  @override
  String toString() => r'myProgramExistsStreamProvider';
}
