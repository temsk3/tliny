// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../util/json_converter.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class DirectMessage with _$DirectMessage {
  const factory DirectMessage({
    String? id,
    required String conversationId,
    required String senderId,
    required String senderName,
    String? senderPhotoUrl,
    required String receiverId,
    required String receiverName,
    String? receiverPhotoUrl,
    required String content,
    MessageType? type,
    List<String>? attachmentUrls,
    bool? isRead,
    @timestampKey DateTime? readAt,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _DirectMessage;

  factory DirectMessage.fromJson(Map<String, dynamic> json) =>
      _$DirectMessageFromJson(json);
}

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    String? id,
    required List<String> participantIds,
    required List<String> participantNames,
    List<String>? participantPhotoUrls,
    String? lastMessageContent,
    String? lastMessageSenderId,
    @timestampKey DateTime? lastMessageAt,
    Map<String, int>? unreadCounts,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('file')
  file,
  @JsonValue('event_share')
  eventShare,
  @JsonValue('product_share')
  productShare,
}
