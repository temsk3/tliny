// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_customer_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CustomerParams _$CustomerParamsFromJson(Map<String, dynamic> json) {
  return _CustomerParams.fromJson(json);
}

/// @nodoc
mixin _$CustomerParams {
  AddressParams? get address => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  ShippingParams? get shipping => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  /// Serializes this CustomerParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerParamsCopyWith<CustomerParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerParamsCopyWith<$Res> {
  factory $CustomerParamsCopyWith(
    CustomerParams value,
    $Res Function(CustomerParams) then,
  ) = _$CustomerParamsCopyWithImpl<$Res, CustomerParams>;
  @useResult
  $Res call({
    AddressParams? address,
    String? description,
    String? email,
    Map<String, dynamic>? metadata,
    String? name,
    String? paymentMethod,
    String? phone,
    ShippingParams? shipping,
    String? source,
  });

  $AddressParamsCopyWith<$Res>? get address;
  $ShippingParamsCopyWith<$Res>? get shipping;
}

/// @nodoc
class _$CustomerParamsCopyWithImpl<$Res, $Val extends CustomerParams>
    implements $CustomerParamsCopyWith<$Res> {
  _$CustomerParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? description = freezed,
    Object? email = freezed,
    Object? metadata = freezed,
    Object? name = freezed,
    Object? paymentMethod = freezed,
    Object? phone = freezed,
    Object? shipping = freezed,
    Object? source = freezed,
  }) {
    return _then(
      _value.copyWith(
            address:
                freezed == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as AddressParams?,
            description:
                freezed == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            metadata:
                freezed == metadata
                    ? _value.metadata
                    : metadata // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            paymentMethod:
                freezed == paymentMethod
                    ? _value.paymentMethod
                    : paymentMethod // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            shipping:
                freezed == shipping
                    ? _value.shipping
                    : shipping // ignore: cast_nullable_to_non_nullable
                        as ShippingParams?,
            source:
                freezed == source
                    ? _value.source
                    : source // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CustomerParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressParamsCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressParamsCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of CustomerParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShippingParamsCopyWith<$Res>? get shipping {
    if (_value.shipping == null) {
      return null;
    }

    return $ShippingParamsCopyWith<$Res>(_value.shipping!, (value) {
      return _then(_value.copyWith(shipping: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerParamsImplCopyWith<$Res>
    implements $CustomerParamsCopyWith<$Res> {
  factory _$$CustomerParamsImplCopyWith(
    _$CustomerParamsImpl value,
    $Res Function(_$CustomerParamsImpl) then,
  ) = __$$CustomerParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AddressParams? address,
    String? description,
    String? email,
    Map<String, dynamic>? metadata,
    String? name,
    String? paymentMethod,
    String? phone,
    ShippingParams? shipping,
    String? source,
  });

  @override
  $AddressParamsCopyWith<$Res>? get address;
  @override
  $ShippingParamsCopyWith<$Res>? get shipping;
}

/// @nodoc
class __$$CustomerParamsImplCopyWithImpl<$Res>
    extends _$CustomerParamsCopyWithImpl<$Res, _$CustomerParamsImpl>
    implements _$$CustomerParamsImplCopyWith<$Res> {
  __$$CustomerParamsImplCopyWithImpl(
    _$CustomerParamsImpl _value,
    $Res Function(_$CustomerParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CustomerParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? description = freezed,
    Object? email = freezed,
    Object? metadata = freezed,
    Object? name = freezed,
    Object? paymentMethod = freezed,
    Object? phone = freezed,
    Object? shipping = freezed,
    Object? source = freezed,
  }) {
    return _then(
      _$CustomerParamsImpl(
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as AddressParams?,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        metadata:
            freezed == metadata
                ? _value._metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        paymentMethod:
            freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        shipping:
            freezed == shipping
                ? _value.shipping
                : shipping // ignore: cast_nullable_to_non_nullable
                    as ShippingParams?,
        source:
            freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerParamsImpl extends _CustomerParams {
  const _$CustomerParamsImpl({
    required this.address,
    required this.description,
    required this.email,
    required final Map<String, dynamic>? metadata,
    required this.name,
    required this.paymentMethod,
    required this.phone,
    required this.shipping,
    required this.source,
  }) : _metadata = metadata,
       super._();

  factory _$CustomerParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerParamsImplFromJson(json);

  @override
  final AddressParams? address;
  @override
  final String? description;
  @override
  final String? email;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? name;
  @override
  final String? paymentMethod;
  @override
  final String? phone;
  @override
  final ShippingParams? shipping;
  @override
  final String? source;

  @override
  String toString() {
    return 'CustomerParams(address: $address, description: $description, email: $email, metadata: $metadata, name: $name, paymentMethod: $paymentMethod, phone: $phone, shipping: $shipping, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerParamsImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    address,
    description,
    email,
    const DeepCollectionEquality().hash(_metadata),
    name,
    paymentMethod,
    phone,
    shipping,
    source,
  );

  /// Create a copy of CustomerParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerParamsImplCopyWith<_$CustomerParamsImpl> get copyWith =>
      __$$CustomerParamsImplCopyWithImpl<_$CustomerParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerParamsImplToJson(this);
  }
}

abstract class _CustomerParams extends CustomerParams {
  const factory _CustomerParams({
    required final AddressParams? address,
    required final String? description,
    required final String? email,
    required final Map<String, dynamic>? metadata,
    required final String? name,
    required final String? paymentMethod,
    required final String? phone,
    required final ShippingParams? shipping,
    required final String? source,
  }) = _$CustomerParamsImpl;
  const _CustomerParams._() : super._();

  factory _CustomerParams.fromJson(Map<String, dynamic> json) =
      _$CustomerParamsImpl.fromJson;

  @override
  AddressParams? get address;
  @override
  String? get description;
  @override
  String? get email;
  @override
  Map<String, dynamic>? get metadata;
  @override
  String? get name;
  @override
  String? get paymentMethod;
  @override
  String? get phone;
  @override
  ShippingParams? get shipping;
  @override
  String? get source;

  /// Create a copy of CustomerParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerParamsImplCopyWith<_$CustomerParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShippingParams _$ShippingParamsFromJson(Map<String, dynamic> json) {
  return _ShippingParams.fromJson(json);
}

/// @nodoc
mixin _$ShippingParams {
  AddressParams? get address => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this ShippingParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShippingParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShippingParamsCopyWith<ShippingParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingParamsCopyWith<$Res> {
  factory $ShippingParamsCopyWith(
    ShippingParams value,
    $Res Function(ShippingParams) then,
  ) = _$ShippingParamsCopyWithImpl<$Res, ShippingParams>;
  @useResult
  $Res call({AddressParams? address, String? name, String? phone});

  $AddressParamsCopyWith<$Res>? get address;
}

/// @nodoc
class _$ShippingParamsCopyWithImpl<$Res, $Val extends ShippingParams>
    implements $ShippingParamsCopyWith<$Res> {
  _$ShippingParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShippingParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _value.copyWith(
            address:
                freezed == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as AddressParams?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ShippingParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressParamsCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressParamsCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShippingParamsImplCopyWith<$Res>
    implements $ShippingParamsCopyWith<$Res> {
  factory _$$ShippingParamsImplCopyWith(
    _$ShippingParamsImpl value,
    $Res Function(_$ShippingParamsImpl) then,
  ) = __$$ShippingParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AddressParams? address, String? name, String? phone});

  @override
  $AddressParamsCopyWith<$Res>? get address;
}

/// @nodoc
class __$$ShippingParamsImplCopyWithImpl<$Res>
    extends _$ShippingParamsCopyWithImpl<$Res, _$ShippingParamsImpl>
    implements _$$ShippingParamsImplCopyWith<$Res> {
  __$$ShippingParamsImplCopyWithImpl(
    _$ShippingParamsImpl _value,
    $Res Function(_$ShippingParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShippingParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? name = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _$ShippingParamsImpl(
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as AddressParams?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShippingParamsImpl implements _ShippingParams {
  const _$ShippingParamsImpl({
    required this.address,
    required this.name,
    required this.phone,
  });

  factory _$ShippingParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShippingParamsImplFromJson(json);

  @override
  final AddressParams? address;
  @override
  final String? name;
  @override
  final String? phone;

  @override
  String toString() {
    return 'ShippingParams(address: $address, name: $name, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShippingParamsImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address, name, phone);

  /// Create a copy of ShippingParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShippingParamsImplCopyWith<_$ShippingParamsImpl> get copyWith =>
      __$$ShippingParamsImplCopyWithImpl<_$ShippingParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShippingParamsImplToJson(this);
  }
}

abstract class _ShippingParams implements ShippingParams {
  const factory _ShippingParams({
    required final AddressParams? address,
    required final String? name,
    required final String? phone,
  }) = _$ShippingParamsImpl;

  factory _ShippingParams.fromJson(Map<String, dynamic> json) =
      _$ShippingParamsImpl.fromJson;

  @override
  AddressParams? get address;
  @override
  String? get name;
  @override
  String? get phone;

  /// Create a copy of ShippingParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShippingParamsImplCopyWith<_$ShippingParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressParams _$AddressParamsFromJson(Map<String, dynamic> json) {
  return _AddressParams.fromJson(json);
}

/// @nodoc
mixin _$AddressParams {
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get line1 => throw _privateConstructorUsedError;
  String? get line2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'postal_code')
  String? get postalCode => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;

  /// Serializes this AddressParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressParamsCopyWith<AddressParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressParamsCopyWith<$Res> {
  factory $AddressParamsCopyWith(
    AddressParams value,
    $Res Function(AddressParams) then,
  ) = _$AddressParamsCopyWithImpl<$Res, AddressParams>;
  @useResult
  $Res call({
    String? city,
    String? country,
    String? line1,
    String? line2,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? state,
  });
}

/// @nodoc
class _$AddressParamsCopyWithImpl<$Res, $Val extends AddressParams>
    implements $AddressParamsCopyWith<$Res> {
  _$AddressParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? country = freezed,
    Object? line1 = freezed,
    Object? line2 = freezed,
    Object? postalCode = freezed,
    Object? state = freezed,
  }) {
    return _then(
      _value.copyWith(
            city:
                freezed == city
                    ? _value.city
                    : city // ignore: cast_nullable_to_non_nullable
                        as String?,
            country:
                freezed == country
                    ? _value.country
                    : country // ignore: cast_nullable_to_non_nullable
                        as String?,
            line1:
                freezed == line1
                    ? _value.line1
                    : line1 // ignore: cast_nullable_to_non_nullable
                        as String?,
            line2:
                freezed == line2
                    ? _value.line2
                    : line2 // ignore: cast_nullable_to_non_nullable
                        as String?,
            postalCode:
                freezed == postalCode
                    ? _value.postalCode
                    : postalCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            state:
                freezed == state
                    ? _value.state
                    : state // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressParamsImplCopyWith<$Res>
    implements $AddressParamsCopyWith<$Res> {
  factory _$$AddressParamsImplCopyWith(
    _$AddressParamsImpl value,
    $Res Function(_$AddressParamsImpl) then,
  ) = __$$AddressParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? city,
    String? country,
    String? line1,
    String? line2,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? state,
  });
}

/// @nodoc
class __$$AddressParamsImplCopyWithImpl<$Res>
    extends _$AddressParamsCopyWithImpl<$Res, _$AddressParamsImpl>
    implements _$$AddressParamsImplCopyWith<$Res> {
  __$$AddressParamsImplCopyWithImpl(
    _$AddressParamsImpl _value,
    $Res Function(_$AddressParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = freezed,
    Object? country = freezed,
    Object? line1 = freezed,
    Object? line2 = freezed,
    Object? postalCode = freezed,
    Object? state = freezed,
  }) {
    return _then(
      _$AddressParamsImpl(
        city:
            freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                    as String?,
        country:
            freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                    as String?,
        line1:
            freezed == line1
                ? _value.line1
                : line1 // ignore: cast_nullable_to_non_nullable
                    as String?,
        line2:
            freezed == line2
                ? _value.line2
                : line2 // ignore: cast_nullable_to_non_nullable
                    as String?,
        postalCode:
            freezed == postalCode
                ? _value.postalCode
                : postalCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        state:
            freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressParamsImpl implements _AddressParams {
  const _$AddressParamsImpl({
    required this.city,
    required this.country,
    required this.line1,
    required this.line2,
    @JsonKey(name: 'postal_code') required this.postalCode,
    required this.state,
  });

  factory _$AddressParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressParamsImplFromJson(json);

  @override
  final String? city;
  @override
  final String? country;
  @override
  final String? line1;
  @override
  final String? line2;
  @override
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @override
  final String? state;

  @override
  String toString() {
    return 'AddressParams(city: $city, country: $country, line1: $line1, line2: $line2, postalCode: $postalCode, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressParamsImpl &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.line1, line1) || other.line1 == line1) &&
            (identical(other.line2, line2) || other.line2 == line2) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, city, country, line1, line2, postalCode, state);

  /// Create a copy of AddressParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressParamsImplCopyWith<_$AddressParamsImpl> get copyWith =>
      __$$AddressParamsImplCopyWithImpl<_$AddressParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressParamsImplToJson(this);
  }
}

abstract class _AddressParams implements AddressParams {
  const factory _AddressParams({
    required final String? city,
    required final String? country,
    required final String? line1,
    required final String? line2,
    @JsonKey(name: 'postal_code') required final String? postalCode,
    required final String? state,
  }) = _$AddressParamsImpl;

  factory _AddressParams.fromJson(Map<String, dynamic> json) =
      _$AddressParamsImpl.fromJson;

  @override
  String? get city;
  @override
  String? get country;
  @override
  String? get line1;
  @override
  String? get line2;
  @override
  @JsonKey(name: 'postal_code')
  String? get postalCode;
  @override
  String? get state;

  /// Create a copy of AddressParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressParamsImplCopyWith<_$AddressParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
