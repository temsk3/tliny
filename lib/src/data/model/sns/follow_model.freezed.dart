// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Follow _$FollowFromJson(Map<String, dynamic> json) {
  return _Follow.fromJson(json);
}

/// @nodoc
mixin _$Follow {
  String? get id => throw _privateConstructorUsedError;
  String get followerId => throw _privateConstructorUsedError;
  String get followerName => throw _privateConstructorUsedError;
  String? get followerPhotoUrl => throw _privateConstructorUsedError;
  String get followingId => throw _privateConstructorUsedError;
  String get followingName => throw _privateConstructorUsedError;
  String? get followingPhotoUrl => throw _privateConstructorUsedError;
  FollowStatus? get status => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this Follow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FollowCopyWith<Follow> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowCopyWith<$Res> {
  factory $FollowCopyWith(Follow value, $Res Function(Follow) then) =
      _$FollowCopyWithImpl<$Res, Follow>;
  @useResult
  $Res call({
    String? id,
    String followerId,
    String followerName,
    String? followerPhotoUrl,
    String followingId,
    String followingName,
    String? followingPhotoUrl,
    FollowStatus? status,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class _$FollowCopyWithImpl<$Res, $Val extends Follow>
    implements $FollowCopyWith<$Res> {
  _$FollowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? followerId = null,
    Object? followerName = null,
    Object? followerPhotoUrl = freezed,
    Object? followingId = null,
    Object? followingName = null,
    Object? followingPhotoUrl = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            followerId:
                null == followerId
                    ? _value.followerId
                    : followerId // ignore: cast_nullable_to_non_nullable
                        as String,
            followerName:
                null == followerName
                    ? _value.followerName
                    : followerName // ignore: cast_nullable_to_non_nullable
                        as String,
            followerPhotoUrl:
                freezed == followerPhotoUrl
                    ? _value.followerPhotoUrl
                    : followerPhotoUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            followingId:
                null == followingId
                    ? _value.followingId
                    : followingId // ignore: cast_nullable_to_non_nullable
                        as String,
            followingName:
                null == followingName
                    ? _value.followingName
                    : followingName // ignore: cast_nullable_to_non_nullable
                        as String,
            followingPhotoUrl:
                freezed == followingPhotoUrl
                    ? _value.followingPhotoUrl
                    : followingPhotoUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as FollowStatus?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FollowImplCopyWith<$Res> implements $FollowCopyWith<$Res> {
  factory _$$FollowImplCopyWith(
    _$FollowImpl value,
    $Res Function(_$FollowImpl) then,
  ) = __$$FollowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String followerId,
    String followerName,
    String? followerPhotoUrl,
    String followingId,
    String followingName,
    String? followingPhotoUrl,
    FollowStatus? status,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class __$$FollowImplCopyWithImpl<$Res>
    extends _$FollowCopyWithImpl<$Res, _$FollowImpl>
    implements _$$FollowImplCopyWith<$Res> {
  __$$FollowImplCopyWithImpl(
    _$FollowImpl _value,
    $Res Function(_$FollowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? followerId = null,
    Object? followerName = null,
    Object? followerPhotoUrl = freezed,
    Object? followingId = null,
    Object? followingName = null,
    Object? followingPhotoUrl = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$FollowImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        followerId:
            null == followerId
                ? _value.followerId
                : followerId // ignore: cast_nullable_to_non_nullable
                    as String,
        followerName:
            null == followerName
                ? _value.followerName
                : followerName // ignore: cast_nullable_to_non_nullable
                    as String,
        followerPhotoUrl:
            freezed == followerPhotoUrl
                ? _value.followerPhotoUrl
                : followerPhotoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        followingId:
            null == followingId
                ? _value.followingId
                : followingId // ignore: cast_nullable_to_non_nullable
                    as String,
        followingName:
            null == followingName
                ? _value.followingName
                : followingName // ignore: cast_nullable_to_non_nullable
                    as String,
        followingPhotoUrl:
            freezed == followingPhotoUrl
                ? _value.followingPhotoUrl
                : followingPhotoUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as FollowStatus?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FollowImpl implements _Follow {
  const _$FollowImpl({
    this.id,
    required this.followerId,
    required this.followerName,
    this.followerPhotoUrl,
    required this.followingId,
    required this.followingName,
    this.followingPhotoUrl,
    this.status,
    @timestampKey this.createdAt,
    @timestampKey this.updatedAt,
    @timestampKey this.deletedAt,
  });

  factory _$FollowImpl.fromJson(Map<String, dynamic> json) =>
      _$$FollowImplFromJson(json);

  @override
  final String? id;
  @override
  final String followerId;
  @override
  final String followerName;
  @override
  final String? followerPhotoUrl;
  @override
  final String followingId;
  @override
  final String followingName;
  @override
  final String? followingPhotoUrl;
  @override
  final FollowStatus? status;
  @override
  @timestampKey
  final DateTime? createdAt;
  @override
  @timestampKey
  final DateTime? updatedAt;
  @override
  @timestampKey
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'Follow(id: $id, followerId: $followerId, followerName: $followerName, followerPhotoUrl: $followerPhotoUrl, followingId: $followingId, followingName: $followingName, followingPhotoUrl: $followingPhotoUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.followerId, followerId) ||
                other.followerId == followerId) &&
            (identical(other.followerName, followerName) ||
                other.followerName == followerName) &&
            (identical(other.followerPhotoUrl, followerPhotoUrl) ||
                other.followerPhotoUrl == followerPhotoUrl) &&
            (identical(other.followingId, followingId) ||
                other.followingId == followingId) &&
            (identical(other.followingName, followingName) ||
                other.followingName == followingName) &&
            (identical(other.followingPhotoUrl, followingPhotoUrl) ||
                other.followingPhotoUrl == followingPhotoUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    followerId,
    followerName,
    followerPhotoUrl,
    followingId,
    followingName,
    followingPhotoUrl,
    status,
    createdAt,
    updatedAt,
    deletedAt,
  );

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowImplCopyWith<_$FollowImpl> get copyWith =>
      __$$FollowImplCopyWithImpl<_$FollowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FollowImplToJson(this);
  }
}

abstract class _Follow implements Follow {
  const factory _Follow({
    final String? id,
    required final String followerId,
    required final String followerName,
    final String? followerPhotoUrl,
    required final String followingId,
    required final String followingName,
    final String? followingPhotoUrl,
    final FollowStatus? status,
    @timestampKey final DateTime? createdAt,
    @timestampKey final DateTime? updatedAt,
    @timestampKey final DateTime? deletedAt,
  }) = _$FollowImpl;

  factory _Follow.fromJson(Map<String, dynamic> json) = _$FollowImpl.fromJson;

  @override
  String? get id;
  @override
  String get followerId;
  @override
  String get followerName;
  @override
  String? get followerPhotoUrl;
  @override
  String get followingId;
  @override
  String get followingName;
  @override
  String? get followingPhotoUrl;
  @override
  FollowStatus? get status;
  @override
  @timestampKey
  DateTime? get createdAt;
  @override
  @timestampKey
  DateTime? get updatedAt;
  @override
  @timestampKey
  DateTime? get deletedAt;

  /// Create a copy of Follow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FollowImplCopyWith<_$FollowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  int? get followersCount => throw _privateConstructorUsedError;
  int? get followingCount => throw _privateConstructorUsedError;
  int? get postsCount => throw _privateConstructorUsedError;
  bool? get isPrivate => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String? id,
    String userId,
    String? displayName,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    bool? isPrivate,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? displayName = freezed,
    Object? bio = freezed,
    Object? profileImageUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? followersCount = freezed,
    Object? followingCount = freezed,
    Object? postsCount = freezed,
    Object? isPrivate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            userId:
                null == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String,
            displayName:
                freezed == displayName
                    ? _value.displayName
                    : displayName // ignore: cast_nullable_to_non_nullable
                        as String?,
            bio:
                freezed == bio
                    ? _value.bio
                    : bio // ignore: cast_nullable_to_non_nullable
                        as String?,
            profileImageUrl:
                freezed == profileImageUrl
                    ? _value.profileImageUrl
                    : profileImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            coverImageUrl:
                freezed == coverImageUrl
                    ? _value.coverImageUrl
                    : coverImageUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            followersCount:
                freezed == followersCount
                    ? _value.followersCount
                    : followersCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            followingCount:
                freezed == followingCount
                    ? _value.followingCount
                    : followingCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            postsCount:
                freezed == postsCount
                    ? _value.postsCount
                    : postsCount // ignore: cast_nullable_to_non_nullable
                        as int?,
            isPrivate:
                freezed == isPrivate
                    ? _value.isPrivate
                    : isPrivate // ignore: cast_nullable_to_non_nullable
                        as bool?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String userId,
    String? displayName,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    bool? isPrivate,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? displayName = freezed,
    Object? bio = freezed,
    Object? profileImageUrl = freezed,
    Object? coverImageUrl = freezed,
    Object? followersCount = freezed,
    Object? followingCount = freezed,
    Object? postsCount = freezed,
    Object? isPrivate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$UserProfileImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        userId:
            null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String,
        displayName:
            freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                    as String?,
        bio:
            freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                    as String?,
        profileImageUrl:
            freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        coverImageUrl:
            freezed == coverImageUrl
                ? _value.coverImageUrl
                : coverImageUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        followersCount:
            freezed == followersCount
                ? _value.followersCount
                : followersCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        followingCount:
            freezed == followingCount
                ? _value.followingCount
                : followingCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        postsCount:
            freezed == postsCount
                ? _value.postsCount
                : postsCount // ignore: cast_nullable_to_non_nullable
                    as int?,
        isPrivate:
            freezed == isPrivate
                ? _value.isPrivate
                : isPrivate // ignore: cast_nullable_to_non_nullable
                    as bool?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    this.id,
    required this.userId,
    this.displayName,
    this.bio,
    this.profileImageUrl,
    this.coverImageUrl,
    this.followersCount,
    this.followingCount,
    this.postsCount,
    this.isPrivate,
    @timestampKey this.createdAt,
    @timestampKey this.updatedAt,
    @timestampKey this.deletedAt,
  });

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String? id;
  @override
  final String userId;
  @override
  final String? displayName;
  @override
  final String? bio;
  @override
  final String? profileImageUrl;
  @override
  final String? coverImageUrl;
  @override
  final int? followersCount;
  @override
  final int? followingCount;
  @override
  final int? postsCount;
  @override
  final bool? isPrivate;
  @override
  @timestampKey
  final DateTime? createdAt;
  @override
  @timestampKey
  final DateTime? updatedAt;
  @override
  @timestampKey
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'UserProfile(id: $id, userId: $userId, displayName: $displayName, bio: $bio, profileImageUrl: $profileImageUrl, coverImageUrl: $coverImageUrl, followersCount: $followersCount, followingCount: $followingCount, postsCount: $postsCount, isPrivate: $isPrivate, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    displayName,
    bio,
    profileImageUrl,
    coverImageUrl,
    followersCount,
    followingCount,
    postsCount,
    isPrivate,
    createdAt,
    updatedAt,
    deletedAt,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    final String? id,
    required final String userId,
    final String? displayName,
    final String? bio,
    final String? profileImageUrl,
    final String? coverImageUrl,
    final int? followersCount,
    final int? followingCount,
    final int? postsCount,
    final bool? isPrivate,
    @timestampKey final DateTime? createdAt,
    @timestampKey final DateTime? updatedAt,
    @timestampKey final DateTime? deletedAt,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String? get id;
  @override
  String get userId;
  @override
  String? get displayName;
  @override
  String? get bio;
  @override
  String? get profileImageUrl;
  @override
  String? get coverImageUrl;
  @override
  int? get followersCount;
  @override
  int? get followingCount;
  @override
  int? get postsCount;
  @override
  bool? get isPrivate;
  @override
  @timestampKey
  DateTime? get createdAt;
  @override
  @timestampKey
  DateTime? get updatedAt;
  @override
  @timestampKey
  DateTime? get deletedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
