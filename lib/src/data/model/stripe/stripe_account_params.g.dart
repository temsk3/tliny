// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_account_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CapabilitiesParams _$CapabilitiesParamsFromJson(Map<String, dynamic> json) =>
    CapabilitiesParams();

Map<String, dynamic> _$CapabilitiesParamsToJson(CapabilitiesParams instance) =>
    <String, dynamic>{};

RequestedParams _$RequestedParamsFromJson(Map<String, dynamic> json) =>
    RequestedParams();

Map<String, dynamic> _$RequestedParamsToJson(RequestedParams instance) =>
    <String, dynamic>{};

BusinessProfileParams _$BusinessProfileParamsFromJson(
  Map<String, dynamic> json,
) => BusinessProfileParams();

Map<String, dynamic> _$BusinessProfileParamsToJson(
  BusinessProfileParams instance,
) => <String, dynamic>{};

TosAcceptanceParams _$TosAcceptanceParamsFromJson(Map<String, dynamic> json) =>
    TosAcceptanceParams();

Map<String, dynamic> _$TosAcceptanceParamsToJson(
  TosAcceptanceParams instance,
) => <String, dynamic>{};

IndividualParams _$IndividualParamsFromJson(Map<String, dynamic> json) =>
    IndividualParams();

Map<String, dynamic> _$IndividualParamsToJson(IndividualParams instance) =>
    <String, dynamic>{};

CompanyParams _$CompanyParamsFromJson(Map<String, dynamic> json) =>
    CompanyParams();

Map<String, dynamic> _$CompanyParamsToJson(CompanyParams instance) =>
    <String, dynamic>{};

RepresentativeParams _$RepresentativeParamsFromJson(
  Map<String, dynamic> json,
) => RepresentativeParams();

Map<String, dynamic> _$RepresentativeParamsToJson(
  RepresentativeParams instance,
) => <String, dynamic>{};

DobParams _$DobParamsFromJson(Map<String, dynamic> json) => DobParams();

Map<String, dynamic> _$DobParamsToJson(DobParams instance) =>
    <String, dynamic>{};

AddressKanaParams _$AddressKanaParamsFromJson(Map<String, dynamic> json) =>
    AddressKanaParams();

Map<String, dynamic> _$AddressKanaParamsToJson(AddressKanaParams instance) =>
    <String, dynamic>{};

AddressKanjiParams _$AddressKanjiParamsFromJson(Map<String, dynamic> json) =>
    AddressKanjiParams();

Map<String, dynamic> _$AddressKanjiParamsToJson(AddressKanjiParams instance) =>
    <String, dynamic>{};

