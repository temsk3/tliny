// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DirectMessage {

 String? get id; String? get conversationId; String? get senderId; String? get senderName; String? get senderPhotoUrl; String? get receiverId; String? get receiverName; String? get receiverPhotoUrl; String? get content; MessageType? get type; List<String>? get attachmentUrls; bool? get isRead;@timestampKey DateTime? get readAt;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of DirectMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DirectMessageCopyWith<DirectMessage> get copyWith => _$DirectMessageCopyWithImpl<DirectMessage>(this as DirectMessage, _$identity);

  /// Serializes this DirectMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DirectMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderPhotoUrl, senderPhotoUrl) || other.senderPhotoUrl == senderPhotoUrl)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.receiverPhotoUrl, receiverPhotoUrl) || other.receiverPhotoUrl == receiverPhotoUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.attachmentUrls, attachmentUrls)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderName,senderPhotoUrl,receiverId,receiverName,receiverPhotoUrl,content,type,const DeepCollectionEquality().hash(attachmentUrls),isRead,readAt,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'DirectMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, receiverId: $receiverId, receiverName: $receiverName, receiverPhotoUrl: $receiverPhotoUrl, content: $content, type: $type, attachmentUrls: $attachmentUrls, isRead: $isRead, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $DirectMessageCopyWith<$Res>  {
  factory $DirectMessageCopyWith(DirectMessage value, $Res Function(DirectMessage) _then) = _$DirectMessageCopyWithImpl;
