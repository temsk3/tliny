// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return _Staff.fromJson(json);
}

/// @nodoc
mixin _$Staff {
  String? get id => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  bool? get isCreated => throw _privateConstructorUsedError;
  bool? get isRetrieve => throw _privateConstructorUsedError;
  bool? get isUpdated => throw _privateConstructorUsedError;
  bool? get isDeleted => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;

  /// Serializes this Staff to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffCopyWith<Staff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) then) =
      _$StaffCopyWithImpl<$Res, Staff>;
  @useResult
  $Res call({
    String? id,
    String? displayName,
    String? name,
    String? email,
    bool? isCreated,
    bool? isRetrieve,
    bool? isUpdated,
    bool? isDeleted,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
    bool? isActive,
  });
}

/// @nodoc
class _$StaffCopyWithImpl<$Res, $Val extends Staff>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? isCreated = freezed,
    Object? isRetrieve = freezed,
    Object? isUpdated = freezed,
    Object? isDeleted = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                freezed == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String?,
            displayName:
                freezed == displayName
                    ? _value.displayName
                    : displayName // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            isCreated:
                freezed == isCreated
                    ? _value.isCreated
                    : isCreated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isRetrieve:
                freezed == isRetrieve
                    ? _value.isRetrieve
                    : isRetrieve // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isUpdated:
                freezed == isUpdated
                    ? _value.isUpdated
                    : isUpdated // ignore: cast_nullable_to_non_nullable
                        as bool?,
            isDeleted:
                freezed == isDeleted
                    ? _value.isDeleted
                    : isDeleted // ignore: cast_nullable_to_non_nullable
                        as bool?,
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
            isActive:
                freezed == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StaffImplCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$$StaffImplCopyWith(
    _$StaffImpl value,
    $Res Function(_$StaffImpl) then,
  ) = __$$StaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? displayName,
    String? name,
    String? email,
    bool? isCreated,
    bool? isRetrieve,
    bool? isUpdated,
    bool? isDeleted,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
    bool? isActive,
  });
}

/// @nodoc
class __$$StaffImplCopyWithImpl<$Res>
    extends _$StaffCopyWithImpl<$Res, _$StaffImpl>
    implements _$$StaffImplCopyWith<$Res> {
  __$$StaffImplCopyWithImpl(
    _$StaffImpl _value,
    $Res Function(_$StaffImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? displayName = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? isCreated = freezed,
    Object? isRetrieve = freezed,
    Object? isUpdated = freezed,
    Object? isDeleted = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isActive = freezed,
  }) {
    return _then(
      _$StaffImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        displayName:
            freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        isCreated:
            freezed == isCreated
                ? _value.isCreated
                : isCreated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isRetrieve:
            freezed == isRetrieve
                ? _value.isRetrieve
                : isRetrieve // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isUpdated:
            freezed == isUpdated
                ? _value.isUpdated
                : isUpdated // ignore: cast_nullable_to_non_nullable
                    as bool?,
        isDeleted:
            freezed == isDeleted
                ? _value.isDeleted
                : isDeleted // ignore: cast_nullable_to_non_nullable
                    as bool?,
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
        isActive:
            freezed == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffImpl extends _Staff {
  const _$StaffImpl({
    this.id,
    required this.displayName,
    required this.name,
    required this.email,
    this.isCreated = true,
    this.isRetrieve = true,
    this.isUpdated = true,
    this.isDeleted = true,
    @timestampKey this.createdAt,
    @timestampKey this.updatedAt,
    @timestampKey this.deletedAt,
    this.isActive = false,
  }) : super._();

  factory _$StaffImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffImplFromJson(json);

  @override
  final String? id;
  @override
  final String? displayName;
  @override
  final String? name;
  @override
  final String? email;
  @override
  @JsonKey()
  final bool? isCreated;
  @override
  @JsonKey()
  final bool? isRetrieve;
  @override
  @JsonKey()
  final bool? isUpdated;
  @override
  @JsonKey()
  final bool? isDeleted;
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
  @JsonKey()
  final bool? isActive;

  @override
  String toString() {
    return 'Staff(id: $id, displayName: $displayName, name: $name, email: $email, isCreated: $isCreated, isRetrieve: $isRetrieve, isUpdated: $isUpdated, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isCreated, isCreated) ||
                other.isCreated == isCreated) &&
            (identical(other.isRetrieve, isRetrieve) ||
                other.isRetrieve == isRetrieve) &&
            (identical(other.isUpdated, isUpdated) ||
                other.isUpdated == isUpdated) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    displayName,
    name,
    email,
    isCreated,
    isRetrieve,
    isUpdated,
    isDeleted,
    createdAt,
    updatedAt,
    deletedAt,
    isActive,
  );

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      __$$StaffImplCopyWithImpl<_$StaffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffImplToJson(this);
  }
}

abstract class _Staff extends Staff {
  const factory _Staff({
    final String? id,
    required final String? displayName,
    required final String? name,
    required final String? email,
    final bool? isCreated,
    final bool? isRetrieve,
    final bool? isUpdated,
    final bool? isDeleted,
    @timestampKey final DateTime? createdAt,
    @timestampKey final DateTime? updatedAt,
    @timestampKey final DateTime? deletedAt,
    final bool? isActive,
  }) = _$StaffImpl;
  const _Staff._() : super._();

  factory _Staff.fromJson(Map<String, dynamic> json) = _$StaffImpl.fromJson;

  @override
  String? get id;
  @override
  String? get displayName;
  @override
  String? get name;
  @override
  String? get email;
  @override
  bool? get isCreated;
  @override
  bool? get isRetrieve;
  @override
  bool? get isUpdated;
  @override
  bool? get isDeleted;
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
  bool? get isActive;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
