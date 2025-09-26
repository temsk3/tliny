// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_customer_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomerParams {

 AddressParams? get address; String? get description; String? get email; Map<String, dynamic>? get metadata; String? get name; String? get paymentMethod; String? get phone; ShippingParams? get shipping; String? get source;
/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerParamsCopyWith<CustomerParams> get copyWith => _$CustomerParamsCopyWithImpl<CustomerParams>(this as CustomerParams, _$identity);

  /// Serializes this CustomerParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerParams&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.name, name) || other.name == name)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,description,email,const DeepCollectionEquality().hash(metadata),name,paymentMethod,phone,shipping,source);

@override
String toString() {
  return 'CustomerParams(address: $address, description: $description, email: $email, metadata: $metadata, name: $name, paymentMethod: $paymentMethod, phone: $phone, shipping: $shipping, source: $source)';
}


}

/// @nodoc
abstract mixin class $CustomerParamsCopyWith<$Res>  {
  factory $CustomerParamsCopyWith(CustomerParams value, $Res Function(CustomerParams) _then) = _$CustomerParamsCopyWithImpl;
@useResult
$Res call({
 AddressParams? address, String? description, String? email, Map<String, dynamic>? metadata, String? name, String? paymentMethod, String? phone, ShippingParams? shipping, String? source
});


$AddressParamsCopyWith<$Res>? get address;$ShippingParamsCopyWith<$Res>? get shipping;

}
/// @nodoc
class _$CustomerParamsCopyWithImpl<$Res>
    implements $CustomerParamsCopyWith<$Res> {
  _$CustomerParamsCopyWithImpl(this._self, this._then);

  final CustomerParams _self;
  final $Res Function(CustomerParams) _then;

/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = freezed,Object? description = freezed,Object? email = freezed,Object? metadata = freezed,Object? name = freezed,Object? paymentMethod = freezed,Object? phone = freezed,Object? shipping = freezed,Object? source = freezed,}) {
  return _then(_self.copyWith(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressParams?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,shipping: freezed == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as ShippingParams?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressParamsCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressParamsCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingParamsCopyWith<$Res>? get shipping {
    if (_self.shipping == null) {
    return null;
  }

  return $ShippingParamsCopyWith<$Res>(_self.shipping!, (value) {
    return _then(_self.copyWith(shipping: value));
  });
}
}


/// Adds pattern-matching-related methods to [CustomerParams].
extension CustomerParamsPatterns on CustomerParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CustomerParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CustomerParams value)  $default,){
final _that = this;
switch (_that) {
case _CustomerParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CustomerParams value)?  $default,){
final _that = this;
switch (_that) {
case _CustomerParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AddressParams? address,  String? description,  String? email,  Map<String, dynamic>? metadata,  String? name,  String? paymentMethod,  String? phone,  ShippingParams? shipping,  String? source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerParams() when $default != null:
return $default(_that.address,_that.description,_that.email,_that.metadata,_that.name,_that.paymentMethod,_that.phone,_that.shipping,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AddressParams? address,  String? description,  String? email,  Map<String, dynamic>? metadata,  String? name,  String? paymentMethod,  String? phone,  ShippingParams? shipping,  String? source)  $default,) {final _that = this;
switch (_that) {
case _CustomerParams():
return $default(_that.address,_that.description,_that.email,_that.metadata,_that.name,_that.paymentMethod,_that.phone,_that.shipping,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AddressParams? address,  String? description,  String? email,  Map<String, dynamic>? metadata,  String? name,  String? paymentMethod,  String? phone,  ShippingParams? shipping,  String? source)?  $default,) {final _that = this;
switch (_that) {
case _CustomerParams() when $default != null:
return $default(_that.address,_that.description,_that.email,_that.metadata,_that.name,_that.paymentMethod,_that.phone,_that.shipping,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CustomerParams extends CustomerParams {
  const _CustomerParams({required this.address, required this.description, required this.email, required final  Map<String, dynamic>? metadata, required this.name, required this.paymentMethod, required this.phone, required this.shipping, required this.source}): _metadata = metadata,super._();
  factory _CustomerParams.fromJson(Map<String, dynamic> json) => _$CustomerParamsFromJson(json);

@override final  AddressParams? address;
@override final  String? description;
@override final  String? email;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? name;
@override final  String? paymentMethod;
@override final  String? phone;
@override final  ShippingParams? shipping;
@override final  String? source;

/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerParamsCopyWith<_CustomerParams> get copyWith => __$CustomerParamsCopyWithImpl<_CustomerParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CustomerParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerParams&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.name, name) || other.name == name)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.shipping, shipping) || other.shipping == shipping)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,description,email,const DeepCollectionEquality().hash(_metadata),name,paymentMethod,phone,shipping,source);

@override
String toString() {
  return 'CustomerParams(address: $address, description: $description, email: $email, metadata: $metadata, name: $name, paymentMethod: $paymentMethod, phone: $phone, shipping: $shipping, source: $source)';
}


}

