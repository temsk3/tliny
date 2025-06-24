// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String? get id => throw _privateConstructorUsedError;
  StatusType? get status => throw _privateConstructorUsedError;
  String? get paymentIntentId => throw _privateConstructorUsedError;
  String? get checkoutSessionId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get purchaseTime => throw _privateConstructorUsedError;
  List<SnapshotProduct>? get snapshotProducts =>
      throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call({
    String? id,
    StatusType? status,
    String? paymentIntentId,
    String? checkoutSessionId,
    String? userId,
    String? eventId,
    @timestampKey DateTime? purchaseTime,
    List<SnapshotProduct>? snapshotProducts,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? paymentIntentId = freezed,
    Object? checkoutSessionId = freezed,
    Object? userId = freezed,
    Object? eventId = freezed,
    Object? purchaseTime = freezed,
    Object? snapshotProducts = freezed,
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
            status:
                freezed == status
                    ? _value.status
                    : status // ignore: cast_nullable_to_non_nullable
                        as StatusType?,
            paymentIntentId:
                freezed == paymentIntentId
                    ? _value.paymentIntentId
                    : paymentIntentId // ignore: cast_nullable_to_non_nullable
                        as String?,
            checkoutSessionId:
                freezed == checkoutSessionId
                    ? _value.checkoutSessionId
                    : checkoutSessionId // ignore: cast_nullable_to_non_nullable
                        as String?,
            userId:
                freezed == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String?,
            eventId:
                freezed == eventId
                    ? _value.eventId
                    : eventId // ignore: cast_nullable_to_non_nullable
                        as String?,
            purchaseTime:
                freezed == purchaseTime
                    ? _value.purchaseTime
                    : purchaseTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            snapshotProducts:
                freezed == snapshotProducts
                    ? _value.snapshotProducts
                    : snapshotProducts // ignore: cast_nullable_to_non_nullable
                        as List<SnapshotProduct>?,
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
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
    _$OrderImpl value,
    $Res Function(_$OrderImpl) then,
  ) = __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    StatusType? status,
    String? paymentIntentId,
    String? checkoutSessionId,
    String? userId,
    String? eventId,
    @timestampKey DateTime? purchaseTime,
    List<SnapshotProduct>? snapshotProducts,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
    _$OrderImpl _value,
    $Res Function(_$OrderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? paymentIntentId = freezed,
    Object? checkoutSessionId = freezed,
    Object? userId = freezed,
    Object? eventId = freezed,
    Object? purchaseTime = freezed,
    Object? snapshotProducts = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$OrderImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        status:
            freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                    as StatusType?,
        paymentIntentId:
            freezed == paymentIntentId
                ? _value.paymentIntentId
                : paymentIntentId // ignore: cast_nullable_to_non_nullable
                    as String?,
        checkoutSessionId:
            freezed == checkoutSessionId
                ? _value.checkoutSessionId
                : checkoutSessionId // ignore: cast_nullable_to_non_nullable
                    as String?,
        userId:
            freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String?,
        eventId:
            freezed == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                    as String?,
        purchaseTime:
            freezed == purchaseTime
                ? _value.purchaseTime
                : purchaseTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        snapshotProducts:
            freezed == snapshotProducts
                ? _value._snapshotProducts
                : snapshotProducts // ignore: cast_nullable_to_non_nullable
                    as List<SnapshotProduct>?,
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

@JsonSerializable(explicitToJson: true)
class _$OrderImpl implements _Order {
  const _$OrderImpl({
    this.id,
    this.status,
    this.paymentIntentId,
    this.checkoutSessionId,
    this.userId,
    this.eventId,
    @timestampKey this.purchaseTime,
    final List<SnapshotProduct>? snapshotProducts,
    @timestampKey this.createdAt,
    @timestampKey this.updatedAt,
    @timestampKey this.deletedAt,
  }) : _snapshotProducts = snapshotProducts;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final String? id;
  @override
  final StatusType? status;
  @override
  final String? paymentIntentId;
  @override
  final String? checkoutSessionId;
  @override
  final String? userId;
  @override
  final String? eventId;
  @override
  @timestampKey
  final DateTime? purchaseTime;
  final List<SnapshotProduct>? _snapshotProducts;
  @override
  List<SnapshotProduct>? get snapshotProducts {
    final value = _snapshotProducts;
    if (value == null) return null;
    if (_snapshotProducts is EqualUnmodifiableListView)
      return _snapshotProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
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
  String toString() {
    return 'Order(id: $id, status: $status, paymentIntentId: $paymentIntentId, checkoutSessionId: $checkoutSessionId, userId: $userId, eventId: $eventId, purchaseTime: $purchaseTime, snapshotProducts: $snapshotProducts, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentIntentId, paymentIntentId) ||
                other.paymentIntentId == paymentIntentId) &&
            (identical(other.checkoutSessionId, checkoutSessionId) ||
                other.checkoutSessionId == checkoutSessionId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.purchaseTime, purchaseTime) ||
                other.purchaseTime == purchaseTime) &&
            const DeepCollectionEquality().equals(
              other._snapshotProducts,
              _snapshotProducts,
            ) &&
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
    status,
    paymentIntentId,
    checkoutSessionId,
    userId,
    eventId,
    purchaseTime,
    const DeepCollectionEquality().hash(_snapshotProducts),
    createdAt,
    updatedAt,
    deletedAt,
  );

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(this);
  }
}

