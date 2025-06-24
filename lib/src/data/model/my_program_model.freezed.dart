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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

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

  /// Serializes this MyProgram to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MyProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyProgramCopyWith<MyProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyProgramCopyWith<$Res> {
  factory $MyProgramCopyWith(MyProgram value, $Res Function(MyProgram) then) =
      _$MyProgramCopyWithImpl<$Res, MyProgram>;
  @useResult
  $Res call({
    String? id,
    String? programId,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class _$MyProgramCopyWithImpl<$Res, $Val extends MyProgram>
    implements $MyProgramCopyWith<$Res> {
  _$MyProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            programId:
                freezed == programId
                    ? _value.programId
                    : programId // ignore: cast_nullable_to_non_nullable
                        as String?,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            deletedAt:
                freezed == deletedAt
                    ? _value.deletedAt
                    : deletedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MyProgramImplCopyWith<$Res>
    implements $MyProgramCopyWith<$Res> {
  factory _$$MyProgramImplCopyWith(
    _$MyProgramImpl value,
    $Res Function(_$MyProgramImpl) then,
  ) = __$$MyProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? programId,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class __$$MyProgramImplCopyWithImpl<$Res>
    extends _$MyProgramCopyWithImpl<$Res, _$MyProgramImpl>
    implements _$$MyProgramImplCopyWith<$Res> {
  __$$MyProgramImplCopyWithImpl(
    _$MyProgramImpl _value,
    $Res Function(_$MyProgramImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? programId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$MyProgramImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        programId:
            freezed == programId
                ? _value.programId
                : programId // ignore: cast_nullable_to_non_nullable
                    as String?,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        deletedAt:
            freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MyProgramImpl extends _MyProgram {
  _$MyProgramImpl({
    this.id,
    required this.programId,
    @timestampKey this.createdAt,
    @timestampKey this.updatedAt,
    @timestampKey this.deletedAt,
  }) : super._();

  factory _$MyProgramImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyProgramImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyProgramImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, programId, createdAt, updatedAt, deletedAt);

  /// Create a copy of MyProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyProgramImplCopyWith<_$MyProgramImpl> get copyWith =>
      __$$MyProgramImplCopyWithImpl<_$MyProgramImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyProgramImplToJson(this);
  }
}

abstract class _MyProgram extends MyProgram {
  factory _MyProgram({
    final String? id,
    required final String? programId,
    @timestampKey final DateTime? createdAt,
    @timestampKey final DateTime? updatedAt,
    @timestampKey final DateTime? deletedAt,
  }) = _$MyProgramImpl;
  _MyProgram._() : super._();

  factory _MyProgram.fromJson(Map<String, dynamic> json) =
      _$MyProgramImpl.fromJson;

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

  /// Create a copy of MyProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyProgramImplCopyWith<_$MyProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
