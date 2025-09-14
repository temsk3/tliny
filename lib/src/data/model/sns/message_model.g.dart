// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectMessageImpl _$$DirectMessageImplFromJson(Map<String, dynamic> json) =>
    _$DirectMessageImpl(
      id: json['id'] as String?,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderPhotoUrl: json['senderPhotoUrl'] as String?,
      receiverId: json['receiverId'] as String,
      receiverName: json['receiverName'] as String,
      receiverPhotoUrl: json['receiverPhotoUrl'] as String?,
      content: json['content'] as String,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      attachmentUrls:
          (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      isRead: json['isRead'] as bool?,
      readAt: dateFromTimestampValue(json['readAt']),
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$DirectMessageImplToJson(_$DirectMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderPhotoUrl': instance.senderPhotoUrl,
      'receiverId': instance.receiverId,
      'receiverName': instance.receiverName,
      'receiverPhotoUrl': instance.receiverPhotoUrl,
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type],
      'attachmentUrls': instance.attachmentUrls,
      'isRead': instance.isRead,
      'readAt': timestampFromDateValue(instance.readAt),
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.file: 'file',
  MessageType.eventShare: 'event_share',
  MessageType.productShare: 'product_share',
};

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String?,
      participantIds:
          (json['participantIds'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      participantNames:
          (json['participantNames'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      participantPhotoUrls:
          (json['participantPhotoUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      lastMessageContent: json['lastMessageContent'] as String?,
      lastMessageSenderId: json['lastMessageSenderId'] as String?,
      lastMessageAt: dateFromTimestampValue(json['lastMessageAt']),
      unreadCounts: (json['unreadCounts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participantIds': instance.participantIds,
      'participantNames': instance.participantNames,
      'participantPhotoUrls': instance.participantPhotoUrls,
      'lastMessageContent': instance.lastMessageContent,
      'lastMessageSenderId': instance.lastMessageSenderId,
      'lastMessageAt': timestampFromDateValue(instance.lastMessageAt),
      'unreadCounts': instance.unreadCounts,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
