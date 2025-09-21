// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Ticket {

 String? get id;// 購入者
 String? get paidUserId; String? get paidUserName;@TimestampConverter() DateTime? get purchaseTime;// 所有者
 String? get ownerId; String? get ownerName; List<Assignment>? get assignment; bool get isActive; bool get isPrinting; bool get isUsed; String? get uuid; String? get pdfUuid;// 商品情報
@DocumentReferenceNullStringConverter() String? get productDocRef; String? get productId;// int? exchangeNumber,
 String? get code; String? get name;// genre: string
 String? get desc; int? get price; List<String> get pictureURL;@TimestampConverter() DateTime? get expirationFrom;@TimestampConverter() DateTime? get expirationTo;// 登録者
 String? get register; String? get registerName;// 開催者
@DocumentReferenceNullStringConverter() String? get organizerDocRef; String? get organizerId;// イベント情報
@DocumentReferenceNullStringConverter() String? get eventDocRef; String? get eventId; String? get eventName;// @Default(true) bool expirationLink,
@TimestampConverter() DateTime? get createdAt;@TimestampConverter() DateTime? get updatedAt;@TimestampConverter() DateTime? get deletedAt;
/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCopyWith<Ticket> get copyWith => _$TicketCopyWithImpl<Ticket>(this as Ticket, _$identity);

  /// Serializes this Ticket to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'Ticket(id: $id, paidUserId: $paidUserId, paidUserName: $paidUserName, purchaseTime: $purchaseTime, ownerId: $ownerId, ownerName: $ownerName, assignment: $assignment, isActive: $isActive, isPrinting: $isPrinting, isUsed: $isUsed, uuid: $uuid, pdfUuid: $pdfUuid, productDocRef: $productDocRef, productId: $productId, code: $code, name: $name, desc: $desc, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, register: $register, registerName: $registerName, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $TicketCopyWith<$Res>  {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) _then) = _$TicketCopyWithImpl;
