// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {

// 商品情報
 String? get id; int? get exchangeNumber;//
 String? get code; String? get name;@JsonKey(unknownEnumValue: GenreType.others) GenreType? get genre; String? get desc; int get stock; int get price; String? get strageId; List<String> get pictureURL;@timestampKey DateTime? get expirationFrom;@timestampKey DateTime? get expirationTo; bool? get isActive; bool? get isPublish;//
 String? get priceId;//
// 登録者
 String? get register;// 開催者
@documentReferenceKey DocumentReference<Map<String, dynamic>>? get organizerDocRef; String? get organizerId;// イベント情報
@documentReferenceKey DocumentReference<Map<String, dynamic>>? get eventDocRef; String? get eventId; String? get eventName; bool? get expirationLink;@timestampKey DateTime? get salesStart;@timestampKey DateTime? get salesEnd;@timestampKey DateTime? get createdAt;@timestampKey DateTime? get updatedAt;@timestampKey DateTime? get deletedAt;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.exchangeNumber, exchangeNumber) || other.exchangeNumber == exchangeNumber)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.price, price) || other.price == price)&&(identical(other.strageId, strageId) || other.strageId == strageId)&&const DeepCollectionEquality().equals(other.pictureURL, pictureURL)&&(identical(other.expirationFrom, expirationFrom) || other.expirationFrom == expirationFrom)&&(identical(other.expirationTo, expirationTo) || other.expirationTo == expirationTo)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPublish, isPublish) || other.isPublish == isPublish)&&(identical(other.priceId, priceId) || other.priceId == priceId)&&(identical(other.register, register) || other.register == register)&&(identical(other.organizerDocRef, organizerDocRef) || other.organizerDocRef == organizerDocRef)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.eventDocRef, eventDocRef) || other.eventDocRef == eventDocRef)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.expirationLink, expirationLink) || other.expirationLink == expirationLink)&&(identical(other.salesStart, salesStart) || other.salesStart == salesStart)&&(identical(other.salesEnd, salesEnd) || other.salesEnd == salesEnd)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,exchangeNumber,code,name,genre,desc,stock,price,strageId,const DeepCollectionEquality().hash(pictureURL),expirationFrom,expirationTo,isActive,isPublish,priceId,register,organizerDocRef,organizerId,eventDocRef,eventId,eventName,expirationLink,salesStart,salesEnd,createdAt,updatedAt,deletedAt]);

@override
String toString() {
  return 'Product(id: $id, exchangeNumber: $exchangeNumber, code: $code, name: $name, genre: $genre, desc: $desc, stock: $stock, price: $price, strageId: $strageId, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, isActive: $isActive, isPublish: $isPublish, priceId: $priceId, register: $register, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, expirationLink: $expirationLink, salesStart: $salesStart, salesEnd: $salesEnd, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String? id, int? exchangeNumber, String? code, String? name,@JsonKey(unknownEnumValue: GenreType.others) GenreType? genre, String? desc, int stock, int price, String? strageId, List<String> pictureURL,@timestampKey DateTime? expirationFrom,@timestampKey DateTime? expirationTo, bool? isActive, bool? isPublish, String? priceId, String? register,@documentReferenceKey DocumentReference<Map<String, dynamic>>? organizerDocRef, String? organizerId,@documentReferenceKey DocumentReference<Map<String, dynamic>>? eventDocRef, String? eventId, String? eventName, bool? expirationLink,@timestampKey DateTime? salesStart,@timestampKey DateTime? salesEnd,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? exchangeNumber = freezed,Object? code = freezed,Object? name = freezed,Object? genre = freezed,Object? desc = freezed,Object? stock = null,Object? price = null,Object? strageId = freezed,Object? pictureURL = null,Object? expirationFrom = freezed,Object? expirationTo = freezed,Object? isActive = freezed,Object? isPublish = freezed,Object? priceId = freezed,Object? register = freezed,Object? organizerDocRef = freezed,Object? organizerId = freezed,Object? eventDocRef = freezed,Object? eventId = freezed,Object? eventName = freezed,Object? expirationLink = freezed,Object? salesStart = freezed,Object? salesEnd = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,exchangeNumber: freezed == exchangeNumber ? _self.exchangeNumber : exchangeNumber // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as GenreType?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,strageId: freezed == strageId ? _self.strageId : strageId // ignore: cast_nullable_to_non_nullable
as String?,pictureURL: null == pictureURL ? _self.pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>,expirationFrom: freezed == expirationFrom ? _self.expirationFrom : expirationFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,expirationTo: freezed == expirationTo ? _self.expirationTo : expirationTo // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isPublish: freezed == isPublish ? _self.isPublish : isPublish // ignore: cast_nullable_to_non_nullable
as bool?,priceId: freezed == priceId ? _self.priceId : priceId // ignore: cast_nullable_to_non_nullable
as String?,register: freezed == register ? _self.register : register // ignore: cast_nullable_to_non_nullable
as String?,organizerDocRef: freezed == organizerDocRef ? _self.organizerDocRef : organizerDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,eventDocRef: freezed == eventDocRef ? _self.eventDocRef : eventDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,eventName: freezed == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String?,expirationLink: freezed == expirationLink ? _self.expirationLink : expirationLink // ignore: cast_nullable_to_non_nullable
as bool?,salesStart: freezed == salesStart ? _self.salesStart : salesStart // ignore: cast_nullable_to_non_nullable
as DateTime?,salesEnd: freezed == salesEnd ? _self.salesEnd : salesEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  int? exchangeNumber,  String? code,  String? name, @JsonKey(unknownEnumValue: GenreType.others)  GenreType? genre,  String? desc,  int stock,  int price,  String? strageId,  List<String> pictureURL, @timestampKey  DateTime? expirationFrom, @timestampKey  DateTime? expirationTo,  bool? isActive,  bool? isPublish,  String? priceId,  String? register, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? organizerDocRef,  String? organizerId, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? eventDocRef,  String? eventId,  String? eventName,  bool? expirationLink, @timestampKey  DateTime? salesStart, @timestampKey  DateTime? salesEnd, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.exchangeNumber,_that.code,_that.name,_that.genre,_that.desc,_that.stock,_that.price,_that.strageId,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.isActive,_that.isPublish,_that.priceId,_that.register,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.expirationLink,_that.salesStart,_that.salesEnd,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  int? exchangeNumber,  String? code,  String? name, @JsonKey(unknownEnumValue: GenreType.others)  GenreType? genre,  String? desc,  int stock,  int price,  String? strageId,  List<String> pictureURL, @timestampKey  DateTime? expirationFrom, @timestampKey  DateTime? expirationTo,  bool? isActive,  bool? isPublish,  String? priceId,  String? register, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? organizerDocRef,  String? organizerId, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? eventDocRef,  String? eventId,  String? eventName,  bool? expirationLink, @timestampKey  DateTime? salesStart, @timestampKey  DateTime? salesEnd, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.exchangeNumber,_that.code,_that.name,_that.genre,_that.desc,_that.stock,_that.price,_that.strageId,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.isActive,_that.isPublish,_that.priceId,_that.register,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.expirationLink,_that.salesStart,_that.salesEnd,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  int? exchangeNumber,  String? code,  String? name, @JsonKey(unknownEnumValue: GenreType.others)  GenreType? genre,  String? desc,  int stock,  int price,  String? strageId,  List<String> pictureURL, @timestampKey  DateTime? expirationFrom, @timestampKey  DateTime? expirationTo,  bool? isActive,  bool? isPublish,  String? priceId,  String? register, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? organizerDocRef,  String? organizerId, @documentReferenceKey  DocumentReference<Map<String, dynamic>>? eventDocRef,  String? eventId,  String? eventName,  bool? expirationLink, @timestampKey  DateTime? salesStart, @timestampKey  DateTime? salesEnd, @timestampKey  DateTime? createdAt, @timestampKey  DateTime? updatedAt, @timestampKey  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.exchangeNumber,_that.code,_that.name,_that.genre,_that.desc,_that.stock,_that.price,_that.strageId,_that.pictureURL,_that.expirationFrom,_that.expirationTo,_that.isActive,_that.isPublish,_that.priceId,_that.register,_that.organizerDocRef,_that.organizerId,_that.eventDocRef,_that.eventId,_that.eventName,_that.expirationLink,_that.salesStart,_that.salesEnd,_that.createdAt,_that.updatedAt,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Product extends Product {
  const _Product({this.id, this.exchangeNumber, this.code, required this.name, @JsonKey(unknownEnumValue: GenreType.others) required this.genre, required this.desc, this.stock = 0, this.price = 50, this.strageId, final  List<String> pictureURL = const [], @timestampKey required this.expirationFrom, @timestampKey required this.expirationTo, required this.isActive, required this.isPublish, this.priceId, this.register, @documentReferenceKey this.organizerDocRef, this.organizerId, @documentReferenceKey this.eventDocRef, this.eventId, this.eventName, this.expirationLink, @timestampKey required this.salesStart, @timestampKey required this.salesEnd, @timestampKey this.createdAt, @timestampKey this.updatedAt, @timestampKey this.deletedAt}): _pictureURL = pictureURL,super._();
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

// 商品情報
@override final  String? id;
@override final  int? exchangeNumber;
//
@override final  String? code;
@override final  String? name;
@override@JsonKey(unknownEnumValue: GenreType.others) final  GenreType? genre;
@override final  String? desc;
@override@JsonKey() final  int stock;
@override@JsonKey() final  int price;
@override final  String? strageId;
 final  List<String> _pictureURL;
@override@JsonKey() List<String> get pictureURL {
  if (_pictureURL is EqualUnmodifiableListView) return _pictureURL;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pictureURL);
}

@override@timestampKey final  DateTime? expirationFrom;
@override@timestampKey final  DateTime? expirationTo;
@override final  bool? isActive;
@override final  bool? isPublish;
//
@override final  String? priceId;
//
// 登録者
@override final  String? register;
// 開催者
@override@documentReferenceKey final  DocumentReference<Map<String, dynamic>>? organizerDocRef;
@override final  String? organizerId;
// イベント情報
@override@documentReferenceKey final  DocumentReference<Map<String, dynamic>>? eventDocRef;
@override final  String? eventId;
@override final  String? eventName;
@override final  bool? expirationLink;
@override@timestampKey final  DateTime? salesStart;
@override@timestampKey final  DateTime? salesEnd;
@override@timestampKey final  DateTime? createdAt;
@override@timestampKey final  DateTime? updatedAt;
@override@timestampKey final  DateTime? deletedAt;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.exchangeNumber, exchangeNumber) || other.exchangeNumber == exchangeNumber)&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.price, price) || other.price == price)&&(identical(other.strageId, strageId) || other.strageId == strageId)&&const DeepCollectionEquality().equals(other._pictureURL, _pictureURL)&&(identical(other.expirationFrom, expirationFrom) || other.expirationFrom == expirationFrom)&&(identical(other.expirationTo, expirationTo) || other.expirationTo == expirationTo)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isPublish, isPublish) || other.isPublish == isPublish)&&(identical(other.priceId, priceId) || other.priceId == priceId)&&(identical(other.register, register) || other.register == register)&&(identical(other.organizerDocRef, organizerDocRef) || other.organizerDocRef == organizerDocRef)&&(identical(other.organizerId, organizerId) || other.organizerId == organizerId)&&(identical(other.eventDocRef, eventDocRef) || other.eventDocRef == eventDocRef)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.expirationLink, expirationLink) || other.expirationLink == expirationLink)&&(identical(other.salesStart, salesStart) || other.salesStart == salesStart)&&(identical(other.salesEnd, salesEnd) || other.salesEnd == salesEnd)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,exchangeNumber,code,name,genre,desc,stock,price,strageId,const DeepCollectionEquality().hash(_pictureURL),expirationFrom,expirationTo,isActive,isPublish,priceId,register,organizerDocRef,organizerId,eventDocRef,eventId,eventName,expirationLink,salesStart,salesEnd,createdAt,updatedAt,deletedAt]);

