// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String?,
      exchangeNumber: (json['exchangeNumber'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      genre: $enumDecodeNullable(_$GenreTypeEnumMap, json['genre'],
          unknownValue: GenreType.others),
      desc: json['desc'] as String?,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toInt() ?? 50,
      strageId: json['strageId'] as String?,
      pictureURL: (json['pictureURL'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      expirationFrom: dateFromTimestampValue(json['expirationFrom']),
      expirationTo: dateFromTimestampValue(json['expirationTo']),
      isActive: json['isActive'] as bool?,
      isPublish: json['isPublish'] as bool?,
      priceId: json['priceId'] as String?,
      register: json['register'] as String?,
      organizerDocRef: documentReference(
          json['organizerDocRef'] as DocumentReference<Map<String, dynamic>>?),
      organizerId: json['organizerId'] as String?,
      eventDocRef: documentReference(
          json['eventDocRef'] as DocumentReference<Map<String, dynamic>>?),
      eventId: json['eventId'] as String?,
      eventName: json['eventName'] as String?,
      expirationLink: json['expirationLink'] as bool?,
      salesStart: dateFromTimestampValue(json['salesStart']),
      salesEnd: dateFromTimestampValue(json['salesEnd']),
      createdAt: dateFromTimestampValue(json['createdAt']),
      updatedAt: dateFromTimestampValue(json['updatedAt']),
      deletedAt: dateFromTimestampValue(json['deletedAt']),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exchangeNumber': instance.exchangeNumber,
      'code': instance.code,
      'name': instance.name,
      'genre': _$GenreTypeEnumMap[instance.genre],
      'desc': instance.desc,
      'stock': instance.stock,
      'price': instance.price,
      'strageId': instance.strageId,
      'pictureURL': instance.pictureURL,
      'expirationFrom': timestampFromDateValue(instance.expirationFrom),
      'expirationTo': timestampFromDateValue(instance.expirationTo),
      'isActive': instance.isActive,
      'isPublish': instance.isPublish,
      'priceId': instance.priceId,
      'register': instance.register,
      'organizerDocRef': documentReference(instance.organizerDocRef),
      'organizerId': instance.organizerId,
      'eventDocRef': documentReference(instance.eventDocRef),
      'eventId': instance.eventId,
      'eventName': instance.eventName,
      'expirationLink': instance.expirationLink,
      'salesStart': timestampFromDateValue(instance.salesStart),
      'salesEnd': timestampFromDateValue(instance.salesEnd),
      'createdAt': timestampFromDateValue(instance.createdAt),
      'updatedAt': timestampFromDateValue(instance.updatedAt),
      'deletedAt': timestampFromDateValue(instance.deletedAt),
    };

const _$GenreTypeEnumMap = {
  GenreType.goods: 'goods',
  GenreType.foods: 'foods',
  GenreType.others: 'others',
};

_$ProductQueryParameterImpl _$$ProductQueryParameterImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductQueryParameterImpl(
      json['programId'] as String?,
      $enumDecodeNullable(_$GenreTypeEnumMap, json['genre']),
    );

Map<String, dynamic> _$$ProductQueryParameterImplToJson(
        _$ProductQueryParameterImpl instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'genre': _$GenreTypeEnumMap[instance.genre],
    };
