// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return _Ticket.fromJson(json);
}

/// @nodoc
mixin _$Ticket {
  String? get id => throw _privateConstructorUsedError; // 購入者
  String? get paidUserId => throw _privateConstructorUsedError;
  String? get paidUserName => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get purchaseTime => throw _privateConstructorUsedError; // 所有者
  String? get ownerId => throw _privateConstructorUsedError;
  String? get ownerName => throw _privateConstructorUsedError;
  List<Assignment>? get assignment => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isPrinting => throw _privateConstructorUsedError;
  bool get isUsed => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String? get pdfUuid => throw _privateConstructorUsedError; // 商品情報
  @DocumentReferenceNullStringConverter()
  String? get productDocRef => throw _privateConstructorUsedError;
  String? get productId =>
      throw _privateConstructorUsedError; // int? exchangeNumber,
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError; // genre: string
  String? get desc => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  List<String> get pictureURL => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get expirationFrom => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get expirationTo => throw _privateConstructorUsedError; // 登録者
  String? get register => throw _privateConstructorUsedError;
  String? get registerName => throw _privateConstructorUsedError; // 開催者
  @DocumentReferenceNullStringConverter()
  String? get organizerDocRef => throw _privateConstructorUsedError;
  String? get organizerId => throw _privateConstructorUsedError; // イベント情報
  @DocumentReferenceNullStringConverter()
  String? get eventDocRef => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String? get eventName =>
      throw _privateConstructorUsedError; // @Default(true) bool expirationLink,
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call({
    String? id,
    String? paidUserId,
    String? paidUserName,
    @TimestampConverter() DateTime? purchaseTime,
    String? ownerId,
    String? ownerName,
    List<Assignment>? assignment,
    bool isActive,
    bool isPrinting,
    bool isUsed,
    String? uuid,
    String? pdfUuid,
    @DocumentReferenceNullStringConverter() String? productDocRef,
    String? productId,
    String? code,
    String? name,
    String? desc,
    int? price,
    List<String> pictureURL,
    @TimestampConverter() DateTime? expirationFrom,
    @TimestampConverter() DateTime? expirationTo,
    String? register,
    String? registerName,
    @DocumentReferenceNullStringConverter() String? organizerDocRef,
    String? organizerId,
    @DocumentReferenceNullStringConverter() String? eventDocRef,
    String? eventId,
    String? eventName,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
  });
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? paidUserId = freezed,
    Object? paidUserName = freezed,
    Object? purchaseTime = freezed,
    Object? ownerId = freezed,
    Object? ownerName = freezed,
    Object? assignment = freezed,
    Object? isActive = null,
    Object? isPrinting = null,
    Object? isUsed = null,
    Object? uuid = freezed,
    Object? pdfUuid = freezed,
    Object? productDocRef = freezed,
    Object? productId = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? price = freezed,
    Object? pictureURL = null,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? register = freezed,
    Object? registerName = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
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
            paidUserId:
                freezed == paidUserId
                    ? _value.paidUserId
                    : paidUserId // ignore: cast_nullable_to_non_nullable
                        as String?,
            paidUserName:
                freezed == paidUserName
                    ? _value.paidUserName
                    : paidUserName // ignore: cast_nullable_to_non_nullable
                        as String?,
            purchaseTime:
                freezed == purchaseTime
                    ? _value.purchaseTime
                    : purchaseTime // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            ownerId:
                freezed == ownerId
                    ? _value.ownerId
                    : ownerId // ignore: cast_nullable_to_non_nullable
                        as String?,
            ownerName:
                freezed == ownerName
                    ? _value.ownerName
                    : ownerName // ignore: cast_nullable_to_non_nullable
                        as String?,
            assignment:
                freezed == assignment
                    ? _value.assignment
                    : assignment // ignore: cast_nullable_to_non_nullable
                        as List<Assignment>?,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            isPrinting:
                null == isPrinting
                    ? _value.isPrinting
                    : isPrinting // ignore: cast_nullable_to_non_nullable
                        as bool,
            isUsed:
                null == isUsed
                    ? _value.isUsed
                    : isUsed // ignore: cast_nullable_to_non_nullable
                        as bool,
            uuid:
                freezed == uuid
                    ? _value.uuid
                    : uuid // ignore: cast_nullable_to_non_nullable
                        as String?,
            pdfUuid:
                freezed == pdfUuid
                    ? _value.pdfUuid
                    : pdfUuid // ignore: cast_nullable_to_non_nullable
                        as String?,
            productDocRef:
                freezed == productDocRef
                    ? _value.productDocRef
                    : productDocRef // ignore: cast_nullable_to_non_nullable
                        as String?,
            productId:
                freezed == productId
                    ? _value.productId
                    : productId // ignore: cast_nullable_to_non_nullable
                        as String?,
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
                null == pictureURL
                    ? _value.pictureURL
                    : pictureURL // ignore: cast_nullable_to_non_nullable
                        as List<String>,
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
            registerName:
                freezed == registerName
                    ? _value.registerName
                    : registerName // ignore: cast_nullable_to_non_nullable
                        as String?,
            organizerDocRef:
                freezed == organizerDocRef
                    ? _value.organizerDocRef
                    : organizerDocRef // ignore: cast_nullable_to_non_nullable
                        as String?,
            organizerId:
                freezed == organizerId
                    ? _value.organizerId
                    : organizerId // ignore: cast_nullable_to_non_nullable
                        as String?,
            eventDocRef:
                freezed == eventDocRef
                    ? _value.eventDocRef
                    : eventDocRef // ignore: cast_nullable_to_non_nullable
                        as String?,
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
abstract class _$$TicketImplCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$TicketImplCopyWith(
    _$TicketImpl value,
    $Res Function(_$TicketImpl) then,
  ) = __$$TicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? paidUserId,
    String? paidUserName,
    @TimestampConverter() DateTime? purchaseTime,
    String? ownerId,
    String? ownerName,
    List<Assignment>? assignment,
    bool isActive,
    bool isPrinting,
    bool isUsed,
    String? uuid,
    String? pdfUuid,
    @DocumentReferenceNullStringConverter() String? productDocRef,
    String? productId,
    String? code,
    String? name,
    String? desc,
    int? price,
    List<String> pictureURL,
    @TimestampConverter() DateTime? expirationFrom,
    @TimestampConverter() DateTime? expirationTo,
    String? register,
    String? registerName,
    @DocumentReferenceNullStringConverter() String? organizerDocRef,
    String? organizerId,
    @DocumentReferenceNullStringConverter() String? eventDocRef,
    String? eventId,
    String? eventName,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? deletedAt,
  });
}

