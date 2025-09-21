// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'user_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'7b838d76413a4ed7caa642e36081918247857705';

@ProviderFor(userStream)
const userStreamProvider = UserStreamFamily._();

final class UserStreamProvider
    extends $FunctionalProvider<AsyncValue<User>, User, Stream<User>>
    with $FutureModifier<User>, $StreamProvider<User> {
  const UserStreamProvider._({
    required UserStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userStreamHash();

  @override
  String toString() {
    return r'userStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<User> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<User> create(Ref ref) {
    final argument = this.argument as String;
    return userStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userStreamHash() => r'2cf4b17d65e881eb21b099203c985d8c3e341b81';

final class UserStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<User>, String> {
  const UserStreamFamily._()
    : super(
        retry: null,
        name: r'userStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserStreamProvider call(String uid) =>
      UserStreamProvider._(argument: uid, from: this);

  @override
  String toString() => r'userStreamProvider';
}

@ProviderFor(publicUserRepository)
const publicUserRepositoryProvider = PublicUserRepositoryProvider._();

final class PublicUserRepositoryProvider
    extends
        $FunctionalProvider<
          PublicUserRepository,
          PublicUserRepository,
          PublicUserRepository
        >
    with $Provider<PublicUserRepository> {
  const PublicUserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicUserRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicUserRepositoryHash();

  @$internal
  @override
  $ProviderElement<PublicUserRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PublicUserRepository create(Ref ref) {
    return publicUserRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PublicUserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PublicUserRepository>(value),
    );
  }
}

String _$publicUserRepositoryHash() =>
    r'506faab5f233a028a1d40fb4e2141c6b34535da3';

@ProviderFor(publicUserStream)
const publicUserStreamProvider = PublicUserStreamFamily._();

final class PublicUserStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<PublicUsers>,
          PublicUsers,
          Stream<PublicUsers>
        >
    with $FutureModifier<PublicUsers>, $StreamProvider<PublicUsers> {
  const PublicUserStreamProvider._({
    required PublicUserStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicUserStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicUserStreamHash();

  @override
  String toString() {
    return r'publicUserStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<PublicUsers> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PublicUsers> create(Ref ref) {
    final argument = this.argument as String;
    return publicUserStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicUserStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicUserStreamHash() => r'a4bebdc2b6382db7796a963ed4541007fe8aa8db';

final class PublicUserStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<PublicUsers>, String> {
  const PublicUserStreamFamily._()
    : super(
        retry: null,
        name: r'publicUserStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicUserStreamProvider call(String uid) =>
      PublicUserStreamProvider._(argument: uid, from: this);

  @override
  String toString() => r'publicUserStreamProvider';
}

@ProviderFor(publicUserFuture)
const publicUserFutureProvider = PublicUserFutureFamily._();

final class PublicUserFutureProvider
    extends
        $FunctionalProvider<
          AsyncValue<PublicUsers>,
          PublicUsers,
          FutureOr<PublicUsers>
        >
    with $FutureModifier<PublicUsers>, $FutureProvider<PublicUsers> {
  const PublicUserFutureProvider._({
    required PublicUserFutureFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicUserFutureProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicUserFutureHash();

  @override
  String toString() {
    return r'publicUserFutureProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PublicUsers> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PublicUsers> create(Ref ref) {
    final argument = this.argument as String;
    return publicUserFuture(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicUserFutureProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicUserFutureHash() => r'9138b3dce22b8a26edb47af9b5f0937e77d51623';

final class PublicUserFutureFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PublicUsers>, String> {
  const PublicUserFutureFamily._()
    : super(
        retry: null,
        name: r'publicUserFutureProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PublicUserFutureProvider call(String uid) =>
      PublicUserFutureProvider._(argument: uid, from: this);

  @override
  String toString() => r'publicUserFutureProvider';
}