@useResult
$Res call({
 String? id, String? conversationId, String? senderId, String? senderName, String? senderPhotoUrl, String? receiverId, String? receiverName, String? receiverPhotoUrl, String? content, MessageType? type, List<String>? attachmentUrls, bool? isRead,@timestampKey DateTime? readAt,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$DirectMessageCopyWithImpl<$Res>
    implements $DirectMessageCopyWith<$Res> {
  _$DirectMessageCopyWithImpl(this._self, this._then);

  final DirectMessage _self;
  final $Res Function(DirectMessage) _then;

/// Create a copy of DirectMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? conversationId = freezed,Object? senderId = freezed,Object? senderName = freezed,Object? senderPhotoUrl = freezed,Object? receiverId = freezed,Object? receiverName = freezed,Object? receiverPhotoUrl = freezed,Object? content = freezed,Object? type = freezed,Object? attachmentUrls = freezed,Object? isRead = freezed,Object? readAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,senderPhotoUrl: freezed == senderPhotoUrl ? _self.senderPhotoUrl : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,receiverId: freezed == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String?,receiverName: freezed == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String?,receiverPhotoUrl: freezed == receiverPhotoUrl ? _self.receiverPhotoUrl : receiverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType?,attachmentUrls: freezed == attachmentUrls ? _self.attachmentUrls : attachmentUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DirectMessage].
extension DirectMessagePatterns on DirectMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DirectMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DirectMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DirectMessage value)  $default,){
final _that = this;
switch (_that) {
case _DirectMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DirectMessage value)?  $default,){
final _that = this;
switch (_that) {
case _DirectMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? conversationId,  String? senderId,  String? senderName,  String? senderPhotoUrl,  String? receiverId,  String? receiverName,  String? receiverPhotoUrl,  String? content,  MessageType? type,  List<String>? attachmentUrls,  bool? isRead, @timestampKey  DateTime? readAt, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DirectMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderName,_that.senderPhotoUrl,_that.receiverId,_that.receiverName,_that.receiverPhotoUrl,_that.content,_that.type,_that.attachmentUrls,_that.isRead,_that.readAt,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? conversationId,  String? senderId,  String? senderName,  String? senderPhotoUrl,  String? receiverId,  String? receiverName,  String? receiverPhotoUrl,  String? content,  MessageType? type,  List<String>? attachmentUrls,  bool? isRead, @timestampKey  DateTime? readAt, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _DirectMessage():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderName,_that.senderPhotoUrl,_that.receiverId,_that.receiverName,_that.receiverPhotoUrl,_that.content,_that.type,_that.attachmentUrls,_that.isRead,_that.readAt,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? conversationId,  String? senderId,  String? senderName,  String? senderPhotoUrl,  String? receiverId,  String? receiverName,  String? receiverPhotoUrl,  String? content,  MessageType? type,  List<String>? attachmentUrls,  bool? isRead, @timestampKey  DateTime? readAt, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _DirectMessage() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderName,_that.senderPhotoUrl,_that.receiverId,_that.receiverName,_that.receiverPhotoUrl,_that.content,_that.type,_that.attachmentUrls,_that.isRead,_that.readAt,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DirectMessage implements DirectMessage {
  const _DirectMessage({this.id, this.conversationId, this.senderId, this.senderName, this.senderPhotoUrl, this.receiverId, this.receiverName, this.receiverPhotoUrl, this.content, this.type, final  List<String>? attachmentUrls, this.isRead, @timestampKey this.readAt, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt}): _attachmentUrls = attachmentUrls;
  factory _DirectMessage.fromJson(Map<String, dynamic> json) => _$DirectMessageFromJson(json);

@override final  String? id;
@override final  String? conversationId;
@override final  String? senderId;
@override final  String? senderName;
@override final  String? senderPhotoUrl;
@override final  String? receiverId;
@override final  String? receiverName;
@override final  String? receiverPhotoUrl;
@override final  String? content;
@override final  MessageType? type;
 final  List<String>? _attachmentUrls;
@override List<String>? get attachmentUrls {
  final value = _attachmentUrls;
  if (value == null) return null;
  if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  bool? isRead;
@override@timestampKey final  DateTime? readAt;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of DirectMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DirectMessageCopyWith<_DirectMessage> get copyWith => __$DirectMessageCopyWithImpl<_DirectMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DirectMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DirectMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderPhotoUrl, senderPhotoUrl) || other.senderPhotoUrl == senderPhotoUrl)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverName, receiverName) || other.receiverName == receiverName)&&(identical(other.receiverPhotoUrl, receiverPhotoUrl) || other.receiverPhotoUrl == receiverPhotoUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._attachmentUrls, _attachmentUrls)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderName,senderPhotoUrl,receiverId,receiverName,receiverPhotoUrl,content,type,const DeepCollectionEquality().hash(_attachmentUrls),isRead,readAt,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'DirectMessage(id: $id, conversationId: $conversationId, senderId: $senderId, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, receiverId: $receiverId, receiverName: $receiverName, receiverPhotoUrl: $receiverPhotoUrl, content: $content, type: $type, attachmentUrls: $attachmentUrls, isRead: $isRead, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$DirectMessageCopyWith<$Res> implements $DirectMessageCopyWith<$Res> {
  factory _$DirectMessageCopyWith(_DirectMessage value, $Res Function(_DirectMessage) _then) = __$DirectMessageCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? conversationId, String? senderId, String? senderName, String? senderPhotoUrl, String? receiverId, String? receiverName, String? receiverPhotoUrl, String? content, MessageType? type, List<String>? attachmentUrls, bool? isRead,@timestampKey DateTime? readAt,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$DirectMessageCopyWithImpl<$Res>
    implements _$DirectMessageCopyWith<$Res> {
  __$DirectMessageCopyWithImpl(this._self, this._then);

  final _DirectMessage _self;
  final $Res Function(_DirectMessage) _then;

/// Create a copy of DirectMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? conversationId = freezed,Object? senderId = freezed,Object? senderName = freezed,Object? senderPhotoUrl = freezed,Object? receiverId = freezed,Object? receiverName = freezed,Object? receiverPhotoUrl = freezed,Object? content = freezed,Object? type = freezed,Object? attachmentUrls = freezed,Object? isRead = freezed,Object? readAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_DirectMessage(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,senderPhotoUrl: freezed == senderPhotoUrl ? _self.senderPhotoUrl : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,receiverId: freezed == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String?,receiverName: freezed == receiverName ? _self.receiverName : receiverName // ignore: cast_nullable_to_non_nullable
as String?,receiverPhotoUrl: freezed == receiverPhotoUrl ? _self.receiverPhotoUrl : receiverPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType?,attachmentUrls: freezed == attachmentUrls ? _self._attachmentUrls : attachmentUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,isRead: freezed == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Conversation {

 String? get id; List<String>? get participantIds; List<String>? get participantNames; List<String>? get participantPhotoUrls; String? get lastMessageContent; String? get lastMessageSenderId;@timestampKey DateTime? get lastMessageAt; Map<String, int>? get unreadCounts;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationCopyWith<Conversation> get copyWith => _$ConversationCopyWithImpl<Conversation>(this as Conversation, _$identity);

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Conversation&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.participantIds, participantIds)&&const DeepCollectionEquality().equals(other.participantNames, participantNames)&&const DeepCollectionEquality().equals(other.participantPhotoUrls, participantPhotoUrls)&&(identical(other.lastMessageContent, lastMessageContent) || other.lastMessageContent == lastMessageContent)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other.unreadCounts, unreadCounts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(participantIds),const DeepCollectionEquality().hash(participantNames),const DeepCollectionEquality().hash(participantPhotoUrls),lastMessageContent,lastMessageSenderId,lastMessageAt,const DeepCollectionEquality().hash(unreadCounts),createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Conversation(id: $id, participantIds: $participantIds, participantNames: $participantNames, participantPhotoUrls: $participantPhotoUrls, lastMessageContent: $lastMessageContent, lastMessageSenderId: $lastMessageSenderId, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res>  {
  factory $ConversationCopyWith(Conversation value, $Res Function(Conversation) _then) = _$ConversationCopyWithImpl;
@useResult
$Res call({
 String? id, List<String>? participantIds, List<String>? participantNames, List<String>? participantPhotoUrls, String? lastMessageContent, String? lastMessageSenderId,@timestampKey DateTime? lastMessageAt, Map<String, int>? unreadCounts,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$ConversationCopyWithImpl<$Res>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? participantIds = freezed,Object? participantNames = freezed,Object? participantPhotoUrls = freezed,Object? lastMessageContent = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,participantIds: freezed == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>?,participantNames: freezed == participantNames ? _self.participantNames : participantNames // ignore: cast_nullable_to_non_nullable
as List<String>?,participantPhotoUrls: freezed == participantPhotoUrls ? _self.participantPhotoUrls : participantPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,lastMessageContent: freezed == lastMessageContent ? _self.lastMessageContent : lastMessageContent // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCounts: freezed == unreadCounts ? _self.unreadCounts : unreadCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Conversation].
extension ConversationPatterns on Conversation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Conversation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Conversation value)  $default,){
final _that = this;
switch (_that) {
case _Conversation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Conversation value)?  $default,){
final _that = this;
switch (_that) {
case _Conversation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  List<String>? participantIds,  List<String>? participantNames,  List<String>? participantPhotoUrls,  String? lastMessageContent,  String? lastMessageSenderId, @timestampKey  DateTime? lastMessageAt,  Map<String, int>? unreadCounts, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.participantIds,_that.participantNames,_that.participantPhotoUrls,_that.lastMessageContent,_that.lastMessageSenderId,_that.lastMessageAt,_that.unreadCounts,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  List<String>? participantIds,  List<String>? participantNames,  List<String>? participantPhotoUrls,  String? lastMessageContent,  String? lastMessageSenderId, @timestampKey  DateTime? lastMessageAt,  Map<String, int>? unreadCounts, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Conversation():
return $default(_that.id,_that.participantIds,_that.participantNames,_that.participantPhotoUrls,_that.lastMessageContent,_that.lastMessageSenderId,_that.lastMessageAt,_that.unreadCounts,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  List<String>? participantIds,  List<String>? participantNames,  List<String>? participantPhotoUrls,  String? lastMessageContent,  String? lastMessageSenderId, @timestampKey  DateTime? lastMessageAt,  Map<String, int>? unreadCounts, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Conversation() when $default != null:
return $default(_that.id,_that.participantIds,_that.participantNames,_that.participantPhotoUrls,_that.lastMessageContent,_that.lastMessageSenderId,_that.lastMessageAt,_that.unreadCounts,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Conversation implements Conversation {
  const _Conversation({this.id, final  List<String>? participantIds, final  List<String>? participantNames, final  List<String>? participantPhotoUrls, this.lastMessageContent, this.lastMessageSenderId, @timestampKey this.lastMessageAt, final  Map<String, int>? unreadCounts, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt}): _participantIds = participantIds,_participantNames = participantNames,_participantPhotoUrls = participantPhotoUrls,_unreadCounts = unreadCounts;
  factory _Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

@override final  String? id;
 final  List<String>? _participantIds;
@override List<String>? get participantIds {
  final value = _participantIds;
  if (value == null) return null;
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _participantNames;
@override List<String>? get participantNames {
  final value = _participantNames;
  if (value == null) return null;
  if (_participantNames is EqualUnmodifiableListView) return _participantNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _participantPhotoUrls;
@override List<String>? get participantPhotoUrls {
  final value = _participantPhotoUrls;
  if (value == null) return null;
  if (_participantPhotoUrls is EqualUnmodifiableListView) return _participantPhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? lastMessageContent;
@override final  String? lastMessageSenderId;
@override@timestampKey final  DateTime? lastMessageAt;
 final  Map<String, int>? _unreadCounts;
@override Map<String, int>? get unreadCounts {
  final value = _unreadCounts;
  if (value == null) return null;
  if (_unreadCounts is EqualUnmodifiableMapView) return _unreadCounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationCopyWith<_Conversation> get copyWith => __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Conversation&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds)&&const DeepCollectionEquality().equals(other._participantNames, _participantNames)&&const DeepCollectionEquality().equals(other._participantPhotoUrls, _participantPhotoUrls)&&(identical(other.lastMessageContent, lastMessageContent) || other.lastMessageContent == lastMessageContent)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other._unreadCounts, _unreadCounts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_participantIds),const DeepCollectionEquality().hash(_participantNames),const DeepCollectionEquality().hash(_participantPhotoUrls),lastMessageContent,lastMessageSenderId,lastMessageAt,const DeepCollectionEquality().hash(_unreadCounts),createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Conversation(id: $id, participantIds: $participantIds, participantNames: $participantNames, participantPhotoUrls: $participantPhotoUrls, lastMessageContent: $lastMessageContent, lastMessageSenderId: $lastMessageSenderId, lastMessageAt: $lastMessageAt, unreadCounts: $unreadCounts, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res> implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(_Conversation value, $Res Function(_Conversation) _then) = __$ConversationCopyWithImpl;
@override @useResult
$Res call({
 String? id, List<String>? participantIds, List<String>? participantNames, List<String>? participantPhotoUrls, String? lastMessageContent, String? lastMessageSenderId,@timestampKey DateTime? lastMessageAt, Map<String, int>? unreadCounts,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

/// Create a copy of Conversation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? participantIds = freezed,Object? participantNames = freezed,Object? participantPhotoUrls = freezed,Object? lastMessageContent = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageAt = freezed,Object? unreadCounts = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_Conversation(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,participantIds: freezed == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>?,participantNames: freezed == participantNames ? _self._participantNames : participantNames // ignore: cast_nullable_to_non_nullable
as List<String>?,participantPhotoUrls: freezed == participantPhotoUrls ? _self._participantPhotoUrls : participantPhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,lastMessageContent: freezed == lastMessageContent ? _self.lastMessageContent : lastMessageContent // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,unreadCounts: freezed == unreadCounts ? _self._unreadCounts : unreadCounts // ignore: cast_nullable_to_non_nullable
as Map<String, int>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
