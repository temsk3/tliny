// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_qrcode_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TicketQRCodeDataModel _$TicketQRCodeDataModelFromJson(
  Map<String, dynamic> json,
) {
  return _TicketQRCodeDataModel.fromJson(json);
}

/// @nodoc
mixin _$TicketQRCodeDataModel {
  String? get id => throw _privateConstructorUsedError;
  String get codeData => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this TicketQRCodeDataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketQRCodeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketQRCodeDataModelCopyWith<TicketQRCodeDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketQRCodeDataModelCopyWith<$Res> {
  factory $TicketQRCodeDataModelCopyWith(
    TicketQRCodeDataModel value,
    $Res Function(TicketQRCodeDataModel) then,
  ) = _$TicketQRCodeDataModelCopyWithImpl<$Res, TicketQRCodeDataModel>;
  @useResult
  $Res call({
    String? id,
    String codeData,
    bool isActive,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
  });
}

/// @nodoc
class _$TicketQRCodeDataModelCopyWithImpl<
  $Res,
  $Val extends TicketQRCodeDataModel
>
    implements $TicketQRCodeDataModelCopyWith<$Res> {
  _$TicketQRCodeDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketQRCodeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? codeData = null,
    Object? isActive = null,
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
            codeData:
                null == codeData
                    ? _value.codeData
                    : codeData // ignore: cast_nullable_to_non_nullable
                        as String,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
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
abstract class _$$TicketQRCodeDataModelImplCopyWith<$Res>
    implements $TicketQRCodeDataModelCopyWith<$Res> {
  factory _$$TicketQRCodeDataModelImplCopyWith(
    _$TicketQRCodeDataModelImpl value,
    $Res Function(_$TicketQRCodeDataModelImpl) then,
  ) = __$$TicketQRCodeDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String codeData,
    bool isActive,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
  });
}

/// @nodoc
class __$$TicketQRCodeDataModelImplCopyWithImpl<$Res>
    extends
        _$TicketQRCodeDataModelCopyWithImpl<$Res, _$TicketQRCodeDataModelImpl>
    implements _$$TicketQRCodeDataModelImplCopyWith<$Res> {
  __$$TicketQRCodeDataModelImplCopyWithImpl(
    _$TicketQRCodeDataModelImpl _value,
    $Res Function(_$TicketQRCodeDataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketQRCodeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? codeData = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$TicketQRCodeDataModelImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        codeData:
            null == codeData
                ? _value.codeData
                : codeData // ignore: cast_nullable_to_non_nullable
                    as String,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
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
class _$TicketQRCodeDataModelImpl implements _TicketQRCodeDataModel {
  _$TicketQRCodeDataModelImpl({
    this.id,
    required this.codeData,
    this.isActive = true,
    @TimestampConverter() this.createdAt,
    @TimestampConverter() this.updatedAt,
    @TimestampConverter() this.deletedAt,
  });

  factory _$TicketQRCodeDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketQRCodeDataModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String codeData;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  @TimestampConverter()
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'TicketQRCodeDataModel(id: $id, codeData: $codeData, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketQRCodeDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.codeData, codeData) ||
                other.codeData == codeData) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    codeData,
    isActive,
    createdAt,
    updatedAt,
    deletedAt,
  );

  /// Create a copy of TicketQRCodeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketQRCodeDataModelImplCopyWith<_$TicketQRCodeDataModelImpl>
  get copyWith =>
      __$$TicketQRCodeDataModelImplCopyWithImpl<_$TicketQRCodeDataModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketQRCodeDataModelImplToJson(this);
  }
}

abstract class _TicketQRCodeDataModel implements TicketQRCodeDataModel {
  factory _TicketQRCodeDataModel({
    final String? id,
    required final String codeData,
    final bool isActive,
    @TimestampConverter() final DateTime? createdAt,
    @TimestampConverter() final DateTime? updatedAt,
    @TimestampConverter() final DateTime? deletedAt,
  }) = _$TicketQRCodeDataModelImpl;

  factory _TicketQRCodeDataModel.fromJson(Map<String, dynamic> json) =
      _$TicketQRCodeDataModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get codeData;
  @override
  bool get isActive;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get deletedAt;

  /// Create a copy of TicketQRCodeDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketQRCodeDataModelImplCopyWith<_$TicketQRCodeDataModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
