// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
// 商品情報
  String? get id => throw _privateConstructorUsedError;
  int? get exchangeNumber => throw _privateConstructorUsedError; //
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: GenreType.others)
  GenreType? get genre => throw _privateConstructorUsedError;
  String? get desc => throw _privateConstructorUsedError;
  int get stock => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  List<String> get pictureURL => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get expirationFrom => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get expirationTo => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  bool? get isPublish => throw _privateConstructorUsedError; //
  String? get priceId => throw _privateConstructorUsedError; //
// 登録者
  String? get register => throw _privateConstructorUsedError; // 開催者
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get organizerDocRef =>
      throw _privateConstructorUsedError;
  String? get organizerId => throw _privateConstructorUsedError; // イベント情報
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get eventDocRef =>
      throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String? get eventName => throw _privateConstructorUsedError;
  bool? get expirationLink => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get salesStart => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get salesEnd => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String? id,
      int? exchangeNumber,
      String? code,
      String? name,
      @JsonKey(unknownEnumValue: GenreType.others)
          GenreType? genre,
      String? desc,
      int stock,
      int price,
      List<String> pictureURL,
      @timestampKey
          DateTime? expirationFrom,
      @timestampKey
          DateTime? expirationTo,
      bool? isActive,
      bool? isPublish,
      String? priceId,
      String? register,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? organizerDocRef,
      String? organizerId,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? eventDocRef,
      String? eventId,
      String? eventName,
      bool? expirationLink,
      @timestampKey
          DateTime? salesStart,
      @timestampKey
          DateTime? salesEnd,
      @timestampKey
          DateTime? createdAt,
      @timestampKey
          DateTime? updatedAt,
      @timestampKey
          DateTime? deletedAt});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? exchangeNumber = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? genre = freezed,
    Object? desc = freezed,
    Object? stock = null,
    Object? price = null,
    Object? pictureURL = null,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? isActive = freezed,
    Object? isPublish = freezed,
    Object? priceId = freezed,
    Object? register = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? expirationLink = freezed,
    Object? salesStart = freezed,
    Object? salesEnd = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeNumber: freezed == exchangeNumber
          ? _value.exchangeNumber
          : exchangeNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as GenreType?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      pictureURL: null == pictureURL
          ? _value.pictureURL
          : pictureURL // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expirationFrom: freezed == expirationFrom
          ? _value.expirationFrom
          : expirationFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expirationTo: freezed == expirationTo
          ? _value.expirationTo
          : expirationTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPublish: freezed == isPublish
          ? _value.isPublish
          : isPublish // ignore: cast_nullable_to_non_nullable
              as bool?,
      priceId: freezed == priceId
          ? _value.priceId
          : priceId // ignore: cast_nullable_to_non_nullable
              as String?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerDocRef: freezed == organizerDocRef
          ? _value.organizerDocRef
          : organizerDocRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Map<String, dynamic>>?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDocRef: freezed == eventDocRef
          ? _value.eventDocRef
          : eventDocRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Map<String, dynamic>>?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationLink: freezed == expirationLink
          ? _value.expirationLink
          : expirationLink // ignore: cast_nullable_to_non_nullable
              as bool?,
      salesStart: freezed == salesStart
          ? _value.salesStart
          : salesStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salesEnd: freezed == salesEnd
          ? _value.salesEnd
          : salesEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$_ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_ProductCopyWith(
          _$_Product value, $Res Function(_$_Product) then) =
      __$$_ProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? exchangeNumber,
      String? code,
      String? name,
      @JsonKey(unknownEnumValue: GenreType.others)
          GenreType? genre,
      String? desc,
      int stock,
      int price,
      List<String> pictureURL,
      @timestampKey
          DateTime? expirationFrom,
      @timestampKey
          DateTime? expirationTo,
      bool? isActive,
      bool? isPublish,
      String? priceId,
      String? register,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? organizerDocRef,
      String? organizerId,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? eventDocRef,
      String? eventId,
      String? eventName,
      bool? expirationLink,
      @timestampKey
          DateTime? salesStart,
      @timestampKey
          DateTime? salesEnd,
      @timestampKey
          DateTime? createdAt,
      @timestampKey
          DateTime? updatedAt,
      @timestampKey
          DateTime? deletedAt});
}

