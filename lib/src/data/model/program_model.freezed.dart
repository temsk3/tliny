// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Program {

 String? get id; String? get organizerId; String? get name; String? get message;@timestampKey DateTime? get salesStart;@timestampKey DateTime? get salesEnd;@timestampKey DateTime? get eventFrom;@timestampKey DateTime? get eventTo; String? get place; String? get storageId; List<String> get pictureURL;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt; bool? get isActive; bool? get isPublish;//
 bool get isSecret; String? get secretUrl; String? get staffCode; List<Staff>? get staff; List<Product>? get product;
/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgramCopyWith<Program> get copyWith => _$ProgramCopyWithImpl<Program>(this as Program, _$identity);

  /// Serializes this Program to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Program&&(identical(other.id, id) || other.id == id)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.message, message) || other.message == message)&&(identical(other.salesStart, salesStart) || other.salesStart == salesStart)&&(identical(other.salesEnd, salesEnd) || other.salesEnd == salesEnd)&&(identical(other.eventFrom, eventFrom) || other.eventFrom == eventFrom)&&(identical(other.eventTo, eventTo) || other.eventTo == eventTo)&&(identical(other.place, place) || other.place == place)&&(identical(other.storageId, storageId) || other.storageId == storageId)&&const DeepCollectionEquality().equals(other.pictureURL, pictureURL)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPublish, isPublish) || other.isPublish == isPublish)&&(identical(other.isSecret, isSecret) || other.isSecret == isSecret)&&(identical(other.secretUrl, secretUrl) || other.secretUrl == secretUrl)&&(identical(other.staffCode, staffCode) || other.staffCode == staffCode)&&const DeepCollectionEquality().equals(other.staff, staff)&&const DeepCollectionEquality().equals(other.product, product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,organizerId,name,message,salesStart,salesEnd,eventFrom,eventTo,place,storageId,const DeepCollectionEquality().hash(pictureURL),createdAt,updatedAt,deletedAt,isActive,isPublish,isSecret,secretUrl,staffCode,const DeepCollectionEquality().hash(staff),const DeepCollectionEquality().hash(product)]);

@override
String toString() {
  return 'Program(id: $id, organizerId: $organizerId, name: $name, message: $message, salesStart: $salesStart, salesEnd: $salesEnd, eventFrom: $eventFrom, eventTo: $eventTo, place: $place, storageId: $storageId, pictureURL: $pictureURL, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isActive: $isActive, isPublish: $isPublish, isSecret: $isSecret, secretUrl: $secretUrl, staffCode: $staffCode, staff: $staff, product: $product)';
}


}

/// @nodoc
abstract mixin class $ProgramCopyWith<$Res>  {
  factory $ProgramCopyWith(Program value, $Res Function(Program) _then) = _$ProgramCopyWithImpl;
@useResult
$Res call({
 String? id, String? organizerId, String? name, String? message,@timestampKey DateTime? salesStart,@timestampKey DateTime? salesEnd,@timestampKey DateTime? eventFrom,@timestampKey DateTime? eventTo, String? place, String? storageId, List<String> pictureURL,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt, bool? isActive, bool? isPublish, bool isSecret, String? secretUrl, String? staffCode, List<Staff>? staff, List<Product>? product
});




}
/// @nodoc
class _$ProgramCopyWithImpl<$Res>
    implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._self, this._then);

  final Program _self;
  final $Res Function(Program) _then;

