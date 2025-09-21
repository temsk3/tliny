// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {

 String? get id; String get userId; String get userName; String? get userPhotoUrl; String get content; List<String>? get imageUrls; String? get eventId; String? get productId; PostType? get type; int? get likesCount; int? get commentsCount; int? get sharesCount;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userPhotoUrl, userPhotoUrl) || other.userPhotoUrl == userPhotoUrl)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.type, type) || other.type == type)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,userPhotoUrl,content,const DeepCollectionEquality().hash(imageUrls),eventId,productId,type,likesCount,commentsCount,sharesCount,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Post(id: $id, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl, content: $content, imageUrls: $imageUrls, eventId: $eventId, productId: $productId, type: $type, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String? id, String userId, String userName, String? userPhotoUrl, String content, List<String>? imageUrls, String? eventId, String? productId, PostType? type, int? likesCount, int? commentsCount, int? sharesCount,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? userName = null,Object? userPhotoUrl = freezed,Object? content = null,Object? imageUrls = freezed,Object? eventId = freezed,Object? productId = freezed,Object? type = freezed,Object? likesCount = freezed,Object? commentsCount = freezed,Object? sharesCount = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userPhotoUrl: freezed == userPhotoUrl ? _self.userPhotoUrl : userPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrls: freezed == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PostType?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,commentsCount: freezed == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int?,sharesCount: freezed == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String userId,  String userName,  String? userPhotoUrl,  String content,  List<String>? imageUrls,  String? eventId,  String? productId,  PostType? type,  int? likesCount,  int? commentsCount,  int? sharesCount, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.userPhotoUrl,_that.content,_that.imageUrls,_that.eventId,_that.productId,_that.type,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String userId,  String userName,  String? userPhotoUrl,  String content,  List<String>? imageUrls,  String? eventId,  String? productId,  PostType? type,  int? likesCount,  int? commentsCount,  int? sharesCount, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.id,_that.userId,_that.userName,_that.userPhotoUrl,_that.content,_that.imageUrls,_that.eventId,_that.productId,_that.type,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String userId,  String userName,  String? userPhotoUrl,  String content,  List<String>? imageUrls,  String? eventId,  String? productId,  PostType? type,  int? likesCount,  int? commentsCount,  int? sharesCount, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.userPhotoUrl,_that.content,_that.imageUrls,_that.eventId,_that.productId,_that.type,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post implements Post {
  const _Post({this.id, required this.userId, required this.userName, this.userPhotoUrl, required this.content, final  List<String>? imageUrls, this.eventId, this.productId, this.type, this.likesCount, this.commentsCount, this.sharesCount, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt}): _imageUrls = imageUrls;
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

@override final  String? id;
@override final  String userId;
@override final  String userName;
@override final  String? userPhotoUrl;
@override final  String content;
 final  List<String>? _imageUrls;
@override List<String>? get imageUrls {
  final value = _imageUrls;
  if (value == null) return null;
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? eventId;
@override final  String? productId;
@override final  PostType? type;
@override final  int? likesCount;
@override final  int? commentsCount;
@override final  int? sharesCount;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userPhotoUrl, userPhotoUrl) || other.userPhotoUrl == userPhotoUrl)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.type, type) || other.type == type)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,userPhotoUrl,content,const DeepCollectionEquality().hash(_imageUrls),eventId,productId,type,likesCount,commentsCount,sharesCount,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Post(id: $id, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl, content: $content, imageUrls: $imageUrls, eventId: $eventId, productId: $productId, type: $type, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String? id, String userId, String userName, String? userPhotoUrl, String content, List<String>? imageUrls, String? eventId, String? productId, PostType? type, int? likesCount, int? commentsCount, int? sharesCount,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? userName = null,Object? userPhotoUrl = freezed,Object? content = null,Object? imageUrls = freezed,Object? eventId = freezed,Object? productId = freezed,Object? type = freezed,Object? likesCount = freezed,Object? commentsCount = freezed,Object? sharesCount = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_Post(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userPhotoUrl: freezed == userPhotoUrl ? _self.userPhotoUrl : userPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrls: freezed == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PostType?,likesCount: freezed == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int?,commentsCount: freezed == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int?,sharesCount: freezed == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PostComment {

 String? get id; String get postId; String get userId; String get userName; String? get userPhotoUrl; String get content;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCommentCopyWith<PostComment> get copyWith => _$PostCommentCopyWithImpl<PostComment>(this as PostComment, _$identity);

  /// Serializes this PostComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostComment&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userPhotoUrl, userPhotoUrl) || other.userPhotoUrl == userPhotoUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,userId,userName,userPhotoUrl,content,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'PostComment(id: $id, postId: $postId, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $PostCommentCopyWith<$Res>  {
  factory $PostCommentCopyWith(PostComment value, $Res Function(PostComment) _then) = _$PostCommentCopyWithImpl;
@useResult
$Res call({
 String? id, String postId, String userId, String userName, String? userPhotoUrl, String content,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$PostCommentCopyWithImpl<$Res>
    implements $PostCommentCopyWith<$Res> {
  _$PostCommentCopyWithImpl(this._self, this._then);

  final PostComment _self;
  final $Res Function(PostComment) _then;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? postId = null,Object? userId = null,Object? userName = null,Object? userPhotoUrl = freezed,Object? content = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userPhotoUrl: freezed == userPhotoUrl ? _self.userPhotoUrl : userPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostComment].
extension PostCommentPatterns on PostComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostComment value)  $default,){
final _that = this;
switch (_that) {
case _PostComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostComment value)?  $default,){
final _that = this;
switch (_that) {
case _PostComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String postId,  String userId,  String userName,  String? userPhotoUrl,  String content, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.userName,_that.userPhotoUrl,_that.content,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String postId,  String userId,  String userName,  String? userPhotoUrl,  String content, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _PostComment():
return $default(_that.id,_that.postId,_that.userId,_that.userName,_that.userPhotoUrl,_that.content,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String postId,  String userId,  String userName,  String? userPhotoUrl,  String content, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _PostComment() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.userName,_that.userPhotoUrl,_that.content,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostComment implements PostComment {
  const _PostComment({this.id, required this.postId, required this.userId, required this.userName, this.userPhotoUrl, required this.content, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt});
  factory _PostComment.fromJson(Map<String, dynamic> json) => _$PostCommentFromJson(json);

@override final  String? id;
@override final  String postId;
@override final  String userId;
@override final  String userName;
@override final  String? userPhotoUrl;
@override final  String content;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCommentCopyWith<_PostComment> get copyWith => __$PostCommentCopyWithImpl<_PostComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostComment&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userPhotoUrl, userPhotoUrl) || other.userPhotoUrl == userPhotoUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,userId,userName,userPhotoUrl,content,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'PostComment(id: $id, postId: $postId, userId: $userId, userName: $userName, userPhotoUrl: $userPhotoUrl, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$PostCommentCopyWith<$Res> implements $PostCommentCopyWith<$Res> {
  factory _$PostCommentCopyWith(_PostComment value, $Res Function(_PostComment) _then) = __$PostCommentCopyWithImpl;
@override @useResult
$Res call({
 String? id, String postId, String userId, String userName, String? userPhotoUrl, String content,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$PostCommentCopyWithImpl<$Res>
    implements _$PostCommentCopyWith<$Res> {
  __$PostCommentCopyWithImpl(this._self, this._then);

  final _PostComment _self;
  final $Res Function(_PostComment) _then;

/// Create a copy of PostComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? postId = null,Object? userId = null,Object? userName = null,Object? userPhotoUrl = freezed,Object? content = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_PostComment(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userPhotoUrl: freezed == userPhotoUrl ? _self.userPhotoUrl : userPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PostLike {

 String? get id; String get postId; String get userId; String get userName;@timestampKey DateTime? get createdAt;
/// Create a copy of PostLike
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostLikeCopyWith<PostLike> get copyWith => _$PostLikeCopyWithImpl<PostLike>(this as PostLike, _$identity);

  /// Serializes this PostLike to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostLike&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,userId,userName,createdAt);

@override
String toString() {
  return 'PostLike(id: $id, postId: $postId, userId: $userId, userName: $userName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PostLikeCopyWith<$Res>  {
  factory $PostLikeCopyWith(PostLike value, $Res Function(PostLike) _then) = _$PostLikeCopyWithImpl;
@useResult
$Res call({
 String? id, String postId, String userId, String userName,@timestampKey DateTime? createdAt
});




}
/// @nodoc
class _$PostLikeCopyWithImpl<$Res>
    implements $PostLikeCopyWith<$Res> {
  _$PostLikeCopyWithImpl(this._self, this._then);

  final PostLike _self;
  final $Res Function(PostLike) _then;

/// Create a copy of PostLike
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? postId = null,Object? userId = null,Object? userName = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PostLike].
extension PostLikePatterns on PostLike {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostLike value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostLike() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostLike value)  $default,){
final _that = this;
switch (_that) {
case _PostLike():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostLike value)?  $default,){
final _that = this;
switch (_that) {
case _PostLike() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String postId,  String userId,  String userName, @timestampKey  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostLike() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.userName,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String postId,  String userId,  String userName, @timestampKey  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PostLike():
return $default(_that.id,_that.postId,_that.userId,_that.userName,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String postId,  String userId,  String userName, @timestampKey  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PostLike() when $default != null:
return $default(_that.id,_that.postId,_that.userId,_that.userName,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostLike implements PostLike {
  const _PostLike({this.id, required this.postId, required this.userId, required this.userName, @timestampKey this.createdAt});
  factory _PostLike.fromJson(Map<String, dynamic> json) => _$PostLikeFromJson(json);

@override final  String? id;
@override final  String postId;
@override final  String userId;
@override final  String userName;
@override@timestampKey final  DateTime? createdAt;

/// Create a copy of PostLike
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostLikeCopyWith<_PostLike> get copyWith => __$PostLikeCopyWithImpl<_PostLike>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostLikeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostLike&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,userId,userName,createdAt);

@override
String toString() {
  return 'PostLike(id: $id, postId: $postId, userId: $userId, userName: $userName, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PostLikeCopyWith<$Res> implements $PostLikeCopyWith<$Res> {
  factory _$PostLikeCopyWith(_PostLike value, $Res Function(_PostLike) _then) = __$PostLikeCopyWithImpl;
@override @useResult
$Res call({
 String? id, String postId, String userId, String userName,@timestampKey DateTime? createdAt
});




}
/// @nodoc
class __$PostLikeCopyWithImpl<$Res>
    implements _$PostLikeCopyWith<$Res> {
  __$PostLikeCopyWithImpl(this._self, this._then);

  final _PostLike _self;
  final $Res Function(_PostLike) _then;

/// Create a copy of PostLike
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? postId = null,Object? userId = null,Object? userName = null,Object? createdAt = freezed,}) {
  return _then(_PostLike(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
