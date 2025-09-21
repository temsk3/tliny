// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppNotification {

 String? get id; String get userId; String get title; String get message; NotificationType? get type; String? get actionUserId; String? get actionUserName; String? get actionUserPhotoUrl; String? get targetId; String? get targetType; Map<String, dynamic>? get metadata; bool? get isRead;@timestampKey DateTime? get readAt;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationCopyWith<AppNotification> get copyWith => _$AppNotificationCopyWithImpl<AppNotification>(this as AppNotification, _$identity);

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionUserId, actionUserId) || other.actionUserId == actionUserId)&&(identical(other.actionUserName, actionUserName) || other.actionUserName == actionUserName)&&(identical(other.actionUserPhotoUrl, actionUserPhotoUrl) || other.actionUserPhotoUrl == actionUserPhotoUrl)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,message,type,actionUserId,actionUserName,actionUserPhotoUrl,targetId,targetType,const DeepCollectionEquality().hash(metadata),isRead,readAt,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'AppNotification(id: $id, userId: $userId, title: $title, message: $message, type: $type, actionUserId: $actionUserId, actionUserName: $actionUserName, actionUserPhotoUrl: $actionUserPhotoUrl, targetId: $targetId, targetType: $targetType, metadata: $metadata, isRead: $isRead, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $AppNotificationCopyWith<$Res>  {
  factory $AppNotificationCopyWith(AppNotification value, $Res Function(AppNotification) _then) = _$AppNotificationCopyWithImpl;
@useResult
$Res call({
 String? id, String userId, String title, String message, NotificationType? type, String? actionUserId, String? actionUserName, String? actionUserPhotoUrl, String? targetId, String? targetType, Map<String, dynamic>? metadata, bool? isRead,@timestampKey DateTime? readAt,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$AppNotificationCopyWithImpl<$Res>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._self, this._then);

  final AppNotification _self;
  final $Res Function(AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? title = null,Object? message = null,Object? type = freezed,Object? actionUserId = freezed,Object? actionUserName = freezed,Object? actionUserPhotoUrl = freezed,Object? targetId = freezed,Object? targetType = freezed,Object? metadata = freezed,Object? isRead = freezed,Object? readAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType?,actionUserId: freezed == actionUserId ? _self.actionUserId : actionUserId // ignore: cast_nullable_to_non_nullable
as String?,actionUserName: freezed == actionUserName ? _self.actionUserName : actionUserName // ignore: cast_nullable_to_non_nullable
as String?,actionUserPhotoUrl: freezed == actionUserPhotoUrl ? _self.actionUserPhotoUrl : actionUserPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppNotification].
extension AppNotificationPatterns on AppNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppNotification value)  $default,){
final _that = this;
switch (_that) {
case _AppNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppNotification value)?  $default,){
final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String userId,  String title,  String message,  NotificationType? type,  String? actionUserId,  String? actionUserName,  String? actionUserPhotoUrl,  String? targetId,  String? targetType,  Map<String, dynamic>? metadata,  bool? isRead, @timestampKey  DateTime? readAt, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.message,_that.type,_that.actionUserId,_that.actionUserName,_that.actionUserPhotoUrl,_that.targetId,_that.targetType,_that.metadata,_that.isRead,_that.readAt,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String userId,  String title,  String message,  NotificationType? type,  String? actionUserId,  String? actionUserName,  String? actionUserPhotoUrl,  String? targetId,  String? targetType,  Map<String, dynamic>? metadata,  bool? isRead, @timestampKey  DateTime? readAt, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _AppNotification():
return $default(_that.id,_that.userId,_that.title,_that.message,_that.type,_that.actionUserId,_that.actionUserName,_that.actionUserPhotoUrl,_that.targetId,_that.targetType,_that.metadata,_that.isRead,_that.readAt,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String userId,  String title,  String message,  NotificationType? type,  String? actionUserId,  String? actionUserName,  String? actionUserPhotoUrl,  String? targetId,  String? targetType,  Map<String, dynamic>? metadata,  bool? isRead, @timestampKey  DateTime? readAt, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.message,_that.type,_that.actionUserId,_that.actionUserName,_that.actionUserPhotoUrl,_that.targetId,_that.targetType,_that.metadata,_that.isRead,_that.readAt,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppNotification implements AppNotification {
  const _AppNotification({this.id, required this.userId, required this.title, required this.message, this.type, this.actionUserId, this.actionUserName, this.actionUserPhotoUrl, this.targetId, this.targetType, final  Map<String, dynamic>? metadata, this.isRead, @timestampKey this.readAt, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt}): _metadata = metadata;
  factory _AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);

@override final  String? id;
@override final  String userId;
@override final  String title;
@override final  String message;
@override final  NotificationType? type;
@override final  String? actionUserId;
@override final  String? actionUserName;
@override final  String? actionUserPhotoUrl;
@override final  String? targetId;
@override final  String? targetType;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  bool? isRead;
@override@timestampKey final  DateTime? readAt;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationCopyWith<_AppNotification> get copyWith => __$AppNotificationCopyWithImpl<_AppNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.type, type) || other.type == type)&&(identical(other.actionUserId, actionUserId) || other.actionUserId == actionUserId)&&(identical(other.actionUserName, actionUserName) || other.actionUserName == actionUserName)&&(identical(other.actionUserPhotoUrl, actionUserPhotoUrl) || other.actionUserPhotoUrl == actionUserPhotoUrl)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.targetType, targetType) || other.targetType == targetType)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,message,type,actionUserId,actionUserName,actionUserPhotoUrl,targetId,targetType,const DeepCollectionEquality().hash(_metadata),isRead,readAt,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'AppNotification(id: $id, userId: $userId, title: $title, message: $message, type: $type, actionUserId: $actionUserId, actionUserName: $actionUserName, actionUserPhotoUrl: $actionUserPhotoUrl, targetId: $targetId, targetType: $targetType, metadata: $metadata, isRead: $isRead, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationCopyWith<$Res> implements $AppNotificationCopyWith<$Res> {
  factory _$AppNotificationCopyWith(_AppNotification value, $Res Function(_AppNotification) _then) = __$AppNotificationCopyWithImpl;
