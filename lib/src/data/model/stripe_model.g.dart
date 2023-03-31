// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LineItem _$$_LineItemFromJson(Map<String, dynamic> json) => _$_LineItem(
      quantity: json['quantity'] as int,
      priceDate: PriceData.fromJson(json['price_date'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_LineItemToJson(_$_LineItem instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'price_date': instance.priceDate.toJson(),
    };

_$_PriceData _$$_PriceDataFromJson(Map<String, dynamic> json) => _$_PriceData(
      unitAmount: json['unit_amount'] as int,
      currency: json['currency'] as String,
      productData:
          ProductData.fromJson(json['product_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PriceDataToJson(_$_PriceData instance) =>
    <String, dynamic>{
      'unit_amount': instance.unitAmount,
      'currency': instance.currency,
      'product_data': instance.productData.toJson(),
    };

_$_ProductData _$$_ProductDataFromJson(Map<String, dynamic> json) =>
    _$_ProductData(
      name: json['name'] as String,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      metaData: MetaData.fromJson(json['meta_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ProductDataToJson(_$_ProductData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'meta_data': instance.metaData.toJson(),
    };

_$_MetaData _$$_MetaDataFromJson(Map<String, dynamic> json) => _$_MetaData(
      productId: json['product_id'] as String,
    );

Map<String, dynamic> _$$_MetaDataToJson(_$_MetaData instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
    };