@useResult
$Res call({
 String? id, String? paidUserId, String? paidUserName,@TimestampConverter() DateTime? purchaseTime, String? ownerId, String? ownerName, List<Assignment>? assignment, bool isActive, bool isPrinting, bool isUsed, String? uuid, String? pdfUuid,@DocumentReferenceNullStringConverter() String? productDocRef, String? productId, String? code, String? name, String? desc, int? price, List<String> pictureURL,@TimestampConverter() DateTime? expirationFrom,@TimestampConverter() DateTime? expirationTo, String? register, String? registerName,@DocumentReferenceNullStringConverter() String? organizerDocRef, String? organizerId,@DocumentReferenceNullStringConverter() String? eventDocRef, String? eventId, String? eventName,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? deletedAt
});




}
/// @nodoc
class _$TicketCopyWithImpl<$Res>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._self, this._then);

  final Ticket _self;
  final $Res Function(Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? paidUserId = freezed,Object? paidUserName = freezed,Object? purchaseTime = freezed,Object? ownerId = freezed,Object? ownerName = freezed,Object? assignment = freezed,Object? isActive = null,Object? isPrinting = null,Object? isUsed = null,Object? uuid = freezed,Object? pdfUuid = freezed,Object? productDocRef = freezed,Object? productId = freezed,Object? code = freezed,Object? name = freezed,Object? desc = freezed,Object? price = freezed,Object? pictureURL = null,Object? expirationFrom = freezed,Object? expirationTo = freezed,Object? register = freezed,Object? registerName = freezed,Object? organizerDocRef = freezed,Object? organizerId = freezed,Object? eventDocRef = freezed,Object? eventId = freezed,Object? eventName = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,paidUserId: freezed == paidUserId ? _self.paidUserId : paidUserId // ignore: cast_nullable_to_non_nullable
as String?,paidUserName: freezed == paidUserName ? _self.paidUserName : paidUserName // ignore: cast_nullable_to_non_nullable
as String?,purchaseTime: freezed == purchaseTime ? _self.purchaseTime : purchaseTime // ignore: cast_nullable_to_non_nullable
as DateTime?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,ownerName: freezed == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String?,assignment: freezed == assignment ? _self.assignment : assignment // ignore: cast_nullable_to_non_nullable
as List<Assignment>?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPrinting: null == isPrinting ? _self.isPrinting : isPrinting // ignore: cast_nullable_to_non_nullable
as bool,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,pdfUuid: freezed == pdfUuid ? _self.pdfUuid : pdfUuid // ignore: cast_nullable_to_non_nullable
as String?,productDocRef: freezed == productDocRef ? _self.productDocRef : productDocRef // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,pictureURL: null == pictureURL ? _self.pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>,expirationFrom: freezed == expirationFrom ? _self.expirationFrom : expirationFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,expirationTo: freezed == expirationTo ? _self.expirationTo : expirationTo // ignore: cast_nullable_to_non_nullable
as DateTime?,register: freezed == register ? _self.register : register // ignore: cast_nullable_to_non_nullable
as String?,registerName: freezed == registerName ? _self.registerName : registerName // ignore: cast_nullable_to_non_nullable
as String?,organizerDocRef: freezed == organizerDocRef ? _self.organizerDocRef : organizerDocRef // ignore: cast_nullable_to_non_nullable
as String?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,eventDocRef: freezed == eventDocRef ? _self.eventDocRef : eventDocRef // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,eventName: freezed == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ticket].
extension TicketPatterns on Ticket {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ticket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ticket value)  $default,){
final _that = this;
switch (_that) {
case _Ticket():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ticket value)?  $default,){
final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? paidUserId,  String? paidUserName, @TimestampConverter()  DateTime? purchaseTime,  String? ownerId,  String? ownerName,  List<Assignment>? assignment,  bool isActive,  bool isPrinting,  bool isUsed,  String? uuid,  String? pdfUuid, @DocumentReferenceNullStringConverter()  String? productDocRef,  String? productId,  String? code,  String? name,  String? desc,  int? price,  List<String> pictureURL, @TimestampConverter()  DateTime? expirationFrom, @TimestampConverter()  DateTime? expirationTo,  String? register,  String? registerName, @DocumentReferenceNullStringConverter()  String? organizerDocRef,  String? organizerId, @DocumentReferenceNullStringConverter()  String? eventDocRef,  String? eventId,  String? eventName, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.paidUserId,_that.paidUserName,_that.purchaseTime,_that.ownerId,_that.ownerName,_that.assignment,_that.isActive,_that.isPrinting,_that.isUsed,_that.uuid,_that.pdfUuid,_that.productDocRef,_that.productId,_that.code,_that.name,_that.desc,_that.price,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.register,_that.registerName,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? paidUserId,  String? paidUserName, @TimestampConverter()  DateTime? purchaseTime,  String? ownerId,  String? ownerName,  List<Assignment>? assignment,  bool isActive,  bool isPrinting,  bool isUsed,  String? uuid,  String? pdfUuid, @DocumentReferenceNullStringConverter()  String? productDocRef,  String? productId,  String? code,  String? name,  String? desc,  int? price,  List<String> pictureURL, @TimestampConverter()  DateTime? expirationFrom, @TimestampConverter()  DateTime? expirationTo,  String? register,  String? registerName, @DocumentReferenceNullStringConverter()  String? organizerDocRef,  String? organizerId, @DocumentReferenceNullStringConverter()  String? eventDocRef,  String? eventId,  String? eventName, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Ticket():
return $default(_that.id,_that.paidUserId,_that.paidUserName,_that.purchaseTime,_that.ownerId,_that.ownerName,_that.assignment,_that.isActive,_that.isPrinting,_that.isUsed,_that.uuid,_that.pdfUuid,_that.productDocRef,_that.productId,_that.code,_that.name,_that.desc,_that.price,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.register,_that.registerName,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? paidUserId,  String? paidUserName, @TimestampConverter()  DateTime? purchaseTime,  String? ownerId,  String? ownerName,  List<Assignment>? assignment,  bool isActive,  bool isPrinting,  bool isUsed,  String? uuid,  String? pdfUuid, @DocumentReferenceNullStringConverter()  String? productDocRef,  String? productId,  String? code,  String? name,  String? desc,  int? price,  List<String> pictureURL, @TimestampConverter()  DateTime? expirationFrom, @TimestampConverter()  DateTime? expirationTo,  String? register,  String? registerName, @DocumentReferenceNullStringConverter()  String? organizerDocRef,  String? organizerId, @DocumentReferenceNullStringConverter()  String? eventDocRef,  String? eventId,  String? eventName, @TimestampConverter()  DateTime? createdAt, @TimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Ticket() when $default != null:
return $default(_that.id,_that.paidUserId,_that.paidUserName,_that.purchaseTime,_that.ownerId,_that.ownerName,_that.assignment,_that.isActive,_that.isPrinting,_that.isUsed,_that.uuid,_that.pdfUuid,_that.productDocRef,_that.productId,_that.code,_that.name,_that.desc,_that.price,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.register,_that.registerName,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Ticket extends Ticket {
  const _Ticket({this.id, this.paidUserId, this.paidUserName, @TimestampConverter() this.purchaseTime, this.ownerId, this.ownerName, final  List<Assignment>? assignment, this.isActive = true, this.isPrinting = false, this.isUsed = false, this.uuid, this.pdfUuid, @DocumentReferenceNullStringConverter() this.productDocRef, this.productId, this.code, this.name, this.desc, this.price, final  List<String> pictureURL = const [], @TimestampConverter() this.expirationFrom, @TimestampConverter() this.expirationTo, this.register, this.registerName, @DocumentReferenceNullStringConverter() this.organizerDocRef, this.organizerId, @DocumentReferenceNullStringConverter() this.eventDocRef, this.eventId, this.eventName, @TimestampConverter() this.createdAt, @TimestampConverter() this.updatedAt, @TimestampConverter() this.deletedAt}): _assignment = assignment,_pictureURL = pictureURL,super._();
  factory _Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

@override final  String? id;
// 購入者
@override final  String? paidUserId;
@override final  String? paidUserName;
@override@TimestampConverter() final  DateTime? purchaseTime;
// 所有者
@override final  String? ownerId;
@override final  String? ownerName;
 final  List<Assignment>? _assignment;
@override List<Assignment>? get assignment {
  final value = _assignment;
  if (value == null) return null;
  if (_assignment is EqualUnmodifiableListView) return _assignment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isPrinting;
@override@JsonKey() final  bool isUsed;
@override final  String? uuid;
@override final  String? pdfUuid;
// 商品情報
@override@DocumentReferenceNullStringConverter() final  String? productDocRef;
@override final  String? productId;
// int? exchangeNumber,
@override final  String? code;
@override final  String? name;
// genre: string
@override final  String? desc;
@override final  int? price;
 final  List<String> _pictureURL;
@override@JsonKey() List<String> get pictureURL {
  if (_pictureURL is EqualUnmodifiableListView) return _pictureURL;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pictureURL);
}

@override@TimestampConverter() final  DateTime? expirationFrom;
@override@TimestampConverter() final  DateTime? expirationTo;
// 登録者
@override final  String? register;
@override final  String? registerName;
// 開催者
@override@DocumentReferenceNullStringConverter() final  String? organizerDocRef;
@override final  String? organizerId;
// イベント情報
@override@DocumentReferenceNullStringConverter() final  String? eventDocRef;
@override final  String? eventId;
@override final  String? eventName;
// @Default(true) bool expirationLink,
@override@TimestampConverter() final  DateTime? createdAt;
@override@TimestampConverter() final  DateTime? updatedAt;
@override@TimestampConverter() final  DateTime? deletedAt;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCopyWith<_Ticket> get copyWith => __$TicketCopyWithImpl<_Ticket>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketToJson(this, );
}



@override
String toString() {
  return 'Ticket(id: $id, paidUserId: $paidUserId, paidUserName: $paidUserName, purchaseTime: $purchaseTime, ownerId: $ownerId, ownerName: $ownerName, assignment: $assignment, isActive: $isActive, isPrinting: $isPrinting, isUsed: $isUsed, uuid: $uuid, pdfUuid: $pdfUuid, productDocRef: $productDocRef, productId: $productId, code: $code, name: $name, desc: $desc, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, register: $register, registerName: $registerName, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$TicketCopyWith(_Ticket value, $Res Function(_Ticket) _then) = __$TicketCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? paidUserId, String? paidUserName,@TimestampConverter() DateTime? purchaseTime, String? ownerId, String? ownerName, List<Assignment>? assignment, bool isActive, bool isPrinting, bool isUsed, String? uuid, String? pdfUuid,@DocumentReferenceNullStringConverter() String? productDocRef, String? productId, String? code, String? name, String? desc, int? price, List<String> pictureURL,@TimestampConverter() DateTime? expirationFrom,@TimestampConverter() DateTime? expirationTo, String? register, String? registerName,@DocumentReferenceNullStringConverter() String? organizerDocRef, String? organizerId,@DocumentReferenceNullStringConverter() String? eventDocRef, String? eventId, String? eventName,@TimestampConverter() DateTime? createdAt,@TimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime? deletedAt
});




}
/// @nodoc
class __$TicketCopyWithImpl<$Res>
    implements _$TicketCopyWith<$Res> {
  __$TicketCopyWithImpl(this._self, this._then);

  final _Ticket _self;
  final $Res Function(_Ticket) _then;

/// Create a copy of Ticket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? paidUserId = freezed,Object? paidUserName = freezed,Object? purchaseTime = freezed,Object? ownerId = freezed,Object? ownerName = freezed,Object? assignment = freezed,Object? isActive = null,Object? isPrinting = null,Object? isUsed = null,Object? uuid = freezed,Object? pdfUuid = freezed,Object? productDocRef = freezed,Object? productId = freezed,Object? code = freezed,Object? name = freezed,Object? desc = freezed,Object? price = freezed,Object? pictureURL = null,Object? expirationFrom = freezed,Object? expirationTo = freezed,Object? register = freezed,Object? registerName = freezed,Object? organizerDocRef = freezed,Object? organizerId = freezed,Object? eventDocRef = freezed,Object? eventId = freezed,Object? eventName = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_Ticket(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,paidUserId: freezed == paidUserId ? _self.paidUserId : paidUserId // ignore: cast_nullable_to_non_nullable
as String?,paidUserName: freezed == paidUserName ? _self.paidUserName : paidUserName // ignore: cast_nullable_to_non_nullable
as String?,purchaseTime: freezed == purchaseTime ? _self.purchaseTime : purchaseTime // ignore: cast_nullable_to_non_nullable
as DateTime?,ownerId: freezed == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String?,ownerName: freezed == ownerName ? _self.ownerName : ownerName // ignore: cast_nullable_to_non_nullable
as String?,assignment: freezed == assignment ? _self._assignment : assignment // ignore: cast_nullable_to_non_nullable
as List<Assignment>?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isPrinting: null == isPrinting ? _self.isPrinting : isPrinting // ignore: cast_nullable_to_non_nullable
as bool,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,pdfUuid: freezed == pdfUuid ? _self.pdfUuid : pdfUuid // ignore: cast_nullable_to_non_nullable
as String?,productDocRef: freezed == productDocRef ? _self.productDocRef : productDocRef // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,pictureURL: null == pictureURL ? _self._pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>,expirationFrom: freezed == expirationFrom ? _self.expirationFrom : expirationFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,expirationTo: freezed == expirationTo ? _self.expirationTo : expirationTo // ignore: cast_nullable_to_non_nullable
as DateTime?,register: freezed == register ? _self.register : register // ignore: cast_nullable_to_non_nullable
as String?,registerName: freezed == registerName ? _self.registerName : registerName // ignore: cast_nullable_to_non_nullable
as String?,organizerDocRef: freezed == organizerDocRef ? _self.organizerDocRef : organizerDocRef // ignore: cast_nullable_to_non_nullable
as String?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,eventDocRef: freezed == eventDocRef ? _self.eventDocRef : eventDocRef // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,eventName: freezed == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Assignment {

 String? get from; String? get to;@timestampKey DateTime? get assignmentDate;
/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentCopyWith<Assignment> get copyWith => _$AssignmentCopyWithImpl<Assignment>(this as Assignment, _$identity);

  /// Serializes this Assignment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Assignment&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.assignmentDate, assignmentDate) || other.assignmentDate == assignmentDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,assignmentDate);

@override
String toString() {
  return 'Assignment(from: $from, to: $to, assignmentDate: $assignmentDate)';
}


}

/// @nodoc
abstract mixin class $AssignmentCopyWith<$Res>  {
  factory $AssignmentCopyWith(Assignment value, $Res Function(Assignment) _then) = _$AssignmentCopyWithImpl;
@useResult
$Res call({
 String? from, String? to,@timestampKey DateTime? assignmentDate
});




}
/// @nodoc
class _$AssignmentCopyWithImpl<$Res>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._self, this._then);

  final Assignment _self;
  final $Res Function(Assignment) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = freezed,Object? to = freezed,Object? assignmentDate = freezed,}) {
  return _then(_self.copyWith(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,assignmentDate: freezed == assignmentDate ? _self.assignmentDate : assignmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Assignment].
extension AssignmentPatterns on Assignment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Assignment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Assignment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Assignment value)  $default,){
final _that = this;
switch (_that) {
case _Assignment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Assignment value)?  $default,){
final _that = this;
switch (_that) {
case _Assignment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? from,  String? to, @timestampKey  DateTime? assignmentDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Assignment() when $default != null:
return $default(_that.from,_that.to,_that.assignmentDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? from,  String? to, @timestampKey  DateTime? assignmentDate)  $default,) {final _that = this;
switch (_that) {
case _Assignment():
return $default(_that.from,_that.to,_that.assignmentDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? from,  String? to, @timestampKey  DateTime? assignmentDate)?  $default,) {final _that = this;
switch (_that) {
case _Assignment() when $default != null:
return $default(_that.from,_that.to,_that.assignmentDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Assignment implements Assignment {
  const _Assignment({this.from, this.to, @timestampKey this.assignmentDate});
  factory _Assignment.fromJson(Map<String, dynamic> json) => _$AssignmentFromJson(json);

@override final  String? from;
@override final  String? to;
@override@timestampKey final  DateTime? assignmentDate;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignmentCopyWith<_Assignment> get copyWith => __$AssignmentCopyWithImpl<_Assignment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssignmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Assignment&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.assignmentDate, assignmentDate) || other.assignmentDate == assignmentDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,assignmentDate);

@override
String toString() {
  return 'Assignment(from: $from, to: $to, assignmentDate: $assignmentDate)';
}


}

/// @nodoc
abstract mixin class _$AssignmentCopyWith<$Res> implements $AssignmentCopyWith<$Res> {
  factory _$AssignmentCopyWith(_Assignment value, $Res Function(_Assignment) _then) = __$AssignmentCopyWithImpl;
@override @useResult
$Res call({
 String? from, String? to,@timestampKey DateTime? assignmentDate
});




}
/// @nodoc
class __$AssignmentCopyWithImpl<$Res>
    implements _$AssignmentCopyWith<$Res> {
  __$AssignmentCopyWithImpl(this._self, this._then);

  final _Assignment _self;
  final $Res Function(_Assignment) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,Object? assignmentDate = freezed,}) {
  return _then(_Assignment(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,assignmentDate: freezed == assignmentDate ? _self.assignmentDate : assignmentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$UsageHistory {

 String? get id;@timestampKey DateTime? get dateOfUse; String? get eventId; String? get receptionistId; List<String>? get useTicket;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of UsageHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsageHistoryCopyWith<UsageHistory> get copyWith => _$UsageHistoryCopyWithImpl<UsageHistory>(this as UsageHistory, _$identity);

  /// Serializes this UsageHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsageHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.dateOfUse, dateOfUse) || other.dateOfUse == dateOfUse)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.receptionistId, receptionistId) || other.receptionistId == receptionistId)&&const DeepCollectionEquality().equals(other.useTicket, useTicket)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateOfUse,eventId,receptionistId,const DeepCollectionEquality().hash(useTicket),createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'UsageHistory(id: $id, dateOfUse: $dateOfUse, eventId: $eventId, receptionistId: $receptionistId, useTicket: $useTicket, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $UsageHistoryCopyWith<$Res>  {
  factory $UsageHistoryCopyWith(UsageHistory value, $Res Function(UsageHistory) _then) = _$UsageHistoryCopyWithImpl;
@useResult
$Res call({
 String? id,@timestampKey DateTime? dateOfUse, String? eventId, String? receptionistId, List<String>? useTicket,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$UsageHistoryCopyWithImpl<$Res>
    implements $UsageHistoryCopyWith<$Res> {
  _$UsageHistoryCopyWithImpl(this._self, this._then);

  final UsageHistory _self;
  final $Res Function(UsageHistory) _then;

/// Create a copy of UsageHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? dateOfUse = freezed,Object? eventId = freezed,Object? receptionistId = freezed,Object? useTicket = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,dateOfUse: freezed == dateOfUse ? _self.dateOfUse : dateOfUse // ignore: cast_nullable_to_non_nullable
as DateTime?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,receptionistId: freezed == receptionistId ? _self.receptionistId : receptionistId // ignore: cast_nullable_to_non_nullable
as String?,useTicket: freezed == useTicket ? _self.useTicket : useTicket // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UsageHistory].
extension UsageHistoryPatterns on UsageHistory {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UsageHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UsageHistory() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UsageHistory value)  $default,){
final _that = this;
switch (_that) {
case _UsageHistory():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UsageHistory value)?  $default,){
final _that = this;
switch (_that) {
case _UsageHistory() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @timestampKey  DateTime? dateOfUse,  String? eventId,  String? receptionistId,  List<String>? useTicket, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UsageHistory() when $default != null:
return $default(_that.id,_that.dateOfUse,_that.eventId,_that.receptionistId,_that.useTicket,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @timestampKey  DateTime? dateOfUse,  String? eventId,  String? receptionistId,  List<String>? useTicket, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _UsageHistory():
return $default(_that.id,_that.dateOfUse,_that.eventId,_that.receptionistId,_that.useTicket,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @timestampKey  DateTime? dateOfUse,  String? eventId,  String? receptionistId,  List<String>? useTicket, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _UsageHistory() when $default != null:
return $default(_that.id,_that.dateOfUse,_that.eventId,_that.receptionistId,_that.useTicket,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UsageHistory extends UsageHistory {
   _UsageHistory({this.id, @timestampKey required this.dateOfUse, required this.eventId, required this.receptionistId, required final  List<String>? useTicket, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt}): _useTicket = useTicket,super._();
  factory _UsageHistory.fromJson(Map<String, dynamic> json) => _$UsageHistoryFromJson(json);

@override final  String? id;
@override@timestampKey final  DateTime? dateOfUse;
@override final  String? eventId;
@override final  String? receptionistId;
 final  List<String>? _useTicket;
@override List<String>? get useTicket {
  final value = _useTicket;
  if (value == null) return null;
  if (_useTicket is EqualUnmodifiableListView) return _useTicket;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of UsageHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsageHistoryCopyWith<_UsageHistory> get copyWith => __$UsageHistoryCopyWithImpl<_UsageHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsageHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsageHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.dateOfUse, dateOfUse) || other.dateOfUse == dateOfUse)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.receptionistId, receptionistId) || other.receptionistId == receptionistId)&&const DeepCollectionEquality().equals(other._useTicket, _useTicket)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,dateOfUse,eventId,receptionistId,const DeepCollectionEquality().hash(_useTicket),createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'UsageHistory(id: $id, dateOfUse: $dateOfUse, eventId: $eventId, receptionistId: $receptionistId, useTicket: $useTicket, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$UsageHistoryCopyWith<$Res> implements $UsageHistoryCopyWith<$Res> {
  factory _$UsageHistoryCopyWith(_UsageHistory value, $Res Function(_UsageHistory) _then) = __$UsageHistoryCopyWithImpl;
@override @useResult
$Res call({
 String? id,@timestampKey DateTime? dateOfUse, String? eventId, String? receptionistId, List<String>? useTicket,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$UsageHistoryCopyWithImpl<$Res>
    implements _$UsageHistoryCopyWith<$Res> {
  __$UsageHistoryCopyWithImpl(this._self, this._then);

  final _UsageHistory _self;
  final $Res Function(_UsageHistory) _then;

/// Create a copy of UsageHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? dateOfUse = freezed,Object? eventId = freezed,Object? receptionistId = freezed,Object? useTicket = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_UsageHistory(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,dateOfUse: freezed == dateOfUse ? _self.dateOfUse : dateOfUse // ignore: cast_nullable_to_non_nullable
as DateTime?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,receptionistId: freezed == receptionistId ? _self.receptionistId : receptionistId // ignore: cast_nullable_to_non_nullable
as String?,useTicket: freezed == useTicket ? _self._useTicket : useTicket // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