@override @useResult
$Res call({
 String? id, String userId, String title, String message, NotificationType? type, String? actionUserId, String? actionUserName, String? actionUserPhotoUrl, String? targetId, String? targetType, Map<String, dynamic>? metadata, bool? isRead,@timestampKey DateTime? readAt,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$AppNotificationCopyWithImpl<$Res>
    implements _$AppNotificationCopyWith<$Res> {
  __$AppNotificationCopyWithImpl(this._self, this._then);

  final _AppNotification _self;
  final $Res Function(_AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? title = null,Object? message = null,Object? type = freezed,Object? actionUserId = freezed,Object? actionUserName = freezed,Object? actionUserPhotoUrl = freezed,Object? targetId = freezed,Object? targetType = freezed,Object? metadata = freezed,Object? isRead = freezed,Object? readAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_AppNotification(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType?,actionUserId: freezed == actionUserId ? _self.actionUserId : actionUserId // ignore: cast_nullable_to_non_nullable
as String?,actionUserName: freezed == actionUserName ? _self.actionUserName : actionUserName // ignore: cast_nullable_to_non_nullable
as String?,actionUserPhotoUrl: freezed == actionUserPhotoUrl ? _self.actionUserPhotoUrl : actionUserPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,targetType: freezed == targetType ? _self.targetType : targetType // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ShareActivity {

 String? get id; String get userId; String get userName; String? get userPhotoUrl; String get contentId; String get contentType; SharePlatform get platform; String? get sharedUrl;@timestampKey DateTime? get createdAt;
/// Create a copy of ShareActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareActivityCopyWith<ShareActivity> get copyWith => _$ShareActivityCopyWithImpl<ShareActivity>(this as ShareActivity, _$identity);

  /// Serializes this ShareActivity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userPhotoUrl, userPhotoUrl) || other.userPhotoUrl == userPhotoUrl)&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.sharedUrl, sharedUrl) || other.sharedUrl == sharedUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,userPhotoUrl,contentId,contentType,platform,sharedUrl,createdAt);

@override
String toString() {
  return 'ShareActivity(id: $id, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl, contentId: $contentId, contentType: $contentType, platform: $platform, sharedUrl: $sharedUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ShareActivityCopyWith<$Res>  {
  factory $ShareActivityCopyWith(ShareActivity value, $Res Function(ShareActivity) _then) = _$ShareActivityCopyWithImpl;
@useResult
$Res call({
 String? id, String userId, String userName, String? userPhotoUrl, String contentId, String contentType, SharePlatform platform, String? sharedUrl,@timestampKey DateTime? createdAt
});




}
/// @nodoc
class _$ShareActivityCopyWithImpl<$Res>
    implements $ShareActivityCopyWith<$Res> {
  _$ShareActivityCopyWithImpl(this._self, this._then);

  final ShareActivity _self;
  final $Res Function(ShareActivity) _then;

/// Create a copy of ShareActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? userName = null,Object? userPhotoUrl = freezed,Object? contentId = null,Object? contentType = null,Object? platform = null,Object? sharedUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userPhotoUrl: freezed == userPhotoUrl ? _self.userPhotoUrl : userPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SharePlatform,sharedUrl: freezed == sharedUrl ? _self.sharedUrl : sharedUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShareActivity].
extension ShareActivityPatterns on ShareActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareActivity value)  $default,){
final _that = this;
switch (_that) {
case _ShareActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareActivity value)?  $default,){
final _that = this;
switch (_that) {
case _ShareActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String userId,  String userName,  String? userPhotoUrl,  String contentId,  String contentType,  SharePlatform platform,  String? sharedUrl, @timestampKey  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareActivity() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.userPhotoUrl,_that.contentId,_that.contentType,_that.platform,_that.sharedUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String userId,  String userName,  String? userPhotoUrl,  String contentId,  String contentType,  SharePlatform platform,  String? sharedUrl, @timestampKey  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ShareActivity():
return $default(_that.id,_that.userId,_that.userName,_that.userPhotoUrl,_that.contentId,_that.contentType,_that.platform,_that.sharedUrl,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String userId,  String userName,  String? userPhotoUrl,  String contentId,  String contentType,  SharePlatform platform,  String? sharedUrl, @timestampKey  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ShareActivity() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.userPhotoUrl,_that.contentId,_that.contentType,_that.platform,_that.sharedUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShareActivity implements ShareActivity {
  const _ShareActivity({this.id, required this.userId, required this.userName, this.userPhotoUrl, required this.contentId, required this.contentType, required this.platform, this.sharedUrl, @timestampKey this.createdAt});
  factory _ShareActivity.fromJson(Map<String, dynamic> json) => _$ShareActivityFromJson(json);

@override final  String? id;
@override final  String userId;
@override final  String userName;
@override final  String? userPhotoUrl;
@override final  String contentId;
@override final  String contentType;
@override final  SharePlatform platform;
@override final  String? sharedUrl;
@override@timestampKey final  DateTime? createdAt;

/// Create a copy of ShareActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareActivityCopyWith<_ShareActivity> get copyWith => __$ShareActivityCopyWithImpl<_ShareActivity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShareActivityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userPhotoUrl, userPhotoUrl) || other.userPhotoUrl == userPhotoUrl)&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.sharedUrl, sharedUrl) || other.sharedUrl == sharedUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,userPhotoUrl,contentId,contentType,platform,sharedUrl,createdAt);

@override
String toString() {
  return 'ShareActivity(id: $id, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl, contentId: $contentId, contentType: $contentType, platform: $platform, sharedUrl: $sharedUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ShareActivityCopyWith<$Res> implements $ShareActivityCopyWith<$Res> {
  factory _$ShareActivityCopyWith(_ShareActivity value, $Res Function(_ShareActivity) _then) = __$ShareActivityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String userId, String userName, String? userPhotoUrl, String contentId, String contentType, SharePlatform platform, String? sharedUrl,@timestampKey DateTime? createdAt
});




}
/// @nodoc
class __$ShareActivityCopyWithImpl<$Res>
    implements _$ShareActivityCopyWith<$Res> {
  __$ShareActivityCopyWithImpl(this._self, this._then);

  final _ShareActivity _self;
  final $Res Function(_ShareActivity) _then;

/// Create a copy of ShareActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? userName = null,Object? userPhotoUrl = freezed,Object? contentId = null,Object? contentType = null,Object? platform = null,Object? sharedUrl = freezed,Object? createdAt = freezed,}) {
  return _then(_ShareActivity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userPhotoUrl: freezed == userPhotoUrl ? _self.userPhotoUrl : userPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SharePlatform,sharedUrl: freezed == sharedUrl ? _self.sharedUrl : sharedUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