/// @nodoc
abstract mixin class _$CustomerParamsCopyWith<$Res> implements $CustomerParamsCopyWith<$Res> {
  factory _$CustomerParamsCopyWith(_CustomerParams value, $Res Function(_CustomerParams) _then) = __$CustomerParamsCopyWithImpl;
@override @useResult
$Res call({
 AddressParams? address, String? description, String? email, Map<String, dynamic>? metadata, String? name, String? paymentMethod, String? phone, ShippingParams? shipping, String? source
});


@override $AddressParamsCopyWith<$Res>? get address;@override $ShippingParamsCopyWith<$Res>? get shipping;

}
/// @nodoc
class __$CustomerParamsCopyWithImpl<$Res>
    implements _$CustomerParamsCopyWith<$Res> {
  __$CustomerParamsCopyWithImpl(this._self, this._then);

  final _CustomerParams _self;
  final $Res Function(_CustomerParams) _then;

/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = freezed,Object? description = freezed,Object? email = freezed,Object? metadata = freezed,Object? name = freezed,Object? paymentMethod = freezed,Object? phone = freezed,Object? shipping = freezed,Object? source = freezed,}) {
  return _then(_CustomerParams(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressParams?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,shipping: freezed == shipping ? _self.shipping : shipping // ignore: cast_nullable_to_non_nullable
as ShippingParams?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressParamsCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressParamsCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of CustomerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ShippingParamsCopyWith<$Res>? get shipping {
    if (_self.shipping == null) {
    return null;
  }

  return $ShippingParamsCopyWith<$Res>(_self.shipping!, (value) {
    return _then(_self.copyWith(shipping: value));
  });
}
}


/// @nodoc
mixin _$ShippingParams {

 AddressParams? get address; String? get name; String? get phone;
/// Create a copy of ShippingParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShippingParamsCopyWith<ShippingParams> get copyWith => _$ShippingParamsCopyWithImpl<ShippingParams>(this as ShippingParams, _$identity);

  /// Serializes this ShippingParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShippingParams&&(identical(other.address, address) || other.address == address)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,name,phone);

@override
String toString() {
  return 'ShippingParams(address: $address, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $ShippingParamsCopyWith<$Res>  {
  factory $ShippingParamsCopyWith(ShippingParams value, $Res Function(ShippingParams) _then) = _$ShippingParamsCopyWithImpl;
@useResult
$Res call({
 AddressParams? address, String? name, String? phone
});


$AddressParamsCopyWith<$Res>? get address;

}
/// @nodoc
class _$ShippingParamsCopyWithImpl<$Res>
    implements $ShippingParamsCopyWith<$Res> {
  _$ShippingParamsCopyWithImpl(this._self, this._then);

  final ShippingParams _self;
  final $Res Function(ShippingParams) _then;

/// Create a copy of ShippingParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = freezed,Object? name = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressParams?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ShippingParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressParamsCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressParamsCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// Adds pattern-matching-related methods to [ShippingParams].
extension ShippingParamsPatterns on ShippingParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShippingParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShippingParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShippingParams value)  $default,){
final _that = this;
switch (_that) {
case _ShippingParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShippingParams value)?  $default,){
final _that = this;
switch (_that) {
case _ShippingParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AddressParams? address,  String? name,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShippingParams() when $default != null:
return $default(_that.address,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AddressParams? address,  String? name,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _ShippingParams():
return $default(_that.address,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AddressParams? address,  String? name,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _ShippingParams() when $default != null:
return $default(_that.address,_that.name,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShippingParams implements ShippingParams {
  const _ShippingParams({this.address, this.name, this.phone});
  factory _ShippingParams.fromJson(Map<String, dynamic> json) => _$ShippingParamsFromJson(json);

@override final  AddressParams? address;
@override final  String? name;
@override final  String? phone;

/// Create a copy of ShippingParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShippingParamsCopyWith<_ShippingParams> get copyWith => __$ShippingParamsCopyWithImpl<_ShippingParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShippingParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShippingParams&&(identical(other.address, address) || other.address == address)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,name,phone);

@override
String toString() {
  return 'ShippingParams(address: $address, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$ShippingParamsCopyWith<$Res> implements $ShippingParamsCopyWith<$Res> {
  factory _$ShippingParamsCopyWith(_ShippingParams value, $Res Function(_ShippingParams) _then) = __$ShippingParamsCopyWithImpl;
@override @useResult
$Res call({
 AddressParams? address, String? name, String? phone
});


@override $AddressParamsCopyWith<$Res>? get address;

}
/// @nodoc
class __$ShippingParamsCopyWithImpl<$Res>
    implements _$ShippingParamsCopyWith<$Res> {
  __$ShippingParamsCopyWithImpl(this._self, this._then);

  final _ShippingParams _self;
  final $Res Function(_ShippingParams) _then;

/// Create a copy of ShippingParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = freezed,Object? name = freezed,Object? phone = freezed,}) {
  return _then(_ShippingParams(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressParams?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ShippingParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressParamsCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressParamsCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}
}


/// @nodoc
mixin _$AddressParams {

 String? get city; String? get country; String? get line1; String? get line2; String? get postalCode; String? get state;
/// Create a copy of AddressParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressParamsCopyWith<AddressParams> get copyWith => _$AddressParamsCopyWithImpl<AddressParams>(this as AddressParams, _$identity);

  /// Serializes this AddressParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressParams&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,country,line1,line2,postalCode,state);

@override
String toString() {
  return 'AddressParams(city: $city, country: $country, line1: $line1, line2: $line2, postalCode: $postalCode, state: $state)';
}


}

/// @nodoc
abstract mixin class $AddressParamsCopyWith<$Res>  {
  factory $AddressParamsCopyWith(AddressParams value, $Res Function(AddressParams) _then) = _$AddressParamsCopyWithImpl;
@useResult
$Res call({
 String? city, String? country, String? line1, String? line2, String? postalCode, String? state
});




}
/// @nodoc
class _$AddressParamsCopyWithImpl<$Res>
    implements $AddressParamsCopyWith<$Res> {
  _$AddressParamsCopyWithImpl(this._self, this._then);

  final AddressParams _self;
  final $Res Function(AddressParams) _then;

/// Create a copy of AddressParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = freezed,Object? country = freezed,Object? line1 = freezed,Object? line2 = freezed,Object? postalCode = freezed,Object? state = freezed,}) {
  return _then(_self.copyWith(
city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressParams].
extension AddressParamsPatterns on AddressParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressParams value)  $default,){
final _that = this;
switch (_that) {
case _AddressParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressParams value)?  $default,){
final _that = this;
switch (_that) {
case _AddressParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? city,  String? country,  String? line1,  String? line2,  String? postalCode,  String? state)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressParams() when $default != null:
return $default(_that.city,_that.country,_that.line1,_that.line2,_that.postalCode,_that.state);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? city,  String? country,  String? line1,  String? line2,  String? postalCode,  String? state)  $default,) {final _that = this;
switch (_that) {
case _AddressParams():
return $default(_that.city,_that.country,_that.line1,_that.line2,_that.postalCode,_that.state);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? city,  String? country,  String? line1,  String? line2,  String? postalCode,  String? state)?  $default,) {final _that = this;
switch (_that) {
case _AddressParams() when $default != null:
return $default(_that.city,_that.country,_that.line1,_that.line2,_that.postalCode,_that.state);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressParams implements AddressParams {
  const _AddressParams({this.city, this.country, this.line1, this.line2, this.postalCode, this.state});
  factory _AddressParams.fromJson(Map<String, dynamic> json) => _$AddressParamsFromJson(json);

@override final  String? city;
@override final  String? country;
@override final  String? line1;
@override final  String? line2;
@override final  String? postalCode;
@override final  String? state;

/// Create a copy of AddressParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressParamsCopyWith<_AddressParams> get copyWith => __$AddressParamsCopyWithImpl<_AddressParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressParams&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.line2, line2) || other.line2 == line2)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.state, state) || other.state == state));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,country,line1,line2,postalCode,state);

@override
String toString() {
  return 'AddressParams(city: $city, country: $country, line1: $line1, line2: $line2, postalCode: $postalCode, state: $state)';
}


}

/// @nodoc
abstract mixin class _$AddressParamsCopyWith<$Res> implements $AddressParamsCopyWith<$Res> {
  factory _$AddressParamsCopyWith(_AddressParams value, $Res Function(_AddressParams) _then) = __$AddressParamsCopyWithImpl;
@override @useResult
$Res call({
 String? city, String? country, String? line1, String? line2, String? postalCode, String? state
});




}
/// @nodoc
class __$AddressParamsCopyWithImpl<$Res>
    implements _$AddressParamsCopyWith<$Res> {
  __$AddressParamsCopyWithImpl(this._self, this._then);

  final _AddressParams _self;
  final $Res Function(_AddressParams) _then;

/// Create a copy of AddressParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = freezed,Object? country = freezed,Object? line1 = freezed,Object? line2 = freezed,Object? postalCode = freezed,Object? state = freezed,}) {
  return _then(_AddressParams(
city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,line2: freezed == line2 ? _self.line2 : line2 // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
