// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../util/json_converter.dart';

part 'follow_model.freezed.dart';
part 'follow_model.g.dart';

@freezed
class Follow with _$Follow {
  const factory Follow({
    String? id,
    required String followerId,
    required String followerName,
    String? followerPhotoUrl,
    required String followingId,
    required String followingName,
    String? followingPhotoUrl,
    FollowStatus? status,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Follow;

  factory Follow.fromJson(Map<String, dynamic> json) => _$FollowFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    String? id,
    required String userId,
    String? displayName,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    bool? isPrivate,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => 
      _$UserProfileFromJson(json);
}

enum FollowStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('blocked')
  blocked,
}