@override
String toString() {
  return 'Product(id: $id, exchangeNumber: $exchangeNumber, code: $code, name: $name, genre: $genre, desc: $desc, stock: $stock, price: $price, strageId: $strageId, pictureURL: $pictureURL, expirationFrom: $expirationFrom, expirationTo: $expirationTo, isActive: $isActive, isPublish: $isPublish, priceId: $priceId, register: $register, organizerDocRef: $organizerDocRef, organizerId: $organizerId, eventDocRef: $eventDocRef, eventId: $eventId, eventName: $eventName, expirationLink: $expirationLink, salesStart: $salesStart, salesEnd: $salesEnd, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String? id, int? exchangeNumber, String? code, String? name,@JsonKey(unknownEnumValue: GenreType.others) GenreType? genre, String? desc, int stock, int price, String? strageId, List<String> pictureURL,@timestampKey DateTime? expirationFrom,@timestampKey DateTime? expirationTo, bool? isActive, bool? isPublish, String? priceId, String? register,@documentReferenceKey DocumentReference<Map<String, dynamic>>? organizerDocRef, String? organizerId,@documentReferenceKey DocumentReference<Map<String, dynamic>>? eventDocRef, String? eventId, String? eventName, bool? expirationLink,@timestampKey DateTime? salesStart,@timestampKey DateTime? salesEnd,@timestampKey DateTime? createdAt,@timestampKey DateTime? updatedAt,@timestampKey DateTime? deletedAt
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? exchangeNumber = freezed,Object? code = freezed,Object? name = freezed,Object? genre = freezed,Object? desc = freezed,Object? stock = null,Object? price = null,Object? strageId = freezed,Object? pictureURL = null,Object? expirationFrom = freezed,Object? expirationTo = freezed,Object? isActive = freezed,Object? isPublish = freezed,Object? priceId = freezed,Object? register = freezed,Object? organizerDocRef = freezed,Object? organizerId = freezed,Object? eventDocRef = freezed,Object? eventId = freezed,Object? eventName = freezed,Object? expirationLink = freezed,Object? salesStart = freezed,Object? salesEnd = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? deletedAt = freezed,}) {
  return _then(_Product(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,exchangeNumber: freezed == exchangeNumber ? _self.exchangeNumber : exchangeNumber // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as GenreType?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,strageId: freezed == strageId ? _self.strageId : strageId // ignore: cast_nullable_to_non_nullable
as String?,pictureURL: null == pictureURL ? _self._pictureURL : pictureURL // ignore: cast_nullable_to_non_nullable
as List<String>,expirationFrom: freezed == expirationFrom ? _self.expirationFrom : expirationFrom // ignore: cast_nullable_to_non_nullable
as DateTime?,expirationTo: freezed == expirationTo ? _self.expirationTo : expirationTo // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,isPublish: freezed == isPublish ? _self.isPublish : isPublish // ignore: cast_nullable_to_non_nullable
as bool?,priceId: freezed == priceId ? _self.priceId : priceId // ignore: cast_nullable_to_non_nullable
as String?,register: freezed == register ? _self.register : register // ignore: cast_nullable_to_non_nullable
as String?,organizerDocRef: freezed == organizerDocRef ? _self.organizerDocRef : organizerDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,organizerId: freezed == organizerId ? _self.organizerId : organizerId // ignore: cast_nullable_to_non_nullable
as String?,eventDocRef: freezed == eventDocRef ? _self.eventDocRef : eventDocRef // ignore: cast_nullable_to_non_nullable
as DocumentReference<Map<String, dynamic>>?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,eventName: freezed == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String?,expirationLink: freezed == expirationLink ? _self.expirationLink : expirationLink // ignore: cast_nullable_to_non_nullable
as bool?,salesStart: freezed == salesStart ? _self.salesStart : salesStart // ignore: cast_nullable_to_non_nullable
as DateTime?,salesEnd: freezed == salesEnd ? _self.salesEnd : salesEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ProductQueryParameter {

 String? get programId; GenreType? get genre;
/// Create a copy of ProductQueryParameter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductQueryParameterCopyWith<ProductQueryParameter> get copyWith => _$ProductQueryParameterCopyWithImpl<ProductQueryParameter>(this as ProductQueryParameter, _$identity);

  /// Serializes this ProductQueryParameter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductQueryParameter&&(identical(other.programId, programId) || other.programId == programId)&&(identical(other.genre, genre) || other.genre == genre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,programId,genre);

@override
String toString() {
  return 'ProductQueryParameter(programId: $programId, genre: $genre)';
}


}

/// @nodoc
abstract mixin class $ProductQueryParameterCopyWith<$Res>  {
  factory $ProductQueryParameterCopyWith(ProductQueryParameter value, $Res Function(ProductQueryParameter) _then) = _$ProductQueryParameterCopyWithImpl;
@useResult
$Res call({
 String? programId, GenreType? genre
});




}
/// @nodoc
class _$ProductQueryParameterCopyWithImpl<$Res>
    implements $ProductQueryParameterCopyWith<$Res> {
  _$ProductQueryParameterCopyWithImpl(this._self, this._then);

  final ProductQueryParameter _self;
  final $Res Function(ProductQueryParameter) _then;

/// Create a copy of ProductQueryParameter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? programId = freezed,Object? genre = freezed,}) {
  return _then(_self.copyWith(
programId: freezed == programId ? _self.programId : programId // ignore: cast_nullable_to_non_nullable
as String?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as GenreType?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductQueryParameter].
extension ProductQueryParameterPatterns on ProductQueryParameter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductQueryParameter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductQueryParameter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductQueryParameter value)  $default,){
final _that = this;
switch (_that) {
case _ProductQueryParameter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductQueryParameter value)?  $default,){
final _that = this;
switch (_that) {
case _ProductQueryParameter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? programId,  GenreType? genre)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductQueryParameter() when $default != null:
return $default(_that.programId,_that.genre);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? programId,  GenreType? genre)  $default,) {final _that = this;
switch (_that) {
case _ProductQueryParameter():
return $default(_that.programId,_that.genre);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? programId,  GenreType? genre)?  $default,) {final _that = this;
switch (_that) {
case _ProductQueryParameter() when $default != null:
return $default(_that.programId,_that.genre);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductQueryParameter implements ProductQueryParameter {
   _ProductQueryParameter(this.programId, this.genre);
  factory _ProductQueryParameter.fromJson(Map<String, dynamic> json) => _$ProductQueryParameterFromJson(json);

@override final  String? programId;
@override final  GenreType? genre;

/// Create a copy of ProductQueryParameter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductQueryParameterCopyWith<_ProductQueryParameter> get copyWith => __$ProductQueryParameterCopyWithImpl<_ProductQueryParameter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductQueryParameterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductQueryParameter&&(identical(other.programId, programId) || other.programId == programId)&&(identical(other.genre, genre) || other.genre == genre));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,programId,genre);

@override
String toString() {
  return 'ProductQueryParameter(programId: $programId, genre: $genre)';
}


}

/// @nodoc
abstract mixin class _$ProductQueryParameterCopyWith<$Res> implements $ProductQueryParameterCopyWith<$Res> {
  factory _$ProductQueryParameterCopyWith(_ProductQueryParameter value, $Res Function(_ProductQueryParameter) _then) = __$ProductQueryParameterCopyWithImpl;
@override @useResult
$Res call({
 String? programId, GenreType? genre
});




}
/// @nodoc
class __$ProductQueryParameterCopyWithImpl<$Res>
    implements _$ProductQueryParameterCopyWith<$Res> {
  __$ProductQueryParameterCopyWithImpl(this._self, this._then);

  final _ProductQueryParameter _self;
  final $Res Function(_ProductQueryParameter) _then;

/// Create a copy of ProductQueryParameter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? programId = freezed,Object? genre = freezed,}) {
  return _then(_ProductQueryParameter(
freezed == programId ? _self.programId : programId // ignore: cast_nullable_to_non_nullable
as String?,freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as GenreType?,
  ));
}


}

// dart format on
