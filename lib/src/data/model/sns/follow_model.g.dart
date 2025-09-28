// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'follow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FollowImpl _$$FollowImplFromJson(Map<String, dynamic> json) => _$FollowImpl(
      id: json['id'] as String?,
      followerId: json['followerId'] as String,
      followerName: json['followerName'] as String,
      followerPhotoUrl: json['followerPhotoUrl'] as String?,
      followingId: json['followingId'] as String,
      followingName: json['followingName'] as String,
      followingPhotoUrl: json['followingPhotoUrl'] as String?,
      status: $enumDecodeNullable(_$FollowStatusEnumMap, json['status']),
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$FollowImplToJson(_$FollowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'followerId': instance.followerId,
      'followerName': instance.followerName,
      'followerPhotoUrl': instance.followerPhotoUrl,
      'followingId': instance.followingId,
      'followingName': instance.followingName,
      'followingPhotoUrl': instance.followingPhotoUrl,
      'status': _$FollowStatusEnumMap[instance.status],
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };

const _$FollowStatusEnumMap = {
  FollowStatus.pending: 'pending',
  FollowStatus.accepted: 'accepted',
  FollowStatus.blocked: 'blocked',
};

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String?,
      bio: json['bio'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      followersCount: (json['followersCount'] as num?)?.toInt(),
      followingCount: (json['followingCount'] as num?)?.toInt(),
      postsCount: (json['postsCount'] as num?)?.toInt(),
      isPrivate: json['isPrivate'] as bool?,
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'bio': instance.bio,
      'profileImageUrl': instance.profileImageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'postsCount': instance.postsCount,
      'isPrivate': instance.isPrivate,
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };
