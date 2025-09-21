// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Order {

 String? get id; StatusType? get status; String? get paymentIntentId; String? get checkoutSessionId; String? get userId; String? get eventId;@timestampKey DateTime? get purchaseTime; List<SnapshotProduct>? get snapshotProducts;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderCopyWith<Order> get copyWith => _$OrderCopyWithImpl<Order>(this as Order, _$identity);

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Order&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.checkoutSessionId, checkoutSessionId) || other.checkoutSessionId == checkoutSessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.purchaseTime, purchaseTime) || other.purchaseTime == purchaseTime)&&const DeepCollectionEquality().equals(other.snapshotProducts, snapshotProducts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,paymentIntentId,checkoutSessionId,userId,eventId,purchaseTime,const DeepCollectionEquality().hash(snapshotProducts),createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Order(id: $id, status: $status, paymentIntentId: $paymentIntentId, checkoutSessionId: $checkoutSessionId, userId: $userId, eventId: $eventId, purchaseTime: $purchaseTime, snapshotProducts: $snapshotProducts, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $OrderCopyWith<$Res>  {
  factory $OrderCopyWith(Order value, $Res Function(Order) _then) = _$OrderCopyWithImpl;
@useResult
$Res call({
 String? id, StatusType? status, String? paymentIntentId, String? checkoutSessionId, String? userId, String? eventId,@timestampKey DateTime? purchaseTime, List<SnapshotProduct>? snapshotProducts,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$OrderCopyWithImpl<$Res>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._self, this._then);

  final Order _self;
  final $Res Function(Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? status = freezed,Object? paymentIntentId = freezed,Object? checkoutSessionId = freezed,Object? userId = freezed,Object? eventId = freezed,Object? purchaseTime = freezed,Object? snapshotProducts = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusType?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,checkoutSessionId: freezed == checkoutSessionId ? _self.checkoutSessionId : checkoutSessionId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,purchaseTime: freezed == purchaseTime ? _self.purchaseTime : purchaseTime // ignore: cast_nullable_to_non_nullable
as DateTime?,snapshotProducts: freezed == snapshotProducts ? _self.snapshotProducts : snapshotProducts // ignore: cast_nullable_to_non_nullable
as List<SnapshotProduct>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Order].
extension OrderPatterns on Order {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Order value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Order value)  $default,){
final _that = this;
switch (_that) {
case _Order():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Order value)?  $default,){
final _that = this;
switch (_that) {
case _Order() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  StatusType? status,  String? paymentIntentId,  String? checkoutSessionId,  String? userId,  String? eventId, @timestampKey  DateTime? purchaseTime,  List<SnapshotProduct>? snapshotProducts, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.status,_that.paymentIntentId,_that.checkoutSessionId,_that.userId,_that.eventId,_that.purchaseTime,_that.snapshotProducts,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  StatusType? status,  String? paymentIntentId,  String? checkoutSessionId,  String? userId,  String? eventId, @timestampKey  DateTime? purchaseTime,  List<SnapshotProduct>? snapshotProducts, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Order():
return $default(_that.id,_that.status,_that.paymentIntentId,_that.checkoutSessionId,_that.userId,_that.eventId,_that.purchaseTime,_that.snapshotProducts,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  StatusType? status,  String? paymentIntentId,  String? checkoutSessionId,  String? userId,  String? eventId, @timestampKey  DateTime? purchaseTime,  List<SnapshotProduct>? snapshotProducts, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Order() when $default != null:
return $default(_that.id,_that.status,_that.paymentIntentId,_that.checkoutSessionId,_that.userId,_that.eventId,_that.purchaseTime,_that.snapshotProducts,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Order implements Order {
  const _Order({this.id, this.status, this.paymentIntentId, this.checkoutSessionId, this.userId, this.eventId, @timestampKey this.purchaseTime, final  List<SnapshotProduct>? snapshotProducts, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt}): _snapshotProducts = snapshotProducts;
  factory _Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

@override final  String? id;
@override final  StatusType? status;
@override final  String? paymentIntentId;
@override final  String? checkoutSessionId;
@override final  String? userId;
@override final  String? eventId;
@override@timestampKey final  DateTime? purchaseTime;
 final  List<SnapshotProduct>? _snapshotProducts;
@override List<SnapshotProduct>? get snapshotProducts {
  final value = _snapshotProducts;
  if (value == null) return null;
  if (_snapshotProducts is EqualUnmodifiableListView) return _snapshotProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderCopyWith<_Order> get copyWith => __$OrderCopyWithImpl<_Order>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Order&&(identical(other.id, id) || other.id == id)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.checkoutSessionId, checkoutSessionId) || other.checkoutSessionId == checkoutSessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.purchaseTime, purchaseTime) || other.purchaseTime == purchaseTime)&&const DeepCollectionEquality().equals(other._snapshotProducts, _snapshotProducts)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,status,paymentIntentId,checkoutSessionId,userId,eventId,purchaseTime,const DeepCollectionEquality().hash(_snapshotProducts),createdAt,updatedAt,deletedAt);

@override
String toString() {
  return 'Order(id: $id, status: $status, paymentIntentId: $paymentIntentId, checkoutSessionId: $checkoutSessionId, userId: $userId, eventId: $eventId, purchaseTime: $purchaseTime, snapshotProducts: $snapshotProducts, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) _then) = __$OrderCopyWithImpl;
@override @useResult
$Res call({
 String? id, StatusType? status, String? paymentIntentId, String? checkoutSessionId, String? userId, String? eventId,@timestampKey DateTime? purchaseTime, List<SnapshotProduct>? snapshotProducts,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(this._self, this._then);

  final _Order _self;
  final $Res Function(_Order) _then;

/// Create a copy of Order
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? status = freezed,Object? paymentIntentId = freezed,Object? checkoutSessionId = freezed,Object? userId = freezed,Object? eventId = freezed,Object? purchaseTime = freezed,Object? snapshotProducts = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_Order(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatusType?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,checkoutSessionId: freezed == checkoutSessionId ? _self.checkoutSessionId : checkoutSessionId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,purchaseTime: freezed == purchaseTime ? _self.purchaseTime : purchaseTime // ignore: cast_nullable_to_non_nullable
as DateTime?,snapshotProducts: freezed == snapshotProducts ? _self._snapshotProducts : snapshotProducts // ignore: cast_nullable_to_non_nullable
as List<SnapshotProduct>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SnapshotProduct {

@documentReferenceKey DocumentReference<Map<String, dynamic>>? get productDocRef; int? get quantity;// 購入者
 String? get userId; String? get userName;// 商品情報
 String? get productId; int? get exchangeNumber; String? get code; String? get name;// genre: string
 String? get desc; int? get price; List<String>? get pictureURL;@timestampKey DateTime? get expirationFrom;@timestampKey DateTime? get expirationTo;// 登録者
 String? get register;// 開催者
@documentReferenceKey DocumentReference<Map<String, dynamic>>? get organizerDocRef; String? get organizerId;// イベント情報
@documentReferenceKey DocumentReference<Map<String, dynamic>>? get eventDocRef; String? get eventId; String? get eventName; bool get expirationLink;// Stripe
 String? get priceId;
/// Create a copy of SnapshotProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SnapshotProductCopyWith<SnapshotProduct> get copyWith => _$SnapshotProductCopyWithImpl<SnapshotProduct>(this as SnapshotProduct, _$identity);

  /// Serializes this SnapshotProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SnapshotProduct&&(identical(other.productDocRef, productDocRef) || other.productDocRef == productDocRef)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.exchangeNumber, exchangeNumber) || other.exchangeNumber == exchangeNumber)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other.pictureURL, pictureURL)&&(identical(other.expirationFrom, expirationFrom) || other.expirationFrom == expirationFrom)&&(identical(other.expirationTo, expirationTo) || other.expirationTo == expirationTo)&&(identical(other.register, register) || other.register == register)&&(identical(other.organizerDocRef, organizerDocRef) || other.organizerDocRef == organizerDocRef)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.eventDocRef, eventDocRef) || other.eventDocRef == eventDocRef)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.expirationLink, expirationLink) || other.expirationLink == expirationLink)&&(identical(other.priceId, priceId) || other.priceId == priceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,productDocRef,quantity,userId,userName,productId,exchangeNumber,code,name,desc,price,const DeepCollectionEquality().hash(pictureURL),expirationFrom,expirationTo,register,organizerDocRef,organizerId,eventDocRef,eventId,eventName,expirationLink,priceId]);

@override
String toString() {
  return 'SnapshotProduct(productDocRef: $productDocRef, quantity: $quantity, userId: $userId, userName: $userName, productId: $productId, exchangeNumber: $exchangeNumber, code: $code, name: $name, desc: $desc, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, register: $register, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, expirationLink: $expirationLink, priceId: $priceId)';
}


}

/// @nodoc
abstract mixin class $SnapshotProductCopyWith<$Res>  {
  factory $SnapshotProductCopyWith(SnapshotProduct value, $Res Function(SnapshotProduct) _then) = _$SnapshotProductCopyWithImpl;
@useResult
$Res call({
@documentReferenceKey DocumentReference<Map<String, dynamic>>? productDocRef, int? quantity, String? userId, String? userName, String? productId, int? exchangeNumber, String? code, String? name, String? desc, int? price, List<String>? pictureURL,@timestampKey DateTime? expirationFrom,@timestampKey DateTime? expirationTo, String? register,@documentReferenceKey DocumentReference<Map<String, dynamic>>? organizerDocRef, String? organizerId,@documentReferenceKey DocumentReference<Map<String, dynamic>>? eventDocRef, String? eventId, String? eventName, bool expirationLink, String? priceId
});




}
/// @nodoc
class _$SnapshotProductCopyWithImpl<$Res>
    implements $SnapshotProductCopyWith<$Res> {
  _$SnapshotProductCopyWithImpl(this._self, this._then);

  final SnapshotProduct _self;
  final $Res Function(SnapshotProduct) _then;

/// Create a copy of SnapshotProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productDocRef = freezed,Object? quantity = freezed,Object? userId = freezed,Object? userName = freezed,Object? productId = freezed,Object? exchangeNumber = freezed,Object? code = freezed,Object? name = freezed,Object? desc = freezed,Object? price = freezed,Object? pictureURL = freezed,Object? expirationFrom = freezed,Object? expirationTo = freezed,Object? register = freezed,Object? organizerDocRef = freezed,Object? organizerId = freezed,Object? eventDocRef = freezed,Object? eventId = freezed,Object? eventName = freezed,Object? expirationLink = null,Object? priceId = freezed,}) {
  return _then(_self.copyWith(
productDocRef: freezed == productDocRef ? _self.productDocRef : productDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,exchangeNumber: freezed == exchangeNumber ? _self.exchangeNumber : exchangeNumber // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,pictureURL: freezed == pictureURL ? _self.pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>?,expirationFrom: freezed == expirationFrom ? _self.expirationFrom : expirationFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,expirationTo: freezed == expirationTo ? _self.expirationTo : expirationTo // ignore: cast_nullable_to_non_nullable
as DateTime?,register: freezed == register ? _self.register : register // ignore: cast_nullable_to_non_nullable
as String?,organizerDocRef: freezed == organizerDocRef ? _self.organizerDocRef : organizerDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,eventDocRef: freezed == eventDocRef ? _self.eventDocRef : eventDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,eventName: freezed == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String?,expirationLink: null == expirationLink ? _self.expirationLink : expirationLink // ignore: cast_nullable_to_non_nullable
as bool,priceId: freezed == priceId ? _self.priceId : priceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SnapshotProduct].
extension SnapshotProductPatterns on SnapshotProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SnapshotProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SnapshotProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SnapshotProduct value)  $default,){
final _that = this;
switch (_that) {
case _SnapshotProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SnapshotProduct value)?  $default,){
final _that = this;
switch (_that) {
case _SnapshotProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@documentReferenceKey  DocumentReference<Map<String, dynamic>>? productDocRef,  int? quantity,  String? userId,  String? userName,  String? productId,  int? exchangeNumber,  String? code,  String? name,  String? desc,  int? price,  List<String>? pictureURL, @timestampKey  DateTime? expirationFrom, @timestampKey  DateTime? expirationTo,  String? register, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? organizerDocRef,  String? organizerId, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? eventDocRef,  String? eventId,  String? eventName,  bool expirationLink,  String? priceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SnapshotProduct() when $default != null:
return $default(_that.productDocRef,_that.quantity,_that.userId,_that.userName,_that.productId,_that.exchangeNumber,_that.code,_that.name,_that.desc,_that.price,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.register,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.expirationLink,_that.priceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@documentReferenceKey  DocumentReference<Map<String, dynamic>>? productDocRef,  int? quantity,  String? userId,  String? userName,  String? productId,  int? exchangeNumber,  String? code,  String? name,  String? desc,  int? price,  List<String>? pictureURL, @timestampKey  DateTime? expirationFrom, @timestampKey  DateTime? expirationTo,  String? register, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? organizerDocRef,  String? organizerId, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? eventDocRef,  String? eventId,  String? eventName,  bool expirationLink,  String? priceId)  $default,) {final _that = this;
switch (_that) {
case _SnapshotProduct():
return $default(_that.productDocRef,_that.quantity,_that.userId,_that.userName,_that.productId,_that.exchangeNumber,_that.code,_that.name,_that.desc,_that.price,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.register,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.expirationLink,_that.priceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@documentReferenceKey  DocumentReference<Map<String, dynamic>>? productDocRef,  int? quantity,  String? userId,  String? userName,  String? productId,  int? exchangeNumber,  String? code,  String? name,  String? desc,  int? price,  List<String>? pictureURL, @timestampKey  DateTime? expirationFrom, @timestampKey  DateTime? expirationTo,  String? register, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? organizerDocRef,  String? organizerId, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? eventDocRef,  String? eventId,  String? eventName,  bool expirationLink,  String? priceId)?  $default,) {final _that = this;
switch (_that) {
case _SnapshotProduct() when $default != null:
return $default(_that.productDocRef,_that.quantity,_that.userId,_that.userName,_that.productId,_that.exchangeNumber,_that.code,_that.name,_that.desc,_that.price,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.register,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.expirationLink,_that.priceId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SnapshotProduct implements SnapshotProduct {
  const _SnapshotProduct({@documentReferenceKey this.productDocRef, this.quantity, this.userId, this.userName, this.productId, this.exchangeNumber, this.code, this.name, this.desc, this.price, final  List<String>? pictureURL, @timestampKey this.expirationFrom, @timestampKey this.expirationTo, this.register, @documentReferenceKey this.organizerDocRef, this.organizerId, @documentReferenceKey this.eventDocRef, this.eventId, this.eventName, this.expirationLink = true, this.priceId}): _pictureURL = pictureURL;
  factory _SnapshotProduct.fromJson(Map<String, dynamic> json) => _$SnapshotProductFromJson(json);

@override@documentReferenceKey final  DocumentReference<Map<String, dynamic>>? productDocRef;
@override final  int? quantity;
// 購入者
@override final  String? userId;
@override final  String? userName;
// 商品情報
@override final  String? productId;
@override final  int? exchangeNumber;
@override final  String? code;
@override final  String? name;
// genre: string
@override final  String? desc;
@override final  int? price;
 final  List<String>? _pictureURL;
@override List<String>? get pictureURL {
  final value = _pictureURL;
  if (value == null) return null;
  if (_pictureURL is EqualUnmodifiableListView) return _pictureURL;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@timestampKey final  DateTime? expirationFrom;
@override@timestampKey final  DateTime? expirationTo;
// 登録者
@override final  String? register;
// 開催者
@override@documentReferenceKey final  DocumentReference<Map<String, dynamic>>? organizerDocRef;
@override final  String? organizerId;
// イベント情報
@override@documentReferenceKey final  DocumentReference<Map<String, dynamic>>? eventDocRef;
@override final  String? eventId;
@override final  String? eventName;
@override@JsonKey() final  bool expirationLink;
// Stripe
@override final  String? priceId;

/// Create a copy of SnapshotProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SnapshotProductCopyWith<_SnapshotProduct> get copyWith => __$SnapshotProductCopyWithImpl<_SnapshotProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SnapshotProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SnapshotProduct&&(identical(other.productDocRef, productDocRef) || other.productDocRef == productDocRef)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.exchangeNumber, exchangeNumber) || other.exchangeNumber == exchangeNumber)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other._pictureURL, _pictureURL)&&(identical(other.expirationFrom, expirationFrom) || other.expirationFrom == expirationFrom)&&(identical(other.expirationTo, expirationTo) || other.expirationTo == expirationTo)&&(identical(other.register, register) || other.register == register)&&(identical(other.organizerDocRef, organizerDocRef) || other.organizerDocRef == organizerDocRef)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.eventDocRef, eventDocRef) || other.eventDocRef == eventDocRef)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.expirationLink, expirationLink) || other.expirationLink == expirationLink)&&(identical(other.priceId, priceId) || other.priceId == priceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,productDocRef,quantity,userId,userName,productId,exchangeNumber,code,name,desc,price,const DeepCollectionEquality().hash(_pictureURL),expirationFrom,expirationTo,register,organizerDocRef,organizerId,eventDocRef,eventId,eventName,expirationLink,priceId]);

@override
String toString() {
  return 'SnapshotProduct(productDocRef: $productDocRef, quantity: $quantity, userId: $userId, userName: $userName, productId: $productId, exchangeNumber: $exchangeNumber, code: $code, name: $name, desc: $desc, price: $price, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, register: $register, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, expirationLink: $expirationLink, priceId: $priceId)';
}


}

/// @nodoc
abstract mixin class _$SnapshotProductCopyWith<$Res> implements $SnapshotProductCopyWith<$Res> {
  factory _$SnapshotProductCopyWith(_SnapshotProduct value, $Res Function(_SnapshotProduct) _then) = __$SnapshotProductCopyWithImpl;
@override @useResult
$Res call({
@documentReferenceKey DocumentReference<Map<String, dynamic>>? productDocRef, int? quantity, String? userId, String? userName, String? productId, int? exchangeNumber, String? code, String? name, String? desc, int? price, List<String>? pictureURL,@timestampKey DateTime? expirationFrom,@timestampKey DateTime? expirationTo, String? register,@documentReferenceKey DocumentReference<Map<String, dynamic>>? organizerDocRef, String? organizerId,@documentReferenceKey DocumentReference<Map<String, dynamic>>? eventDocRef, String? eventId, String? eventName, bool expirationLink, String? priceId
});




}
/// @nodoc
class __$SnapshotProductCopyWithImpl<$Res>
    implements _$SnapshotProductCopyWith<$Res> {
  __$SnapshotProductCopyWithImpl(this._self, this._then);

  final _SnapshotProduct _self;
  final $Res Function(_SnapshotProduct) _then;

/// Create a copy of SnapshotProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productDocRef = freezed,Object? quantity = freezed,Object? userId = freezed,Object? userName = freezed,Object? productId = freezed,Object? exchangeNumber = freezed,Object? code = freezed,Object? name = freezed,Object? desc = freezed,Object? price = freezed,Object? pictureURL = freezed,Object? expirationFrom = freezed,Object? expirationTo = freezed,Object? register = freezed,Object? organizerDocRef = freezed,Object? organizerId = freezed,Object? eventDocRef = freezed,Object? eventId = freezed,Object? eventName = freezed,Object? expirationLink = null,Object? priceId = freezed,}) {
  return _then(_SnapshotProduct(
productDocRef: freezed == productDocRef ? _self.productDocRef : productDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,quantity: freezed == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String?,exchangeNumber: freezed == exchangeNumber ? _self.exchangeNumber : exchangeNumber // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,pictureURL: freezed == pictureURL ? _self._pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>?,expirationFrom: freezed == expirationFrom ? _self.expirationFrom : expirationFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,expirationTo: freezed == expirationTo ? _self.expirationTo : expirationTo // ignore: cast_nullable_to_non_nullable
as DateTime?,register: freezed == register ? _self.register : register // ignore: cast_nullable_to_non_nullable
as String?,organizerDocRef: freezed == organizerDocRef ? _self.organizerDocRef : organizerDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,eventDocRef: freezed == eventDocRef ? _self.eventDocRef : eventDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,eventName: freezed == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String?,expirationLink: null == expirationLink ? _self.expirationLink : expirationLink // ignore: cast_nullable_to_non_nullable
as bool,priceId: freezed == priceId ? _self.priceId : priceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
