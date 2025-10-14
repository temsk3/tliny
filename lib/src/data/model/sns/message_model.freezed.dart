// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DirectMessage _$DirectMessageFromJson(Map<String, dynamic> json) {
  return _DirectMessage.fromJson(json);
}

/// @nodoc
mixin _$DirectMessage {
  String? get id => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String? get senderPhotoUrl => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get receiverName => throw _privateConstructorUsedError;
  String? get receiverPhotoUrl => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  MessageType? get type => throw _privateConstructorUsedError;
  List<String>? get attachmentUrls => throw _privateConstructorUsedError;
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
  $DirectMessageCopyWith<DirectMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectMessageCopyWith<$Res> {
  factory $DirectMessageCopyWith(
          DirectMessage value, $Res Function(DirectMessage) then) =
      _$DirectMessageCopyWithImpl<$Res, DirectMessage>;
  @useResult
  $Res call(
      {String? id,
      String conversationId,
      String senderId,
      String senderName,
      String? senderPhotoUrl,
      String receiverId,
      String receiverName,
      String? receiverPhotoUrl,
      String content,
      MessageType? type,
      List<String>? attachmentUrls,
      bool? isRead,
      @timestampKey DateTime? readAt,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class _$DirectMessageCopyWithImpl<$Res, $Val extends DirectMessage>
    implements $DirectMessageCopyWith<$Res> {
  _$DirectMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderPhotoUrl = freezed,
    Object? receiverId = null,
    Object? receiverName = null,
    Object? receiverPhotoUrl = freezed,
    Object? content = null,
    Object? type = freezed,
    Object? attachmentUrls = freezed,
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
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderPhotoUrl: freezed == senderPhotoUrl
          ? _value.senderPhotoUrl
          : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverName: null == receiverName
          ? _value.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String,
      receiverPhotoUrl: freezed == receiverPhotoUrl
          ? _value.receiverPhotoUrl
          : receiverPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType?,
      attachmentUrls: freezed == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
abstract class _$$DirectMessageImplCopyWith<$Res>
    implements $DirectMessageCopyWith<$Res> {
  factory _$$DirectMessageImplCopyWith(
          _$DirectMessageImpl value, $Res Function(_$DirectMessageImpl) then) =
      __$$DirectMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String conversationId,
      String senderId,
      String senderName,
      String? senderPhotoUrl,
      String receiverId,
      String receiverName,
      String? receiverPhotoUrl,
      String content,
      MessageType? type,
      List<String>? attachmentUrls,
      bool? isRead,
      @timestampKey DateTime? readAt,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class __$$DirectMessageImplCopyWithImpl<$Res>
    extends _$DirectMessageCopyWithImpl<$Res, _$DirectMessageImpl>
    implements _$$DirectMessageImplCopyWith<$Res> {
  __$$DirectMessageImplCopyWithImpl(
      _$DirectMessageImpl _value, $Res Function(_$DirectMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderPhotoUrl = freezed,
    Object? receiverId = null,
    Object? receiverName = null,
    Object? receiverPhotoUrl = freezed,
    Object? content = null,
    Object? type = freezed,
    Object? attachmentUrls = freezed,
    Object? isRead = freezed,
    Object? readAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$DirectMessageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderPhotoUrl: freezed == senderPhotoUrl
          ? _value.senderPhotoUrl
          : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      receiverId: null == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverName: null == receiverName
          ? _value.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String,
      receiverPhotoUrl: freezed == receiverPhotoUrl
          ? _value.receiverPhotoUrl
          : receiverPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType?,
      attachmentUrls: freezed == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
class _$DirectMessageImpl implements _DirectMessage {
  const _$DirectMessageImpl(
      {this.id,
      required this.conversationId,
      required this.senderId,
      required this.senderName,
      this.senderPhotoUrl,
      required this.receiverId,
      required this.receiverName,
      this.receiverPhotoUrl,
      required this.content,
      this.type,
      final List<String>? attachmentUrls,
      this.isRead,
      @timestampKey this.readAt,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : _attachmentUrls = attachmentUrls;

  factory _$DirectMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectMessageImplFromJson(json);

  @override
  final String? id;
  @override
  final String conversationId;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String? senderPhotoUrl;
  @override
  final String receiverId;
  @override
  final String receiverName;
  @override
  final String? receiverPhotoUrl;
  @override
  final String content;
  @override
  final MessageType? type;
  final List<String>? _attachmentUrls;
  @override
  List<String>? get attachmentUrls {
    final value = _attachmentUrls;
    if (value == null) return null;
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
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
    return 'DirectMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, receiverId: $receiverId, receiverName: $receiverName, receiverPhotoUrl: $receiverPhotoUrl, content: $content, type: $type, attachmentUrls: $attachmentUrls, isRead: $isRead, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderPhotoUrl, senderPhotoUrl) ||
                other.senderPhotoUrl == senderPhotoUrl) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.receiverPhotoUrl, receiverPhotoUrl) ||
                other.receiverPhotoUrl == receiverPhotoUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
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
      conversationId,
      senderId,
      senderName,
      senderPhotoUrl,
      receiverId,
      receiverName,
      receiverPhotoUrl,
      content,
      type,
      const DeepCollectionEquality().hash(_attachmentUrls),
      isRead,
      readAt,
      createdAt,
      updatedAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectMessageImplCopyWith<_$DirectMessageImpl> get copyWith =>
      __$$DirectMessageImplCopyWithImpl<_$DirectMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectMessageImplToJson(
      this,
    );
  }
}

abstract class _DirectMessage implements DirectMessage {
  const factory _DirectMessage(
      {final String? id,
      required final String conversationId,
      required final String senderId,
      required final String senderName,
      final String? senderPhotoUrl,
      required final String receiverId,
      required final String receiverName,
      final String? receiverPhotoUrl,
      required final String content,
      final MessageType? type,
      final List<String>? attachmentUrls,
      final bool? isRead,
      @timestampKey final DateTime? readAt,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt}) = _$DirectMessageImpl;

  factory _DirectMessage.fromJson(Map<String, dynamic> json) =
      _$DirectMessageImpl.fromJson;

  @override
  String? get id;
  @override
  String get conversationId;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String? get senderPhotoUrl;
  @override
  String get receiverId;
  @override
  String get receiverName;
  @override
  String? get receiverPhotoUrl;
  @override
  String get content;
  @override
  MessageType? get type;
  @override
  List<String>? get attachmentUrls;
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
  _$$DirectMessageImplCopyWith<_$DirectMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String? get id => throw _privateConstructorUsedError;
  List<String> get participantIds => throw _privateConstructorUsedError;
  List<String> get participantNames => throw _privateConstructorUsedError;
  List<String>? get participantPhotoUrls => throw _privateConstructorUsedError;
  String? get lastMessageContent => throw _privateConstructorUsedError;
  String? get lastMessageSenderId => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  Map<String, int>? get unreadCounts => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {String? id,
      List<String> participantIds,
      List<String> participantNames,
      List<String>? participantPhotoUrls,
      String? lastMessageContent,
      String? lastMessageSenderId,
      @timestampKey DateTime? lastMessageAt,
      Map<String, int>? unreadCounts,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? participantIds = null,
    Object? participantNames = null,
    Object? participantPhotoUrls = freezed,
    Object? lastMessageContent = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      participantIds: null == participantIds
          ? _value.participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantNames: null == participantNames
          ? _value.participantNames
          : participantNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantPhotoUrls: freezed == participantPhotoUrls
          ? _value.participantPhotoUrls
          : participantPhotoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lastMessageContent: freezed == lastMessageContent
          ? _value.lastMessageContent
          : lastMessageContent // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageSenderId: freezed == lastMessageSenderId
          ? _value.lastMessageSenderId
          : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCounts: freezed == unreadCounts
          ? _value.unreadCounts
          : unreadCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
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
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      List<String> participantIds,
      List<String> participantNames,
      List<String>? participantPhotoUrls,
      String? lastMessageContent,
      String? lastMessageSenderId,
      @timestampKey DateTime? lastMessageAt,
      Map<String, int>? unreadCounts,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? participantIds = null,
    Object? participantNames = null,
    Object? participantPhotoUrls = freezed,
    Object? lastMessageContent = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCounts = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$ConversationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      participantIds: null == participantIds
          ? _value._participantIds
          : participantIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantNames: null == participantNames
          ? _value._participantNames
          : participantNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      participantPhotoUrls: freezed == participantPhotoUrls
          ? _value._participantPhotoUrls
          : participantPhotoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lastMessageContent: freezed == lastMessageContent
          ? _value.lastMessageContent
          : lastMessageContent // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageSenderId: freezed == lastMessageSenderId
          ? _value.lastMessageSenderId
          : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCounts: freezed == unreadCounts
          ? _value._unreadCounts
          : unreadCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
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
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {this.id,
      required final List<String> participantIds,
      required final List<String> participantNames,
      final List<String>? participantPhotoUrls,
      this.lastMessageContent,
      this.lastMessageSenderId,
      @timestampKey this.lastMessageAt,
      final Map<String, int>? unreadCounts,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : _participantIds = participantIds,
        _participantNames = participantNames,
        _participantPhotoUrls = participantPhotoUrls,
        _unreadCounts = unreadCounts;

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String? id;
  final List<String> _participantIds;
  @override
  List<String> get participantIds {
    if (_participantIds is EqualUnmodifiableListView) return _participantIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantIds);
  }

  final List<String> _participantNames;
  @override
  List<String> get participantNames {
    if (_participantNames is EqualUnmodifiableListView)
      return _participantNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participantNames);
  }

  final List<String>? _participantPhotoUrls;
  @override
  List<String>? get participantPhotoUrls {
    final value = _participantPhotoUrls;
    if (value == null) return null;
    if (_participantPhotoUrls is EqualUnmodifiableListView)
      return _participantPhotoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? lastMessageContent;
  @override
  final String? lastMessageSenderId;
  @override
  @timestampKey
  final DateTime? lastMessageAt;
  final Map<String, int>? _unreadCounts;
  @override
  Map<String, int>? get unreadCounts {
    final value = _unreadCounts;
    if (value == null) return null;
    if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

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
    return 'Conversation(id: $id, participantIds: $participantIds, participantNames: $participantNames, participantPhotoUrls: $participantPhotoUrls, lastMessageContent: $lastMessageContent, lastMessageSenderId: $lastMessageSenderId, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._participantIds, _participantIds) &&
            const DeepCollectionEquality()
                .equals(other._participantNames, _participantNames) &&
            const DeepCollectionEquality()
                .equals(other._participantPhotoUrls, _participantPhotoUrls) &&
            (identical(other.lastMessageContent, lastMessageContent) ||
                other.lastMessageContent == lastMessageContent) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            const DeepCollectionEquality()
                .equals(other._unreadCounts, _unreadCounts) &&
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
      const DeepCollectionEquality().hash(_participantIds),
      const DeepCollectionEquality().hash(_participantNames),
      const DeepCollectionEquality().hash(_participantPhotoUrls),
      lastMessageContent,
      lastMessageSenderId,
      lastMessageAt,
      const DeepCollectionEquality().hash(_unreadCounts),
      createdAt,
      updatedAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
      {final String? id,
      required final List<String> participantIds,
      required final List<String> participantNames,
      final List<String>? participantPhotoUrls,
      final String? lastMessageContent,
      final String? lastMessageSenderId,
      @timestampKey final DateTime? lastMessageAt,
      final Map<String, int>? unreadCounts,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt}) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String? get id;
  @override
  List<String> get participantIds;
  @override
  List<String> get participantNames;
  @override
  List<String>? get participantPhotoUrls;
  @override
  String? get lastMessageContent;
  @override
  String? get lastMessageSenderId;
  @override
  @timestampKey
  DateTime? get lastMessageAt;
  @override
  Map<String, int>? get unreadCounts;
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
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
