import 'package:freezed_annotation/freezed_annotation.dart';

part 'stripe_customer_params.freezed.dart';
part 'stripe_customer_params.g.dart';

////////////////////////////////////////////////////////////////
// Customer
@freezed
class CustomerParams with _$CustomerParams {
  const factory CustomerParams({
    required AddressParams? address,
    required String? description,
    required String? email,
    required Map<String, dynamic>? metadata,
    required String? name,
    required String? paymentMethod,
    required String? phone,
    required ShippingParams? shipping,
    required String? source,
  }) = _CustomerParams;
  const CustomerParams._();
  factory CustomerParams.fromJson(Map<String, dynamic> json) =>
      _$CustomerParamsFromJson(json);
}

// Customer Shipping
@freezed
class ShippingParams with _$ShippingParams {
  const factory ShippingParams({
    required AddressParams? address,
    required String? name,
    required String? phone,
  }) = _ShippingParams;

  factory ShippingParams.fromJson(Map<String, dynamic> json) =>
      _$ShippingParamsFromJson(json);
}

// Customer Address
@freezed
class AddressParams with _$AddressParams {
  const factory AddressParams({
    required String? city,
    required String? country,
    required String? line1,
    required String? line2,
    @JsonKey(name: 'postal_code') required String? postalCode,
    required String? state,
  }) = _AddressParams;

  factory AddressParams.fromJson(Map<String, dynamic> json) =>
      _$AddressParamsFromJson(json);
}
