// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: json['id'] as String?,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  userPhotoUrl: json['userPhotoUrl'] as String?,
  content: json['content'] as String,
  imageUrls: (json['imageUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  eventId: json['eventId'] as String?,
  productId: json['productId'] as String?,
  type: $enumDecodeNullable(_$PostTypeEnumMap, json['type']),
  likesCount: (json['likesCount'] as num?)?.toInt(),
  commentsCount: (json['commentsCount'] as num?)?.toInt(),
  sharesCount: (json['sharesCount'] as num?)?.toInt(),
  createdAt: dateFromTimestampValue(json['createdAt']),
  updatedAt: dateFromTimestampValue(json['updatedAt']),
  deletedAt: dateFromTimestampValue(json['deletedAt']),
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'userName': instance.userName,
  'userPhotoUrl': instance.userPhotoUrl,
  'content': instance.content,
  'imageUrls': instance.imageUrls,
  'eventId': instance.eventId,
  'productId': instance.productId,
  'type': _$PostTypeEnumMap[instance.type],
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'sharesCount': instance.sharesCount,
  'createdAt': timestampFromDateValue(instance.createdAt),
  'updatedAt': timestampFromDateValue(instance.updatedAt),
  'deletedAt': timestampFromDateValue(instance.deletedAt),
};

const _$PostTypeEnumMap = {
  PostType.text: 'text',
  PostType.eventShare: 'event_share',
  PostType.productShare: 'product_share',
  PostType.image: 'image',
};

_PostComment _$PostCommentFromJson(Map<String, dynamic> json) => _PostComment(
  id: json['id'] as String?,
  postId: json['postId'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  userPhotoUrl: json['userPhotoUrl'] as String?,
  content: json['content'] as String,
  createdAt: dateFromTimestampValue(json['createdAt']),
  updatedAt: dateFromTimestampValue(json['updatedAt']),
  deletedAt: dateFromTimestampValue(json['deletedAt']),
);

Map<String, dynamic> _$PostCommentToJson(_PostComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhotoUrl': instance.userPhotoUrl,
      'content': instance.content,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };

_PostLike _$PostLikeFromJson(Map<String, dynamic> json) => _PostLike(
  id: json['id'] as String?,
  postId: json['postId'] as String,
  userId: json['userId'] as String,
  userName: json['userName'] as String,
  createdAt: dateFromTimestampValue(json['createdAt']),
);

Map<String, dynamic> _$PostLikeToJson(_PostLike instance) => <String, dynamic>{
  'id': instance.id,
  'postId': instance.postId,
  'userId': instance.userId,
  'userName': instance.userName,
  'createdAt': timestampFromDateValue(instance.createdAt),
};
