// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'stripe_account_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountParamsImpl _$$AccountParamsImplFromJson(Map<String, dynamic> json) =>
    _$AccountParamsImpl(
      type: $enumDecodeNullable(_$TypeEnumMap, json['type']),
      country: $enumDecodeNullable(_$CountryEnumMap, json['country']),
      capabilities:
          json['capabilities'] == null
              ? null
              : CapabilitiesParams.fromJson(
                json['capabilities'] as Map<String, dynamic>,
              ),
      email: json['email'] as String?,
      businessType: $enumDecodeNullable(
        _$BusinessTypeEnumMap,
        json['business_type'],
      ),
      businessProfile:
          json['business_profile'] == null
              ? null
              : BusinessProfileParams.fromJson(
                json['business_profile'] as Map<String, dynamic>,
              ),
      tosAcceptance:
          json['tos_acceptance'] == null
              ? null
              : TosAcceptanceParams.fromJson(
                json['tos_acceptance'] as Map<String, dynamic>,
              ),
      externalAccount: json['external_account'] as String?,
      individual:
          json['individual'] == null
              ? null
              : IndividualParams.fromJson(
                json['individual'] as Map<String, dynamic>,
              ),
      company:
          json['company'] == null
              ? null
              : CompanyParams.fromJson(json['company'] as Map<String, dynamic>),
      representative:
          json['representative'] == null
              ? null
              : RepresentativeParams.fromJson(
                json['representative'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$$AccountParamsImplToJson(_$AccountParamsImpl instance) =>
    <String, dynamic>{
      'type': _$TypeEnumMap[instance.type],
      'country': _$CountryEnumMap[instance.country],
      'capabilities': instance.capabilities?.toJson(),
      'email': instance.email,
      'business_type': _$BusinessTypeEnumMap[instance.businessType],
      'business_profile': instance.businessProfile?.toJson(),
      'tos_acceptance': instance.tosAcceptance?.toJson(),
      'external_account': instance.externalAccount,
      'individual': instance.individual?.toJson(),
      'company': instance.company?.toJson(),
      'representative': instance.representative?.toJson(),
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

_$CapabilitiesParamsImpl _$$CapabilitiesParamsImplFromJson(
  Map<String, dynamic> json,
) => _$CapabilitiesParamsImpl(
  bankTransferPayments: RequestedParams.fromJson(
    json['bank_transfer_payments'] as Map<String, dynamic>,
  ),
  cardPayments: RequestedParams.fromJson(
    json['card_payments'] as Map<String, dynamic>,
  ),
  jcbPayments: RequestedParams.fromJson(
    json['jcb_payments'] as Map<String, dynamic>,
  ),
  konbiniPayments: RequestedParams.fromJson(
    json['konbini_payments'] as Map<String, dynamic>,
  ),
  transfers: RequestedParams.fromJson(
    json['transfers'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$CapabilitiesParamsImplToJson(
  _$CapabilitiesParamsImpl instance,
) => <String, dynamic>{
  'bank_transfer_payments': instance.bankTransferPayments,
  'card_payments': instance.cardPayments,
  'jcb_payments': instance.jcbPayments,
  'konbini_payments': instance.konbiniPayments,
  'transfers': instance.transfers,
};

_$RequestedParamsImpl _$$RequestedParamsImplFromJson(
  Map<String, dynamic> json,
) => _$RequestedParamsImpl(required: json['required'] as bool?);

Map<String, dynamic> _$$RequestedParamsImplToJson(
  _$RequestedParamsImpl instance,
) => <String, dynamic>{'required': instance.required};

_$BusinessProfileParamsImpl _$$BusinessProfileParamsImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessProfileParamsImpl(
  mcc: json['mcc'] as String?,
  url: json['url'] as String?,
  productDescription: json['product_description'] as String?,
);

Map<String, dynamic> _$$BusinessProfileParamsImplToJson(
  _$BusinessProfileParamsImpl instance,
) => <String, dynamic>{
  'mcc': instance.mcc,
  'url': instance.url,
  'product_description': instance.productDescription,
};

_$TosAcceptanceParamsImpl _$$TosAcceptanceParamsImplFromJson(
  Map<String, dynamic> json,
) => _$TosAcceptanceParamsImpl(
  ip: json['ip'] as String?,
  data: json['data'] as String?,
);

Map<String, dynamic> _$$TosAcceptanceParamsImplToJson(
  _$TosAcceptanceParamsImpl instance,
) => <String, dynamic>{'ip': instance.ip, 'data': instance.data};

_$IndividualParamsImpl _$$IndividualParamsImplFromJson(
  Map<String, dynamic> json,
) => _$IndividualParamsImpl(
  firstNameKana: json['first_name_kana'] as String?,
  firstNameKanji: json['first_name_kanji'] as String?,
  lastNameKana: json['last_name_kana'] as String?,
  lastNameKanji: json['last_name_kanji'] as String?,
  dob:
      json['dob'] == null
          ? null
          : DobParams.fromJson(json['dob'] as Map<String, dynamic>),
  addressKana:
      json['address_kana'] == null
          ? null
          : AddressKanaParams.fromJson(
            json['address_kana'] as Map<String, dynamic>,
          ),
  addressKanji:
      json['address_kanji'] == null
          ? null
          : AddressKanjiParams.fromJson(
            json['address_kanji'] as Map<String, dynamic>,
          ),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$$IndividualParamsImplToJson(
  _$IndividualParamsImpl instance,
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

_$CompanyParamsImpl _$$CompanyParamsImplFromJson(Map<String, dynamic> json) =>
    _$CompanyParamsImpl(
      name: json['name'] as String?,
      nameKana: json['name_kana'] as String?,
      nameKanji: json['name_kanji'] as String?,
      addressKana:
          json['address_kana'] == null
              ? null
              : AddressKanaParams.fromJson(
                json['address_kana'] as Map<String, dynamic>,
              ),
      addressKanji:
          json['address_kanji'] == null
              ? null
              : AddressKanjiParams.fromJson(
                json['address_kanji'] as Map<String, dynamic>,
              ),
      phone: json['phone'] as String?,
      taxId: json['taxId'] as String?,
    );

Map<String, dynamic> _$$CompanyParamsImplToJson(_$CompanyParamsImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_kana': instance.nameKana,
      'name_kanji': instance.nameKanji,
      'address_kana': instance.addressKana,
      'address_kanji': instance.addressKanji,
      'phone': instance.phone,
      'taxId': instance.taxId,
    };

_$RepresentativeParamsImpl _$$RepresentativeParamsImplFromJson(
  Map<String, dynamic> json,
) => _$RepresentativeParamsImpl(
  firstNameKana: json['first_name_kana'] as String?,
  firstNameKanji: json['first_name_kanji'] as String?,
  lastNameKana: json['last_name_kana'] as String?,
  lastNameKanji: json['last_name_kanji'] as String?,
  dob:
      json['dob'] == null
          ? null
          : DobParams.fromJson(json['dob'] as Map<String, dynamic>),
  addressKana:
      json['address_kana'] == null
          ? null
          : AddressKanaParams.fromJson(
            json['address_kana'] as Map<String, dynamic>,
          ),
  addressKanji:
      json['address_kanji'] == null
          ? null
          : AddressKanjiParams.fromJson(
            json['address_kanji'] as Map<String, dynamic>,
          ),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
);

Map<String, dynamic> _$$RepresentativeParamsImplToJson(
  _$RepresentativeParamsImpl instance,
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

_$DobParamsImpl _$$DobParamsImplFromJson(Map<String, dynamic> json) =>
    _$DobParamsImpl(
      day: json['day'] as String?,
      month: json['month'] as String?,
      year: json['year'] as String?,
    );

Map<String, dynamic> _$$DobParamsImplToJson(_$DobParamsImpl instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
    };

_$AddressKanaParamsImpl _$$AddressKanaParamsImplFromJson(
  Map<String, dynamic> json,
) => _$AddressKanaParamsImpl(
  line1: json['line1'] as String?,
  postalCode: json['postal_code'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  town: json['town'] as String?,
);

Map<String, dynamic> _$$AddressKanaParamsImplToJson(
  _$AddressKanaParamsImpl instance,
) => <String, dynamic>{
  'line1': instance.line1,
  'postal_code': instance.postalCode,
  'city': instance.city,
  'state': instance.state,
  'town': instance.town,
};

_$AddressKanjiParamsImpl _$$AddressKanjiParamsImplFromJson(
  Map<String, dynamic> json,
) => _$AddressKanjiParamsImpl(
  line1: json['line1'] as String?,
  postalCode: json['postal_code'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  town: json['town'] as String?,
);

Map<String, dynamic> _$$AddressKanjiParamsImplToJson(
  _$AddressKanjiParamsImpl instance,
) => <String, dynamic>{
  'line1': instance.line1,
  'postal_code': instance.postalCode,
  'city': instance.city,
  'state': instance.state,
  'town': instance.town,
};
