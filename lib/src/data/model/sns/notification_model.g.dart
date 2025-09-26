// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      type: $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
      actionUserId: json['actionUserId'] as String?,
      actionUserName: json['actionUserName'] as String?,
      actionUserPhotoUrl: json['actionUserPhotoUrl'] as String?,
      targetId: json['targetId'] as String?,
      targetType: json['targetType'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      isRead: json['isRead'] as bool?,
      readAt: dateFromTimestampValue(json['readAt']),
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'message': instance.message,
      'type': _$NotificationTypeEnumMap[instance.type],
      'actionUserId': instance.actionUserId,
      'actionUserName': instance.actionUserName,
      'actionUserPhotoUrl': instance.actionUserPhotoUrl,
      'targetId': instance.targetId,
      'targetType': instance.targetType,
      'metadata': instance.metadata,
      'isRead': instance.isRead,
      'readAt': timestampFromDateValue(instance.readAt),
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.follow: 'follow',
  NotificationType.like: 'like',
  NotificationType.comment: 'comment',
  NotificationType.message: 'message',
  NotificationType.eventReminder: 'event_reminder',
  NotificationType.purchaseConfirmation: 'purchase_confirmation',
  NotificationType.ticketIssued: 'ticket_issued',
  NotificationType.paymentSuccess: 'payment_success',
  NotificationType.paymentFailed: 'payment_failed',
};

_ShareActivity _$ShareActivityFromJson(Map<String, dynamic> json) =>
    _ShareActivity(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      contentId: json['contentId'] as String?,
      contentType: json['contentType'] as String?,
      platform: $enumDecodeNullable(_$SharePlatformEnumMap, json['platform']),
      sharedUrl: json['sharedUrl'] as String?,
      createdAt: dateFromTimestampValue(json['createdAt']),
    );

Map<String, dynamic> _$ShareActivityToJson(_ShareActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhotoUrl': instance.userPhotoUrl,
      'contentId': instance.contentId,
      'contentType': instance.contentType,
      'platform': _$SharePlatformEnumMap[instance.platform],
      'sharedUrl': instance.sharedUrl,
      'createdAt': timestampFromDateValue(instance.createdAt),
    };

const _$SharePlatformEnumMap = {
  SharePlatform.twitter: 'twitter',
  SharePlatform.facebook: 'facebook',
  SharePlatform.instagram: 'instagram',
  SharePlatform.line: 'line',
  SharePlatform.nativeShare: 'native_share',
};
