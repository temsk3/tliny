// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineItem _$LineItemFromJson(Map<String, dynamic> json) => LineItem(
  quantity: (json['quantity'] as num).toInt(),
  priceDate: PriceData.fromJson(json['price_date'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LineItemToJson(LineItem instance) => <String, dynamic>{
  'quantity': instance.quantity,
  'price_date': instance.priceDate.toJson(),
};

PriceData _$PriceDataFromJson(Map<String, dynamic> json) => PriceData(
  unitAmount: (json['unit_amount'] as num).toInt(),
  currency: json['currency'] as String,
  productData: ProductData.fromJson(
    json['product_data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$PriceDataToJson(PriceData instance) => <String, dynamic>{
  'unit_amount': instance.unitAmount,
  'currency': instance.currency,
  'product_data': instance.productData.toJson(),
};

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
  name: json['name'] as String,
  description: json['description'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  metaData: MetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'meta_data': instance.metaData.toJson(),
    };

MetaData _$MetaDataFromJson(Map<String, dynamic> json) =>
    MetaData(productId: json['product_id'] as String);

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
  'product_id': instance.productId,
};

_$LineItemImpl _$$LineItemImplFromJson(Map<String, dynamic> json) =>
    _$LineItemImpl(
      quantity: (json['quantity'] as num).toInt(),
      priceDate: PriceData.fromJson(json['priceDate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LineItemImplToJson(_$LineItemImpl instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'priceDate': instance.priceDate,
    };

_$PriceDataImpl _$$PriceDataImplFromJson(Map<String, dynamic> json) =>
    _$PriceDataImpl(
      unitAmount: (json['unitAmount'] as num).toInt(),
      currency: json['currency'] as String,
      productData: ProductData.fromJson(
        json['productData'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$PriceDataImplToJson(_$PriceDataImpl instance) =>
    <String, dynamic>{
      'unitAmount': instance.unitAmount,
      'currency': instance.currency,
      'productData': instance.productData,
    };

_$ProductDataImpl _$$ProductDataImplFromJson(Map<String, dynamic> json) =>
    _$ProductDataImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      metaData: MetaData.fromJson(json['metaData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductDataImplToJson(_$ProductDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'metaData': instance.metaData,
    };

_$MetaDataImpl _$$MetaDataImplFromJson(Map<String, dynamic> json) =>
    _$MetaDataImpl(productId: json['productId'] as String);

Map<String, dynamic> _$$MetaDataImplToJson(_$MetaDataImpl instance) =>
    <String, dynamic>{'productId': instance.productId};
