// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
  id: json['id'] as String?,
  status: $enumDecodeNullable(_$StatusTypeEnumMap, json['status']),
  paymentIntentId: json['paymentIntentId'] as String?,
  checkoutSessionId: json['checkoutSessionId'] as String?,
  userId: json['userId'] as String?,
  eventId: json['eventId'] as String?,
  purchaseTime: dateFromTimestampValue(json['purchaseTime']),
  snapshotProducts:
      (json['snapshotProducts'] as List<dynamic>?)
          ?.map((e) => SnapshotProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
  createdAt: dateFromTimestampValue(json['createdAt']),
  updatedAt: dateFromTimestampValue(json['updatedAt']),
  deletedAt: dateFromTimestampValue(json['deletedAt']),
);

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$StatusTypeEnumMap[instance.status],
  'paymentIntentId': instance.paymentIntentId,
  'checkoutSessionId': instance.checkoutSessionId,
  'userId': instance.userId,
  'eventId': instance.eventId,
  'purchaseTime': timestampFromDateValue(instance.purchaseTime),
  'snapshotProducts':
      instance.snapshotProducts?.map((e) => e.toJson()).toList(),
  'createdAt': timestampFromDateValue(instance.createdAt),
  'updatedAt': timestampFromDateValue(instance.updatedAt),
  'deletedAt': timestampFromDateValue(instance.deletedAt),
};

const _$StatusTypeEnumMap = {
  StatusType.pre: 'pre',
  StatusType.order: 'order',
  StatusType.cancel: 'cancel',
};

_SnapshotProduct _$SnapshotProductFromJson(Map<String, dynamic> json) =>
    _SnapshotProduct(
      productDocRef: documentReference(
        json['productDocRef'] as DocumentReference<Map<String, dynamic>>?,
      ),
      quantity: (json['quantity'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      productId: json['productId'] as String?,
      exchangeNumber: (json['exchangeNumber'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      price: (json['price'] as num?)?.toInt(),
      pictureURL:
          (json['pictureURL'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      expirationFrom: dateFromTimestampValue(json['expirationFrom']),
      expirationTo: dateFromTimestampValue(json['expirationTo']),
      register: json['register'] as String?,
      organizerDocRef: documentReference(
        json['organizerDocRef'] as DocumentReference<Map<String, dynamic>>?,
      ),
      organizerId: json['organizerId'] as String?,
      eventDocRef: documentReference(
        json['eventDocRef'] as DocumentReference<Map<String, dynamic>>?,
      ),
      eventId: json['eventId'] as String?,
      eventName: json['eventName'] as String?,
      expirationLink: json['expirationLink'] as bool? ?? true,
      priceId: json['priceId'] as String?,
    );

Map<String, dynamic> _$SnapshotProductToJson(_SnapshotProduct instance) =>
    <String, dynamic>{
      'productDocRef': documentReference(instance.productDocRef),
      'quantity': instance.quantity,
      'userId': instance.userId,
      'userName': instance.userName,
      'productId': instance.productId,
      'exchangeNumber': instance.exchangeNumber,
      'code': instance.code,
      'name': instance.name,
      'desc': instance.desc,
      'price': instance.price,
      'pictureURL': instance.pictureURL,
      'expirationFrom': timestampFromDateValue(instance.expirationFrom),
      'expirationTo': timestampFromDateValue(instance.expirationTo),
      'register': instance.register,
      'organizerDocRef': documentReference(instance.organizerDocRef),
      'organizerId': instance.organizerId,
      'eventDocRef': documentReference(instance.eventDocRef),
      'eventId': instance.eventId,
      'eventName': instance.eventName,
      'expirationLink': instance.expirationLink,
      'priceId': instance.priceId,
    };
