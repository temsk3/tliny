// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Program _$ProgramFromJson(Map<String, dynamic> json) {
  return _Program.fromJson(json);
}

/// @nodoc
mixin _$Program {
  String? get id => throw _privateConstructorUsedError;
  String? get organizerId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get salesStart => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get salesEnd => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get eventFrom => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get eventTo => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String? get storageId => throw _privateConstructorUsedError;
  List<String> get pictureURL => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  bool? get isPublish => throw _privateConstructorUsedError; //
  bool get isSecret => throw _privateConstructorUsedError;
  String? get secretUrl => throw _privateConstructorUsedError;
  String? get staffCode => throw _privateConstructorUsedError;
  List<Staff>? get staff => throw _privateConstructorUsedError;
  List<Product>? get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgramCopyWith<Program> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramCopyWith<$Res> {
  factory $ProgramCopyWith(Program value, $Res Function(Program) then) =
      _$ProgramCopyWithImpl<$Res, Program>;
  @useResult
  $Res call(
      {String? id,
      String? organizerId,
      String? name,
      String? message,
      @timestampKey DateTime? salesStart,
      @timestampKey DateTime? salesEnd,
      @timestampKey DateTime? eventFrom,
      @timestampKey DateTime? eventTo,
      String? place,
      String? storageId,
      List<String> pictureURL,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt,
      bool? isActive,
      bool? isPublish,
      bool isSecret,
      String? secretUrl,
      String? staffCode,
      List<Staff>? staff,
      List<Product>? product});
}

/// @nodoc
class _$ProgramCopyWithImpl<$Res, $Val extends Program>
    implements $ProgramCopyWith<$Res> {
  _$ProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? organizerId = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? salesStart = freezed,
    Object? salesEnd = freezed,
    Object? eventFrom = freezed,
    Object? eventTo = freezed,
    Object? place = freezed,
    Object? storageId = freezed,
    Object? pictureURL = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isActive = freezed,
    Object? isPublish = freezed,
    Object? isSecret = null,
    Object? secretUrl = freezed,
    Object? staffCode = freezed,
    Object? staff = freezed,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      salesStart: freezed == salesStart
          ? _value.salesStart
          : salesStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salesEnd: freezed == salesEnd
          ? _value.salesEnd
          : salesEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventFrom: freezed == eventFrom
          ? _value.eventFrom
          : eventFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventTo: freezed == eventTo
          ? _value.eventTo
          : eventTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
      storageId: freezed == storageId
          ? _value.storageId
          : storageId // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureURL: null == pictureURL
          ? _value.pictureURL
          : pictureURL // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPublish: freezed == isPublish
          ? _value.isPublish
          : isPublish // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSecret: null == isSecret
          ? _value.isSecret
          : isSecret // ignore: cast_nullable_to_non_nullable
              as bool,
      secretUrl: freezed == secretUrl
          ? _value.secretUrl
          : secretUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      staffCode: freezed == staffCode
          ? _value.staffCode
          : staffCode // ignore: cast_nullable_to_non_nullable
              as String?,
      staff: freezed == staff
          ? _value.staff
          : staff // ignore: cast_nullable_to_non_nullable
              as List<Staff>?,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgramImplCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$$ProgramImplCopyWith(
          _$ProgramImpl value, $Res Function(_$ProgramImpl) then) =
      __$$ProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? organizerId,
      String? name,
      String? message,
      @timestampKey DateTime? salesStart,
      @timestampKey DateTime? salesEnd,
      @timestampKey DateTime? eventFrom,
      @timestampKey DateTime? eventTo,
      String? place,
      String? storageId,
      List<String> pictureURL,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt,
      bool? isActive,
      bool? isPublish,
      bool isSecret,
      String? secretUrl,
      String? staffCode,
      List<Staff>? staff,
      List<Product>? product});
}