_AccountParams _$AccountParamsFromJson(Map<String, dynamic> json) =>
    _AccountParams(
      type: $enumDecodeNullable(_$TypeEnumMap, json['type']),
      country: $enumDecodeNullable(_$CountryEnumMap, json['country']),
      capabilities: json['capabilities'] == null
          ? null
          : CapabilitiesParams.fromJson(
              json['capabilities'] as Map<String, dynamic>,
            ),
      email: json['email'] as String?,
      businessType: $enumDecodeNullable(
        _$BusinessTypeEnumMap,
        json['businessType'],
      ),
      businessProfile: json['businessProfile'] == null
          ? null
          : BusinessProfileParams.fromJson(
              json['businessProfile'] as Map<String, dynamic>,
            ),
      tosAcceptance: json['tosAcceptance'] == null
          ? null
          : TosAcceptanceParams.fromJson(
              json['tosAcceptance'] as Map<String, dynamic>,
            ),
      externalAccount: json['externalAccount'] as String?,
      individual: json['individual'] == null
          ? null
          : IndividualParams.fromJson(
              json['individual'] as Map<String, dynamic>,
            ),
      company: json['company'] == null
          ? null
          : CompanyParams.fromJson(json['company'] as Map<String, dynamic>),
      representative: json['representative'] == null
          ? null
          : RepresentativeParams.fromJson(
              json['representative'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AccountParamsToJson(_AccountParams instance) =>
    <String, dynamic>{
      'type': _$TypeEnumMap[instance.type],
      'country': _$CountryEnumMap[instance.country],
      'capabilities': instance.capabilities,
      'email': instance.email,
      'businessType': _$BusinessTypeEnumMap[instance.businessType],
      'businessProfile': instance.businessProfile,
      'tosAcceptance': instance.tosAcceptance,
      'externalAccount': instance.externalAccount,
      'individual': instance.individual,
      'company': instance.company,
      'representative': instance.representative,
    };

const _$TypeEnumMap = {
  Type.custom: 'custom',
  Type.express: 'express',
  Type.standard: 'standard',
};

const _$CountryEnumMap = {Country.jp: 'jp'};

const _$BusinessTypeEnumMap = {
  BusinessType.individual: 'individual',
  BusinessType.company: 'company',
};

_CapabilitiesParams _$CapabilitiesParamsFromJson(
  Map<String, dynamic> json,
) => _CapabilitiesParams(
  bankTransferPayments: json['bank_transfer_payments'] == null
      ? null
      : RequestedParams.fromJson(
          json['bank_transfer_payments'] as Map<String, dynamic>,
        ),
  cardPayments: json['card_payments'] == null
      ? null
      : RequestedParams.fromJson(json['card_payments'] as Map<String, dynamic>),
  jcbPayments: json['jcb_payments'] == null
      ? null
      : RequestedParams.fromJson(json['jcb_payments'] as Map<String, dynamic>),
  konbiniPayments: json['konbini_payments'] == null
      ? null
      : RequestedParams.fromJson(
          json['konbini_payments'] as Map<String, dynamic>,
        ),
  transfers: json['transfers'] == null
      ? null
      : RequestedParams.fromJson(json['transfers'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CapabilitiesParamsToJson(_CapabilitiesParams instance) =>
    <String, dynamic>{
      'bank_transfer_payments': instance.bankTransferPayments,
      'card_payments': instance.cardPayments,
      'jcb_payments': instance.jcbPayments,
      'konbini_payments': instance.konbiniPayments,
      'transfers': instance.transfers,
    };

_RequestedParams _$RequestedParamsFromJson(Map<String, dynamic> json) =>
    _RequestedParams(required: json['required'] as bool?);

Map<String, dynamic> _$RequestedParamsToJson(_RequestedParams instance) =>
    <String, dynamic>{'required': instance.required};

_BusinessProfileParams _$BusinessProfileParamsFromJson(
  Map<String, dynamic> json,
) => _BusinessProfileParams(
  mcc: json['mcc'] as String?,
  url: json['url'] as String?,
  productDescription: json['product_description'] as String?,
);

Map<String, dynamic> _$BusinessProfileParamsToJson(
  _BusinessProfileParams instance,
) => <String, dynamic>{
  'mcc': instance.mcc,
  'url': instance.url,
  'product_description': instance.productDescription,
};

_TosAcceptanceParams _$TosAcceptanceParamsFromJson(Map<String, dynamic> json) =>
    _TosAcceptanceParams(
      ip: json['ip'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$TosAcceptanceParamsToJson(
  _TosAcceptanceParams instance,
) => <String, dynamic>{'ip': instance.ip, 'data': instance.data};

_IndividualParams _$IndividualParamsFromJson(Map<String, dynamic> json) =>
    _IndividualParams(
      firstNameKana: json['first_name_kana'] as String?,
      firstNameKanji: json['first_name_kanji'] as String?,
      lastNameKana: json['last_name_kana'] as String?,
      lastNameKanji: json['last_name_kanji'] as String?,
      dob: json['dob'] == null
          ? null
          : DobParams.fromJson(json['dob'] as Map<String, dynamic>),
      addressKana: json['address_kana'] == null
          ? null
          : AddressKanaParams.fromJson(
              json['address_kana'] as Map<String, dynamic>,
            ),
      addressKanji: json['address_kanji'] == null
          ? null
          : AddressKanjiParams.fromJson(
              json['address_kanji'] as Map<String, dynamic>,
            ),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$IndividualParamsToJson(_IndividualParams instance) =>
    <String, dynamic>{
      'first_name_kana': instance.firstNameKana,
      'first_name_kanji': instance.firstNameKanji,
      'last_name_kana': instance.lastNameKana,
      'last_name_kanji': instance.lastNameKanji,
      'dob': instance.dob,
      'address_kana': instance.addressKana,
      'address_kanji': instance.addressKanji,
      'email': instance.email,
      'phone': instance.phone,
    };

_CompanyParams _$CompanyParamsFromJson(Map<String, dynamic> json) =>
    _CompanyParams(
      name: json['name'] as String?,
      nameKana: json['name_kana'] as String?,
      nameKanji: json['name_kanji'] as String?,
      addressKana: json['address_kana'] == null
          ? null
          : AddressKanaParams.fromJson(
              json['address_kana'] as Map<String, dynamic>,
            ),
      addressKanji: json['address_kanji'] == null
          ? null
          : AddressKanjiParams.fromJson(
              json['address_kanji'] as Map<String, dynamic>,
            ),
      phone: json['phone'] as String?,
      taxId: json['taxId'] as String?,
    );

Map<String, dynamic> _$CompanyParamsToJson(_CompanyParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_kana': instance.nameKana,
      'name_kanji': instance.nameKanji,
      'address_kana': instance.addressKana,
      'address_kanji': instance.addressKanji,
      'phone': instance.phone,
      'taxId': instance.taxId,
    };

_RepresentativeParams _$RepresentativeParamsFromJson(
  Map<String, dynamic> json,
) => _RepresentativeParams(
  firstNameKana: json['first_name_kana'] as String?,
  firstNameKanji: json['first_name_kanji'] as String?,
  lastNameKana: json['last_name_kana'] as String?,
  lastNameKanji: json['last_name_kanji'] as String?,
  dob: json['dob'] == null
      ? null
      : DobParams.fromJson(json['dob'] as Map<String, dynamic>),
  addressKana: json['address_kana'] == null
      ? null
      : AddressKanaParams.fromJson(
          json['address_kana'] as Map<String, dynamic>,
        ),
  addressKanji: json['address_kanji'] == null
      ? null
      : AddressKanjiParams.fromJson(
          json['address_kanji'] as Map<String, dynamic>,
        ),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$RepresentativeParamsToJson(
  _RepresentativeParams instance,
) => <String, dynamic>{
  'first_name_kana': instance.firstNameKana,
  'first_name_kanji': instance.firstNameKanji,
  'last_name_kana': instance.lastNameKana,
  'last_name_kanji': instance.lastNameKanji,
  'dob': instance.dob,
  'address_kana': instance.addressKana,
  'address_kanji': instance.addressKanji,
  'email': instance.email,
  'phone': instance.phone,
};

_DobParams _$DobParamsFromJson(Map<String, dynamic> json) => _DobParams(
  day: json['day'] as String?,
  month: json['month'] as String?,
  year: json['year'] as String?,
);

Map<String, dynamic> _$DobParamsToJson(_DobParams instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
    };

_AddressKanaParams _$AddressKanaParamsFromJson(Map<String, dynamic> json) =>
    _AddressKanaParams(
      line1: json['line1'] as String?,
      postalCode: json['postal_code'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      town: json['town'] as String?,
    );

Map<String, dynamic> _$AddressKanaParamsToJson(_AddressKanaParams instance) =>
    <String, dynamic>{
      'line1': instance.line1,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'state': instance.state,
      'town': instance.town,
    };

_AddressKanjiParams _$AddressKanjiParamsFromJson(Map<String, dynamic> json) =>
    _AddressKanjiParams(
      line1: json['line1'] as String?,
      postalCode: json['postal_code'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      town: json['town'] as String?,
    );

Map<String, dynamic> _$AddressKanjiParamsToJson(_AddressKanjiParams instance) =>
    <String, dynamic>{
      'line1': instance.line1,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'state': instance.state,
      'town': instance.town,
    };
