// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LineItemImpl _$$LineItemImplFromJson(Map<String, dynamic> json) =>
    _$LineItemImpl(
      quantity: (json['quantity'] as num).toInt(),
      priceDate: PriceData.fromJson(json['price_date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LineItemImplToJson(_$LineItemImpl instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'price_date': instance.priceDate.toJson(),
    };

_$PriceDataImpl _$$PriceDataImplFromJson(Map<String, dynamic> json) =>
    _$PriceDataImpl(
      unitAmount: (json['unit_amount'] as num).toInt(),
      currency: json['currency'] as String,
      productData: ProductData.fromJson(
        json['product_data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$PriceDataImplToJson(_$PriceDataImpl instance) =>
    <String, dynamic>{
      'unit_amount': instance.unitAmount,
      'currency': instance.currency,
      'product_data': instance.productData.toJson(),
    };

_$ProductDataImpl _$$ProductDataImplFromJson(Map<String, dynamic> json) =>
    _$ProductDataImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      metaData: MetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ProductDataImplToJson(_$ProductDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'meta_data': instance.metaData.toJson(),
    };

_$MetaDataImpl _$$MetaDataImplFromJson(Map<String, dynamic> json) =>
    _$MetaDataImpl(productId: json['product_id'] as String);

Map<String, dynamic> _$$MetaDataImplToJson(_$MetaDataImpl instance) =>
    <String, dynamic>{'product_id': instance.productId};
