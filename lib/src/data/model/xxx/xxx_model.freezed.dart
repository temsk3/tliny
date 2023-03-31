// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xxx_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Xxx _$XxxFromJson(Map<String, dynamic> json) {
  return _Xxx.fromJson(json);
}

/// @nodoc
mixin _$Xxx {
  String? get id => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $XxxCopyWith<Xxx> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XxxCopyWith<$Res> {
  factory $XxxCopyWith(Xxx value, $Res Function(Xxx) then) =
      _$XxxCopyWithImpl<$Res, Xxx>;
  @useResult
  $Res call(
      {String? id,
      String data,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class _$XxxCopyWithImpl<$Res, $Val extends Xxx> implements $XxxCopyWith<$Res> {
  _$XxxCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? data = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_XxxCopyWith<$Res> implements $XxxCopyWith<$Res> {
  factory _$$_XxxCopyWith(_$_Xxx value, $Res Function(_$_Xxx) then) =
      __$$_XxxCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String data,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class __$$_XxxCopyWithImpl<$Res> extends _$XxxCopyWithImpl<$Res, _$_Xxx>
    implements _$$_XxxCopyWith<$Res> {
  __$$_XxxCopyWithImpl(_$_Xxx _value, $Res Function(_$_Xxx) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? data = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_Xxx(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Xxx extends _Xxx {
  const _$_Xxx(
      {this.id,
      required this.data,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : super._();

  factory _$_Xxx.fromJson(Map<String, dynamic> json) => _$$_XxxFromJson(json);

  @override
  final String? id;
  @override
  final String data;
  @override
  @timestampKey
  final DateTime? createdAt;
  @override
  @timestampKey
  final DateTime? updatedAt;
  @override
  @timestampKey
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'Xxx(id: $id, data: $data, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Xxx &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, data, createdAt, updatedAt, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_XxxCopyWith<_$_Xxx> get copyWith =>
      __$$_XxxCopyWithImpl<_$_Xxx>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_XxxToJson(
      this,
    );
  }
}

abstract class _Xxx extends Xxx {
  const factory _Xxx(
      {final String? id,
      required final String data,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt}) = _$_Xxx;
  const _Xxx._() : super._();

  factory _Xxx.fromJson(Map<String, dynamic> json) = _$_Xxx.fromJson;

  @override
  String? get id;
  @override
  String get data;
  @override
  @timestampKey
  DateTime? get createdAt;
  @override
  @timestampKey
  DateTime? get updatedAt;
  @override
  @timestampKey
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$_XxxCopyWith<_$_Xxx> get copyWith => throw _privateConstructorUsedError;
}
