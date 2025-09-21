// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_reference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocRefModel {

@DocumentReferenceNullStringConverter() String? get docRef;
/// Create a copy of DocRefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DocRefModelCopyWith<DocRefModel> get copyWith => _$DocRefModelCopyWithImpl<DocRefModel>(this as DocRefModel, _$identity);

  /// Serializes this DocRefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DocRefModel&&(identical(other.docRef, docRef) || other.docRef == docRef));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docRef);

@override
String toString() {
  return 'DocRefModel(docRef: $docRef)';
}


}

/// @nodoc
abstract mixin class $DocRefModelCopyWith<$Res>  {
  factory $DocRefModelCopyWith(DocRefModel value, $Res Function(DocRefModel) _then) = _$DocRefModelCopyWithImpl;
@useResult
$Res call({
@DocumentReferenceNullStringConverter() String? docRef
});




}
/// @nodoc
class _$DocRefModelCopyWithImpl<$Res>
    implements $DocRefModelCopyWith<$Res> {
  _$DocRefModelCopyWithImpl(this._self, this._then);

  final DocRefModel _self;
  final $Res Function(DocRefModel) _then;

/// Create a copy of DocRefModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? docRef = freezed,}) {
  return _then(_self.copyWith(
docRef: freezed == docRef ? _self.docRef : docRef // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DocRefModel].
extension DocRefModelPatterns on DocRefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DocRefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DocRefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DocRefModel value)  $default,){
final _that = this;
switch (_that) {
case _DocRefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DocRefModel value)?  $default,){
final _that = this;
switch (_that) {
case _DocRefModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@DocumentReferenceNullStringConverter()  String? docRef)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DocRefModel() when $default != null:
return $default(_that.docRef);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@DocumentReferenceNullStringConverter()  String? docRef)  $default,) {final _that = this;
switch (_that) {
case _DocRefModel():
return $default(_that.docRef);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@DocumentReferenceNullStringConverter()  String? docRef)?  $default,) {final _that = this;
switch (_that) {
case _DocRefModel() when $default != null:
return $default(_that.docRef);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DocRefModel implements DocRefModel {
   _DocRefModel(@DocumentReferenceNullStringConverter() this.docRef);
  factory _DocRefModel.fromJson(Map<String, dynamic> json) => _$DocRefModelFromJson(json);

@override@DocumentReferenceNullStringConverter() final  String? docRef;

/// Create a copy of DocRefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DocRefModelCopyWith<_DocRefModel> get copyWith => __$DocRefModelCopyWithImpl<_DocRefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DocRefModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DocRefModel&&(identical(other.docRef, docRef) || other.docRef == docRef));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,docRef);

@override
String toString() {
  return 'DocRefModel(docRef: $docRef)';
}


}

/// @nodoc
abstract mixin class _$DocRefModelCopyWith<$Res> implements $DocRefModelCopyWith<$Res> {
  factory _$DocRefModelCopyWith(_DocRefModel value, $Res Function(_DocRefModel) _then) = __$DocRefModelCopyWithImpl;
@override @useResult
$Res call({
@DocumentReferenceNullStringConverter() String? docRef
});




}
/// @nodoc
class __$DocRefModelCopyWithImpl<$Res>
    implements _$DocRefModelCopyWith<$Res> {
  __$DocRefModelCopyWithImpl(this._self, this._then);

  final _DocRefModel _self;
  final $Res Function(_DocRefModel) _then;

/// Create a copy of DocRefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? docRef = freezed,}) {
  return _then(_DocRefModel(
freezed == docRef ? _self.docRef : docRef // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
