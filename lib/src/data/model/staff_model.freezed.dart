// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Staff {

 String? get id; String? get displayName; String? get name; String? get email; bool? get isCreated; bool? get isRetrieve; bool? get isUpdated; bool? get isDeleted;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt; bool? get isActive;
/// Create a copy of Staff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffCopyWith<Staff> get copyWith => _$StaffCopyWithImpl<Staff>(this as Staff, _$identity);

  /// Serializes this Staff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Staff&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.isCreated, isCreated) || other.isCreated == isCreated)&&(identical(other.isRetrieve, isRetrieve) || other.isRetrieve == isRetrieve)&&(identical(other.isUpdated, isUpdated) || other.isUpdated == isUpdated)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,name,email,isCreated,isRetrieve,isUpdated,isDeleted,createdAt,updatedAt,deletedAt,isActive);

@override
String toString() {
  return 'Staff(id: $id, displayName: $displayName, name: $name, email: $email, isCreated: $isCreated, isRetrieve: $isRetrieve, isUpdated: $isUpdated, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $StaffCopyWith<$Res>  {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) _then) = _$StaffCopyWithImpl;
@useResult
$Res call({
 String? id, String? displayName, String? name, String? email, bool? isCreated, bool? isRetrieve, bool? isUpdated, bool? isDeleted,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt, bool? isActive
});




}
/// @nodoc
class _$StaffCopyWithImpl<$Res>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._self, this._then);

  final Staff _self;
  final $Res Function(Staff) _then;

/// Create a copy of Staff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? displayName = freezed,Object? name = freezed,Object? email = freezed,Object? isCreated = freezed,Object? isRetrieve = freezed,Object? isUpdated = freezed,Object? isDeleted = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,Object? isActive = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isCreated: freezed == isCreated ? _self.isCreated : isCreated // ignore: cast_nullable_to_non_nullable
as bool?,isRetrieve: freezed == isRetrieve ? _self.isRetrieve : isRetrieve // ignore: cast_nullable_to_non_nullable
as bool?,isUpdated: freezed == isUpdated ? _self.isUpdated : isUpdated // ignore: cast_nullable_to_non_nullable
as bool?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [Staff].
extension StaffPatterns on Staff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Staff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Staff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Staff value)  $default,){
final _that = this;
switch (_that) {
case _Staff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Staff value)?  $default,){
final _that = this;
switch (_that) {
case _Staff() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? displayName,  String? name,  String? email,  bool? isCreated,  bool? isRetrieve,  bool? isUpdated,  bool? isDeleted, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt,  bool? isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Staff() when $default != null:
return $default(_that.id,_that.displayName,_that.name,_that.email,_that.isCreated,_that.isRetrieve,_that.isUpdated,_that.isDeleted,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? displayName,  String? name,  String? email,  bool? isCreated,  bool? isRetrieve,  bool? isUpdated,  bool? isDeleted, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt,  bool? isActive)  $default,) {final _that = this;
switch (_that) {
case _Staff():
return $default(_that.id,_that.displayName,_that.name,_that.email,_that.isCreated,_that.isRetrieve,_that.isUpdated,_that.isDeleted,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? displayName,  String? name,  String? email,  bool? isCreated,  bool? isRetrieve,  bool? isUpdated,  bool? isDeleted, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt,  bool? isActive)?  $default,) {final _that = this;
switch (_that) {
case _Staff() when $default != null:
return $default(_that.id,_that.displayName,_that.name,_that.email,_that.isCreated,_that.isRetrieve,_that.isUpdated,_that.isDeleted,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Staff extends Staff {
  const _Staff({this.id, required this.displayName, required this.name, required this.email, this.isCreated = true, this.isRetrieve = true, this.isUpdated = true, this.isDeleted = true, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt, this.isActive = false}): super._();
  factory _Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

@override final  String? id;
@override final  String? displayName;
@override final  String? name;
@override final  String? email;
@override@JsonKey() final  bool? isCreated;
@override@JsonKey() final  bool? isRetrieve;
@override@JsonKey() final  bool? isUpdated;
@override@JsonKey() final  bool? isDeleted;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;
@override@JsonKey() final  bool? isActive;

/// Create a copy of Staff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffCopyWith<_Staff> get copyWith => __$StaffCopyWithImpl<_Staff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Staff&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.isCreated, isCreated) || other.isCreated == isCreated)&&(identical(other.isRetrieve, isRetrieve) || other.isRetrieve == isRetrieve)&&(identical(other.isUpdated, isUpdated) || other.isUpdated == isUpdated)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,name,email,isCreated,isRetrieve,isUpdated,isDeleted,createdAt,updatedAt,deletedAt,isActive);

@override
String toString() {
  return 'Staff(id: $id, displayName: $displayName, name: $name, email: $email, isCreated: $isCreated, isRetrieve: $isRetrieve, isUpdated: $isUpdated, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$StaffCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$StaffCopyWith(_Staff value, $Res Function(_Staff) _then) = __$StaffCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? displayName, String? name, String? email, bool? isCreated, bool? isRetrieve, bool? isUpdated, bool? isDeleted,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt, bool? isActive
});




}
/// @nodoc
class __$StaffCopyWithImpl<$Res>
    implements _$StaffCopyWith<$Res> {
  __$StaffCopyWithImpl(this._self, this._then);

  final _Staff _self;
  final $Res Function(_Staff) _then;

/// Create a copy of Staff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? displayName = freezed,Object? name = freezed,Object? email = freezed,Object? isCreated = freezed,Object? isRetrieve = freezed,Object? isUpdated = freezed,Object? isDeleted = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,Object? isActive = freezed,}) {
  return _then(_Staff(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,isCreated: freezed == isCreated ? _self.isCreated : isCreated // ignore: cast_nullable_to_non_nullable
as bool?,isRetrieve: freezed == isRetrieve ? _self.isRetrieve : isRetrieve // ignore: cast_nullable_to_non_nullable
as bool?,isUpdated: freezed == isUpdated ? _self.isUpdated : isUpdated // ignore: cast_nullable_to_non_nullable
as bool?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