/// @nodoc
class __$$_ProductCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$_Product>
    implements _$$_ProductCopyWith<$Res> {
  __$$_ProductCopyWithImpl(_$_Product _value, $Res Function(_$_Product) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? exchangeNumber = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? genre = freezed,
    Object? desc = freezed,
    Object? stock = null,
    Object? price = null,
    Object? pictureURL = null,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? isActive = freezed,
    Object? isPublish = freezed,
    Object? priceId = freezed,
    Object? register = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? expirationLink = freezed,
    Object? salesStart = freezed,
    Object? salesEnd = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_Product(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeNumber: freezed == exchangeNumber
          ? _value.exchangeNumber
          : exchangeNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as GenreType?,
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      pictureURL: null == pictureURL
          ? _value._pictureURL
          : pictureURL // ignore: cast_nullable_to_non_nullable
              as List<String>,
      expirationFrom: freezed == expirationFrom
          ? _value.expirationFrom
          : expirationFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expirationTo: freezed == expirationTo
          ? _value.expirationTo
          : expirationTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPublish: freezed == isPublish
          ? _value.isPublish
          : isPublish // ignore: cast_nullable_to_non_nullable
              as bool?,
      priceId: freezed == priceId
          ? _value.priceId
          : priceId // ignore: cast_nullable_to_non_nullable
              as String?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as String?,
      organizerDocRef: freezed == organizerDocRef
          ? _value.organizerDocRef
          : organizerDocRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Map<String, dynamic>>?,
      organizerId: freezed == organizerId
          ? _value.organizerId
          : organizerId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDocRef: freezed == eventDocRef
          ? _value.eventDocRef
          : eventDocRef // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Map<String, dynamic>>?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      expirationLink: freezed == expirationLink
          ? _value.expirationLink
          : expirationLink // ignore: cast_nullable_to_non_nullable
              as bool?,
      salesStart: freezed == salesStart
          ? _value.salesStart
          : salesStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salesEnd: freezed == salesEnd
          ? _value.salesEnd
          : salesEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$_Product extends _Product {
  const _$_Product(
      {this.id,
      this.exchangeNumber,
      this.code,
      required this.name,
      @JsonKey(unknownEnumValue: GenreType.others) required this.genre,
      required this.desc,
      this.stock = 0,
      this.price = 50,
      final List<String> pictureURL = const [],
      @timestampKey required this.expirationFrom,
      @timestampKey required this.expirationTo,
      required this.isActive,
      required this.isPublish,
      this.priceId,
      this.register,
      @documentReferenceKey this.organizerDocRef,
      this.organizerId,
      @documentReferenceKey this.eventDocRef,
      this.eventId,
      this.eventName,
      this.expirationLink,
      @timestampKey required this.salesStart,
      @timestampKey required this.salesEnd,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : _pictureURL = pictureURL,
        super._();

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$$_ProductFromJson(json);

// 商品情報
  @override
  final String? id;
  @override
  final int? exchangeNumber;
//
  @override
  final String? code;
  @override
  final String? name;
  @override
  @JsonKey(unknownEnumValue: GenreType.others)
  final GenreType? genre;
  @override
  final String? desc;
  @override
  @JsonKey()
  final int stock;
  @override
  @JsonKey()
  final int price;
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
  final DateTime? expirationFrom;
  @override
  @timestampKey
  final DateTime? expirationTo;
  @override
  final bool? isActive;
  @override
  final bool? isPublish;
//
  @override
  final String? priceId;
//
// 登録者
  @override
  final String? register;
// 開催者
  @override
  @documentReferenceKey
  final DocumentReference<Map<String, dynamic>>? organizerDocRef;
  @override
  final String? organizerId;
// イベント情報
  @override
  @documentReferenceKey
  final DocumentReference<Map<String, dynamic>>? eventDocRef;
  @override
  final String? eventId;
  @override
  final String? eventName;
  @override
  final bool? expirationLink;
  @override
  @timestampKey
  final DateTime? salesStart;
  @override
  @timestampKey
  final DateTime? salesEnd;
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
    return 'Product(id: $id, exchangeNumber: $exchangeNumber, code: $code, name: $name, genre: $genre, desc: $desc, stock: $stock, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, isActive: $isActive, isPublish: $isPublish, priceId: $priceId, register: $register, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, expirationLink: $expirationLink, salesStart: $salesStart, salesEnd: $salesEnd, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Product &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exchangeNumber, exchangeNumber) ||
                other.exchangeNumber == exchangeNumber) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.genre, genre) || other.genre == genre) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other._pictureURL, _pictureURL) &&
            (identical(other.expirationFrom, expirationFrom) ||
                other.expirationFrom == expirationFrom) &&
            (identical(other.expirationTo, expirationTo) ||
                other.expirationTo == expirationTo) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPublish, isPublish) ||
                other.isPublish == isPublish) &&
            (identical(other.priceId, priceId) || other.priceId == priceId) &&
            (identical(other.register, register) ||
                other.register == register) &&
            (identical(other.organizerDocRef, organizerDocRef) ||
                other.organizerDocRef == organizerDocRef) &&
            (identical(other.organizerId, organizerId) ||
                other.organizerId == organizerId) &&
            (identical(other.eventDocRef, eventDocRef) ||
                other.eventDocRef == eventDocRef) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.expirationLink, expirationLink) ||
                other.expirationLink == expirationLink) &&
            (identical(other.salesStart, salesStart) ||
                other.salesStart == salesStart) &&
            (identical(other.salesEnd, salesEnd) ||
                other.salesEnd == salesEnd) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        exchangeNumber,
        code,
        name,
        genre,
        desc,
        stock,
        price,
        const DeepCollectionEquality().hash(_pictureURL),
        expirationFrom,
        expirationTo,
        isActive,
        isPublish,
        priceId,
        register,
        organizerDocRef,
        organizerId,
        eventDocRef,
        eventId,
        eventName,
        expirationLink,
        salesStart,
        salesEnd,
        createdAt,
        updatedAt,
        deletedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      __$$_ProductCopyWithImpl<_$_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductToJson(
      this,
    );
  }
}

