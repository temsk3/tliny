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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return _Ticket.fromJson(json);
}

/// @nodoc
mixin _$Ticket {
  String? get id => throw _privateConstructorUsedError; // 購入者
  String? get paidUserId => throw _privateConstructorUsedError;
  String? get paidUserName => throw _privateConstructorUsedError;
  String? get purchaseTime => throw _privateConstructorUsedError; // 所有者
  String? get ownerId => throw _privateConstructorUsedError;
  String? get ownerName => throw _privateConstructorUsedError;
  List<Assignment>? get assignment => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isPrinting => throw _privateConstructorUsedError; // 商品情報
  String? get productId => throw _privateConstructorUsedError;
  int? get exchangeNumber => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError; // genre: string
  String? get desc => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  List<String> get pictureURL => throw _privateConstructorUsedError;
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
  bool get expirationLink => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @timestampKey
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call(
      {String? id,
      String? paidUserId,
      String? paidUserName,
      String? purchaseTime,
      String? ownerId,
      String? ownerName,
      List<Assignment>? assignment,
      bool isActive,
      bool isPrinting,
      String? productId,
      int? exchangeNumber,
      String? code,
      String? name,
      String? desc,
      int? price,
      List<String> pictureURL,
      @timestampKey
          DateTime? expirationFrom,
      @timestampKey
          DateTime? expirationTo,
      String? register,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? organizerDocRef,
      String? organizerId,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? eventDocRef,
      String? eventId,
      String? eventName,
      bool expirationLink,
      @timestampKey
          DateTime? createdAt,
      @timestampKey
          DateTime? updatedAt,
      @timestampKey
          DateTime? deletedAt});
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    Object? productId = freezed,
    Object? exchangeNumber = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? price = freezed,
    Object? pictureURL = null,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? register = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? expirationLink = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      paidUserId: freezed == paidUserId
          ? _value.paidUserId
          : paidUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      paidUserName: freezed == paidUserName
          ? _value.paidUserName
          : paidUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseTime: freezed == purchaseTime
          ? _value.purchaseTime
          : purchaseTime // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      assignment: freezed == assignment
          ? _value.assignment
          : assignment // ignore: cast_nullable_to_non_nullable
              as List<Assignment>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrinting: null == isPrinting
          ? _value.isPrinting
          : isPrinting // ignore: cast_nullable_to_non_nullable
              as bool,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
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
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
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
      expirationLink: null == expirationLink
          ? _value.expirationLink
          : expirationLink // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$_TicketCopyWith(_$_Ticket value, $Res Function(_$_Ticket) then) =
      __$$_TicketCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? paidUserId,
      String? paidUserName,
      String? purchaseTime,
      String? ownerId,
      String? ownerName,
      List<Assignment>? assignment,
      bool isActive,
      bool isPrinting,
      String? productId,
      int? exchangeNumber,
      String? code,
      String? name,
      String? desc,
      int? price,
      List<String> pictureURL,
      @timestampKey
          DateTime? expirationFrom,
      @timestampKey
          DateTime? expirationTo,
      String? register,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? organizerDocRef,
      String? organizerId,
      @documentReferenceKey
          DocumentReference<Map<String, dynamic>>? eventDocRef,
      String? eventId,
      String? eventName,
      bool expirationLink,
      @timestampKey
          DateTime? createdAt,
      @timestampKey
          DateTime? updatedAt,
      @timestampKey
          DateTime? deletedAt});
}