/// @nodoc
class __$$ProgramImplCopyWithImpl<$Res>
    extends _$ProgramCopyWithImpl<$Res, _$ProgramImpl>
    implements _$$ProgramImplCopyWith<$Res> {
  __$$ProgramImplCopyWithImpl(
      _$ProgramImpl _value, $Res Function(_$ProgramImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? organizerId = freezed,
    Object? name = freezed,
    Object? message = freezed,
    Object? salesStart = freezed,
    Object? salesEnd = freezed,
    Object? eventFrom = freezed,
    Object? eventTo = freezed,
    Object? place = freezed,
    Object? storageId = freezed,
    Object? pictureURL = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isActive = freezed,
    Object? isPublish = freezed,
    Object? isSecret = null,
    Object? secretUrl = freezed,
    Object? staffCode = freezed,
    Object? staff = freezed,
    Object? product = freezed,
  }) {
    return _then(_$ProgramImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      salesStart: freezed == salesStart
          ? _value.salesStart
          : salesStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salesEnd: freezed == salesEnd
          ? _value.salesEnd
          : salesEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventFrom: freezed == eventFrom
          ? _value.eventFrom
          : eventFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventTo: freezed == eventTo
          ? _value.eventTo
          : eventTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
      storageId: freezed == storageId
          ? _value.storageId
          : storageId // ignore: cast_nullable_to_non_nullable
              as String?,
      pictureURL: null == pictureURL
          ? _value._pictureURL
          : pictureURL // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPublish: freezed == isPublish
          ? _value.isPublish
          : isPublish // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSecret: null == isSecret
          ? _value.isSecret
          : isSecret // ignore: cast_nullable_to_non_nullable
              as bool,
      secretUrl: freezed == secretUrl
          ? _value.secretUrl
          : secretUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      staffCode: freezed == staffCode
          ? _value.staffCode
          : staffCode // ignore: cast_nullable_to_non_nullable
              as String?,
      staff: freezed == staff
          ? _value._staff
          : staff // ignore: cast_nullable_to_non_nullable
              as List<Staff>?,
      product: freezed == product
          ? _value._product
          : product // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramImpl extends _Program {
  const _$ProgramImpl(
      {this.id,
      required this.organizerId,
      required this.name,
      required this.message,
      @timestampKey required this.salesStart,
      @timestampKey required this.salesEnd,
      @timestampKey required this.eventFrom,
      @timestampKey required this.eventTo,
      required this.place,
      this.storageId,
      final List<String> pictureURL = const [],
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt,
      required this.isActive,
      required this.isPublish,
      this.isSecret = false,
      this.secretUrl,
      this.staffCode,
      final List<Staff>? staff,
      final List<Product>? product})
      : _pictureURL = pictureURL,
        _staff = staff,
        _product = product,
        super._();

  factory _$ProgramImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramImplFromJson(json);

  @override
  final String? id;
  @override
  final String? organizerId;
  @override
  final String? name;
  @override
  final String? message;
  @override
  @timestampKey
  final DateTime? salesStart;
  @override
  @timestampKey
  final DateTime? salesEnd;
  @override
  @timestampKey
  final DateTime? eventFrom;
  @override
  @timestampKey
  final DateTime? eventTo;
  @override
  final String? place;
  @override
  final String? storageId;
  final List<String> _pictureURL;
  @override
  @JsonKey()
  List<String> get pictureURL {
    if (_pictureURL is EqualUnmodifiableListView) return _pictureURL;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictureURL);
  }

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
  final bool? isActive;
  @override
  final bool? isPublish;
//
  @override
  @JsonKey()
  final bool isSecret;
  @override
  final String? secretUrl;
  @override
  final String? staffCode;
  final List<Staff>? _staff;
  @override
  List<Staff>? get staff {
    final value = _staff;
    if (value == null) return null;
    if (_staff is EqualUnmodifiableListView) return _staff;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Product>? _product;
  @override
  List<Product>? get product {
    final value = _product;
    if (value == null) return null;
    if (_product is EqualUnmodifiableListView) return _product;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Program(id: $id, organizerId: $organizerId, name: $name, message: $message, salesStart: $salesStart, salesEnd: $salesEnd, eventFrom: $eventFrom, eventTo: $eventTo, place: $place, storageId: $storageId, pictureURL: $pictureURL, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isActive: $isActive, isPublish: $isPublish, isSecret: $isSecret, secretUrl: $secretUrl, staffCode: $staffCode, staff: $staff, product: $product)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.salesStart, salesStart) ||
                other.salesStart == salesStart) &&
            (identical(other.salesEnd, salesEnd) ||
                other.salesEnd == salesEnd) &&
            (identical(other.eventFrom, eventFrom) ||
                other.eventFrom == eventFrom) &&
            (identical(other.eventTo, eventTo) || other.eventTo == eventTo) &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.storageId, storageId) ||
                other.storageId == storageId) &&
            const DeepCollectionEquality()
                .equals(other._pictureURL, _pictureURL) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPublish, isPublish) ||
                other.isPublish == isPublish) &&
            (identical(other.isSecret, isSecret) ||
                other.isSecret == isSecret) &&
            (identical(other.secretUrl, secretUrl) ||
                other.secretUrl == secretUrl) &&
            (identical(other.staffCode, staffCode) ||
                other.staffCode == staffCode) &&
            const DeepCollectionEquality().equals(other._staff, _staff) &&
            const DeepCollectionEquality().equals(other._product, _product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizerId,
        name,
        message,
        salesStart,
        salesEnd,
        eventFrom,
        eventTo,
        place,
        storageId,
        const DeepCollectionEquality().hash(_pictureURL),
        createdAt,
        updatedAt,
        deletedAt,
        isActive,
        isPublish,
        isSecret,
        secretUrl,
        staffCode,
        const DeepCollectionEquality().hash(_staff),
        const DeepCollectionEquality().hash(_product)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramImplCopyWith<_$ProgramImpl> get copyWith =>
      __$$ProgramImplCopyWithImpl<_$ProgramImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramImplToJson(
      this,
    );
  }
}

abstract class _Program extends Program {
  const factory _Program(
      {final String? id,
      required final String? organizerId,
      required final String? name,
      required final String? message,
      @timestampKey required final DateTime? salesStart,
      @timestampKey required final DateTime? salesEnd,
      @timestampKey required final DateTime? eventFrom,
      @timestampKey required final DateTime? eventTo,
      required final String? place,
      final String? storageId,
      final List<String> pictureURL,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt,
      required final bool? isActive,
      required final bool? isPublish,
      final bool isSecret,
      final String? secretUrl,
      final String? staffCode,
      final List<Staff>? staff,
      final List<Product>? product}) = _$ProgramImpl;
  const _Program._() : super._();

  factory _Program.fromJson(Map<String, dynamic> json) = _$ProgramImpl.fromJson;

  @override
  String? get id;
  @override
  String? get organizerId;
  @override
  String? get name;
  @override
  String? get message;
  @override
  @timestampKey
  DateTime? get salesStart;
  @override
  @timestampKey
  DateTime? get salesEnd;
  @override
  @timestampKey
  DateTime? get eventFrom;
  @override
  @timestampKey
  DateTime? get eventTo;
  @override
  String? get place;
  @override
  String? get storageId;
  @override
  List<String> get pictureURL;
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
  @override
  bool? get isPublish;
  @override //
  bool get isSecret;
  @override
  String? get secretUrl;
  @override
  String? get staffCode;
  @override
  List<Staff>? get staff;
  @override
  List<Product>? get product;
  @override
  @JsonKey(ignore: true)
  _$$ProgramImplCopyWith<_$ProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
