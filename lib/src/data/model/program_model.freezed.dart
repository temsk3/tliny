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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
  List<String> get pictureURL => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  bool? get isPublish => throw _privateConstructorUsedError; //
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
      List<String> pictureURL,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt,
      bool? isActive,
      bool? isPublish,
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
    Object? pictureURL = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isActive = freezed,
    Object? isPublish = freezed,
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
abstract class _$$_ProgramCopyWith<$Res> implements $ProgramCopyWith<$Res> {
  factory _$$_ProgramCopyWith(
          _$_Program value, $Res Function(_$_Program) then) =
      __$$_ProgramCopyWithImpl<$Res>;
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
      List<String> pictureURL,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt,
      bool? isActive,
      bool? isPublish,
      String? staffCode,
      List<Staff>? staff,
      List<Product>? product});
}

/// @nodoc
class __$$_ProgramCopyWithImpl<$Res>
    extends _$ProgramCopyWithImpl<$Res, _$_Program>
    implements _$$_ProgramCopyWith<$Res> {
  __$$_ProgramCopyWithImpl(_$_Program _value, $Res Function(_$_Program) _then)
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
    Object? pictureURL = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? isActive = freezed,
    Object? isPublish = freezed,
    Object? staffCode = freezed,
    Object? staff = freezed,
    Object? product = freezed,
  }) {
    return _then(_$_Program(
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
class _$_Program extends _Program {
  const _$_Program(
      {this.id,
      required this.organizerId,
      required this.name,
      required this.message,
      @timestampKey required this.salesStart,
      @timestampKey required this.salesEnd,
      @timestampKey required this.eventFrom,
      @timestampKey required this.eventTo,
      required this.place,
      final List<String> pictureURL = const [],
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt,
      required this.isActive,
      required this.isPublish,
      this.staffCode,
      final List<Staff>? staff,
      final List<Product>? product})
      : _pictureURL = pictureURL,
        _staff = staff,
        _product = product,
        super._();

  factory _$_Program.fromJson(Map<String, dynamic> json) =>
      _$$_ProgramFromJson(json);

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
    return 'Program(id: $id, organizerId: $organizerId, name: $name, message: $message, salesStart: $salesStart, salesEnd: $salesEnd, eventFrom: $eventFrom, eventTo: $eventTo, place: $place, pictureURL: $pictureURL, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, isActive: $isActive, isPublish: $isPublish, staffCode: $staffCode, staff: $staff, product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Program &&
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
            (identical(other.staffCode, staffCode) ||
                other.staffCode == staffCode) &&
            const DeepCollectionEquality().equals(other._staff, _staff) &&
            const DeepCollectionEquality().equals(other._product, _product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
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
      const DeepCollectionEquality().hash(_pictureURL),
      createdAt,
      updatedAt,
      deletedAt,
      isActive,
      isPublish,
      staffCode,
      const DeepCollectionEquality().hash(_staff),
      const DeepCollectionEquality().hash(_product));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      __$$_ProgramCopyWithImpl<_$_Program>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgramToJson(
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
      final List<String> pictureURL,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt,
      required final bool? isActive,
      required final bool? isPublish,
      final String? staffCode,
      final List<Staff>? staff,
      final List<Product>? product}) = _$_Program;
  const _Program._() : super._();

  factory _Program.fromJson(Map<String, dynamic> json) = _$_Program.fromJson;

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
  String? get staffCode;
  @override
  List<Staff>? get staff;
  @override
  List<Product>? get product;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramCopyWith<_$_Program> get copyWith =>
      throw _privateConstructorUsedError;
}
