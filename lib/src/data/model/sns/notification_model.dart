// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../util/json_converter.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class AppNotification with _$AppNotification {
  const factory AppNotification({
    String? id,
    String? userId,
    String? title,
    String? message,
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
    @timestampKey DateTime? deletedAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}

@freezed
class ShareActivity with _$ShareActivity {
  const factory ShareActivity({
    String? id,
    String? userId,
    String? userName,
    String? userPhotoUrl,
    String? contentId,
    String? contentType,
    SharePlatform? platform,
    String? sharedUrl,
    @timestampKey DateTime? createdAt,
  }) = _ShareActivity;

  factory ShareActivity.fromJson(Map<String, dynamic> json) =>
      _$ShareActivityFromJson(json);
}

enum NotificationType {
  @JsonValue('follow')
  follow,
  @JsonValue('like')
  like,
  @JsonValue('comment')
  comment,
  @JsonValue('message')
  message,
  @JsonValue('event_reminder')
  eventReminder,
  @JsonValue('purchase_confirmation')
  purchaseConfirmation,
  @JsonValue('ticket_issued')
  ticketIssued,
  @JsonValue('payment_success')
  paymentSuccess,
  @JsonValue('payment_failed')
  paymentFailed,
}

enum SharePlatform {
  @JsonValue('twitter')
  twitter,
  @JsonValue('facebook')
  facebook,
  @JsonValue('instagram')
  instagram,
  @JsonValue('line')
  line,
  @JsonValue('native_share')
  nativeShare,
}
