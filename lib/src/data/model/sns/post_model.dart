// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../util/json_converter.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    String? id,
    required String userId,
    required String userName,
    String? userPhotoUrl,
    required String content,
    List<String>? imageUrls,
    String? eventId,
    String? productId,
    PostType? type,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
class PostComment with _$PostComment {
  const factory PostComment({
    String? id,
    required String postId,
    required String userId,
    required String userName,
    String? userPhotoUrl,
    required String content,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  }) = _PostComment;

  factory PostComment.fromJson(Map<String, dynamic> json) =>
      _$PostCommentFromJson(json);
}

@freezed
class PostLike with _$PostLike {
  const factory PostLike({
    String? id,
    required String postId,
    required String userId,
    required String userName,
    @timestampKey DateTime? createdAt,
  }) = _PostLike;

  factory PostLike.fromJson(Map<String, dynamic> json) =>
      _$PostLikeFromJson(json);
}

enum PostType {
  @JsonValue('text')
  text,
  @JsonValue('event_share')
  eventShare,
  @JsonValue('product_share')
  productShare,
  @JsonValue('image')
  image,
}