abstract class _Order implements Order {
  const factory _Order({
    final String? id,
    final StatusType? status,
    final String? paymentIntentId,
    final String? checkoutSessionId,
    final String? userId,
    final String? eventId,
    @timestampKey final DateTime? purchaseTime,
    final List<SnapshotProduct>? snapshotProducts,
    @timestampKey final DateTime? createdAt,
    @timestampKey final DateTime? updatedAt,
    @timestampKey final DateTime? deletedAt,
  }) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  String? get id;
  @override
  StatusType? get status;
  @override
  String? get paymentIntentId;
  @override
  String? get checkoutSessionId;
  @override
  String? get userId;
  @override
  String? get eventId;
  @override
  @timestampKey
  DateTime? get purchaseTime;
  @override
  List<SnapshotProduct>? get snapshotProducts;
  @override
  @timestampKey
  DateTime? get createdAt;
  @override
  @timestampKey
  DateTime? get updatedAt;
  @override
  @timestampKey
  DateTime? get deletedAt;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnapshotProduct _$SnapshotProductFromJson(Map<String, dynamic> json) {
  return _SnapshotProduct.fromJson(json);
}

/// @nodoc
mixin _$SnapshotProduct {
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get productDocRef =>
      throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError; // 購入者
  String? get userId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError; // 商品情報
  String? get productId => throw _privateConstructorUsedError;
  int? get exchangeNumber => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError; // genre: string
  String? get desc => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  List<String>? get pictureURL => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get expirationFrom => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get expirationTo => throw _privateConstructorUsedError; // 登録者
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
  bool get expirationLink => throw _privateConstructorUsedError; // Stripe
  String? get priceId => throw _privateConstructorUsedError;

  /// Serializes this SnapshotProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnapshotProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnapshotProductCopyWith<SnapshotProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnapshotProductCopyWith<$Res> {
  factory $SnapshotProductCopyWith(
    SnapshotProduct value,
    $Res Function(SnapshotProduct) then,
  ) = _$SnapshotProductCopyWithImpl<$Res, SnapshotProduct>;
  @useResult
  $Res call({
    @documentReferenceKey
    DocumentReference<Map<String, dynamic>>? productDocRef,
    int? quantity,
    String? userId,
    String? userName,
    String? productId,
    int? exchangeNumber,
    String? code,
    String? name,
    String? desc,
    int? price,
    List<String>? pictureURL,
    @timestampKey DateTime? expirationFrom,
    @timestampKey DateTime? expirationTo,
    String? register,
    @documentReferenceKey
    DocumentReference<Map<String, dynamic>>? organizerDocRef,
    String? organizerId,
    @documentReferenceKey DocumentReference<Map<String, dynamic>>? eventDocRef,
    String? eventId,
    String? eventName,
    bool expirationLink,
    String? priceId,
  });
}

/// @nodoc
class _$SnapshotProductCopyWithImpl<$Res, $Val extends SnapshotProduct>
    implements $SnapshotProductCopyWith<$Res> {
  _$SnapshotProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnapshotProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productDocRef = freezed,
    Object? quantity = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? productId = freezed,
    Object? exchangeNumber = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? price = freezed,
    Object? pictureURL = freezed,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? register = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? expirationLink = null,
    Object? priceId = freezed,
  }) {
    return _then(
      _value.copyWith(
            productDocRef:
                freezed == productDocRef
                    ? _value.productDocRef
                    : productDocRef // ignore: cast_nullable_to_non_nullable
                        as DocumentReference<Map<String, dynamic>>?,
            quantity:
                freezed == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int?,
            userId:
                freezed == userId
                    ? _value.userId
                    : userId // ignore: cast_nullable_to_non_nullable
                        as String?,
            userName:
                freezed == userName
                    ? _value.userName
                    : userName // ignore: cast_nullable_to_non_nullable
                        as String?,
            productId:
                freezed == productId
                    ? _value.productId
                    : productId // ignore: cast_nullable_to_non_nullable
                        as String?,
            exchangeNumber:
                freezed == exchangeNumber
                    ? _value.exchangeNumber
                    : exchangeNumber // ignore: cast_nullable_to_non_nullable
                        as int?,
            code:
                freezed == code
                    ? _value.code
                    : code // ignore: cast_nullable_to_non_nullable
                        as String?,
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            desc:
                freezed == desc
                    ? _value.desc
                    : desc // ignore: cast_nullable_to_non_nullable
                        as String?,
            price:
                freezed == price
                    ? _value.price
                    : price // ignore: cast_nullable_to_non_nullable
                        as int?,
            pictureURL:
                freezed == pictureURL
                    ? _value.pictureURL
                    : pictureURL // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
            expirationFrom:
                freezed == expirationFrom
                    ? _value.expirationFrom
                    : expirationFrom // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            expirationTo:
                freezed == expirationTo
                    ? _value.expirationTo
                    : expirationTo // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            register:
                freezed == register
                    ? _value.register
                    : register // ignore: cast_nullable_to_non_nullable
                        as String?,
            organizerDocRef:
                freezed == organizerDocRef
                    ? _value.organizerDocRef
                    : organizerDocRef // ignore: cast_nullable_to_non_nullable
                        as DocumentReference<Map<String, dynamic>>?,
            organizerId:
                freezed == organizerId
                    ? _value.organizerId
                    : organizerId // ignore: cast_nullable_to_non_nullable
                        as String?,
            eventDocRef:
                freezed == eventDocRef
                    ? _value.eventDocRef
                    : eventDocRef // ignore: cast_nullable_to_non_nullable
                        as DocumentReference<Map<String, dynamic>>?,
            eventId:
                freezed == eventId
                    ? _value.eventId
                    : eventId // ignore: cast_nullable_to_non_nullable
                        as String?,
            eventName:
                freezed == eventName
                    ? _value.eventName
                    : eventName // ignore: cast_nullable_to_non_nullable
                        as String?,
            expirationLink:
                null == expirationLink
                    ? _value.expirationLink
                    : expirationLink // ignore: cast_nullable_to_non_nullable
                        as bool,
            priceId:
                freezed == priceId
                    ? _value.priceId
                    : priceId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SnapshotProductImplCopyWith<$Res>
    implements $SnapshotProductCopyWith<$Res> {
  factory _$$SnapshotProductImplCopyWith(
    _$SnapshotProductImpl value,
    $Res Function(_$SnapshotProductImpl) then,
  ) = __$$SnapshotProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @documentReferenceKey
    DocumentReference<Map<String, dynamic>>? productDocRef,
    int? quantity,
    String? userId,
    String? userName,
    String? productId,
    int? exchangeNumber,
    String? code,
    String? name,
    String? desc,
    int? price,
    List<String>? pictureURL,
    @timestampKey DateTime? expirationFrom,
    @timestampKey DateTime? expirationTo,
    String? register,
    @documentReferenceKey
    DocumentReference<Map<String, dynamic>>? organizerDocRef,
    String? organizerId,
    @documentReferenceKey DocumentReference<Map<String, dynamic>>? eventDocRef,
    String? eventId,
    String? eventName,
    bool expirationLink,
    String? priceId,
  });
}

/// @nodoc
class __$$SnapshotProductImplCopyWithImpl<$Res>
    extends _$SnapshotProductCopyWithImpl<$Res, _$SnapshotProductImpl>
    implements _$$SnapshotProductImplCopyWith<$Res> {
  __$$SnapshotProductImplCopyWithImpl(
    _$SnapshotProductImpl _value,
    $Res Function(_$SnapshotProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SnapshotProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productDocRef = freezed,
    Object? quantity = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? productId = freezed,
    Object? exchangeNumber = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? price = freezed,
    Object? pictureURL = freezed,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? register = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? expirationLink = null,
    Object? priceId = freezed,
  }) {
    return _then(
      _$SnapshotProductImpl(
        productDocRef:
            freezed == productDocRef
                ? _value.productDocRef
                : productDocRef // ignore: cast_nullable_to_non_nullable
                    as DocumentReference<Map<String, dynamic>>?,
        quantity:
            freezed == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int?,
        userId:
            freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                    as String?,
        userName:
            freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                    as String?,
        productId:
            freezed == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                    as String?,
        exchangeNumber:
            freezed == exchangeNumber
                ? _value.exchangeNumber
                : exchangeNumber // ignore: cast_nullable_to_non_nullable
                    as int?,
        code:
            freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                    as String?,
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        desc:
            freezed == desc
                ? _value.desc
                : desc // ignore: cast_nullable_to_non_nullable
                    as String?,
        price:
            freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                    as int?,
        pictureURL:
            freezed == pictureURL
                ? _value._pictureURL
                : pictureURL // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
        expirationFrom:
            freezed == expirationFrom
                ? _value.expirationFrom
                : expirationFrom // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        expirationTo:
            freezed == expirationTo
                ? _value.expirationTo
                : expirationTo // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        register:
            freezed == register
                ? _value.register
                : register // ignore: cast_nullable_to_non_nullable
                    as String?,
        organizerDocRef:
            freezed == organizerDocRef
                ? _value.organizerDocRef
                : organizerDocRef // ignore: cast_nullable_to_non_nullable
                    as DocumentReference<Map<String, dynamic>>?,
        organizerId:
            freezed == organizerId
                ? _value.organizerId
                : organizerId // ignore: cast_nullable_to_non_nullable
                    as String?,
        eventDocRef:
            freezed == eventDocRef
                ? _value.eventDocRef
                : eventDocRef // ignore: cast_nullable_to_non_nullable
                    as DocumentReference<Map<String, dynamic>>?,
        eventId:
            freezed == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                    as String?,
        eventName:
            freezed == eventName
                ? _value.eventName
                : eventName // ignore: cast_nullable_to_non_nullable
                    as String?,
        expirationLink:
            null == expirationLink
                ? _value.expirationLink
                : expirationLink // ignore: cast_nullable_to_non_nullable
                    as bool,
        priceId:
            freezed == priceId
                ? _value.priceId
                : priceId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SnapshotProductImpl implements _SnapshotProduct {
  const _$SnapshotProductImpl({
    @documentReferenceKey this.productDocRef,
    this.quantity,
    this.userId,
    this.userName,
    this.productId,
    this.exchangeNumber,
    this.code,
    this.name,
    this.desc,
    this.price,
    final List<String>? pictureURL,
    @timestampKey this.expirationFrom,
    @timestampKey this.expirationTo,
    this.register,
    @documentReferenceKey this.organizerDocRef,
    this.organizerId,
    @documentReferenceKey this.eventDocRef,
    this.eventId,
    this.eventName,
    this.expirationLink = true,
    this.priceId,
  }) : _pictureURL = pictureURL;

  factory _$SnapshotProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnapshotProductImplFromJson(json);

  @override
  @documentReferenceKey
  final DocumentReference<Map<String, dynamic>>? productDocRef;
  @override
  final int? quantity;
  // 購入者
  @override
  final String? userId;
  @override
  final String? userName;
  // 商品情報
  @override
  final String? productId;
  @override
  final int? exchangeNumber;
  @override
  final String? code;
  @override
  final String? name;
  // genre: string
  @override
  final String? desc;
  @override
  final int? price;
  final List<String>? _pictureURL;
  @override
  List<String>? get pictureURL {
    final value = _pictureURL;
    if (value == null) return null;
    if (_pictureURL is EqualUnmodifiableListView) return _pictureURL;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @timestampKey
  final DateTime? expirationFrom;
  @override
  @timestampKey
  final DateTime? expirationTo;
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
  @JsonKey()
  final bool expirationLink;
  // Stripe
  @override
  final String? priceId;

  @override
  String toString() {
    return 'SnapshotProduct(productDocRef: $productDocRef, quantity: $quantity, userId: $userId, userName: $userName, productId: $productId, exchangeNumber: $exchangeNumber, code: $code, name: $name, desc: $desc, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, register: $register, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, expirationLink: $expirationLink, priceId: $priceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnapshotProductImpl &&
            (identical(other.productDocRef, productDocRef) ||
                other.productDocRef == productDocRef) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.exchangeNumber, exchangeNumber) ||
                other.exchangeNumber == exchangeNumber) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality().equals(
              other._pictureURL,
              _pictureURL,
            ) &&
            (identical(other.expirationFrom, expirationFrom) ||
                other.expirationFrom == expirationFrom) &&
            (identical(other.expirationTo, expirationTo) ||
                other.expirationTo == expirationTo) &&
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
            (identical(other.priceId, priceId) || other.priceId == priceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    productDocRef,
    quantity,
    userId,
    userName,
    productId,
    exchangeNumber,
    code,
    name,
    desc,
    price,
    const DeepCollectionEquality().hash(_pictureURL),
    expirationFrom,
    expirationTo,
    register,
    organizerDocRef,
    organizerId,
    eventDocRef,
    eventId,
    eventName,
    expirationLink,
    priceId,
  ]);

  /// Create a copy of SnapshotProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnapshotProductImplCopyWith<_$SnapshotProductImpl> get copyWith =>
      __$$SnapshotProductImplCopyWithImpl<_$SnapshotProductImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SnapshotProductImplToJson(this);
  }
}

abstract class _SnapshotProduct implements SnapshotProduct {
  const factory _SnapshotProduct({
    @documentReferenceKey
    final DocumentReference<Map<String, dynamic>>? productDocRef,
    final int? quantity,
    final String? userId,
    final String? userName,
    final String? productId,
    final int? exchangeNumber,
    final String? code,
    final String? name,
    final String? desc,
    final int? price,
    final List<String>? pictureURL,
    @timestampKey final DateTime? expirationFrom,
    @timestampKey final DateTime? expirationTo,
    final String? register,
    @documentReferenceKey
    final DocumentReference<Map<String, dynamic>>? organizerDocRef,
    final String? organizerId,
    @documentReferenceKey
    final DocumentReference<Map<String, dynamic>>? eventDocRef,
    final String? eventId,
    final String? eventName,
    final bool expirationLink,
    final String? priceId,
  }) = _$SnapshotProductImpl;

  factory _SnapshotProduct.fromJson(Map<String, dynamic> json) =
      _$SnapshotProductImpl.fromJson;

  @override
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get productDocRef;
  @override
  int? get quantity; // 購入者
  @override
  String? get userId;
  @override
  String? get userName; // 商品情報
  @override
  String? get productId;
  @override
  int? get exchangeNumber;
  @override
  String? get code;
  @override
  String? get name; // genre: string
  @override
  String? get desc;
  @override
  int? get price;
  @override
  List<String>? get pictureURL;
  @override
  @timestampKey
  DateTime? get expirationFrom;
  @override
  @timestampKey
  DateTime? get expirationTo; // 登録者
  @override
  String? get register; // 開催者
  @override
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get organizerDocRef;
  @override
  String? get organizerId; // イベント情報
  @override
  @documentReferenceKey
  DocumentReference<Map<String, dynamic>>? get eventDocRef;
  @override
  String? get eventId;
  @override
  String? get eventName;
  @override
  bool get expirationLink; // Stripe
  @override
  String? get priceId;

  /// Create a copy of SnapshotProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnapshotProductImplCopyWith<_$SnapshotProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