/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? organizerId = freezed,Object? name = freezed,Object? message = freezed,Object? salesStart = freezed,Object? salesEnd = freezed,Object? eventFrom = freezed,Object? eventTo = freezed,Object? place = freezed,Object? storageId = freezed,Object? pictureURL = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,Object? isActive = freezed,Object? isPublish = freezed,Object? isSecret = null,Object? secretUrl = freezed,Object? staffCode = freezed,Object? staff = freezed,Object? product = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,salesStart: freezed == salesStart ? _self.salesStart : salesStart // ignore: cast_nullable_to_non_nullable
as DateTime?,salesEnd: freezed == salesEnd ? _self.salesEnd : salesEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,eventFrom: freezed == eventFrom ? _self.eventFrom : eventFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,eventTo: freezed == eventTo ? _self.eventTo : eventTo // ignore: cast_nullable_to_non_nullable
as DateTime?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,storageId: freezed == storageId ? _self.storageId : storageId // ignore: cast_nullable_to_non_nullable
as String?,pictureURL: null == pictureURL ? _self.pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isPublish: freezed == isPublish ? _self.isPublish : isPublish // ignore: cast_nullable_to_non_nullable
as bool?,isSecret: null == isSecret ? _self.isSecret : isSecret // ignore: cast_nullable_to_non_nullable
as bool,secretUrl: freezed == secretUrl ? _self.secretUrl : secretUrl // ignore: cast_nullable_to_non_nullable
as String?,staffCode: freezed == staffCode ? _self.staffCode : staffCode // ignore: cast_nullable_to_non_nullable
as String?,staff: freezed == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as List<Staff>?,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as List<Product>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Program].
extension ProgramPatterns on Program {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Program value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Program() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Program value)  $default,){
final _that = this;
switch (_that) {
case _Program():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Program value)?  $default,){
final _that = this;
switch (_that) {
case _Program() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? organizerId,  String? name,  String? message, @timestampKey  DateTime? salesStart, @timestampKey  DateTime? salesEnd, @timestampKey  DateTime? eventFrom, @timestampKey  DateTime? eventTo,  String? place,  String? storageId,  List<String> pictureURL, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt,  bool? isActive,  bool? isPublish,  bool isSecret,  String? secretUrl,  String? staffCode,  List<Staff>? staff,  List<Product>? product)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Program() when $default != null:
return $default(_that.id,_that.organizerId,_that.name,_that.message,_that.salesStart,_that.salesEnd,_that.eventFrom,_that.eventTo,_that.place,_that.storageId,_that.pictureURL,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isActive,_that.isPublish,_that.isSecret,_that.secretUrl,_that.staffCode,_that.staff,_that.product);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? organizerId,  String? name,  String? message, @timestampKey  DateTime? salesStart, @timestampKey  DateTime? salesEnd, @timestampKey  DateTime? eventFrom, @timestampKey  DateTime? eventTo,  String? place,  String? storageId,  List<String> pictureURL, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt,  bool? isActive,  bool? isPublish,  bool isSecret,  String? secretUrl,  String? staffCode,  List<Staff>? staff,  List<Product>? product)  $default,) {final _that = this;
switch (_that) {
case _Program():
return $default(_that.id,_that.organizerId,_that.name,_that.message,_that.salesStart,_that.salesEnd,_that.eventFrom,_that.eventTo,_that.place,_that.storageId,_that.pictureURL,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isActive,_that.isPublish,_that.isSecret,_that.secretUrl,_that.staffCode,_that.staff,_that.product);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? organizerId,  String? name,  String? message, @timestampKey  DateTime? salesStart, @timestampKey  DateTime? salesEnd, @timestampKey  DateTime? eventFrom, @timestampKey  DateTime? eventTo,  String? place,  String? storageId,  List<String> pictureURL, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt,  bool? isActive,  bool? isPublish,  bool isSecret,  String? secretUrl,  String? staffCode,  List<Staff>? staff,  List<Product>? product)?  $default,) {final _that = this;
switch (_that) {
case _Program() when $default != null:
return $default(_that.id,_that.organizerId,_that.name,_that.message,_that.salesStart,_that.salesEnd,_that.eventFrom,_that.eventTo,_that.place,_that.storageId,_that.pictureURL,_that.createdAt,_that.updatedAt,_that.deletedAt,_that.isActive,_that.isPublish,_that.isSecret,_that.secretUrl,_that.staffCode,_that.staff,_that.product);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Program extends Program {
  const _Program({this.id, required this.organizerId, required this.name, required this.message, @timestampKey required this.salesStart, @timestampKey required this.salesEnd, @timestampKey required this.eventFrom, @timestampKey required this.eventTo, required this.place, this.storageId, final  List<String> pictureURL = const [], @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt, required this.isActive, required this.isPublish, this.isSecret = false, this.secretUrl, this.staffCode, final  List<Staff>? staff, final  List<Product>? product}): _pictureURL = pictureURL,_staff = staff,_product = product,super._();
  factory _Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);

@override final  String? id;
@override final  String? organizerId;
@override final  String? name;
@override final  String? message;
@override@timestampKey final  DateTime? salesStart;
@override@timestampKey final  DateTime? salesEnd;
@override@timestampKey final  DateTime? eventFrom;
@override@timestampKey final  DateTime? eventTo;
@override final  String? place;
@override final  String? storageId;
 final  List<String> _pictureURL;
@override@JsonKey() List<String> get pictureURL {
  if (_pictureURL is EqualUnmodifiableListView) return _pictureURL;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pictureURL);
}

@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;
@override final  bool? isActive;
@override final  bool? isPublish;
//
@override@JsonKey() final  bool isSecret;
@override final  String? secretUrl;
@override final  String? staffCode;
 final  List<Staff>? _staff;
@override List<Staff>? get staff {
  final value = _staff;
  if (value == null) return null;
  if (_staff is EqualUnmodifiableListView) return _staff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Product>? _product;
@override List<Product>? get product {
  final value = _product;
  if (value == null) return null;
  if (_product is EqualUnmodifiableListView) return _product;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgramCopyWith<_Program> get copyWith => __$ProgramCopyWithImpl<_Program>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Program&&(identical(other.id, id) || other.id == id)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.message, message) || other.message == message)&&(identical(other.salesStart, salesStart) || other.salesStart == salesStart)&&(identical(other.salesEnd, salesEnd) || other.salesEnd == salesEnd)&&(identical(other.eventFrom, eventFrom) || other.eventFrom == eventFrom)&&(identical(other.eventTo, eventTo) || other.eventTo == eventTo)&&(identical(other.place, place) || other.place == place)&&(identical(other.storageId, storageId) || other.storageId == storageId)&&const DeepCollectionEquality().equals(other._pictureURL, _pictureURL)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPublish, isPublish) || other.isPublish == isPublish)&&(identical(other.isSecret, isSecret) || other.isSecret == isSecret)&&(identical(other.secretUrl, secretUrl) || other.secretUrl == secretUrl)&&(identical(other.staffCode, staffCode) || other.staffCode == staffCode)&&const DeepCollectionEquality().equals(other._staff, _staff)&&const DeepCollectionEquality().equals(other._product, _product));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,organizerId,name,message,salesStart,salesEnd,eventFrom,eventTo,place,storageId,const DeepCollectionEquality().hash(_pictureURL),createdAt,updatedAt,deletedAt,isActive,isPublish,isSecret,secretUrl,staffCode,const DeepCollectionEquality().hash(_staff),const DeepCollectionEquality().hash(_product)]);

