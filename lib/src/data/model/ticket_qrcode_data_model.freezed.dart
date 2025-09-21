// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_qrcode_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketQRCodeDataModel {

 String? get id; String get codeData; bool get isActive;@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt;@TimestampConverter() DateTime? get deletedAt;
/// Create a copy of TicketQRCodeDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketQRCodeDataModelCopyWith<TicketQRCodeDataModel> get copyWith => _$TicketQRCodeDataModelCopyWithImpl<TicketQRCodeDataModel>(this as TicketQRCodeDataModel, _$identity);

  /// Serializes this TicketQRCodeDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketQRCodeDataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.codeData, codeData) || other.codeData == codeData)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,codeData,isActive,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'TicketQRCodeDataModel(id: $id, codeData: $codeData, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $TicketQRCodeDataModelCopyWith<$Res>  {
  factory $TicketQRCodeDataModelCopyWith(TicketQRCodeDataModel value, $Res Function(TicketQRCodeDataModel) _then) = _$TicketQRCodeDataModelCopyWithImpl;
@useResult
$Res call({
 String? id, String codeData, bool isActive,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? deletedAt
});




}
/// @nodoc
class _$TicketQRCodeDataModelCopyWithImpl<$Res>
    implements $TicketQRCodeDataModelCopyWith<$Res> {
  _$TicketQRCodeDataModelCopyWithImpl(this._self, this._then);

  final TicketQRCodeDataModel _self;
  final $Res Function(TicketQRCodeDataModel) _then;

/// Create a copy of TicketQRCodeDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? codeData = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,codeData: null == codeData ? _self.codeData : codeData // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketQRCodeDataModel].
extension TicketQRCodeDataModelPatterns on TicketQRCodeDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketQRCodeDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketQRCodeDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketQRCodeDataModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketQRCodeDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketQRCodeDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketQRCodeDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String codeData,  bool isActive, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketQRCodeDataModel() when $default != null:
return $default(_that.id,_that.codeData,_that.isActive,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String codeData,  bool isActive, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _TicketQRCodeDataModel():
return $default(_that.id,_that.codeData,_that.isActive,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String codeData,  bool isActive, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketQRCodeDataModel() when $default != null:
return $default(_that.id,_that.codeData,_that.isActive,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketQRCodeDataModel implements TicketQRCodeDataModel {
   _TicketQRCodeDataModel({this.id, required this.codeData, this.isActive = true, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, @TimestampConverter() this.deletedAt});
  factory _TicketQRCodeDataModel.fromJson(Map<String, dynamic> json) => _$TicketQRCodeDataModelFromJson(json);

@override final  String? id;
@override final  String codeData;
@override@JsonKey() final  bool isActive;
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override@TimestampConverter() final  DateTime? deletedAt;

/// Create a copy of TicketQRCodeDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketQRCodeDataModelCopyWith<_TicketQRCodeDataModel> get copyWith => __$TicketQRCodeDataModelCopyWithImpl<_TicketQRCodeDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketQRCodeDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketQRCodeDataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.codeData, codeData) || other.codeData == codeData)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,codeData,isActive,createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'TicketQRCodeDataModel(id: $id, codeData: $codeData, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketQRCodeDataModelCopyWith<$Res> implements $TicketQRCodeDataModelCopyWith<$Res> {
  factory _$TicketQRCodeDataModelCopyWith(_TicketQRCodeDataModel value, $Res Function(_TicketQRCodeDataModel) _then) = __$TicketQRCodeDataModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String codeData, bool isActive,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? deletedAt
});




}
/// @nodoc
class __$TicketQRCodeDataModelCopyWithImpl<$Res>
    implements _$TicketQRCodeDataModelCopyWith<$Res> {
  __$TicketQRCodeDataModelCopyWithImpl(this._self, this._then);

  final _TicketQRCodeDataModel _self;
  final $Res Function(_TicketQRCodeDataModel) _then;

/// Create a copy of TicketQRCodeDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? codeData = null,Object? isActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_TicketQRCodeDataModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,codeData: null == codeData ? _self.codeData : codeData // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
