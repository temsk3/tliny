// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_customer_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingParams _$ShippingParamsFromJson(Map<String, dynamic> json) =>
    ShippingParams();

Map<String, dynamic> _$ShippingParamsToJson(ShippingParams instance) =>
    <String, dynamic>{};

AddressParams _$AddressParamsFromJson(Map<String, dynamic> json) =>
    AddressParams();

Map<String, dynamic> _$AddressParamsToJson(AddressParams instance) =>
    <String, dynamic>{};

_CustomerParams _$CustomerParamsFromJson(Map<String, dynamic> json) =>
    _CustomerParams(
      address: json['address'] == null
          ? null
          : AddressParams.fromJson(json['address'] as Map<String, dynamic>),
      description: json['description'] as String?,
      email: json['email'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      phone: json['phone'] as String?,
      shipping: json['shipping'] == null
          ? null
          : ShippingParams.fromJson(json['shipping'] as Map<String, dynamic>),
      source: json['source'] as String?,
    );

Map<String, dynamic> _$CustomerParamsToJson(_CustomerParams instance) =>
    <String, dynamic>{
      'address': instance.address,
      'description': instance.description,
      'email': instance.email,
      'metadata': instance.metadata,
      'name': instance.name,
      'paymentMethod': instance.paymentMethod,
      'phone': instance.phone,
      'shipping': instance.shipping,
      'source': instance.source,
    };

_ShippingParams _$ShippingParamsFromJson(Map<String, dynamic> json) =>
    _ShippingParams(
      address: json['address'] == null
          ? null
          : AddressParams.fromJson(json['address'] as Map<String, dynamic>),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ShippingParamsToJson(_ShippingParams instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'phone': instance.phone,
    };

_AddressParams _$AddressParamsFromJson(Map<String, dynamic> json) =>
    _AddressParams(
      city: json['city'] as String?,
      country: json['country'] as String?,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$AddressParamsToJson(_AddressParams instance) =>
    <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'line1': instance.line1,
      'line2': instance.line2,
      'postalCode': instance.postalCode,
      'state': instance.state,
    };