@override
String toString() {
  return 'Program(id: $id, organizerId: $organizerId, name: $name, message: $message, salesStart: $salesStart, salesEnd: $salesEnd, eventFrom: $eventFrom, eventTo: $eventTo, place: $place, storageId: $storageId, pictureURL: $pictureURL, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isActive: $isActive, isPublish: $isPublish, isSecret: $isSecret, secretUrl: $secretUrl, staffCode: $staffCode, staff: $staff, product: $product)';
}


}

/// @nodoc
abstract mixin class _$ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$ProgramCopyWith(_Program value, $Res Function(_Program) _then) = __$ProgramCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? organizerId, String? name, String? message,@timestampKey DateTime? salesStart,@timestampKey DateTime? salesEnd,@timestampKey DateTime? eventFrom,@timestampKey DateTime? eventTo, String? place, String? storageId, List<String> pictureURL,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt, bool? isActive, bool? isPublish, bool isSecret, String? secretUrl, String? staffCode, List<Staff>? staff, List<Product>? product
});




}
/// @nodoc
class __$ProgramCopyWithImpl<$Res>
    implements _$ProgramCopyWith<$Res> {
  __$ProgramCopyWithImpl(this._self, this._then);

  final _Program _self;
  final $Res Function(_Program) _then;

/// Create a copy of Program
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? organizerId = freezed,Object? name = freezed,Object? message = freezed,Object? salesStart = freezed,Object? salesEnd = freezed,Object? eventFrom = freezed,Object? eventTo = freezed,Object? place = freezed,Object? storageId = freezed,Object? pictureURL = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,Object? isActive = freezed,Object? isPublish = freezed,Object? isSecret = null,Object? secretUrl = freezed,Object? staffCode = freezed,Object? staff = freezed,Object? product = freezed,}) {
  return _then(_Program(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,salesStart: freezed == salesStart ? _self.salesStart : salesStart // ignore: cast_nullable_to_non_nullable
as DateTime?,salesEnd: freezed == salesEnd ? _self.salesEnd : salesEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,eventFrom: freezed == eventFrom ? _self.eventFrom : eventFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,eventTo: freezed == eventTo ? _self.eventTo : eventTo // ignore: cast_nullable_to_non_nullable
as DateTime?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,storageId: freezed == storageId ? _self.storageId : storageId // ignore: cast_nullable_to_non_nullable
as String?,pictureURL: null == pictureURL ? _self._pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isPublish: freezed == isPublish ? _self.isPublish : isPublish // ignore: cast_nullable_to_non_nullable
as bool?,isSecret: null == isSecret ? _self.isSecret : isSecret // ignore: cast_nullable_to_non_nullable
as bool,secretUrl: freezed == secretUrl ? _self.secretUrl : secretUrl // ignore: cast_nullable_to_non_nullable
as String?,staffCode: freezed == staffCode ? _self.staffCode : staffCode // ignore: cast_nullable_to_non_nullable
as String?,staff: freezed == staff ? _self._staff : staff // ignore: cast_nullable_to_non_nullable
as List<Staff>?,product: freezed == product ? _self._product : product // ignore: cast_nullable_to_non_nullable
as List<Product>?,
  ));
}


}

// dart format on
