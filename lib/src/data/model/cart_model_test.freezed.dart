// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_model_test.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartTest {

 String? get id; int get quantity; String? get productId;
/// Create a copy of CartTest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartTestCopyWith<CartTest> get copyWith => _$CartTestCopyWithImpl<CartTest>(this as CartTest, _$identity);

  /// Serializes this CartTest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartTest&&(identical(other.id, id) || other.id == id)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.productId, productId) || other.productId == productId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quantity,productId);

@override
String toString() {
  return 'CartTest(id: $id, quantity: $quantity, productId: $productId)';
}


}

/// @nodoc
abstract mixin class $CartTestCopyWith<$Res>  {
  factory $CartTestCopyWith(CartTest value, $Res Function(CartTest) _then) = _$CartTestCopyWithImpl;
@useResult
$Res call({
 String? id, int quantity, String? productId
});




}
/// @nodoc
class _$CartTestCopyWithImpl<$Res>
    implements $CartTestCopyWith<$Res> {
  _$CartTestCopyWithImpl(this._self, this._then);

  final CartTest _self;
  final $Res Function(CartTest) _then;

/// Create a copy of CartTest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? quantity = null,Object? productId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CartTest].
extension CartTestPatterns on CartTest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartTest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartTest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartTest value)  $default,){
final _that = this;
switch (_that) {
case _CartTest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartTest value)?  $default,){
final _that = this;
switch (_that) {
case _CartTest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  int quantity,  String? productId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartTest() when $default != null:
return $default(_that.id,_that.quantity,_that.productId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  int quantity,  String? productId)  $default,) {final _that = this;
switch (_that) {
case _CartTest():
return $default(_that.id,_that.quantity,_that.productId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  int quantity,  String? productId)?  $default,) {final _that = this;
switch (_that) {
case _CartTest() when $default != null:
return $default(_that.id,_that.quantity,_that.productId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartTest extends CartTest {
  const _CartTest({this.id, required this.quantity, this.productId}): super._();
  factory _CartTest.fromJson(Map<String, dynamic> json) => _$CartTestFromJson(json);

@override final  String? id;
@override final  int quantity;
@override final  String? productId;

/// Create a copy of CartTest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartTestCopyWith<_CartTest> get copyWith => __$CartTestCopyWithImpl<_CartTest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartTestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartTest&&(identical(other.id, id) || other.id == id)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.productId, productId) || other.productId == productId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quantity,productId);

@override
String toString() {
  return 'CartTest(id: $id, quantity: $quantity, productId: $productId)';
}


}

/// @nodoc
abstract mixin class _$CartTestCopyWith<$Res> implements $CartTestCopyWith<$Res> {
  factory _$CartTestCopyWith(_CartTest value, $Res Function(_CartTest) _then) = __$CartTestCopyWithImpl;
@override @useResult
$Res call({
 String? id, int quantity, String? productId
});




}
/// @nodoc
class __$CartTestCopyWithImpl<$Res>
    implements _$CartTestCopyWith<$Res> {
  __$CartTestCopyWithImpl(this._self, this._then);

  final _CartTest _self;
  final $Res Function(_CartTest) _then;

/// Create a copy of CartTest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? quantity = null,Object? productId = freezed,}) {
  return _then(_CartTest(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
