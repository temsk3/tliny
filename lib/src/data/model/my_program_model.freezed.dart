// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_program_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyProgram _$MyProgramFromJson(Map<String, dynamic> json) {
  return _MyProgram.fromJson(json);
}

/// @nodoc
mixin _$MyProgram {
  String? get id => throw _privateConstructorUsedError;
  String? get programId => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyProgramCopyWith<MyProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyProgramCopyWith<$Res> {
  factory $MyProgramCopyWith(MyProgram value, $Res Function(MyProgram) then) =
      _$MyProgramCopyWithImpl<$Res, MyProgram>;
  @useResult
  $Res call(
      {String? id,
      String? programId,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class _$MyProgramCopyWithImpl<$Res, $Val extends MyProgram>
    implements $MyProgramCopyWith<$Res> {
  _$MyProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      programId: freezed == programId
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$_MyProgramCopyWith<$Res> implements $MyProgramCopyWith<$Res> {
  factory _$$_MyProgramCopyWith(
          _$_MyProgram value, $Res Function(_$_MyProgram) then) =
      __$$_MyProgramCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? programId,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class __$$_MyProgramCopyWithImpl<$Res>
    extends _$MyProgramCopyWithImpl<$Res, _$_MyProgram>
    implements _$$_MyProgramCopyWith<$Res> {
  __$$_MyProgramCopyWithImpl(
      _$_MyProgram _value, $Res Function(_$_MyProgram) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_MyProgram(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      programId: freezed == programId
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_MyProgram extends _MyProgram {
  _$_MyProgram(
      {this.id,
      required this.programId,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : super._();

  factory _$_MyProgram.fromJson(Map<String, dynamic> json) =>
      _$$_MyProgramFromJson(json);

  @override
  final String? id;
  @override
  final String? programId;
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
    return 'MyProgram(id: $id, programId: $programId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyProgram &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.programId, programId) ||
                other.programId == programId) &&
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
      Object.hash(runtimeType, id, programId, createdAt, updatedAt, deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyProgramCopyWith<_$_MyProgram> get copyWith =>
      __$$_MyProgramCopyWithImpl<_$_MyProgram>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyProgramToJson(
      this,
    );
  }
}

abstract class _MyProgram extends MyProgram {
  factory _MyProgram(
      {final String? id,
      required final String? programId,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt}) = _$_MyProgram;
  _MyProgram._() : super._();

  factory _MyProgram.fromJson(Map<String, dynamic> json) =
      _$_MyProgram.fromJson;

  @override
  String? get id;
  @override
  String? get programId;
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
  _$$_MyProgramCopyWith<_$_MyProgram> get copyWith =>
      throw _privateConstructorUsedError;
}
