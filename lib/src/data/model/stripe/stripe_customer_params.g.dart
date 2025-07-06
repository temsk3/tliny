// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_customer_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerParams _$CustomerParamsFromJson(Map<String, dynamic> json) =>
    CustomerParams(
      address:
          json['address'] == null
              ? null
              : AddressParams.fromJson(json['address'] as Map<String, dynamic>),
      description: json['description'] as String?,
      email: json['email'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String?,
      paymentMethod: json['payment_method'] as String?,
      phone: json['phone'] as String?,
      shipping:
          json['shipping'] == null
              ? null
              : ShippingParams.fromJson(
                json['shipping'] as Map<String, dynamic>,
              ),
      source: json['source'] as String?,
    );

Map<String, dynamic> _$CustomerParamsToJson(CustomerParams instance) =>
    <String, dynamic>{
      'address': instance.address?.toJson(),
      'description': instance.description,
      'email': instance.email,
      'metadata': instance.metadata,
      'name': instance.name,
      'payment_method': instance.paymentMethod,
      'phone': instance.phone,
      'shipping': instance.shipping?.toJson(),
      'source': instance.source,
    };

ShippingParams _$ShippingParamsFromJson(Map<String, dynamic> json) =>
    ShippingParams(
      address:
          json['address'] == null
              ? null
              : AddressParams.fromJson(json['address'] as Map<String, dynamic>),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ShippingParamsToJson(ShippingParams instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'phone': instance.phone,
    };

AddressParams _$AddressParamsFromJson(Map<String, dynamic> json) =>
    AddressParams(
      city: json['city'] as String?,
      country: json['country'] as String?,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      postalCode: json['postal_code'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$AddressParamsToJson(AddressParams instance) =>
    <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'line1': instance.line1,
      'line2': instance.line2,
      'postal_code': instance.postalCode,
      'state': instance.state,
    };

_$CustomerParamsImpl _$$CustomerParamsImplFromJson(Map<String, dynamic> json) =>
    _$CustomerParamsImpl(
      address:
          json['address'] == null
              ? null
              : AddressParams.fromJson(json['address'] as Map<String, dynamic>),
      description: json['description'] as String?,
      email: json['email'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      name: json['name'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      phone: json['phone'] as String?,
      shipping:
          json['shipping'] == null
              ? null
              : ShippingParams.fromJson(
                json['shipping'] as Map<String, dynamic>,
              ),
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$CustomerParamsImplToJson(
  _$CustomerParamsImpl instance,
) => <String, dynamic>{
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

_$ShippingParamsImpl _$$ShippingParamsImplFromJson(Map<String, dynamic> json) =>
    _$ShippingParamsImpl(
      address:
          json['address'] == null
              ? null
              : AddressParams.fromJson(json['address'] as Map<String, dynamic>),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$$ShippingParamsImplToJson(
  _$ShippingParamsImpl instance,
) => <String, dynamic>{
  'address': instance.address,
  'name': instance.name,
  'phone': instance.phone,
};

_$AddressParamsImpl _$$AddressParamsImplFromJson(Map<String, dynamic> json) =>
    _$AddressParamsImpl(
      city: json['city'] as String?,
      country: json['country'] as String?,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      postalCode: json['postal_code'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$AddressParamsImplToJson(_$AddressParamsImpl instance) =>
    <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'line1': instance.line1,
      'line2': instance.line2,
      'postal_code': instance.postalCode,
      'state': instance.state,
    };