abstract class _Product extends Product {
  const factory _Product(
      {final String? id,
      final int? exchangeNumber,
      final String? code,
      required final String? name,
      @JsonKey(unknownEnumValue: GenreType.others)
          required final GenreType? genre,
      required final String? desc,
      final int stock,
      final int price,
      final List<String> pictureURL,
      @timestampKey
          required final DateTime? expirationFrom,
      @timestampKey
          required final DateTime? expirationTo,
      required final bool? isActive,
      required final bool? isPublish,
      final String? priceId,
      final String? register,
      @documentReferenceKey
          final DocumentReference<Map<String, dynamic>>? organizerDocRef,
      final String? organizerId,
      @documentReferenceKey
          final DocumentReference<Map<String, dynamic>>? eventDocRef,
      final String? eventId,
      final String? eventName,
      final bool? expirationLink,
      @timestampKey
          required final DateTime? salesStart,
      @timestampKey
          required final DateTime? salesEnd,
      @timestampKey
          final DateTime? createdAt,
      @timestampKey
          final DateTime? updatedAt,
      @timestampKey
          final DateTime? deletedAt}) = _$_Product;
  const _Product._() : super._();

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override // 商品情報
  String? get id;
  @override
  int? get exchangeNumber;
  @override //
  String? get code;
  @override
  String? get name;
  @override
  @JsonKey(unknownEnumValue: GenreType.others)
  GenreType? get genre;
  @override
  String? get desc;
  @override
  int get stock;
  @override
  int get price;
  @override
  List<String> get pictureURL;
  @override
  @timestampKey
  DateTime? get expirationFrom;
  @override
  @timestampKey
  DateTime? get expirationTo;
  @override
  bool? get isActive;
  @override
  bool? get isPublish;
  @override //
  String? get priceId;
  @override //
// 登録者
  String? get register;
  @override // 開催者
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get organizerDocRef;
  @override
  String? get organizerId;
  @override // イベント情報
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get eventDocRef;
  @override
  String? get eventId;
  @override
  String? get eventName;
  @override
  bool? get expirationLink;
  @override
  @timestampKey
  DateTime? get salesStart;
  @override
  @timestampKey
  DateTime? get salesEnd;
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
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductQueryParameter _$ProductQueryParameterFromJson(
    Map<String, dynamic> json) {
  return _ProductQueryParameter.fromJson(json);
}

/// @nodoc
mixin _$ProductQueryParameter {
  String? get programId => throw _privateConstructorUsedError;
  GenreType? get genre => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductQueryParameterCopyWith<ProductQueryParameter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductQueryParameterCopyWith<$Res> {
  factory $ProductQueryParameterCopyWith(ProductQueryParameter value,
          $Res Function(ProductQueryParameter) then) =
      _$ProductQueryParameterCopyWithImpl<$Res, ProductQueryParameter>;
  @useResult
  $Res call({String? programId, GenreType? genre});
}

/// @nodoc
class _$ProductQueryParameterCopyWithImpl<$Res,
        $Val extends ProductQueryParameter>
    implements $ProductQueryParameterCopyWith<$Res> {
  _$ProductQueryParameterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programId = freezed,
    Object? genre = freezed,
  }) {
    return _then(_value.copyWith(
      programId: freezed == programId
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String?,
      genre: freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as GenreType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductQueryParameterCopyWith<$Res>
    implements $ProductQueryParameterCopyWith<$Res> {
  factory _$$_ProductQueryParameterCopyWith(_$_ProductQueryParameter value,
          $Res Function(_$_ProductQueryParameter) then) =
      __$$_ProductQueryParameterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? programId, GenreType? genre});
}

/// @nodoc
class __$$_ProductQueryParameterCopyWithImpl<$Res>
    extends _$ProductQueryParameterCopyWithImpl<$Res, _$_ProductQueryParameter>
    implements _$$_ProductQueryParameterCopyWith<$Res> {
  __$$_ProductQueryParameterCopyWithImpl(_$_ProductQueryParameter _value,
      $Res Function(_$_ProductQueryParameter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programId = freezed,
    Object? genre = freezed,
  }) {
    return _then(_$_ProductQueryParameter(
      freezed == programId
          ? _value.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == genre
          ? _value.genre
          : genre // ignore: cast_nullable_to_non_nullable
              as GenreType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProductQueryParameter implements _ProductQueryParameter {
  _$_ProductQueryParameter(this.programId, this.genre);

  factory _$_ProductQueryParameter.fromJson(Map<String, dynamic> json) =>
      _$$_ProductQueryParameterFromJson(json);

  @override
  final String? programId;
  @override
  final GenreType? genre;

  @override
  String toString() {
    return 'ProductQueryParameter(programId: $programId, genre: $genre)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductQueryParameter &&
            (identical(other.programId, programId) ||
                other.programId == programId) &&
            (identical(other.genre, genre) || other.genre == genre));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, programId, genre);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductQueryParameterCopyWith<_$_ProductQueryParameter> get copyWith =>
      __$$_ProductQueryParameterCopyWithImpl<_$_ProductQueryParameter>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductQueryParameterToJson(
      this,
    );
  }
}

abstract class _ProductQueryParameter implements ProductQueryParameter {
  factory _ProductQueryParameter(
          final String? programId, final GenreType? genre) =
      _$_ProductQueryParameter;

  factory _ProductQueryParameter.fromJson(Map<String, dynamic> json) =
      _$_ProductQueryParameter.fromJson;

  @override
  String? get programId;
  @override
  GenreType? get genre;
  @override
  @JsonKey(ignore: true)
  _$$_ProductQueryParameterCopyWith<_$_ProductQueryParameter> get copyWith =>
      throw _privateConstructorUsedError;
}
