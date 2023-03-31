// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zipcode_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Address _$AddressFromJson(Map<String, dynamic> json) {
  return _Address.fromJson(json);
}

/// @nodoc
mixin _$Address {
  String get address1 => throw _privateConstructorUsedError;
  String get address2 => throw _privateConstructorUsedError;
  String get address3 => throw _privateConstructorUsedError;
  String get kana1 => throw _privateConstructorUsedError;
  String get kana2 => throw _privateConstructorUsedError;
  String get kana3 => throw _privateConstructorUsedError;
  String get prefcode => throw _privateConstructorUsedError;
  String get zipcode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res, Address>;
  @useResult
  $Res call(
      {String address1,
      String address2,
      String address3,
      String kana1,
      String kana2,
      String kana3,
      String prefcode,
      String zipcode});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res, $Val extends Address>
    implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address1 = null,
    Object? address2 = null,
    Object? address3 = null,
    Object? kana1 = null,
    Object? kana2 = null,
    Object? kana3 = null,
    Object? prefcode = null,
    Object? zipcode = null,
  }) {
    return _then(_value.copyWith(
      address1: null == address1
          ? _value.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String,
      address2: null == address2
          ? _value.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String,
      address3: null == address3
          ? _value.address3
          : address3 // ignore: cast_nullable_to_non_nullable
              as String,
      kana1: null == kana1
          ? _value.kana1
          : kana1 // ignore: cast_nullable_to_non_nullable
              as String,
      kana2: null == kana2
          ? _value.kana2
          : kana2 // ignore: cast_nullable_to_non_nullable
              as String,
      kana3: null == kana3
          ? _value.kana3
          : kana3 // ignore: cast_nullable_to_non_nullable
              as String,
      prefcode: null == prefcode
          ? _value.prefcode
          : prefcode // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: null == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$$_AddressCopyWith(
          _$_Address value, $Res Function(_$_Address) then) =
      __$$_AddressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address1,
      String address2,
      String address3,
      String kana1,
      String kana2,
      String kana3,
      String prefcode,
      String zipcode});
}

/// @nodoc
class __$$_AddressCopyWithImpl<$Res>
    extends _$AddressCopyWithImpl<$Res, _$_Address>
    implements _$$_AddressCopyWith<$Res> {
  __$$_AddressCopyWithImpl(_$_Address _value, $Res Function(_$_Address) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address1 = null,
    Object? address2 = null,
    Object? address3 = null,
    Object? kana1 = null,
    Object? kana2 = null,
    Object? kana3 = null,
    Object? prefcode = null,
    Object? zipcode = null,
  }) {
    return _then(_$_Address(
      address1: null == address1
          ? _value.address1
          : address1 // ignore: cast_nullable_to_non_nullable
              as String,
      address2: null == address2
          ? _value.address2
          : address2 // ignore: cast_nullable_to_non_nullable
              as String,
      address3: null == address3
          ? _value.address3
          : address3 // ignore: cast_nullable_to_non_nullable
              as String,
      kana1: null == kana1
          ? _value.kana1
          : kana1 // ignore: cast_nullable_to_non_nullable
              as String,
      kana2: null == kana2
          ? _value.kana2
          : kana2 // ignore: cast_nullable_to_non_nullable
              as String,
      kana3: null == kana3
          ? _value.kana3
          : kana3 // ignore: cast_nullable_to_non_nullable
              as String,
      prefcode: null == prefcode
          ? _value.prefcode
          : prefcode // ignore: cast_nullable_to_non_nullable
              as String,
      zipcode: null == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Address extends _Address {
  const _$_Address(
      {required this.address1,
      required this.address2,
      required this.address3,
      required this.kana1,
      required this.kana2,
      required this.kana3,
      required this.prefcode,
      required this.zipcode})
      : super._();

  factory _$_Address.fromJson(Map<String, dynamic> json) =>
      _$$_AddressFromJson(json);

  @override
  final String address1;
  @override
  final String address2;
  @override
  final String address3;
  @override
  final String kana1;
  @override
  final String kana2;
  @override
  final String kana3;
  @override
  final String prefcode;
  @override
  final String zipcode;

  @override
  String toString() {
    return 'Address(address1: $address1, address2: $address2, address3: $address3, kana1: $kana1, kana2: $kana2, kana3: $kana3, prefcode: $prefcode, zipcode: $zipcode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Address &&
            (identical(other.address1, address1) ||
                other.address1 == address1) &&
            (identical(other.address2, address2) ||
                other.address2 == address2) &&
            (identical(other.address3, address3) ||
                other.address3 == address3) &&
            (identical(other.kana1, kana1) || other.kana1 == kana1) &&
            (identical(other.kana2, kana2) || other.kana2 == kana2) &&
            (identical(other.kana3, kana3) || other.kana3 == kana3) &&
            (identical(other.prefcode, prefcode) ||
                other.prefcode == prefcode) &&
            (identical(other.zipcode, zipcode) || other.zipcode == zipcode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address1, address2, address3,
      kana1, kana2, kana3, prefcode, zipcode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddressCopyWith<_$_Address> get copyWith =>
      __$$_AddressCopyWithImpl<_$_Address>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressToJson(
      this,
    );
  }
}

abstract class _Address extends Address {
  const factory _Address(
      {required final String address1,
      required final String address2,
      required final String address3,
      required final String kana1,
      required final String kana2,
      required final String kana3,
      required final String prefcode,
      required final String zipcode}) = _$_Address;
  const _Address._() : super._();

  factory _Address.fromJson(Map<String, dynamic> json) = _$_Address.fromJson;

  @override
  String get address1;
  @override
  String get address2;
  @override
  String get address3;
  @override
  String get kana1;
  @override
  String get kana2;
  @override
  String get kana3;
  @override
  String get prefcode;
  @override
  String get zipcode;
  @override
  @JsonKey(ignore: true)
  _$$_AddressCopyWith<_$_Address> get copyWith =>
      throw _privateConstructorUsedError;
}
