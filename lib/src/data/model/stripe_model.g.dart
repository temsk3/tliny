// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LineItem _$LineItemFromJson(Map<String, dynamic> json) => _LineItem(
  quantity: (json['quantity'] as num).toInt(),
  priceDate: PriceData.fromJson(json['priceDate'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LineItemToJson(_LineItem instance) => <String, dynamic>{
  'quantity': instance.quantity,
  'priceDate': instance.priceDate,
};

_PriceData _$PriceDataFromJson(Map<String, dynamic> json) => _PriceData(
  unitAmount: (json['unitAmount'] as num).toInt(),
  currency: json['currency'] as String,
  productData: ProductData.fromJson(
    json['productData'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PriceDataToJson(_PriceData instance) =>
    <String, dynamic>{
      'unitAmount': instance.unitAmount,
      'currency': instance.currency,
      'productData': instance.productData,
    };

_ProductData _$ProductDataFromJson(Map<String, dynamic> json) => _ProductData(
  name: json['name'] as String,
  description: json['description'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  metaData: MetaData.fromJson(json['metaData'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductDataToJson(_ProductData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'metaData': instance.metaData,
    };

_MetaData _$MetaDataFromJson(Map<String, dynamic> json) =>
    _MetaData(productId: json['product_id'] as String);

Map<String, dynamic> _$MetaDataToJson(_MetaData instance) => <String, dynamic>{
  'product_id': instance.productId,
};