/// @nodoc
class __$$_TicketCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$_Ticket>
    implements _$$_TicketCopyWith<$Res> {
  __$$_TicketCopyWithImpl(_$_Ticket _value, $Res Function(_$_Ticket) _then)
      : super(_value, _then);

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
    Object? productId = freezed,
    Object? exchangeNumber = freezed,
    Object? code = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? price = freezed,
    Object? pictureURL = null,
    Object? expirationFrom = freezed,
    Object? expirationTo = freezed,
    Object? register = freezed,
    Object? organizerDocRef = freezed,
    Object? organizerId = freezed,
    Object? eventDocRef = freezed,
    Object? eventId = freezed,
    Object? eventName = freezed,
    Object? expirationLink = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_Ticket(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      paidUserId: freezed == paidUserId
          ? _value.paidUserId
          : paidUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      paidUserName: freezed == paidUserName
          ? _value.paidUserName
          : paidUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseTime: freezed == purchaseTime
          ? _value.purchaseTime
          : purchaseTime // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerName: freezed == ownerName
          ? _value.ownerName
          : ownerName // ignore: cast_nullable_to_non_nullable
              as String?,
      assignment: freezed == assignment
          ? _value._assignment
          : assignment // ignore: cast_nullable_to_non_nullable
              as List<Assignment>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrinting: null == isPrinting
          ? _value.isPrinting
          : isPrinting // ignore: cast_nullable_to_non_nullable
              as bool,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
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
      desc: freezed == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
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
      expirationLink: null == expirationLink
          ? _value.expirationLink
          : expirationLink // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$_Ticket extends _Ticket {
  const _$_Ticket(
      {this.id,
      this.paidUserId,
      this.paidUserName,
      this.purchaseTime,
      this.ownerId,
      this.ownerName,
      final List<Assignment>? assignment,
      this.isActive = true,
      this.isPrinting = false,
      this.productId,
      this.exchangeNumber,
      this.code,
      this.name,
      this.desc,
      this.price,
      final List<String> pictureURL = const [],
      @timestampKey this.expirationFrom,
      @timestampKey this.expirationTo,
      this.register,
      @documentReferenceKey this.organizerDocRef,
      this.organizerId,
      @documentReferenceKey this.eventDocRef,
      this.eventId,
      this.eventName,
      this.expirationLink = true,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : _assignment = assignment,
        _pictureURL = pictureURL,
        super._();

  factory _$_Ticket.fromJson(Map<String, dynamic> json) =>
      _$$_TicketFromJson(json);

  @override
  final String? id;
// 購入者
  @override
  final String? paidUserId;
  @override
  final String? paidUserName;
  @override
  final String? purchaseTime;
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
    return 'Ticket(id: $id, paidUserId: $paidUserId, paidUserName: $paidUserName, purchaseTime: $purchaseTime, ownerId: $ownerId, ownerName: $ownerName, assignment: $assignment, isActive: $isActive, isPrinting: $isPrinting, productId: $productId, exchangeNumber: $exchangeNumber, code: $code, name: $name, desc: $desc, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, register: $register, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, expirationLink: $expirationLink, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ticket &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.paidUserId, paidUserId) ||
                other.paidUserId == paidUserId) &&
            (identical(other.paidUserName, paidUserName) ||
                other.paidUserName == paidUserName) &&
            (identical(other.purchaseTime, purchaseTime) ||
                other.purchaseTime == purchaseTime) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.ownerName, ownerName) ||
                other.ownerName == ownerName) &&
            const DeepCollectionEquality()
                .equals(other._assignment, _assignment) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isPrinting, isPrinting) ||
                other.isPrinting == isPrinting) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.exchangeNumber, exchangeNumber) ||
                other.exchangeNumber == exchangeNumber) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other._pictureURL, _pictureURL) &&
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
        paidUserId,
        paidUserName,
        purchaseTime,
        ownerId,
        ownerName,
        const DeepCollectionEquality().hash(_assignment),
        isActive,
        isPrinting,
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
        createdAt,
        updatedAt,
        deletedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
      __$$_TicketCopyWithImpl<_$_Ticket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TicketToJson(
      this,
    );
  }
}

