import 'package:freezed_annotation/freezed_annotation.dart';

import 'stripe_enum.dart';

part 'stripe_account_params.freezed.dart';
part 'stripe_account_params.g.dart';

////////////////////////////////////////////////////////////////
// Account
@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AccountParams with _$AccountParams {
  const factory AccountParams({
    @JsonKey(unknownEnumValue: null) required Type? type,
    @JsonKey(unknownEnumValue: null) required Country? country,
    required CapabilitiesParams? capabilities,
    required String? email, //
    @JsonKey(unknownEnumValue: null) required BusinessType? businessType,
    required BusinessProfileParams? businessProfile,
    required TosAcceptanceParams? tosAcceptance,
    required String? externalAccount,
    required IndividualParams? individual, // // 個人
    required CompanyParams? company, // // 法人＆個人事業主
    required RepresentativeParams? representative, // // 法人＆個人事業主
  }) = _AccountParams;

  factory AccountParams.fromJson(Map<String, dynamic> json) =>
      _$AccountParamsFromJson(json);
}

// Account Capabilities
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class CapabilitiesParams with _$CapabilitiesParams {
  const factory CapabilitiesParams({
    @JsonKey(name: 'bank_transfer_payments')
    required RequestedParams bankTransferPayments,
    @JsonKey(name: 'card_payments') required RequestedParams cardPayments,
    @JsonKey(name: 'jcb_payments') required RequestedParams jcbPayments,
    @JsonKey(name: 'konbini_payments') required RequestedParams konbiniPayments,
    required RequestedParams transfers,
  }) = _CapabilitiesParams;

  factory CapabilitiesParams.fromJson(Map<String, dynamic> json) =>
      _$CapabilitiesParamsFromJson(json);
}

// Account Requested
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class RequestedParams with _$RequestedParams {
  const factory RequestedParams({required bool? required}) = _RequestedParams;

  factory RequestedParams.fromJson(Map<String, dynamic> json) =>
      _$RequestedParamsFromJson(json);
}

// Account BusinessProfile
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class BusinessProfileParams with _$BusinessProfileParams {
  const factory BusinessProfileParams({
    required String? mcc,
    required String? url,
    @JsonKey(name: 'product_description') required String? productDescription,
  }) = _BusinessProfileParams;

  factory BusinessProfileParams.fromJson(Map<String, dynamic> json) =>
      _$BusinessProfileParamsFromJson(json);
}

// Account TosAcceptance
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class TosAcceptanceParams with _$TosAcceptanceParams {
  const factory TosAcceptanceParams({
    required String? ip,
    required String? data,
  }) = _TosAcceptanceParams;

  factory TosAcceptanceParams.fromJson(Map<String, dynamic> json) =>
      _$TosAcceptanceParamsFromJson(json);
}

// Account Individual 個人のみ
@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class IndividualParams with _$IndividualParams {
  const factory IndividualParams({
    @JsonKey(name: 'first_name_kana') required String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') required String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') required String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') required String? lastNameKanji,
    required DobParams? dob,
    @JsonKey(name: 'address_kana') required AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') required AddressKanjiParams? addressKanji,
    required String? email,
    required String? phone,
  }) = _IndividualParams;

  factory IndividualParams.fromJson(Map<String, dynamic> json) =>
      _$IndividualParamsFromJson(json);
}

// Account Company
@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CompanyParams with _$CompanyParams {
  const factory CompanyParams({
    required String? name, // 法人の場合必須 //ローマ字または英語表記
    @JsonKey(name: 'name_kana') required String? nameKana, // 法人の場合必須
    @JsonKey(name: 'name_kanji') required String? nameKanji, // 法人の場合必須
    @JsonKey(name: 'address_kana') required AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') required AddressKanjiParams? addressKanji,
    required String? phone,
    required String? taxId, // 法人の場合必須
  }) = _CompanyParams;

  factory CompanyParams.fromJson(Map<String, dynamic> json) =>
      _$CompanyParamsFromJson(json);
}

// Account Representative
@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RepresentativeParams with _$RepresentativeParams {
  const factory RepresentativeParams({
    @JsonKey(name: 'first_name_kana') required String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') required String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') required String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') required String? lastNameKanji,
    required DobParams? dob,
    @JsonKey(name: 'address_kana') required AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') required AddressKanjiParams? addressKanji,
    required String? email,
    required String? phone,
  }) = _RepresentativeParams;

  factory RepresentativeParams.fromJson(Map<String, dynamic> json) =>
      _$RepresentativeParamsFromJson(json);
}

// Account Dob
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class DobParams with _$DobParams {
  const factory DobParams({
    required String? day,
    required String? month,
    required String? year,
  }) = _DobParams;

  factory DobParams.fromJson(Map<String, dynamic> json) =>
      _$DobParamsFromJson(json);
}

// Account AddressKana
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class AddressKanaParams with _$AddressKanaParams {
  const factory AddressKanaParams({
    required String? line1,
    @JsonKey(name: 'postal_code') required String? postalCode,
    required String? city,
    required String? state,
    required String? town,
  }) = _AddressKanaParams;

  factory AddressKanaParams.fromJson(Map<String, dynamic> json) =>
      _$AddressKanaParamsFromJson(json);
}

// Account AddressKanji
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class AddressKanjiParams with _$AddressKanjiParams {
  const factory AddressKanjiParams({
    required String? line1,
    @JsonKey(name: 'postal_code') required String? postalCode,
    required String? city,
    required String? state,
    required String? town,
  }) = _AddressKanjiParams;

  factory AddressKanjiParams.fromJson(Map<String, dynamic> json) =>
      _$AddressKanjiParamsFromJson(json);
}
