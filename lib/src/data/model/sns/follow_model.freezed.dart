// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Follow {

 String? get id; String get followerId; String get followerName; String? get followerPhotoUrl; String get followingId; String get followingName; String? get followingPhotoUrl; FollowStatus? get status;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of Follow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FollowCopyWith<Follow> get copyWith => _$FollowCopyWithImpl<Follow>(this as Follow, _$identity);

  /// Serializes this Follow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Follow&&(identical(other.id, id) || other.id == id)&&(identical(other.followerId, followerId) || other.followerId == followerId)&&(identical(other.followerName, followerName) || other.followerName == followerName)&&(identical(other.followerPhotoUrl, followerPhotoUrl) || other.followerPhotoUrl == followerPhotoUrl)&&(identical(other.followingId, followingId) || other.followingId == followingId)&&(identical(other.followingName, followingName) || other.followingName == followingName)&&(identical(other.followingPhotoUrl, followingPhotoUrl) || other.followingPhotoUrl == followingPhotoUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,followerId,followerName,followerPhotoUrl,followingId,followingName,followingPhotoUrl,status,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Follow(id: $id, followerId: $followerId, followerName: $followerName, followerPhotoUrl: $followerPhotoUrl, followingId: $followingId, followingName: $followingName, followingPhotoUrl: $followingPhotoUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $FollowCopyWith<$Res>  {
  factory $FollowCopyWith(Follow value, $Res Function(Follow) _then) = _$FollowCopyWithImpl;
@useResult
$Res call({
 String? id, String followerId, String followerName, String? followerPhotoUrl, String followingId, String followingName, String? followingPhotoUrl, FollowStatus? status,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$FollowCopyWithImpl<$Res>
    implements $FollowCopyWith<$Res> {
  _$FollowCopyWithImpl(this._self, this._then);

  final Follow _self;
  final $Res Function(Follow) _then;

/// Create a copy of Follow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? followerId = null,Object? followerName = null,Object? followerPhotoUrl = freezed,Object? followingId = null,Object? followingName = null,Object? followingPhotoUrl = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,followerId: null == followerId ? _self.followerId : followerId // ignore: cast_nullable_to_non_nullable
as String,followerName: null == followerName ? _self.followerName : followerName // ignore: cast_nullable_to_non_nullable
as String,followerPhotoUrl: freezed == followerPhotoUrl ? _self.followerPhotoUrl : followerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,followingId: null == followingId ? _self.followingId : followingId // ignore: cast_nullable_to_non_nullable
as String,followingName: null == followingName ? _self.followingName : followingName // ignore: cast_nullable_to_non_nullable
as String,followingPhotoUrl: freezed == followingPhotoUrl ? _self.followingPhotoUrl : followingPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FollowStatus?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Follow].
extension FollowPatterns on Follow {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Follow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Follow() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Follow value)  $default,){
final _that = this;
switch (_that) {
case _Follow():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Follow value)?  $default,){
final _that = this;
switch (_that) {
case _Follow() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String followerId,  String followerName,  String? followerPhotoUrl,  String followingId,  String followingName,  String? followingPhotoUrl,  FollowStatus? status, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Follow() when $default != null:
return $default(_that.id,_that.followerId,_that.followerName,_that.followerPhotoUrl,_that.followingId,_that.followingName,_that.followingPhotoUrl,_that.status,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String followerId,  String followerName,  String? followerPhotoUrl,  String followingId,  String followingName,  String? followingPhotoUrl,  FollowStatus? status, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Follow():
return $default(_that.id,_that.followerId,_that.followerName,_that.followerPhotoUrl,_that.followingId,_that.followingName,_that.followingPhotoUrl,_that.status,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String followerId,  String followerName,  String? followerPhotoUrl,  String followingId,  String followingName,  String? followingPhotoUrl,  FollowStatus? status, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Follow() when $default != null:
return $default(_that.id,_that.followerId,_that.followerName,_that.followerPhotoUrl,_that.followingId,_that.followingName,_that.followingPhotoUrl,_that.status,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Follow implements Follow {
  const _Follow({this.id, required this.followerId, required this.followerName, this.followerPhotoUrl, required this.followingId, required this.followingName, this.followingPhotoUrl, this.status, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt});
  factory _Follow.fromJson(Map<String, dynamic> json) => _$FollowFromJson(json);

@override final  String? id;
@override final  String followerId;
@override final  String followerName;
@override final  String? followerPhotoUrl;
@override final  String followingId;
@override final  String followingName;
@override final  String? followingPhotoUrl;
@override final  FollowStatus? status;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of Follow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FollowCopyWith<_Follow> get copyWith => __$FollowCopyWithImpl<_Follow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FollowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Follow&&(identical(other.id, id) || other.id == id)&&(identical(other.followerId, followerId) || other.followerId == followerId)&&(identical(other.followerName, followerName) || other.followerName == followerName)&&(identical(other.followerPhotoUrl, followerPhotoUrl) || other.followerPhotoUrl == followerPhotoUrl)&&(identical(other.followingId, followingId) || other.followingId == followingId)&&(identical(other.followingName, followingName) || other.followingName == followingName)&&(identical(other.followingPhotoUrl, followingPhotoUrl) || other.followingPhotoUrl == followingPhotoUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,followerId,followerName,followerPhotoUrl,followingId,followingName,followingPhotoUrl,status,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Follow(id: $id, followerId: $followerId, followerName: $followerName, followerPhotoUrl: $followerPhotoUrl, followingId: $followingId, followingName: $followingName, followingPhotoUrl: $followingPhotoUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$FollowCopyWith<$Res> implements $FollowCopyWith<$Res> {
  factory _$FollowCopyWith(_Follow value, $Res Function(_Follow) _then) = __$FollowCopyWithImpl;
@override @useResult
$Res call({
 String? id, String followerId, String followerName, String? followerPhotoUrl, String followingId, String followingName, String? followingPhotoUrl, FollowStatus? status,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$FollowCopyWithImpl<$Res>
    implements _$FollowCopyWith<$Res> {
  __$FollowCopyWithImpl(this._self, this._then);

  final _Follow _self;
  final $Res Function(_Follow) _then;

/// Create a copy of Follow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? followerId = null,Object? followerName = null,Object? followerPhotoUrl = freezed,Object? followingId = null,Object? followingName = null,Object? followingPhotoUrl = freezed,Object? status = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_Follow(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,followerId: null == followerId ? _self.followerId : followerId // ignore: cast_nullable_to_non_nullable
as String,followerName: null == followerName ? _self.followerName : followerName // ignore: cast_nullable_to_non_nullable
as String,followerPhotoUrl: freezed == followerPhotoUrl ? _self.followerPhotoUrl : followerPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,followingId: null == followingId ? _self.followingId : followingId // ignore: cast_nullable_to_non_nullable
as String,followingName: null == followingName ? _self.followingName : followingName // ignore: cast_nullable_to_non_nullable
as String,followingPhotoUrl: freezed == followingPhotoUrl ? _self.followingPhotoUrl : followingPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FollowStatus?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$UserProfile {

 String? get id; String get userId; String? get displayName; String? get bio; String? get profileImageUrl; String? get coverImageUrl; int? get followersCount; int? get followingCount; int? get postsCount; bool? get isPrivate;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.postsCount, postsCount) || other.postsCount == postsCount)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,displayName,bio,profileImageUrl,coverImageUrl,followersCount,followingCount,postsCount,isPrivate,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'UserProfile(id: $id, userId: $userId, displayName: $displayName, bio: $bio, profileImageUrl: $profileImageUrl, coverImageUrl: $coverImageUrl, followersCount: $followersCount, followingCount: $followingCount, postsCount: $postsCount, isPrivate: $isPrivate, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String? id, String userId, String? displayName, String? bio, String? profileImageUrl, String? coverImageUrl, int? followersCount, int? followingCount, int? postsCount, bool? isPrivate,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? displayName = freezed,Object? bio = freezed,Object? profileImageUrl = freezed,Object? coverImageUrl = freezed,Object? followersCount = freezed,Object? followingCount = freezed,Object? postsCount = freezed,Object? isPrivate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,followersCount: freezed == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int?,followingCount: freezed == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int?,postsCount: freezed == postsCount ? _self.postsCount : postsCount // ignore: cast_nullable_to_non_nullable
as int?,isPrivate: freezed == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String userId,  String? displayName,  String? bio,  String? profileImageUrl,  String? coverImageUrl,  int? followersCount,  int? followingCount,  int? postsCount,  bool? isPrivate, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.profileImageUrl,_that.coverImageUrl,_that.followersCount,_that.followingCount,_that.postsCount,_that.isPrivate,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String userId,  String? displayName,  String? bio,  String? profileImageUrl,  String? coverImageUrl,  int? followersCount,  int? followingCount,  int? postsCount,  bool? isPrivate, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.profileImageUrl,_that.coverImageUrl,_that.followersCount,_that.followingCount,_that.postsCount,_that.isPrivate,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String userId,  String? displayName,  String? bio,  String? profileImageUrl,  String? coverImageUrl,  int? followersCount,  int? followingCount,  int? postsCount,  bool? isPrivate, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.id,_that.userId,_that.displayName,_that.bio,_that.profileImageUrl,_that.coverImageUrl,_that.followersCount,_that.followingCount,_that.postsCount,_that.isPrivate,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({this.id, required this.userId, this.displayName, this.bio, this.profileImageUrl, this.coverImageUrl, this.followersCount, this.followingCount, this.postsCount, this.isPrivate, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String? id;
@override final  String userId;
@override final  String? displayName;
@override final  String? bio;
@override final  String? profileImageUrl;
@override final  String? coverImageUrl;
@override final  int? followersCount;
@override final  int? followingCount;
@override final  int? postsCount;
@override final  bool? isPrivate;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.postsCount, postsCount) || other.postsCount == postsCount)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,displayName,bio,profileImageUrl,coverImageUrl,followersCount,followingCount,postsCount,isPrivate,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'UserProfile(id: $id, userId: $userId, displayName: $displayName, bio: $bio, profileImageUrl: $profileImageUrl, coverImageUrl: $coverImageUrl, followersCount: $followersCount, followingCount: $followingCount, postsCount: $postsCount, isPrivate: $isPrivate, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String? id, String userId, String? displayName, String? bio, String? profileImageUrl, String? coverImageUrl, int? followersCount, int? followingCount, int? postsCount, bool? isPrivate,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? displayName = freezed,Object? bio = freezed,Object? profileImageUrl = freezed,Object? coverImageUrl = freezed,Object? followersCount = freezed,Object? followingCount = freezed,Object? postsCount = freezed,Object? isPrivate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_UserProfile(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,followersCount: freezed == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int?,followingCount: freezed == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int?,postsCount: freezed == postsCount ? _self.postsCount : postsCount // ignore: cast_nullable_to_non_nullable
as int?,isPrivate: freezed == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