abstract class _Ticket extends Ticket {
  const factory _Ticket(
      {final String? id,
      final String? paidUserId,
      final String? paidUserName,
      final String? purchaseTime,
      final String? ownerId,
      final String? ownerName,
      final List<Assignment>? assignment,
      final bool isActive,
      final bool isPrinting,
      final String? productId,
      final int? exchangeNumber,
      final String? code,
      final String? name,
      final String? desc,
      final int? price,
      final List<String> pictureURL,
      @timestampKey
          final DateTime? expirationFrom,
      @timestampKey
          final DateTime? expirationTo,
      final String? register,
      @documentReferenceKey
          final DocumentReference<Map<String, dynamic>>? organizerDocRef,
      final String? organizerId,
      @documentReferenceKey
          final DocumentReference<Map<String, dynamic>>? eventDocRef,
      final String? eventId,
      final String? eventName,
      final bool expirationLink,
      @timestampKey
          final DateTime? createdAt,
      @timestampKey
          final DateTime? updatedAt,
      @timestampKey
          final DateTime? deletedAt}) = _$_Ticket;
  const _Ticket._() : super._();

  factory _Ticket.fromJson(Map<String, dynamic> json) = _$_Ticket.fromJson;

  @override
  String? get id;
  @override // 購入者
  String? get paidUserId;
  @override
  String? get paidUserName;
  @override
  String? get purchaseTime;
  @override // 所有者
  String? get ownerId;
  @override
  String? get ownerName;
  @override
  List<Assignment>? get assignment;
  @override
  bool get isActive;
  @override
  bool get isPrinting;
  @override // 商品情報
  String? get productId;
  @override
  int? get exchangeNumber;
  @override
  String? get code;
  @override
  String? get name;
  @override // genre: string
  String? get desc;
  @override
  int? get price;
  @override
  List<String> get pictureURL;
  @override
  @timestampKey
  DateTime? get expirationFrom;
  @override
  @timestampKey
  DateTime? get expirationTo;
  @override // 登録者
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
  bool get expirationLink;
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
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignmentCopyWith<Assignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentCopyWith<$Res> {
  factory $AssignmentCopyWith(
          Assignment value, $Res Function(Assignment) then) =
      _$AssignmentCopyWithImpl<$Res, Assignment>;
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? assignmentDate = freezed,
  }) {
    return _then(_value.copyWith(
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentDate: freezed == assignmentDate
          ? _value.assignmentDate
          : assignmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AssignmentCopyWith<$Res>
    implements $AssignmentCopyWith<$Res> {
  factory _$$_AssignmentCopyWith(
          _$_Assignment value, $Res Function(_$_Assignment) then) =
      __$$_AssignmentCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? from, String? to, @timestampKey DateTime? assignmentDate});
}

/// @nodoc
class __$$_AssignmentCopyWithImpl<$Res>
    extends _$AssignmentCopyWithImpl<$Res, _$_Assignment>
    implements _$$_AssignmentCopyWith<$Res> {
  __$$_AssignmentCopyWithImpl(
      _$_Assignment _value, $Res Function(_$_Assignment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? from = freezed,
    Object? to = freezed,
    Object? assignmentDate = freezed,
  }) {
    return _then(_$_Assignment(
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      assignmentDate: freezed == assignmentDate
          ? _value.assignmentDate
          : assignmentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Assignment implements _Assignment {
  const _$_Assignment({this.from, this.to, @timestampKey this.assignmentDate});

  factory _$_Assignment.fromJson(Map<String, dynamic> json) =>
      _$$_AssignmentFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Assignment &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.assignmentDate, assignmentDate) ||
                other.assignmentDate == assignmentDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, from, to, assignmentDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AssignmentCopyWith<_$_Assignment> get copyWith =>
      __$$_AssignmentCopyWithImpl<_$_Assignment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AssignmentToJson(
      this,
    );
  }
}

abstract class _Assignment implements Assignment {
  const factory _Assignment(
      {final String? from,
      final String? to,
      @timestampKey final DateTime? assignmentDate}) = _$_Assignment;

  factory _Assignment.fromJson(Map<String, dynamic> json) =
      _$_Assignment.fromJson;

  @override
  String? get from;
  @override
  String? get to;
  @override
  @timestampKey
  DateTime? get assignmentDate;
  @override
  @JsonKey(ignore: true)
  _$$_AssignmentCopyWith<_$_Assignment> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UsageHistoryCopyWith<UsageHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageHistoryCopyWith<$Res> {
  factory $UsageHistoryCopyWith(
          UsageHistory value, $Res Function(UsageHistory) then) =
      _$UsageHistoryCopyWithImpl<$Res, UsageHistory>;
  @useResult
  $Res call(
      {String? id,
      @timestampKey DateTime? dateOfUse,
      String? eventId,
      String? receptionistId,
      List<String>? useTicket,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class _$UsageHistoryCopyWithImpl<$Res, $Val extends UsageHistory>
    implements $UsageHistoryCopyWith<$Res> {
  _$UsageHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfUse: freezed == dateOfUse
          ? _value.dateOfUse
          : dateOfUse // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      receptionistId: freezed == receptionistId
          ? _value.receptionistId
          : receptionistId // ignore: cast_nullable_to_non_nullable
              as String?,
      useTicket: freezed == useTicket
          ? _value.useTicket
          : useTicket // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
abstract class _$$_UsageHistoryCopyWith<$Res>
    implements $UsageHistoryCopyWith<$Res> {
  factory _$$_UsageHistoryCopyWith(
          _$_UsageHistory value, $Res Function(_$_UsageHistory) then) =
      __$$_UsageHistoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      @timestampKey DateTime? dateOfUse,
      String? eventId,
      String? receptionistId,
      List<String>? useTicket,
      @timestampKey DateTime? createdAt,
      @timestampKey DateTime? updatedAt,
      @timestampKey DateTime? deletedAt});
}

/// @nodoc
class __$$_UsageHistoryCopyWithImpl<$Res>
    extends _$UsageHistoryCopyWithImpl<$Res, _$_UsageHistory>
    implements _$$_UsageHistoryCopyWith<$Res> {
  __$$_UsageHistoryCopyWithImpl(
      _$_UsageHistory _value, $Res Function(_$_UsageHistory) _then)
      : super(_value, _then);

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
    return _then(_$_UsageHistory(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfUse: freezed == dateOfUse
          ? _value.dateOfUse
          : dateOfUse // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      receptionistId: freezed == receptionistId
          ? _value.receptionistId
          : receptionistId // ignore: cast_nullable_to_non_nullable
              as String?,
      useTicket: freezed == useTicket
          ? _value._useTicket
          : useTicket // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
class _$_UsageHistory extends _UsageHistory {
  _$_UsageHistory(
      {this.id,
      @timestampKey required this.dateOfUse,
      required this.eventId,
      required this.receptionistId,
      required final List<String>? useTicket,
      @timestampKey this.createdAt,
      @timestampKey this.updatedAt,
      @timestampKey this.deletedAt})
      : _useTicket = useTicket,
        super._();

  factory _$_UsageHistory.fromJson(Map<String, dynamic> json) =>
      _$$_UsageHistoryFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UsageHistory &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dateOfUse, dateOfUse) ||
                other.dateOfUse == dateOfUse) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.receptionistId, receptionistId) ||
                other.receptionistId == receptionistId) &&
            const DeepCollectionEquality()
                .equals(other._useTicket, _useTicket) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
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
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UsageHistoryCopyWith<_$_UsageHistory> get copyWith =>
      __$$_UsageHistoryCopyWithImpl<_$_UsageHistory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UsageHistoryToJson(
      this,
    );
  }
}

abstract class _UsageHistory extends UsageHistory {
  factory _UsageHistory(
      {final String? id,
      @timestampKey required final DateTime? dateOfUse,
      required final String? eventId,
      required final String? receptionistId,
      required final List<String>? useTicket,
      @timestampKey final DateTime? createdAt,
      @timestampKey final DateTime? updatedAt,
      @timestampKey final DateTime? deletedAt}) = _$_UsageHistory;
  _UsageHistory._() : super._();

  factory _UsageHistory.fromJson(Map<String, dynamic> json) =
      _$_UsageHistory.fromJson;

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
  @override
  @JsonKey(ignore: true)
  _$$_UsageHistoryCopyWith<_$_UsageHistory> get copyWith =>
      throw _privateConstructorUsedError;
}
