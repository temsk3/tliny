// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) {
  return _AppNotification.fromJson(json);
}

/// @nodoc
mixin _$AppNotification {
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  NotificationType? get type => throw _privateConstructorUsedError;
  String? get actionUserId => throw _privateConstructorUsedError;
  String? get actionUserName => throw _privateConstructorUsedError;
  String? get actionUserPhotoUrl => throw _privateConstructorUsedError;
  String? get targetId => throw _privateConstructorUsedError;
  String? get targetType => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool? get isRead => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get readAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppNotificationCopyWith<AppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppNotificationCopyWith<$Res> {
  factory $AppNotificationCopyWith(
          AppNotification value, $Res Function(AppNotification) then) =
      _$AppNotificationCopyWithImpl<$Res, AppNotification>;
  @useResult
  $Res call(
      {String? id,
      String userId,
      String title,
      String message,
      NotificationType? type,
      String? actionUserId,
      String? actionUserName,
      String? actionUserPhotoUrl,
      String? targetId,
      String? targetType,
      Map<String, dynamic>? metadata,
      bool? isRead,
      @timestampKey DateTime? readAt,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class _$AppNotificationCopyWithImpl<$Res, $Val extends AppNotification>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? title = null,
    Object? message = null,
    Object? type = freezed,
    Object? actionUserId = freezed,
    Object? actionUserName = freezed,
    Object? actionUserPhotoUrl = freezed,
    Object? targetId = freezed,
    Object? targetType = freezed,
    Object? metadata = freezed,
    Object? isRead = freezed,
    Object? readAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType?,
      actionUserId: freezed == actionUserId
          ? _value.actionUserId
          : actionUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUserName: freezed == actionUserName
          ? _value.actionUserName
          : actionUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUserPhotoUrl: freezed == actionUserPhotoUrl
          ? _value.actionUserPhotoUrl
          : actionUserPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetType: freezed == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppNotificationImplCopyWith<$Res>
    implements $AppNotificationCopyWith<$Res> {
  factory _$$AppNotificationImplCopyWith(_$AppNotificationImpl value,
          $Res Function(_$AppNotificationImpl) then) =
      __$$AppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String userId,
      String title,
      String message,
      NotificationType? type,
      String? actionUserId,
      String? actionUserName,
      String? actionUserPhotoUrl,
      String? targetId,
      String? targetType,
      Map<String, dynamic>? metadata,
      bool? isRead,
      @timestampKey DateTime? readAt,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class __$$AppNotificationImplCopyWithImpl<$Res>
    extends _$AppNotificationCopyWithImpl<$Res, _$AppNotificationImpl>
    implements _$$AppNotificationImplCopyWith<$Res> {
  __$$AppNotificationImplCopyWithImpl(
      _$AppNotificationImpl _value, $Res Function(_$AppNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? title = null,
    Object? message = null,
    Object? type = freezed,
    Object? actionUserId = freezed,
    Object? actionUserName = freezed,
    Object? actionUserPhotoUrl = freezed,
    Object? targetId = freezed,
    Object? targetType = freezed,
    Object? metadata = freezed,
    Object? isRead = freezed,
    Object? readAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$AppNotificationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType?,
      actionUserId: freezed == actionUserId
          ? _value.actionUserId
          : actionUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUserName: freezed == actionUserName
          ? _value.actionUserName
          : actionUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      actionUserPhotoUrl: freezed == actionUserPhotoUrl
          ? _value.actionUserPhotoUrl
          : actionUserPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetType: freezed == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppNotificationImpl implements _AppNotification {
  const _$AppNotificationImpl(
      {this.id,
      required this.userId,
      required this.title,
      required this.message,
      this.type,
      this.actionUserId,
      this.actionUserName,
      this.actionUserPhotoUrl,
      this.targetId,
      this.targetType,
      final Map<String, dynamic>? metadata,
      this.isRead,
      @timestampKey this.readAt,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : _metadata = metadata;

  factory _$AppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppNotificationImplFromJson(json);

  @override
  final String? id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String message;
  @override
  final NotificationType? type;
  @override
  final String? actionUserId;
  @override
  final String? actionUserName;
  @override
  final String? actionUserPhotoUrl;
  @override
  final String? targetId;
  @override
  final String? targetType;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? isRead;
  @override
  @timestampKey
  final DateTime? readAt;
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
    return 'AppNotification(id: $id, userId: $userId, title: $title, message: $message, type: $type, actionUserId: $actionUserId, actionUserName: $actionUserName, actionUserPhotoUrl: $actionUserPhotoUrl, targetId: $targetId, targetType: $targetType, metadata: $metadata, isRead: $isRead, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.actionUserId, actionUserId) ||
                other.actionUserId == actionUserId) &&
            (identical(other.actionUserName, actionUserName) ||
                other.actionUserName == actionUserName) &&
            (identical(other.actionUserPhotoUrl, actionUserPhotoUrl) ||
                other.actionUserPhotoUrl == actionUserPhotoUrl) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      title,
      message,
      type,
      actionUserId,
      actionUserName,
      actionUserPhotoUrl,
      targetId,
      targetType,
      const DeepCollectionEquality().hash(_metadata),
      isRead,
      readAt,
      createdAt,
      updatedAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      __$$AppNotificationImplCopyWithImpl<_$AppNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppNotificationImplToJson(
      this,
    );
  }
}

abstract class _AppNotification implements AppNotification {
  const factory _AppNotification(
      {final String? id,
      required final String userId,
      required final String title,
      required final String message,
      final NotificationType? type,
      final String? actionUserId,
      final String? actionUserName,
      final String? actionUserPhotoUrl,
      final String? targetId,
      final String? targetType,
      final Map<String, dynamic>? metadata,
      final bool? isRead,
      @timestampKey final DateTime? readAt,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt}) = _$AppNotificationImpl;

  factory _AppNotification.fromJson(Map<String, dynamic> json) =
      _$AppNotificationImpl.fromJson;

  @override
  String? get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get message;
  @override
  NotificationType? get type;
  @override
  String? get actionUserId;
  @override
  String? get actionUserName;
  @override
  String? get actionUserPhotoUrl;
  @override
  String? get targetId;
  @override
  String? get targetType;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool? get isRead;
  @override
  @timestampKey
  DateTime? get readAt;
  @override
  @timestampKey
  DateTime? get createdAt;
  @override
  @timestampKey
  DateTime? get updatedAt;
  @override
  @timestampKey
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$AppNotificationImplCopyWith<_$AppNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShareActivity _$ShareActivityFromJson(Map<String, dynamic> json) {
  return _ShareActivity.fromJson(json);
}

/// @nodoc
mixin _$ShareActivity {
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String? get userPhotoUrl => throw _privateConstructorUsedError;
  String get contentId => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  SharePlatform get platform => throw _privateConstructorUsedError;
  String? get sharedUrl => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShareActivityCopyWith<ShareActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareActivityCopyWith<$Res> {
  factory $ShareActivityCopyWith(
          ShareActivity value, $Res Function(ShareActivity) then) =
      _$ShareActivityCopyWithImpl<$Res, ShareActivity>;
  @useResult
  $Res call(
      {String? id,
      String userId,
      String userName,
      String? userPhotoUrl,
      String contentId,
      String contentType,
      SharePlatform platform,
      String? sharedUrl,
      @timestampKey DateTime? createdAt});
}

/// @nodoc
class _$ShareActivityCopyWithImpl<$Res, $Val extends ShareActivity>
    implements $ShareActivityCopyWith<$Res> {
  _$ShareActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? userName = null,
    Object? userPhotoUrl = freezed,
    Object? contentId = null,
    Object? contentType = null,
    Object? platform = null,
    Object? sharedUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPhotoUrl: freezed == userPhotoUrl
          ? _value.userPhotoUrl
          : userPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as SharePlatform,
      sharedUrl: freezed == sharedUrl
          ? _value.sharedUrl
          : sharedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShareActivityImplCopyWith<$Res>
    implements $ShareActivityCopyWith<$Res> {
  factory _$$ShareActivityImplCopyWith(
          _$ShareActivityImpl value, $Res Function(_$ShareActivityImpl) then) =
      __$$ShareActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String userId,
      String userName,
      String? userPhotoUrl,
      String contentId,
      String contentType,
      SharePlatform platform,
      String? sharedUrl,
      @timestampKey DateTime? createdAt});
}

/// @nodoc
class __$$ShareActivityImplCopyWithImpl<$Res>
    extends _$ShareActivityCopyWithImpl<$Res, _$ShareActivityImpl>
    implements _$$ShareActivityImplCopyWith<$Res> {
  __$$ShareActivityImplCopyWithImpl(
      _$ShareActivityImpl _value, $Res Function(_$ShareActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = null,
    Object? userName = null,
    Object? userPhotoUrl = freezed,
    Object? contentId = null,
    Object? contentType = null,
    Object? platform = null,
    Object? sharedUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ShareActivityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPhotoUrl: freezed == userPhotoUrl
          ? _value.userPhotoUrl
          : userPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as SharePlatform,
      sharedUrl: freezed == sharedUrl
          ? _value.sharedUrl
          : sharedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareActivityImpl implements _ShareActivity {
  const _$ShareActivityImpl(
      {this.id,
      required this.userId,
      required this.userName,
      this.userPhotoUrl,
      required this.contentId,
      required this.contentType,
      required this.platform,
      this.sharedUrl,
      @timestampKey this.createdAt});

  factory _$ShareActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShareActivityImplFromJson(json);

  @override
  final String? id;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String? userPhotoUrl;
  @override
  final String contentId;
  @override
  final String contentType;
  @override
  final SharePlatform platform;
  @override
  final String? sharedUrl;
  @override
  @timestampKey
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ShareActivity(id: $id, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl, contentId: $contentId, contentType: $contentType, platform: $platform, sharedUrl: $sharedUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhotoUrl, userPhotoUrl) ||
                other.userPhotoUrl == userPhotoUrl) &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.sharedUrl, sharedUrl) ||
                other.sharedUrl == sharedUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, userName,
      userPhotoUrl, contentId, contentType, platform, sharedUrl, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareActivityImplCopyWith<_$ShareActivityImpl> get copyWith =>
      __$$ShareActivityImplCopyWithImpl<_$ShareActivityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShareActivityImplToJson(
      this,
    );
  }
}

abstract class _ShareActivity implements ShareActivity {
  const factory _ShareActivity(
      {final String? id,
      required final String userId,
      required final String userName,
      final String? userPhotoUrl,
      required final String contentId,
      required final String contentType,
      required final SharePlatform platform,
      final String? sharedUrl,
      @timestampKey final DateTime? createdAt}) = _$ShareActivityImpl;

  factory _ShareActivity.fromJson(Map<String, dynamic> json) =
      _$ShareActivityImpl.fromJson;

  @override
  String? get id;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String? get userPhotoUrl;
  @override
  String get contentId;
  @override
  String get contentType;
  @override
  SharePlatform get platform;
  @override
  String? get sharedUrl;
  @override
  @timestampKey
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ShareActivityImplCopyWith<_$ShareActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