/// @nodoc
class __$$TicketImplCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$TicketImpl>
    implements _$$TicketImplCopyWith<$Res> {
  __$$TicketImplCopyWithImpl(
    _$TicketImpl _value,
    $Res Function(_$TicketImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? paidUserId = freezed,
    Object? paidUserName = freezed,
    Object? purchaseTime = freezed,
    Object? ownerId = freezed,
    Object? ownerName = freezed,
    Object? assignment = freezed,
    Object? isActive = null,
    Object? isPrinting = null,
    Object? isUsed = null,
    Object? uuid = freezed,
    Object? pdfUuid = freezed,
    Object? productDocRef = freezed,
    Object? productId = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? price = freezed,
    Object? pictureURL = null,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? register = freezed,
    Object? registerName = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$TicketImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        paidUserId:
            freezed == paidUserId
                ? _value.paidUserId
                : paidUserId // ignore: cast_nullable_to_non_nullable
                    as String?,
        paidUserName:
            freezed == paidUserName
                ? _value.paidUserName
                : paidUserName // ignore: cast_nullable_to_non_nullable
                    as String?,
        purchaseTime:
            freezed == purchaseTime
                ? _value.purchaseTime
                : purchaseTime // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        ownerId:
            freezed == ownerId
                ? _value.ownerId
                : ownerId // ignore: cast_nullable_to_non_nullable
                    as String?,
        ownerName:
            freezed == ownerName
                ? _value.ownerName
                : ownerName // ignore: cast_nullable_to_non_nullable
                    as String?,
        assignment:
            freezed == assignment
                ? _value._assignment
                : assignment // ignore: cast_nullable_to_non_nullable
                    as List<Assignment>?,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        isPrinting:
            null == isPrinting
                ? _value.isPrinting
                : isPrinting // ignore: cast_nullable_to_non_nullable
                    as bool,
        isUsed:
            null == isUsed
                ? _value.isUsed
                : isUsed // ignore: cast_nullable_to_non_nullable
                    as bool,
        uuid:
            freezed == uuid
                ? _value.uuid
                : uuid // ignore: cast_nullable_to_non_nullable
                    as String?,
        pdfUuid:
            freezed == pdfUuid
                ? _value.pdfUuid
                : pdfUuid // ignore: cast_nullable_to_non_nullable
                    as String?,
        productDocRef:
            freezed == productDocRef
                ? _value.productDocRef
                : productDocRef // ignore: cast_nullable_to_non_nullable
                    as String?,
        productId:
            freezed == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                    as String?,
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
            null == pictureURL
                ? _value._pictureURL
                : pictureURL // ignore: cast_nullable_to_non_nullable
                    as List<String>,
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
        registerName:
            freezed == registerName
                ? _value.registerName
                : registerName // ignore: cast_nullable_to_non_nullable
                    as String?,
        organizerDocRef:
            freezed == organizerDocRef
                ? _value.organizerDocRef
                : organizerDocRef // ignore: cast_nullable_to_non_nullable
                    as String?,
        organizerId:
            freezed == organizerId
                ? _value.organizerId
                : organizerId // ignore: cast_nullable_to_non_nullable
                    as String?,
        eventDocRef:
            freezed == eventDocRef
                ? _value.eventDocRef
                : eventDocRef // ignore: cast_nullable_to_non_nullable
                    as String?,
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
class _$TicketImpl extends _Ticket {
  const _$TicketImpl({
    this.id,
    this.paidUserId,
    this.paidUserName,
    @TimestampConverter() this.purchaseTime,
    this.ownerId,
    this.ownerName,
    final List<Assignment>? assignment,
    this.isActive = true,
    this.isPrinting = false,
    this.isUsed = false,
    this.uuid,
    this.pdfUuid,
    @DocumentReferenceNullStringConverter() this.productDocRef,
    this.productId,
    this.code,
    this.name,
    this.desc,
    this.price,
    final List<String> pictureURL = const [],
    @TimestampConverter() this.expirationFrom,
    @TimestampConverter() this.expirationTo,
    this.register,
    this.registerName,
    @DocumentReferenceNullStringConverter() this.organizerDocRef,
    this.organizerId,
    @DocumentReferenceNullStringConverter() this.eventDocRef,
    this.eventId,
    this.eventName,
    @TimestampConverter() this.createdAt,
    @TimestampConverter() this.updatedAt,
    @TimestampConverter() this.deletedAt,
  }) : _assignment = assignment,
       _pictureURL = pictureURL,
       super._();

  factory _$TicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketImplFromJson(json);

  @override
  final String? id;
  // 購入者
  @override
  final String? paidUserId;
  @override
  final String? paidUserName;
  @override
  @TimestampConverter()
  final DateTime? purchaseTime;
  // 所有者
  @override
  final String? ownerId;
  @override
  final String? ownerName;
  final List<Assignment>? _assignment;
  @override
  List<Assignment>? get assignment {
    final value = _assignment;
    if (value == null) return null;
    if (_assignment is EqualUnmodifiableListView) return _assignment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isPrinting;
  @override
  @JsonKey()
  final bool isUsed;
  @override
  final String? uuid;
  @override
  final String? pdfUuid;
  // 商品情報
  @override
  @DocumentReferenceNullStringConverter()
  final String? productDocRef;
  @override
  final String? productId;
  // int? exchangeNumber,
  @override
  final String? code;
  @override
  final String? name;
  // genre: string
  @override
  final String? desc;
  @override
  final int? price;
  final List<String> _pictureURL;
  @override
  @JsonKey()
  List<String> get pictureURL {
    if (_pictureURL is EqualUnmodifiableListView) return _pictureURL;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pictureURL);
  }

  @override
  @TimestampConverter()
  final DateTime? expirationFrom;
  @override
  @TimestampConverter()
  final DateTime? expirationTo;
  // 登録者
  @override
  final String? register;
  @override
  final String? registerName;
  // 開催者
  @override
  @DocumentReferenceNullStringConverter()
  final String? organizerDocRef;
  @override
  final String? organizerId;
  // イベント情報
  @override
  @DocumentReferenceNullStringConverter()
  final String? eventDocRef;
  @override
  final String? eventId;
  @override
  final String? eventName;
  // @Default(true) bool expirationLink,
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
    return 'Ticket(id: $id, paidUserId: $paidUserId, paidUserName: $paidUserName, purchaseTime: $purchaseTime, ownerId: $ownerId, ownerName: $ownerName, assignment: $assignment, isActive: $isActive, isPrinting: $isPrinting, isUsed: $isUsed, uuid: $uuid, pdfUuid: $pdfUuid, productDocRef: $productDocRef, productId: $productId, code: $code, name: $name, desc: $desc, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, register: $register, registerName: $registerName, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      __$$TicketImplCopyWithImpl<_$TicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketImplToJson(this);
  }
}

abstract class _Ticket extends Ticket {
  const factory _Ticket({
    final String? id,
    final String? paidUserId,
    final String? paidUserName,
    @TimestampConverter() final DateTime? purchaseTime,
    final String? ownerId,
    final String? ownerName,
    final List<Assignment>? assignment,
    final bool isActive,
    final bool isPrinting,
    final bool isUsed,
    final String? uuid,
    final String? pdfUuid,
    @DocumentReferenceNullStringConverter() final String? productDocRef,
    final String? productId,
    final String? code,
    final String? name,
    final String? desc,
    final int? price,
    final List<String> pictureURL,
    @TimestampConverter() final DateTime? expirationFrom,
    @TimestampConverter() final DateTime? expirationTo,
    final String? register,
    final String? registerName,
    @DocumentReferenceNullStringConverter() final String? organizerDocRef,
    final String? organizerId,
    @DocumentReferenceNullStringConverter() final String? eventDocRef,
    final String? eventId,
    final String? eventName,
    @TimestampConverter() final DateTime? createdAt,
    @TimestampConverter() final DateTime? updatedAt,
    @TimestampConverter() final DateTime? deletedAt,
  }) = _$TicketImpl;
  const _Ticket._() : super._();

  factory _Ticket.fromJson(Map<String, dynamic> json) = _$TicketImpl.fromJson;

  @override
  String? get id; // 購入者
  @override
  String? get paidUserId;
  @override
  String? get paidUserName;
  @override
  @TimestampConverter()
  DateTime? get purchaseTime; // 所有者
  @override
  String? get ownerId;
  @override
  String? get ownerName;
  @override
  List<Assignment>? get assignment;
  @override
  bool get isActive;
  @override
  bool get isPrinting;
  @override
  bool get isUsed;
  @override
  String? get uuid;
  @override
  String? get pdfUuid; // 商品情報
  @override
  @DocumentReferenceNullStringConverter()
  String? get productDocRef;
  @override
  String? get productId; // int? exchangeNumber,
  @override
  String? get code;
  @override
  String? get name; // genre: string
  @override
  String? get desc;
  @override
  int? get price;
  @override
  List<String> get pictureURL;
  @override
  @TimestampConverter()
  DateTime? get expirationFrom;
  @override
  @TimestampConverter()
  DateTime? get expirationTo; // 登録者
  @override
  String? get register;
  @override
  String? get registerName; // 開催者
  @override
  @DocumentReferenceNullStringConverter()
  String? get organizerDocRef;
  @override
  String? get organizerId; // イベント情報
  @override
  @DocumentReferenceNullStringConverter()
  String? get eventDocRef;
  @override
  String? get eventId;
  @override
  String? get eventName; // @Default(true) bool expirationLink,
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get deletedAt;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Assignment _$AssignmentFromJson(Map<String, dynamic> json) {
  return _Assignment.fromJson(json);
}

/// @nodoc
mixin _$Assignment {
  String? get from => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get assignmentDate => throw _privateConstructorUsedError;

  /// Serializes this Assignment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignmentCopyWith<Assignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentCopyWith<$Res> {
  factory $AssignmentCopyWith(
    Assignment value,
    $Res Function(Assignment) then,
  ) = _$AssignmentCopyWithImpl<$Res, Assignment>;
  @useResult
  $Res call({String? from, String? to, @timestampKey DateTime? assignmentDate});
}

/// @nodoc
class _$AssignmentCopyWithImpl<$Res, $Val extends Assignment>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? assignmentDate = freezed,
  }) {
    return _then(
      _value.copyWith(
            from:
                freezed == from
                    ? _value.from
                    : from // ignore: cast_nullable_to_non_nullable
                        as String?,
            to:
                freezed == to
                    ? _value.to
                    : to // ignore: cast_nullable_to_non_nullable
                        as String?,
            assignmentDate:
                freezed == assignmentDate
                    ? _value.assignmentDate
                    : assignmentDate // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssignmentImplCopyWith<$Res>
    implements $AssignmentCopyWith<$Res> {
  factory _$$AssignmentImplCopyWith(
    _$AssignmentImpl value,
    $Res Function(_$AssignmentImpl) then,
  ) = __$$AssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? from, String? to, @timestampKey DateTime? assignmentDate});
}

/// @nodoc
class __$$AssignmentImplCopyWithImpl<$Res>
    extends _$AssignmentCopyWithImpl<$Res, _$AssignmentImpl>
    implements _$$AssignmentImplCopyWith<$Res> {
  __$$AssignmentImplCopyWithImpl(
    _$AssignmentImpl _value,
    $Res Function(_$AssignmentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? assignmentDate = freezed,
  }) {
    return _then(
      _$AssignmentImpl(
        from:
            freezed == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                    as String?,
        to:
            freezed == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                    as String?,
        assignmentDate:
            freezed == assignmentDate
                ? _value.assignmentDate
                : assignmentDate // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentImpl implements _Assignment {
  const _$AssignmentImpl({
    this.from,
    this.to,
    @timestampKey this.assignmentDate,
  });

  factory _$AssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentImplFromJson(json);

  @override
  final String? from;
  @override
  final String? to;
  @override
  @timestampKey
  final DateTime? assignmentDate;

  @override
  String toString() {
    return 'Assignment(from: $from, to: $to, assignmentDate: $assignmentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentImpl &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.assignmentDate, assignmentDate) ||
                other.assignmentDate == assignmentDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, from, to, assignmentDate);

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      __$$AssignmentImplCopyWithImpl<_$AssignmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentImplToJson(this);
  }
}

abstract class _Assignment implements Assignment {
  const factory _Assignment({
    final String? from,
    final String? to,
    @timestampKey final DateTime? assignmentDate,
  }) = _$AssignmentImpl;

  factory _Assignment.fromJson(Map<String, dynamic> json) =
      _$AssignmentImpl.fromJson;

  @override
  String? get from;
  @override
  String? get to;
  @override
  @timestampKey
  DateTime? get assignmentDate;

  /// Create a copy of Assignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignmentImplCopyWith<_$AssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsageHistory _$UsageHistoryFromJson(Map<String, dynamic> json) {
  return _UsageHistory.fromJson(json);
}

/// @nodoc
mixin _$UsageHistory {
  String? get id => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get dateOfUse => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String? get receptionistId => throw _privateConstructorUsedError;
  List<String>? get useTicket => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  /// Serializes this UsageHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageHistoryCopyWith<UsageHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageHistoryCopyWith<$Res> {
  factory $UsageHistoryCopyWith(
    UsageHistory value,
    $Res Function(UsageHistory) then,
  ) = _$UsageHistoryCopyWithImpl<$Res, UsageHistory>;
  @useResult
  $Res call({
    String? id,
    @timestampKey DateTime? dateOfUse,
    String? eventId,
    String? receptionistId,
    List<String>? useTicket,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class _$UsageHistoryCopyWithImpl<$Res, $Val extends UsageHistory>
    implements $UsageHistoryCopyWith<$Res> {
  _$UsageHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? dateOfUse = freezed,
    Object? eventId = freezed,
    Object? receptionistId = freezed,
    Object? useTicket = freezed,
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
            dateOfUse:
                freezed == dateOfUse
                    ? _value.dateOfUse
                    : dateOfUse // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            eventId:
                freezed == eventId
                    ? _value.eventId
                    : eventId // ignore: cast_nullable_to_non_nullable
                        as String?,
            receptionistId:
                freezed == receptionistId
                    ? _value.receptionistId
                    : receptionistId // ignore: cast_nullable_to_non_nullable
                        as String?,
            useTicket:
                freezed == useTicket
                    ? _value.useTicket
                    : useTicket // ignore: cast_nullable_to_non_nullable
                        as List<String>?,
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
abstract class _$$UsageHistoryImplCopyWith<$Res>
    implements $UsageHistoryCopyWith<$Res> {
  factory _$$UsageHistoryImplCopyWith(
    _$UsageHistoryImpl value,
    $Res Function(_$UsageHistoryImpl) then,
  ) = __$$UsageHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    @timestampKey DateTime? dateOfUse,
    String? eventId,
    String? receptionistId,
    List<String>? useTicket,
    @timestampKey DateTime? createdAt,
    @timestampKey DateTime? updatedAt,
    @timestampKey DateTime? deletedAt,
  });
}

/// @nodoc
class __$$UsageHistoryImplCopyWithImpl<$Res>
    extends _$UsageHistoryCopyWithImpl<$Res, _$UsageHistoryImpl>
    implements _$$UsageHistoryImplCopyWith<$Res> {
  __$$UsageHistoryImplCopyWithImpl(
    _$UsageHistoryImpl _value,
    $Res Function(_$UsageHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UsageHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? dateOfUse = freezed,
    Object? eventId = freezed,
    Object? receptionistId = freezed,
    Object? useTicket = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(
      _$UsageHistoryImpl(
        id:
            freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String?,
        dateOfUse:
            freezed == dateOfUse
                ? _value.dateOfUse
                : dateOfUse // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        eventId:
            freezed == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                    as String?,
        receptionistId:
            freezed == receptionistId
                ? _value.receptionistId
                : receptionistId // ignore: cast_nullable_to_non_nullable
                    as String?,
        useTicket:
            freezed == useTicket
                ? _value._useTicket
                : useTicket // ignore: cast_nullable_to_non_nullable
                    as List<String>?,
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
class _$UsageHistoryImpl extends _UsageHistory {
  _$UsageHistoryImpl({
    this.id,
    @timestampKey required this.dateOfUse,
    required this.eventId,
    required this.receptionistId,
    required final List<String>? useTicket,
    @timestampKey this.createdAt,
    @timestampKey this.updatedAt,
    @timestampKey this.deletedAt,
  }) : _useTicket = useTicket,
       super._();

  factory _$UsageHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageHistoryImplFromJson(json);

  @override
  final String? id;
  @override
  @timestampKey
  final DateTime? dateOfUse;
  @override
  final String? eventId;
  @override
  final String? receptionistId;
  final List<String>? _useTicket;
  @override
  List<String>? get useTicket {
    final value = _useTicket;
    if (value == null) return null;
    if (_useTicket is EqualUnmodifiableListView) return _useTicket;
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
    return 'UsageHistory(id: $id, dateOfUse: $dateOfUse, eventId: $eventId, receptionistId: $receptionistId, useTicket: $useTicket, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dateOfUse, dateOfUse) ||
                other.dateOfUse == dateOfUse) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.receptionistId, receptionistId) ||
                other.receptionistId == receptionistId) &&
            const DeepCollectionEquality().equals(
              other._useTicket,
              _useTicket,
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
    dateOfUse,
    eventId,
    receptionistId,
    const DeepCollectionEquality().hash(_useTicket),
    createdAt,
    updatedAt,
    deletedAt,
  );

  /// Create a copy of UsageHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageHistoryImplCopyWith<_$UsageHistoryImpl> get copyWith =>
      __$$UsageHistoryImplCopyWithImpl<_$UsageHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageHistoryImplToJson(this);
  }
}

abstract class _UsageHistory extends UsageHistory {
  factory _UsageHistory({
    final String? id,
    @timestampKey required final DateTime? dateOfUse,
    required final String? eventId,
    required final String? receptionistId,
    required final List<String>? useTicket,
    @timestampKey final DateTime? createdAt,
    @timestampKey final DateTime? updatedAt,
    @timestampKey final DateTime? deletedAt,
  }) = _$UsageHistoryImpl;
  _UsageHistory._() : super._();

  factory _UsageHistory.fromJson(Map<String, dynamic> json) =
      _$UsageHistoryImpl.fromJson;

  @override
  String? get id;
  @override
  @timestampKey
  DateTime? get dateOfUse;
  @override
  String? get eventId;
  @override
  String? get receptionistId;
  @override
  List<String>? get useTicket;
  @override
  @timestampKey
  DateTime? get createdAt;
  @override
  @timestampKey
  DateTime? get updatedAt;
  @override
  @timestampKey
  DateTime? get deletedAt;

  /// Create a copy of UsageHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageHistoryImplCopyWith<_$UsageHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
