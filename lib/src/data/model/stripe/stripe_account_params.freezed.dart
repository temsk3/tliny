// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_account_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AccountParams _$AccountParamsFromJson(Map<String, dynamic> json) {
  return _AccountParams.fromJson(json);
}

/// @nodoc
mixin _$AccountParams {
  @JsonKey(unknownEnumValue: null)
  Type? get type => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: null)
  Country? get country => throw _privateConstructorUsedError;
  CapabilitiesParams? get capabilities => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError; //
  @JsonKey(unknownEnumValue: null)
  BusinessType? get businessType => throw _privateConstructorUsedError;
  BusinessProfileParams? get businessProfile =>
      throw _privateConstructorUsedError;
  TosAcceptanceParams? get tosAcceptance => throw _privateConstructorUsedError;
  String? get externalAccount => throw _privateConstructorUsedError;
  IndividualParams? get individual =>
      throw _privateConstructorUsedError; // // 個人
  CompanyParams? get company =>
      throw _privateConstructorUsedError; // // 法人＆個人事業主
  RepresentativeParams? get representative =>
      throw _privateConstructorUsedError;

  /// Serializes this AccountParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountParamsCopyWith<AccountParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountParamsCopyWith<$Res> {
  factory $AccountParamsCopyWith(
    AccountParams value,
    $Res Function(AccountParams) then,
  ) = _$AccountParamsCopyWithImpl<$Res, AccountParams>;
  @useResult
  $Res call({
    @JsonKey(unknownEnumValue: null) Type? type,
    @JsonKey(unknownEnumValue: null) Country? country,
    CapabilitiesParams? capabilities,
    String? email,
    @JsonKey(unknownEnumValue: null) BusinessType? businessType,
    BusinessProfileParams? businessProfile,
    TosAcceptanceParams? tosAcceptance,
    String? externalAccount,
    IndividualParams? individual,
    CompanyParams? company,
    RepresentativeParams? representative,
  });

  $CapabilitiesParamsCopyWith<$Res>? get capabilities;
  $BusinessProfileParamsCopyWith<$Res>? get businessProfile;
  $TosAcceptanceParamsCopyWith<$Res>? get tosAcceptance;
  $IndividualParamsCopyWith<$Res>? get individual;
  $CompanyParamsCopyWith<$Res>? get company;
  $RepresentativeParamsCopyWith<$Res>? get representative;
}

/// @nodoc
class _$AccountParamsCopyWithImpl<$Res, $Val extends AccountParams>
    implements $AccountParamsCopyWith<$Res> {
  _$AccountParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? country = freezed,
    Object? capabilities = freezed,
    Object? email = freezed,
    Object? businessType = freezed,
    Object? businessProfile = freezed,
    Object? tosAcceptance = freezed,
    Object? externalAccount = freezed,
    Object? individual = freezed,
    Object? company = freezed,
    Object? representative = freezed,
  }) {
    return _then(
      _value.copyWith(
            type:
                freezed == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as Type?,
            country:
                freezed == country
                    ? _value.country
                    : country // ignore: cast_nullable_to_non_nullable
                        as Country?,
            capabilities:
                freezed == capabilities
                    ? _value.capabilities
                    : capabilities // ignore: cast_nullable_to_non_nullable
                        as CapabilitiesParams?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            businessType:
                freezed == businessType
                    ? _value.businessType
                    : businessType // ignore: cast_nullable_to_non_nullable
                        as BusinessType?,
            businessProfile:
                freezed == businessProfile
                    ? _value.businessProfile
                    : businessProfile // ignore: cast_nullable_to_non_nullable
                        as BusinessProfileParams?,
            tosAcceptance:
                freezed == tosAcceptance
                    ? _value.tosAcceptance
                    : tosAcceptance // ignore: cast_nullable_to_non_nullable
                        as TosAcceptanceParams?,
            externalAccount:
                freezed == externalAccount
                    ? _value.externalAccount
                    : externalAccount // ignore: cast_nullable_to_non_nullable
                        as String?,
            individual:
                freezed == individual
                    ? _value.individual
                    : individual // ignore: cast_nullable_to_non_nullable
                        as IndividualParams?,
            company:
                freezed == company
                    ? _value.company
                    : company // ignore: cast_nullable_to_non_nullable
                        as CompanyParams?,
            representative:
                freezed == representative
                    ? _value.representative
                    : representative // ignore: cast_nullable_to_non_nullable
                        as RepresentativeParams?,
          )
          as $Val,
    );
  }

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CapabilitiesParamsCopyWith<$Res>? get capabilities {
    if (_value.capabilities == null) {
      return null;
    }

    return $CapabilitiesParamsCopyWith<$Res>(_value.capabilities!, (value) {
      return _then(_value.copyWith(capabilities: value) as $Val);
    });
  }

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusinessProfileParamsCopyWith<$Res>? get businessProfile {
    if (_value.businessProfile == null) {
      return null;
    }

    return $BusinessProfileParamsCopyWith<$Res>(_value.businessProfile!, (
      value,
    ) {
      return _then(_value.copyWith(businessProfile: value) as $Val);
    });
  }

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TosAcceptanceParamsCopyWith<$Res>? get tosAcceptance {
    if (_value.tosAcceptance == null) {
      return null;
    }

    return $TosAcceptanceParamsCopyWith<$Res>(_value.tosAcceptance!, (value) {
      return _then(_value.copyWith(tosAcceptance: value) as $Val);
    });
  }

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IndividualParamsCopyWith<$Res>? get individual {
    if (_value.individual == null) {
      return null;
    }

    return $IndividualParamsCopyWith<$Res>(_value.individual!, (value) {
      return _then(_value.copyWith(individual: value) as $Val);
    });
  }

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CompanyParamsCopyWith<$Res>? get company {
    if (_value.company == null) {
      return null;
    }

    return $CompanyParamsCopyWith<$Res>(_value.company!, (value) {
      return _then(_value.copyWith(company: value) as $Val);
    });
  }

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RepresentativeParamsCopyWith<$Res>? get representative {
    if (_value.representative == null) {
      return null;
    }

    return $RepresentativeParamsCopyWith<$Res>(_value.representative!, (value) {
      return _then(_value.copyWith(representative: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountParamsImplCopyWith<$Res>
    implements $AccountParamsCopyWith<$Res> {
  factory _$$AccountParamsImplCopyWith(
    _$AccountParamsImpl value,
    $Res Function(_$AccountParamsImpl) then,
  ) = __$$AccountParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(unknownEnumValue: null) Type? type,
    @JsonKey(unknownEnumValue: null) Country? country,
    CapabilitiesParams? capabilities,
    String? email,
    @JsonKey(unknownEnumValue: null) BusinessType? businessType,
    BusinessProfileParams? businessProfile,
    TosAcceptanceParams? tosAcceptance,
    String? externalAccount,
    IndividualParams? individual,
    CompanyParams? company,
    RepresentativeParams? representative,
  });

  @override
  $CapabilitiesParamsCopyWith<$Res>? get capabilities;
  @override
  $BusinessProfileParamsCopyWith<$Res>? get businessProfile;
  @override
  $TosAcceptanceParamsCopyWith<$Res>? get tosAcceptance;
  @override
  $IndividualParamsCopyWith<$Res>? get individual;
  @override
  $CompanyParamsCopyWith<$Res>? get company;
  @override
  $RepresentativeParamsCopyWith<$Res>? get representative;
}

/// @nodoc
class __$$AccountParamsImplCopyWithImpl<$Res>
    extends _$AccountParamsCopyWithImpl<$Res, _$AccountParamsImpl>
    implements _$$AccountParamsImplCopyWith<$Res> {
  __$$AccountParamsImplCopyWithImpl(
    _$AccountParamsImpl _value,
    $Res Function(_$AccountParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? country = freezed,
    Object? capabilities = freezed,
    Object? email = freezed,
    Object? businessType = freezed,
    Object? businessProfile = freezed,
    Object? tosAcceptance = freezed,
    Object? externalAccount = freezed,
    Object? individual = freezed,
    Object? company = freezed,
    Object? representative = freezed,
  }) {
    return _then(
      _$AccountParamsImpl(
        type:
            freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as Type?,
        country:
            freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                    as Country?,
        capabilities:
            freezed == capabilities
                ? _value.capabilities
                : capabilities // ignore: cast_nullable_to_non_nullable
                    as CapabilitiesParams?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        businessType:
            freezed == businessType
                ? _value.businessType
                : businessType // ignore: cast_nullable_to_non_nullable
                    as BusinessType?,
        businessProfile:
            freezed == businessProfile
                ? _value.businessProfile
                : businessProfile // ignore: cast_nullable_to_non_nullable
                    as BusinessProfileParams?,
        tosAcceptance:
            freezed == tosAcceptance
                ? _value.tosAcceptance
                : tosAcceptance // ignore: cast_nullable_to_non_nullable
                    as TosAcceptanceParams?,
        externalAccount:
            freezed == externalAccount
                ? _value.externalAccount
                : externalAccount // ignore: cast_nullable_to_non_nullable
                    as String?,
        individual:
            freezed == individual
                ? _value.individual
                : individual // ignore: cast_nullable_to_non_nullable
                    as IndividualParams?,
        company:
            freezed == company
                ? _value.company
                : company // ignore: cast_nullable_to_non_nullable
                    as CompanyParams?,
        representative:
            freezed == representative
                ? _value.representative
                : representative // ignore: cast_nullable_to_non_nullable
                    as RepresentativeParams?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$AccountParamsImpl implements _AccountParams {
  const _$AccountParamsImpl({
    @JsonKey(unknownEnumValue: null) required this.type,
    @JsonKey(unknownEnumValue: null) required this.country,
    required this.capabilities,
    required this.email,
    @JsonKey(unknownEnumValue: null) required this.businessType,
    required this.businessProfile,
    required this.tosAcceptance,
    required this.externalAccount,
    required this.individual,
    required this.company,
    required this.representative,
  });

  factory _$AccountParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountParamsImplFromJson(json);

  @override
  @JsonKey(unknownEnumValue: null)
  final Type? type;
  @override
  @JsonKey(unknownEnumValue: null)
  final Country? country;
  @override
  final CapabilitiesParams? capabilities;
  @override
  final String? email;
  //
  @override
  @JsonKey(unknownEnumValue: null)
  final BusinessType? businessType;
  @override
  final BusinessProfileParams? businessProfile;
  @override
  final TosAcceptanceParams? tosAcceptance;
  @override
  final String? externalAccount;
  @override
  final IndividualParams? individual;
  // // 個人
  @override
  final CompanyParams? company;
  // // 法人＆個人事業主
  @override
  final RepresentativeParams? representative;

  @override
  String toString() {
    return 'AccountParams(type: $type, country: $country, capabilities: $capabilities, email: $email, businessType: $businessType, businessProfile: $businessProfile, tosAcceptance: $tosAcceptance, externalAccount: $externalAccount, individual: $individual, company: $company, representative: $representative)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountParamsImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.capabilities, capabilities) ||
                other.capabilities == capabilities) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.businessType, businessType) ||
                other.businessType == businessType) &&
            (identical(other.businessProfile, businessProfile) ||
                other.businessProfile == businessProfile) &&
            (identical(other.tosAcceptance, tosAcceptance) ||
                other.tosAcceptance == tosAcceptance) &&
            (identical(other.externalAccount, externalAccount) ||
                other.externalAccount == externalAccount) &&
            (identical(other.individual, individual) ||
                other.individual == individual) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.representative, representative) ||
                other.representative == representative));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    country,
    capabilities,
    email,
    businessType,
    businessProfile,
    tosAcceptance,
    externalAccount,
    individual,
    company,
    representative,
  );

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountParamsImplCopyWith<_$AccountParamsImpl> get copyWith =>
      __$$AccountParamsImplCopyWithImpl<_$AccountParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountParamsImplToJson(this);
  }
}

abstract class _AccountParams implements AccountParams {
  const factory _AccountParams({
    @JsonKey(unknownEnumValue: null) required final Type? type,
    @JsonKey(unknownEnumValue: null) required final Country? country,
    required final CapabilitiesParams? capabilities,
    required final String? email,
    @JsonKey(unknownEnumValue: null) required final BusinessType? businessType,
    required final BusinessProfileParams? businessProfile,
    required final TosAcceptanceParams? tosAcceptance,
    required final String? externalAccount,
    required final IndividualParams? individual,
    required final CompanyParams? company,
    required final RepresentativeParams? representative,
  }) = _$AccountParamsImpl;

  factory _AccountParams.fromJson(Map<String, dynamic> json) =
      _$AccountParamsImpl.fromJson;

  @override
  @JsonKey(unknownEnumValue: null)
  Type? get type;
  @override
  @JsonKey(unknownEnumValue: null)
  Country? get country;
  @override
  CapabilitiesParams? get capabilities;
  @override
  String? get email; //
  @override
  @JsonKey(unknownEnumValue: null)
  BusinessType? get businessType;
  @override
  BusinessProfileParams? get businessProfile;
  @override
  TosAcceptanceParams? get tosAcceptance;
  @override
  String? get externalAccount;
  @override
  IndividualParams? get individual; // // 個人
  @override
  CompanyParams? get company; // // 法人＆個人事業主
  @override
  RepresentativeParams? get representative;

  /// Create a copy of AccountParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountParamsImplCopyWith<_$AccountParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CapabilitiesParams _$CapabilitiesParamsFromJson(Map<String, dynamic> json) {
  return _CapabilitiesParams.fromJson(json);
}

/// @nodoc
mixin _$CapabilitiesParams {
  @JsonKey(name: 'bank_transfer_payments')
  RequestedParams get bankTransferPayments =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'card_payments')
  RequestedParams get cardPayments => throw _privateConstructorUsedError;
  @JsonKey(name: 'jcb_payments')
  RequestedParams get jcbPayments => throw _privateConstructorUsedError;
  @JsonKey(name: 'konbini_payments')
  RequestedParams get konbiniPayments => throw _privateConstructorUsedError;
  RequestedParams get transfers => throw _privateConstructorUsedError;

  /// Serializes this CapabilitiesParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CapabilitiesParamsCopyWith<CapabilitiesParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapabilitiesParamsCopyWith<$Res> {
  factory $CapabilitiesParamsCopyWith(
    CapabilitiesParams value,
    $Res Function(CapabilitiesParams) then,
  ) = _$CapabilitiesParamsCopyWithImpl<$Res, CapabilitiesParams>;
  @useResult
  $Res call({
    @JsonKey(name: 'bank_transfer_payments')
    RequestedParams bankTransferPayments,
    @JsonKey(name: 'card_payments') RequestedParams cardPayments,
    @JsonKey(name: 'jcb_payments') RequestedParams jcbPayments,
    @JsonKey(name: 'konbini_payments') RequestedParams konbiniPayments,
    RequestedParams transfers,
  });

  $RequestedParamsCopyWith<$Res> get bankTransferPayments;
  $RequestedParamsCopyWith<$Res> get cardPayments;
  $RequestedParamsCopyWith<$Res> get jcbPayments;
  $RequestedParamsCopyWith<$Res> get konbiniPayments;
  $RequestedParamsCopyWith<$Res> get transfers;
}

/// @nodoc
class _$CapabilitiesParamsCopyWithImpl<$Res, $Val extends CapabilitiesParams>
    implements $CapabilitiesParamsCopyWith<$Res> {
  _$CapabilitiesParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankTransferPayments = null,
    Object? cardPayments = null,
    Object? jcbPayments = null,
    Object? konbiniPayments = null,
    Object? transfers = null,
  }) {
    return _then(
      _value.copyWith(
            bankTransferPayments:
                null == bankTransferPayments
                    ? _value.bankTransferPayments
                    : bankTransferPayments // ignore: cast_nullable_to_non_nullable
                        as RequestedParams,
            cardPayments:
                null == cardPayments
                    ? _value.cardPayments
                    : cardPayments // ignore: cast_nullable_to_non_nullable
                        as RequestedParams,
            jcbPayments:
                null == jcbPayments
                    ? _value.jcbPayments
                    : jcbPayments // ignore: cast_nullable_to_non_nullable
                        as RequestedParams,
            konbiniPayments:
                null == konbiniPayments
                    ? _value.konbiniPayments
                    : konbiniPayments // ignore: cast_nullable_to_non_nullable
                        as RequestedParams,
            transfers:
                null == transfers
                    ? _value.transfers
                    : transfers // ignore: cast_nullable_to_non_nullable
                        as RequestedParams,
          )
          as $Val,
    );
  }

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestedParamsCopyWith<$Res> get bankTransferPayments {
    return $RequestedParamsCopyWith<$Res>(_value.bankTransferPayments, (value) {
      return _then(_value.copyWith(bankTransferPayments: value) as $Val);
    });
  }

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestedParamsCopyWith<$Res> get cardPayments {
    return $RequestedParamsCopyWith<$Res>(_value.cardPayments, (value) {
      return _then(_value.copyWith(cardPayments: value) as $Val);
    });
  }

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestedParamsCopyWith<$Res> get jcbPayments {
    return $RequestedParamsCopyWith<$Res>(_value.jcbPayments, (value) {
      return _then(_value.copyWith(jcbPayments: value) as $Val);
    });
  }

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestedParamsCopyWith<$Res> get konbiniPayments {
    return $RequestedParamsCopyWith<$Res>(_value.konbiniPayments, (value) {
      return _then(_value.copyWith(konbiniPayments: value) as $Val);
    });
  }

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RequestedParamsCopyWith<$Res> get transfers {
    return $RequestedParamsCopyWith<$Res>(_value.transfers, (value) {
      return _then(_value.copyWith(transfers: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CapabilitiesParamsImplCopyWith<$Res>
    implements $CapabilitiesParamsCopyWith<$Res> {
  factory _$$CapabilitiesParamsImplCopyWith(
    _$CapabilitiesParamsImpl value,
    $Res Function(_$CapabilitiesParamsImpl) then,
  ) = __$$CapabilitiesParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'bank_transfer_payments')
    RequestedParams bankTransferPayments,
    @JsonKey(name: 'card_payments') RequestedParams cardPayments,
    @JsonKey(name: 'jcb_payments') RequestedParams jcbPayments,
    @JsonKey(name: 'konbini_payments') RequestedParams konbiniPayments,
    RequestedParams transfers,
  });

  @override
  $RequestedParamsCopyWith<$Res> get bankTransferPayments;
  @override
  $RequestedParamsCopyWith<$Res> get cardPayments;
  @override
  $RequestedParamsCopyWith<$Res> get jcbPayments;
  @override
  $RequestedParamsCopyWith<$Res> get konbiniPayments;
  @override
  $RequestedParamsCopyWith<$Res> get transfers;
}

/// @nodoc
class __$$CapabilitiesParamsImplCopyWithImpl<$Res>
    extends _$CapabilitiesParamsCopyWithImpl<$Res, _$CapabilitiesParamsImpl>
    implements _$$CapabilitiesParamsImplCopyWith<$Res> {
  __$$CapabilitiesParamsImplCopyWithImpl(
    _$CapabilitiesParamsImpl _value,
    $Res Function(_$CapabilitiesParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankTransferPayments = null,
    Object? cardPayments = null,
    Object? jcbPayments = null,
    Object? konbiniPayments = null,
    Object? transfers = null,
  }) {
    return _then(
      _$CapabilitiesParamsImpl(
        bankTransferPayments:
            null == bankTransferPayments
                ? _value.bankTransferPayments
                : bankTransferPayments // ignore: cast_nullable_to_non_nullable
                    as RequestedParams,
        cardPayments:
            null == cardPayments
                ? _value.cardPayments
                : cardPayments // ignore: cast_nullable_to_non_nullable
                    as RequestedParams,
        jcbPayments:
            null == jcbPayments
                ? _value.jcbPayments
                : jcbPayments // ignore: cast_nullable_to_non_nullable
                    as RequestedParams,
        konbiniPayments:
            null == konbiniPayments
                ? _value.konbiniPayments
                : konbiniPayments // ignore: cast_nullable_to_non_nullable
                    as RequestedParams,
        transfers:
            null == transfers
                ? _value.transfers
                : transfers // ignore: cast_nullable_to_non_nullable
                    as RequestedParams,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CapabilitiesParamsImpl implements _CapabilitiesParams {
  const _$CapabilitiesParamsImpl({
    @JsonKey(name: 'bank_transfer_payments') required this.bankTransferPayments,
    @JsonKey(name: 'card_payments') required this.cardPayments,
    @JsonKey(name: 'jcb_payments') required this.jcbPayments,
    @JsonKey(name: 'konbini_payments') required this.konbiniPayments,
    required this.transfers,
  });

  factory _$CapabilitiesParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapabilitiesParamsImplFromJson(json);

  @override
  @JsonKey(name: 'bank_transfer_payments')
  final RequestedParams bankTransferPayments;
  @override
  @JsonKey(name: 'card_payments')
  final RequestedParams cardPayments;
  @override
  @JsonKey(name: 'jcb_payments')
  final RequestedParams jcbPayments;
  @override
  @JsonKey(name: 'konbini_payments')
  final RequestedParams konbiniPayments;
  @override
  final RequestedParams transfers;

  @override
  String toString() {
    return 'CapabilitiesParams(bankTransferPayments: $bankTransferPayments, cardPayments: $cardPayments, jcbPayments: $jcbPayments, konbiniPayments: $konbiniPayments, transfers: $transfers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapabilitiesParamsImpl &&
            (identical(other.bankTransferPayments, bankTransferPayments) ||
                other.bankTransferPayments == bankTransferPayments) &&
            (identical(other.cardPayments, cardPayments) ||
                other.cardPayments == cardPayments) &&
            (identical(other.jcbPayments, jcbPayments) ||
                other.jcbPayments == jcbPayments) &&
            (identical(other.konbiniPayments, konbiniPayments) ||
                other.konbiniPayments == konbiniPayments) &&
            (identical(other.transfers, transfers) ||
                other.transfers == transfers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bankTransferPayments,
    cardPayments,
    jcbPayments,
    konbiniPayments,
    transfers,
  );

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CapabilitiesParamsImplCopyWith<_$CapabilitiesParamsImpl> get copyWith =>
      __$$CapabilitiesParamsImplCopyWithImpl<_$CapabilitiesParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CapabilitiesParamsImplToJson(this);
  }
}

abstract class _CapabilitiesParams implements CapabilitiesParams {
  const factory _CapabilitiesParams({
    @JsonKey(name: 'bank_transfer_payments')
    required final RequestedParams bankTransferPayments,
    @JsonKey(name: 'card_payments') required final RequestedParams cardPayments,
    @JsonKey(name: 'jcb_payments') required final RequestedParams jcbPayments,
    @JsonKey(name: 'konbini_payments')
    required final RequestedParams konbiniPayments,
    required final RequestedParams transfers,
  }) = _$CapabilitiesParamsImpl;

  factory _CapabilitiesParams.fromJson(Map<String, dynamic> json) =
      _$CapabilitiesParamsImpl.fromJson;

  @override
  @JsonKey(name: 'bank_transfer_payments')
  RequestedParams get bankTransferPayments;
  @override
  @JsonKey(name: 'card_payments')
  RequestedParams get cardPayments;
  @override
  @JsonKey(name: 'jcb_payments')
  RequestedParams get jcbPayments;
  @override
  @JsonKey(name: 'konbini_payments')
  RequestedParams get konbiniPayments;
  @override
  RequestedParams get transfers;

  /// Create a copy of CapabilitiesParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CapabilitiesParamsImplCopyWith<_$CapabilitiesParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RequestedParams _$RequestedParamsFromJson(Map<String, dynamic> json) {
  return _RequestedParams.fromJson(json);
}

/// @nodoc
mixin _$RequestedParams {
  bool? get required => throw _privateConstructorUsedError;

  /// Serializes this RequestedParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestedParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestedParamsCopyWith<RequestedParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestedParamsCopyWith<$Res> {
  factory $RequestedParamsCopyWith(
    RequestedParams value,
    $Res Function(RequestedParams) then,
  ) = _$RequestedParamsCopyWithImpl<$Res, RequestedParams>;
  @useResult
  $Res call({bool? required});
}

/// @nodoc
class _$RequestedParamsCopyWithImpl<$Res, $Val extends RequestedParams>
    implements $RequestedParamsCopyWith<$Res> {
  _$RequestedParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestedParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? required = freezed}) {
    return _then(
      _value.copyWith(
            required:
                freezed == required
                    ? _value.required
                    : required // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequestedParamsImplCopyWith<$Res>
    implements $RequestedParamsCopyWith<$Res> {
  factory _$$RequestedParamsImplCopyWith(
    _$RequestedParamsImpl value,
    $Res Function(_$RequestedParamsImpl) then,
  ) = __$$RequestedParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? required});
}

/// @nodoc
class __$$RequestedParamsImplCopyWithImpl<$Res>
    extends _$RequestedParamsCopyWithImpl<$Res, _$RequestedParamsImpl>
    implements _$$RequestedParamsImplCopyWith<$Res> {
  __$$RequestedParamsImplCopyWithImpl(
    _$RequestedParamsImpl _value,
    $Res Function(_$RequestedParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestedParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? required = freezed}) {
    return _then(
      _$RequestedParamsImpl(
        required:
            freezed == required
                ? _value.required
                : required // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestedParamsImpl implements _RequestedParams {
  const _$RequestedParamsImpl({required this.required});

  factory _$RequestedParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestedParamsImplFromJson(json);

  @override
  final bool? required;

  @override
  String toString() {
    return 'RequestedParams(required: $required)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestedParamsImpl &&
            (identical(other.required, required) ||
                other.required == required));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, required);

  /// Create a copy of RequestedParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestedParamsImplCopyWith<_$RequestedParamsImpl> get copyWith =>
      __$$RequestedParamsImplCopyWithImpl<_$RequestedParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestedParamsImplToJson(this);
  }
}

abstract class _RequestedParams implements RequestedParams {
  const factory _RequestedParams({required final bool? required}) =
      _$RequestedParamsImpl;

  factory _RequestedParams.fromJson(Map<String, dynamic> json) =
      _$RequestedParamsImpl.fromJson;

  @override
  bool? get required;

  /// Create a copy of RequestedParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestedParamsImplCopyWith<_$RequestedParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusinessProfileParams _$BusinessProfileParamsFromJson(
  Map<String, dynamic> json,
) {
  return _BusinessProfileParams.fromJson(json);
}

/// @nodoc
mixin _$BusinessProfileParams {
  String? get mcc => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_description')
  String? get productDescription => throw _privateConstructorUsedError;

  /// Serializes this BusinessProfileParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessProfileParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessProfileParamsCopyWith<BusinessProfileParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessProfileParamsCopyWith<$Res> {
  factory $BusinessProfileParamsCopyWith(
    BusinessProfileParams value,
    $Res Function(BusinessProfileParams) then,
  ) = _$BusinessProfileParamsCopyWithImpl<$Res, BusinessProfileParams>;
  @useResult
  $Res call({
    String? mcc,
    String? url,
    @JsonKey(name: 'product_description') String? productDescription,
  });
}

/// @nodoc
class _$BusinessProfileParamsCopyWithImpl<
  $Res,
  $Val extends BusinessProfileParams
>
    implements $BusinessProfileParamsCopyWith<$Res> {
  _$BusinessProfileParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessProfileParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mcc = freezed,
    Object? url = freezed,
    Object? productDescription = freezed,
  }) {
    return _then(
      _value.copyWith(
            mcc:
                freezed == mcc
                    ? _value.mcc
                    : mcc // ignore: cast_nullable_to_non_nullable
                        as String?,
            url:
                freezed == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String?,
            productDescription:
                freezed == productDescription
                    ? _value.productDescription
                    : productDescription // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessProfileParamsImplCopyWith<$Res>
    implements $BusinessProfileParamsCopyWith<$Res> {
  factory _$$BusinessProfileParamsImplCopyWith(
    _$BusinessProfileParamsImpl value,
    $Res Function(_$BusinessProfileParamsImpl) then,
  ) = __$$BusinessProfileParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? mcc,
    String? url,
    @JsonKey(name: 'product_description') String? productDescription,
  });
}

/// @nodoc
class __$$BusinessProfileParamsImplCopyWithImpl<$Res>
    extends
        _$BusinessProfileParamsCopyWithImpl<$Res, _$BusinessProfileParamsImpl>
    implements _$$BusinessProfileParamsImplCopyWith<$Res> {
  __$$BusinessProfileParamsImplCopyWithImpl(
    _$BusinessProfileParamsImpl _value,
    $Res Function(_$BusinessProfileParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessProfileParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mcc = freezed,
    Object? url = freezed,
    Object? productDescription = freezed,
  }) {
    return _then(
      _$BusinessProfileParamsImpl(
        mcc:
            freezed == mcc
                ? _value.mcc
                : mcc // ignore: cast_nullable_to_non_nullable
                    as String?,
        url:
            freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String?,
        productDescription:
            freezed == productDescription
                ? _value.productDescription
                : productDescription // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessProfileParamsImpl implements _BusinessProfileParams {
  const _$BusinessProfileParamsImpl({
    required this.mcc,
    required this.url,
    @JsonKey(name: 'product_description') required this.productDescription,
  });

  factory _$BusinessProfileParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessProfileParamsImplFromJson(json);

  @override
  final String? mcc;
  @override
  final String? url;
  @override
  @JsonKey(name: 'product_description')
  final String? productDescription;

  @override
  String toString() {
    return 'BusinessProfileParams(mcc: $mcc, url: $url, productDescription: $productDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessProfileParamsImpl &&
            (identical(other.mcc, mcc) || other.mcc == mcc) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.productDescription, productDescription) ||
                other.productDescription == productDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mcc, url, productDescription);

  /// Create a copy of BusinessProfileParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessProfileParamsImplCopyWith<_$BusinessProfileParamsImpl>
  get copyWith =>
      __$$BusinessProfileParamsImplCopyWithImpl<_$BusinessProfileParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessProfileParamsImplToJson(this);
  }
}

abstract class _BusinessProfileParams implements BusinessProfileParams {
  const factory _BusinessProfileParams({
    required final String? mcc,
    required final String? url,
    @JsonKey(name: 'product_description')
    required final String? productDescription,
  }) = _$BusinessProfileParamsImpl;

  factory _BusinessProfileParams.fromJson(Map<String, dynamic> json) =
      _$BusinessProfileParamsImpl.fromJson;

  @override
  String? get mcc;
  @override
  String? get url;
  @override
  @JsonKey(name: 'product_description')
  String? get productDescription;

  /// Create a copy of BusinessProfileParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessProfileParamsImplCopyWith<_$BusinessProfileParamsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TosAcceptanceParams _$TosAcceptanceParamsFromJson(Map<String, dynamic> json) {
  return _TosAcceptanceParams.fromJson(json);
}

/// @nodoc
mixin _$TosAcceptanceParams {
  String? get ip => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  /// Serializes this TosAcceptanceParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TosAcceptanceParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TosAcceptanceParamsCopyWith<TosAcceptanceParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TosAcceptanceParamsCopyWith<$Res> {
  factory $TosAcceptanceParamsCopyWith(
    TosAcceptanceParams value,
    $Res Function(TosAcceptanceParams) then,
  ) = _$TosAcceptanceParamsCopyWithImpl<$Res, TosAcceptanceParams>;
  @useResult
  $Res call({String? ip, String? data});
}

/// @nodoc
class _$TosAcceptanceParamsCopyWithImpl<$Res, $Val extends TosAcceptanceParams>
    implements $TosAcceptanceParamsCopyWith<$Res> {
  _$TosAcceptanceParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TosAcceptanceParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ip = freezed, Object? data = freezed}) {
    return _then(
      _value.copyWith(
            ip:
                freezed == ip
                    ? _value.ip
                    : ip // ignore: cast_nullable_to_non_nullable
                        as String?,
            data:
                freezed == data
                    ? _value.data
                    : data // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TosAcceptanceParamsImplCopyWith<$Res>
    implements $TosAcceptanceParamsCopyWith<$Res> {
  factory _$$TosAcceptanceParamsImplCopyWith(
    _$TosAcceptanceParamsImpl value,
    $Res Function(_$TosAcceptanceParamsImpl) then,
  ) = __$$TosAcceptanceParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? ip, String? data});
}

/// @nodoc
class __$$TosAcceptanceParamsImplCopyWithImpl<$Res>
    extends _$TosAcceptanceParamsCopyWithImpl<$Res, _$TosAcceptanceParamsImpl>
    implements _$$TosAcceptanceParamsImplCopyWith<$Res> {
  __$$TosAcceptanceParamsImplCopyWithImpl(
    _$TosAcceptanceParamsImpl _value,
    $Res Function(_$TosAcceptanceParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TosAcceptanceParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ip = freezed, Object? data = freezed}) {
    return _then(
      _$TosAcceptanceParamsImpl(
        ip:
            freezed == ip
                ? _value.ip
                : ip // ignore: cast_nullable_to_non_nullable
                    as String?,
        data:
            freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TosAcceptanceParamsImpl implements _TosAcceptanceParams {
  const _$TosAcceptanceParamsImpl({required this.ip, required this.data});

  factory _$TosAcceptanceParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TosAcceptanceParamsImplFromJson(json);

  @override
  final String? ip;
  @override
  final String? data;

  @override
  String toString() {
    return 'TosAcceptanceParams(ip: $ip, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TosAcceptanceParamsImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ip, data);

  /// Create a copy of TosAcceptanceParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TosAcceptanceParamsImplCopyWith<_$TosAcceptanceParamsImpl> get copyWith =>
      __$$TosAcceptanceParamsImplCopyWithImpl<_$TosAcceptanceParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TosAcceptanceParamsImplToJson(this);
  }
}

abstract class _TosAcceptanceParams implements TosAcceptanceParams {
  const factory _TosAcceptanceParams({
    required final String? ip,
    required final String? data,
  }) = _$TosAcceptanceParamsImpl;

  factory _TosAcceptanceParams.fromJson(Map<String, dynamic> json) =
      _$TosAcceptanceParamsImpl.fromJson;

  @override
  String? get ip;
  @override
  String? get data;

  /// Create a copy of TosAcceptanceParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TosAcceptanceParamsImplCopyWith<_$TosAcceptanceParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IndividualParams _$IndividualParamsFromJson(Map<String, dynamic> json) {
  return _IndividualParams.fromJson(json);
}

/// @nodoc
mixin _$IndividualParams {
  @JsonKey(name: 'first_name_kana')
  String? get firstNameKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name_kanji')
  String? get firstNameKanji => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name_kana')
  String? get lastNameKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name_kanji')
  String? get lastNameKanji => throw _privateConstructorUsedError;
  DobParams? get dob => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_kana')
  AddressKanaParams? get addressKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_kanji')
  AddressKanjiParams? get addressKanji => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this IndividualParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IndividualParamsCopyWith<IndividualParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndividualParamsCopyWith<$Res> {
  factory $IndividualParamsCopyWith(
    IndividualParams value,
    $Res Function(IndividualParams) then,
  ) = _$IndividualParamsCopyWithImpl<$Res, IndividualParams>;
  @useResult
  $Res call({
    @JsonKey(name: 'first_name_kana') String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') String? lastNameKanji,
    DobParams? dob,
    @JsonKey(name: 'address_kana') AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji,
    String? email,
    String? phone,
  });

  $DobParamsCopyWith<$Res>? get dob;
  $AddressKanaParamsCopyWith<$Res>? get addressKana;
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji;
}

/// @nodoc
class _$IndividualParamsCopyWithImpl<$Res, $Val extends IndividualParams>
    implements $IndividualParamsCopyWith<$Res> {
  _$IndividualParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstNameKana = freezed,
    Object? firstNameKanji = freezed,
    Object? lastNameKana = freezed,
    Object? lastNameKanji = freezed,
    Object? dob = freezed,
    Object? addressKana = freezed,
    Object? addressKanji = freezed,
    Object? email = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstNameKana:
                freezed == firstNameKana
                    ? _value.firstNameKana
                    : firstNameKana // ignore: cast_nullable_to_non_nullable
                        as String?,
            firstNameKanji:
                freezed == firstNameKanji
                    ? _value.firstNameKanji
                    : firstNameKanji // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastNameKana:
                freezed == lastNameKana
                    ? _value.lastNameKana
                    : lastNameKana // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastNameKanji:
                freezed == lastNameKanji
                    ? _value.lastNameKanji
                    : lastNameKanji // ignore: cast_nullable_to_non_nullable
                        as String?,
            dob:
                freezed == dob
                    ? _value.dob
                    : dob // ignore: cast_nullable_to_non_nullable
                        as DobParams?,
            addressKana:
                freezed == addressKana
                    ? _value.addressKana
                    : addressKana // ignore: cast_nullable_to_non_nullable
                        as AddressKanaParams?,
            addressKanji:
                freezed == addressKanji
                    ? _value.addressKanji
                    : addressKanji // ignore: cast_nullable_to_non_nullable
                        as AddressKanjiParams?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DobParamsCopyWith<$Res>? get dob {
    if (_value.dob == null) {
      return null;
    }

    return $DobParamsCopyWith<$Res>(_value.dob!, (value) {
      return _then(_value.copyWith(dob: value) as $Val);
    });
  }

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_value.addressKana == null) {
      return null;
    }

    return $AddressKanaParamsCopyWith<$Res>(_value.addressKana!, (value) {
      return _then(_value.copyWith(addressKana: value) as $Val);
    });
  }

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_value.addressKanji == null) {
      return null;
    }

    return $AddressKanjiParamsCopyWith<$Res>(_value.addressKanji!, (value) {
      return _then(_value.copyWith(addressKanji: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IndividualParamsImplCopyWith<$Res>
    implements $IndividualParamsCopyWith<$Res> {
  factory _$$IndividualParamsImplCopyWith(
    _$IndividualParamsImpl value,
    $Res Function(_$IndividualParamsImpl) then,
  ) = __$$IndividualParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'first_name_kana') String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') String? lastNameKanji,
    DobParams? dob,
    @JsonKey(name: 'address_kana') AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji,
    String? email,
    String? phone,
  });

  @override
  $DobParamsCopyWith<$Res>? get dob;
  @override
  $AddressKanaParamsCopyWith<$Res>? get addressKana;
  @override
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji;
}

/// @nodoc
class __$$IndividualParamsImplCopyWithImpl<$Res>
    extends _$IndividualParamsCopyWithImpl<$Res, _$IndividualParamsImpl>
    implements _$$IndividualParamsImplCopyWith<$Res> {
  __$$IndividualParamsImplCopyWithImpl(
    _$IndividualParamsImpl _value,
    $Res Function(_$IndividualParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstNameKana = freezed,
    Object? firstNameKanji = freezed,
    Object? lastNameKana = freezed,
    Object? lastNameKanji = freezed,
    Object? dob = freezed,
    Object? addressKana = freezed,
    Object? addressKanji = freezed,
    Object? email = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _$IndividualParamsImpl(
        firstNameKana:
            freezed == firstNameKana
                ? _value.firstNameKana
                : firstNameKana // ignore: cast_nullable_to_non_nullable
                    as String?,
        firstNameKanji:
            freezed == firstNameKanji
                ? _value.firstNameKanji
                : firstNameKanji // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastNameKana:
            freezed == lastNameKana
                ? _value.lastNameKana
                : lastNameKana // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastNameKanji:
            freezed == lastNameKanji
                ? _value.lastNameKanji
                : lastNameKanji // ignore: cast_nullable_to_non_nullable
                    as String?,
        dob:
            freezed == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                    as DobParams?,
        addressKana:
            freezed == addressKana
                ? _value.addressKana
                : addressKana // ignore: cast_nullable_to_non_nullable
                    as AddressKanaParams?,
        addressKanji:
            freezed == addressKanji
                ? _value.addressKanji
                : addressKanji // ignore: cast_nullable_to_non_nullable
                    as AddressKanjiParams?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IndividualParamsImpl implements _IndividualParams {
  const _$IndividualParamsImpl({
    @JsonKey(name: 'first_name_kana') required this.firstNameKana,
    @JsonKey(name: 'first_name_kanji') required this.firstNameKanji,
    @JsonKey(name: 'last_name_kana') required this.lastNameKana,
    @JsonKey(name: 'last_name_kanji') required this.lastNameKanji,
    required this.dob,
    @JsonKey(name: 'address_kana') required this.addressKana,
    @JsonKey(name: 'address_kanji') required this.addressKanji,
    required this.email,
    required this.phone,
  });

  factory _$IndividualParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$IndividualParamsImplFromJson(json);

  @override
  @JsonKey(name: 'first_name_kana')
  final String? firstNameKana;
  @override
  @JsonKey(name: 'first_name_kanji')
  final String? firstNameKanji;
  @override
  @JsonKey(name: 'last_name_kana')
  final String? lastNameKana;
  @override
  @JsonKey(name: 'last_name_kanji')
  final String? lastNameKanji;
  @override
  final DobParams? dob;
  @override
  @JsonKey(name: 'address_kana')
  final AddressKanaParams? addressKana;
  @override
  @JsonKey(name: 'address_kanji')
  final AddressKanjiParams? addressKanji;
  @override
  final String? email;
  @override
  final String? phone;

  @override
  String toString() {
    return 'IndividualParams(firstNameKana: $firstNameKana, firstNameKanji: $firstNameKanji, lastNameKana: $lastNameKana, lastNameKanji: $lastNameKanji, dob: $dob, addressKana: $addressKana, addressKanji: $addressKanji, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndividualParamsImpl &&
            (identical(other.firstNameKana, firstNameKana) ||
                other.firstNameKana == firstNameKana) &&
            (identical(other.firstNameKanji, firstNameKanji) ||
                other.firstNameKanji == firstNameKanji) &&
            (identical(other.lastNameKana, lastNameKana) ||
                other.lastNameKana == lastNameKana) &&
            (identical(other.lastNameKanji, lastNameKanji) ||
                other.lastNameKanji == lastNameKanji) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.addressKana, addressKana) ||
                other.addressKana == addressKana) &&
            (identical(other.addressKanji, addressKanji) ||
                other.addressKanji == addressKanji) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstNameKana,
    firstNameKanji,
    lastNameKana,
    lastNameKanji,
    dob,
    addressKana,
    addressKanji,
    email,
    phone,
  );

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IndividualParamsImplCopyWith<_$IndividualParamsImpl> get copyWith =>
      __$$IndividualParamsImplCopyWithImpl<_$IndividualParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IndividualParamsImplToJson(this);
  }
}

abstract class _IndividualParams implements IndividualParams {
  const factory _IndividualParams({
    @JsonKey(name: 'first_name_kana') required final String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') required final String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') required final String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') required final String? lastNameKanji,
    required final DobParams? dob,
    @JsonKey(name: 'address_kana')
    required final AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji')
    required final AddressKanjiParams? addressKanji,
    required final String? email,
    required final String? phone,
  }) = _$IndividualParamsImpl;

  factory _IndividualParams.fromJson(Map<String, dynamic> json) =
      _$IndividualParamsImpl.fromJson;

  @override
  @JsonKey(name: 'first_name_kana')
  String? get firstNameKana;
  @override
  @JsonKey(name: 'first_name_kanji')
  String? get firstNameKanji;
  @override
  @JsonKey(name: 'last_name_kana')
  String? get lastNameKana;
  @override
  @JsonKey(name: 'last_name_kanji')
  String? get lastNameKanji;
  @override
  DobParams? get dob;
  @override
  @JsonKey(name: 'address_kana')
  AddressKanaParams? get addressKana;
  @override
  @JsonKey(name: 'address_kanji')
  AddressKanjiParams? get addressKanji;
  @override
  String? get email;
  @override
  String? get phone;

  /// Create a copy of IndividualParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IndividualParamsImplCopyWith<_$IndividualParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompanyParams _$CompanyParamsFromJson(Map<String, dynamic> json) {
  return _CompanyParams.fromJson(json);
}

/// @nodoc
mixin _$CompanyParams {
  String? get name =>
      throw _privateConstructorUsedError; // 法人の場合必須 //ローマ字または英語表記
  @JsonKey(name: 'name_kana')
  String? get nameKana => throw _privateConstructorUsedError; // 法人の場合必須
  @JsonKey(name: 'name_kanji')
  String? get nameKanji => throw _privateConstructorUsedError; // 法人の場合必須
  @JsonKey(name: 'address_kana')
  AddressKanaParams? get addressKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_kanji')
  AddressKanjiParams? get addressKanji => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get taxId => throw _privateConstructorUsedError;

  /// Serializes this CompanyParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CompanyParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CompanyParamsCopyWith<CompanyParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyParamsCopyWith<$Res> {
  factory $CompanyParamsCopyWith(
    CompanyParams value,
    $Res Function(CompanyParams) then,
  ) = _$CompanyParamsCopyWithImpl<$Res, CompanyParams>;
  @useResult
  $Res call({
    String? name,
    @JsonKey(name: 'name_kana') String? nameKana,
    @JsonKey(name: 'name_kanji') String? nameKanji,
    @JsonKey(name: 'address_kana') AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji,
    String? phone,
    String? taxId,
  });

  $AddressKanaParamsCopyWith<$Res>? get addressKana;
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji;
}

/// @nodoc
class _$CompanyParamsCopyWithImpl<$Res, $Val extends CompanyParams>
    implements $CompanyParamsCopyWith<$Res> {
  _$CompanyParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CompanyParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? nameKana = freezed,
    Object? nameKanji = freezed,
    Object? addressKana = freezed,
    Object? addressKanji = freezed,
    Object? phone = freezed,
    Object? taxId = freezed,
  }) {
    return _then(
      _value.copyWith(
            name:
                freezed == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String?,
            nameKana:
                freezed == nameKana
                    ? _value.nameKana
                    : nameKana // ignore: cast_nullable_to_non_nullable
                        as String?,
            nameKanji:
                freezed == nameKanji
                    ? _value.nameKanji
                    : nameKanji // ignore: cast_nullable_to_non_nullable
                        as String?,
            addressKana:
                freezed == addressKana
                    ? _value.addressKana
                    : addressKana // ignore: cast_nullable_to_non_nullable
                        as AddressKanaParams?,
            addressKanji:
                freezed == addressKanji
                    ? _value.addressKanji
                    : addressKanji // ignore: cast_nullable_to_non_nullable
                        as AddressKanjiParams?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
            taxId:
                freezed == taxId
                    ? _value.taxId
                    : taxId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CompanyParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_value.addressKana == null) {
      return null;
    }

    return $AddressKanaParamsCopyWith<$Res>(_value.addressKana!, (value) {
      return _then(_value.copyWith(addressKana: value) as $Val);
    });
  }

  /// Create a copy of CompanyParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_value.addressKanji == null) {
      return null;
    }

    return $AddressKanjiParamsCopyWith<$Res>(_value.addressKanji!, (value) {
      return _then(_value.copyWith(addressKanji: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompanyParamsImplCopyWith<$Res>
    implements $CompanyParamsCopyWith<$Res> {
  factory _$$CompanyParamsImplCopyWith(
    _$CompanyParamsImpl value,
    $Res Function(_$CompanyParamsImpl) then,
  ) = __$$CompanyParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    @JsonKey(name: 'name_kana') String? nameKana,
    @JsonKey(name: 'name_kanji') String? nameKanji,
    @JsonKey(name: 'address_kana') AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji,
    String? phone,
    String? taxId,
  });

  @override
  $AddressKanaParamsCopyWith<$Res>? get addressKana;
  @override
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji;
}

/// @nodoc
class __$$CompanyParamsImplCopyWithImpl<$Res>
    extends _$CompanyParamsCopyWithImpl<$Res, _$CompanyParamsImpl>
    implements _$$CompanyParamsImplCopyWith<$Res> {
  __$$CompanyParamsImplCopyWithImpl(
    _$CompanyParamsImpl _value,
    $Res Function(_$CompanyParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CompanyParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? nameKana = freezed,
    Object? nameKanji = freezed,
    Object? addressKana = freezed,
    Object? addressKanji = freezed,
    Object? phone = freezed,
    Object? taxId = freezed,
  }) {
    return _then(
      _$CompanyParamsImpl(
        name:
            freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String?,
        nameKana:
            freezed == nameKana
                ? _value.nameKana
                : nameKana // ignore: cast_nullable_to_non_nullable
                    as String?,
        nameKanji:
            freezed == nameKanji
                ? _value.nameKanji
                : nameKanji // ignore: cast_nullable_to_non_nullable
                    as String?,
        addressKana:
            freezed == addressKana
                ? _value.addressKana
                : addressKana // ignore: cast_nullable_to_non_nullable
                    as AddressKanaParams?,
        addressKanji:
            freezed == addressKanji
                ? _value.addressKanji
                : addressKanji // ignore: cast_nullable_to_non_nullable
                    as AddressKanjiParams?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        taxId:
            freezed == taxId
                ? _value.taxId
                : taxId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyParamsImpl implements _CompanyParams {
  const _$CompanyParamsImpl({
    required this.name,
    @JsonKey(name: 'name_kana') required this.nameKana,
    @JsonKey(name: 'name_kanji') required this.nameKanji,
    @JsonKey(name: 'address_kana') required this.addressKana,
    @JsonKey(name: 'address_kanji') required this.addressKanji,
    required this.phone,
    required this.taxId,
  });

  factory _$CompanyParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyParamsImplFromJson(json);

  @override
  final String? name;
  // 法人の場合必須 //ローマ字または英語表記
  @override
  @JsonKey(name: 'name_kana')
  final String? nameKana;
  // 法人の場合必須
  @override
  @JsonKey(name: 'name_kanji')
  final String? nameKanji;
  // 法人の場合必須
  @override
  @JsonKey(name: 'address_kana')
  final AddressKanaParams? addressKana;
  @override
  @JsonKey(name: 'address_kanji')
  final AddressKanjiParams? addressKanji;
  @override
  final String? phone;
  @override
  final String? taxId;

  @override
  String toString() {
    return 'CompanyParams(name: $name, nameKana: $nameKana, nameKanji: $nameKanji, addressKana: $addressKana, addressKanji: $addressKanji, phone: $phone, taxId: $taxId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyParamsImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameKana, nameKana) ||
                other.nameKana == nameKana) &&
            (identical(other.nameKanji, nameKanji) ||
                other.nameKanji == nameKanji) &&
            (identical(other.addressKana, addressKana) ||
                other.addressKana == addressKana) &&
            (identical(other.addressKanji, addressKanji) ||
                other.addressKanji == addressKanji) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.taxId, taxId) || other.taxId == taxId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    nameKana,
    nameKanji,
    addressKana,
    addressKanji,
    phone,
    taxId,
  );

  /// Create a copy of CompanyParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyParamsImplCopyWith<_$CompanyParamsImpl> get copyWith =>
      __$$CompanyParamsImplCopyWithImpl<_$CompanyParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyParamsImplToJson(this);
  }
}

abstract class _CompanyParams implements CompanyParams {
  const factory _CompanyParams({
    required final String? name,
    @JsonKey(name: 'name_kana') required final String? nameKana,
    @JsonKey(name: 'name_kanji') required final String? nameKanji,
    @JsonKey(name: 'address_kana')
    required final AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji')
    required final AddressKanjiParams? addressKanji,
    required final String? phone,
    required final String? taxId,
  }) = _$CompanyParamsImpl;

  factory _CompanyParams.fromJson(Map<String, dynamic> json) =
      _$CompanyParamsImpl.fromJson;

  @override
  String? get name; // 法人の場合必須 //ローマ字または英語表記
  @override
  @JsonKey(name: 'name_kana')
  String? get nameKana; // 法人の場合必須
  @override
  @JsonKey(name: 'name_kanji')
  String? get nameKanji; // 法人の場合必須
  @override
  @JsonKey(name: 'address_kana')
  AddressKanaParams? get addressKana;
  @override
  @JsonKey(name: 'address_kanji')
  AddressKanjiParams? get addressKanji;
  @override
  String? get phone;
  @override
  String? get taxId;

  /// Create a copy of CompanyParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompanyParamsImplCopyWith<_$CompanyParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RepresentativeParams _$RepresentativeParamsFromJson(Map<String, dynamic> json) {
  return _RepresentativeParams.fromJson(json);
}

/// @nodoc
mixin _$RepresentativeParams {
  @JsonKey(name: 'first_name_kana')
  String? get firstNameKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name_kanji')
  String? get firstNameKanji => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name_kana')
  String? get lastNameKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name_kanji')
  String? get lastNameKanji => throw _privateConstructorUsedError;
  DobParams? get dob => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_kana')
  AddressKanaParams? get addressKana => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_kanji')
  AddressKanjiParams? get addressKanji => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;

  /// Serializes this RepresentativeParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepresentativeParamsCopyWith<RepresentativeParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepresentativeParamsCopyWith<$Res> {
  factory $RepresentativeParamsCopyWith(
    RepresentativeParams value,
    $Res Function(RepresentativeParams) then,
  ) = _$RepresentativeParamsCopyWithImpl<$Res, RepresentativeParams>;
  @useResult
  $Res call({
    @JsonKey(name: 'first_name_kana') String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') String? lastNameKanji,
    DobParams? dob,
    @JsonKey(name: 'address_kana') AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji,
    String? email,
    String? phone,
  });

  $DobParamsCopyWith<$Res>? get dob;
  $AddressKanaParamsCopyWith<$Res>? get addressKana;
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji;
}

/// @nodoc
class _$RepresentativeParamsCopyWithImpl<
  $Res,
  $Val extends RepresentativeParams
>
    implements $RepresentativeParamsCopyWith<$Res> {
  _$RepresentativeParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstNameKana = freezed,
    Object? firstNameKanji = freezed,
    Object? lastNameKana = freezed,
    Object? lastNameKanji = freezed,
    Object? dob = freezed,
    Object? addressKana = freezed,
    Object? addressKanji = freezed,
    Object? email = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _value.copyWith(
            firstNameKana:
                freezed == firstNameKana
                    ? _value.firstNameKana
                    : firstNameKana // ignore: cast_nullable_to_non_nullable
                        as String?,
            firstNameKanji:
                freezed == firstNameKanji
                    ? _value.firstNameKanji
                    : firstNameKanji // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastNameKana:
                freezed == lastNameKana
                    ? _value.lastNameKana
                    : lastNameKana // ignore: cast_nullable_to_non_nullable
                        as String?,
            lastNameKanji:
                freezed == lastNameKanji
                    ? _value.lastNameKanji
                    : lastNameKanji // ignore: cast_nullable_to_non_nullable
                        as String?,
            dob:
                freezed == dob
                    ? _value.dob
                    : dob // ignore: cast_nullable_to_non_nullable
                        as DobParams?,
            addressKana:
                freezed == addressKana
                    ? _value.addressKana
                    : addressKana // ignore: cast_nullable_to_non_nullable
                        as AddressKanaParams?,
            addressKanji:
                freezed == addressKanji
                    ? _value.addressKanji
                    : addressKanji // ignore: cast_nullable_to_non_nullable
                        as AddressKanjiParams?,
            email:
                freezed == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String?,
            phone:
                freezed == phone
                    ? _value.phone
                    : phone // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DobParamsCopyWith<$Res>? get dob {
    if (_value.dob == null) {
      return null;
    }

    return $DobParamsCopyWith<$Res>(_value.dob!, (value) {
      return _then(_value.copyWith(dob: value) as $Val);
    });
  }

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_value.addressKana == null) {
      return null;
    }

    return $AddressKanaParamsCopyWith<$Res>(_value.addressKana!, (value) {
      return _then(_value.copyWith(addressKana: value) as $Val);
    });
  }

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_value.addressKanji == null) {
      return null;
    }

    return $AddressKanjiParamsCopyWith<$Res>(_value.addressKanji!, (value) {
      return _then(_value.copyWith(addressKanji: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RepresentativeParamsImplCopyWith<$Res>
    implements $RepresentativeParamsCopyWith<$Res> {
  factory _$$RepresentativeParamsImplCopyWith(
    _$RepresentativeParamsImpl value,
    $Res Function(_$RepresentativeParamsImpl) then,
  ) = __$$RepresentativeParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'first_name_kana') String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') String? lastNameKanji,
    DobParams? dob,
    @JsonKey(name: 'address_kana') AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji,
    String? email,
    String? phone,
  });

  @override
  $DobParamsCopyWith<$Res>? get dob;
  @override
  $AddressKanaParamsCopyWith<$Res>? get addressKana;
  @override
  $AddressKanjiParamsCopyWith<$Res>? get addressKanji;
}

/// @nodoc
class __$$RepresentativeParamsImplCopyWithImpl<$Res>
    extends _$RepresentativeParamsCopyWithImpl<$Res, _$RepresentativeParamsImpl>
    implements _$$RepresentativeParamsImplCopyWith<$Res> {
  __$$RepresentativeParamsImplCopyWithImpl(
    _$RepresentativeParamsImpl _value,
    $Res Function(_$RepresentativeParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstNameKana = freezed,
    Object? firstNameKanji = freezed,
    Object? lastNameKana = freezed,
    Object? lastNameKanji = freezed,
    Object? dob = freezed,
    Object? addressKana = freezed,
    Object? addressKanji = freezed,
    Object? email = freezed,
    Object? phone = freezed,
  }) {
    return _then(
      _$RepresentativeParamsImpl(
        firstNameKana:
            freezed == firstNameKana
                ? _value.firstNameKana
                : firstNameKana // ignore: cast_nullable_to_non_nullable
                    as String?,
        firstNameKanji:
            freezed == firstNameKanji
                ? _value.firstNameKanji
                : firstNameKanji // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastNameKana:
            freezed == lastNameKana
                ? _value.lastNameKana
                : lastNameKana // ignore: cast_nullable_to_non_nullable
                    as String?,
        lastNameKanji:
            freezed == lastNameKanji
                ? _value.lastNameKanji
                : lastNameKanji // ignore: cast_nullable_to_non_nullable
                    as String?,
        dob:
            freezed == dob
                ? _value.dob
                : dob // ignore: cast_nullable_to_non_nullable
                    as DobParams?,
        addressKana:
            freezed == addressKana
                ? _value.addressKana
                : addressKana // ignore: cast_nullable_to_non_nullable
                    as AddressKanaParams?,
        addressKanji:
            freezed == addressKanji
                ? _value.addressKanji
                : addressKanji // ignore: cast_nullable_to_non_nullable
                    as AddressKanjiParams?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RepresentativeParamsImpl implements _RepresentativeParams {
  const _$RepresentativeParamsImpl({
    @JsonKey(name: 'first_name_kana') required this.firstNameKana,
    @JsonKey(name: 'first_name_kanji') required this.firstNameKanji,
    @JsonKey(name: 'last_name_kana') required this.lastNameKana,
    @JsonKey(name: 'last_name_kanji') required this.lastNameKanji,
    required this.dob,
    @JsonKey(name: 'address_kana') required this.addressKana,
    @JsonKey(name: 'address_kanji') required this.addressKanji,
    required this.email,
    required this.phone,
  });

  factory _$RepresentativeParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepresentativeParamsImplFromJson(json);

  @override
  @JsonKey(name: 'first_name_kana')
  final String? firstNameKana;
  @override
  @JsonKey(name: 'first_name_kanji')
  final String? firstNameKanji;
  @override
  @JsonKey(name: 'last_name_kana')
  final String? lastNameKana;
  @override
  @JsonKey(name: 'last_name_kanji')
  final String? lastNameKanji;
  @override
  final DobParams? dob;
  @override
  @JsonKey(name: 'address_kana')
  final AddressKanaParams? addressKana;
  @override
  @JsonKey(name: 'address_kanji')
  final AddressKanjiParams? addressKanji;
  @override
  final String? email;
  @override
  final String? phone;

  @override
  String toString() {
    return 'RepresentativeParams(firstNameKana: $firstNameKana, firstNameKanji: $firstNameKanji, lastNameKana: $lastNameKana, lastNameKanji: $lastNameKanji, dob: $dob, addressKana: $addressKana, addressKanji: $addressKanji, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepresentativeParamsImpl &&
            (identical(other.firstNameKana, firstNameKana) ||
                other.firstNameKana == firstNameKana) &&
            (identical(other.firstNameKanji, firstNameKanji) ||
                other.firstNameKanji == firstNameKanji) &&
            (identical(other.lastNameKana, lastNameKana) ||
                other.lastNameKana == lastNameKana) &&
            (identical(other.lastNameKanji, lastNameKanji) ||
                other.lastNameKanji == lastNameKanji) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.addressKana, addressKana) ||
                other.addressKana == addressKana) &&
            (identical(other.addressKanji, addressKanji) ||
                other.addressKanji == addressKanji) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    firstNameKana,
    firstNameKanji,
    lastNameKana,
    lastNameKanji,
    dob,
    addressKana,
    addressKanji,
    email,
    phone,
  );

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepresentativeParamsImplCopyWith<_$RepresentativeParamsImpl>
  get copyWith =>
      __$$RepresentativeParamsImplCopyWithImpl<_$RepresentativeParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RepresentativeParamsImplToJson(this);
  }
}

abstract class _RepresentativeParams implements RepresentativeParams {
  const factory _RepresentativeParams({
    @JsonKey(name: 'first_name_kana') required final String? firstNameKana,
    @JsonKey(name: 'first_name_kanji') required final String? firstNameKanji,
    @JsonKey(name: 'last_name_kana') required final String? lastNameKana,
    @JsonKey(name: 'last_name_kanji') required final String? lastNameKanji,
    required final DobParams? dob,
    @JsonKey(name: 'address_kana')
    required final AddressKanaParams? addressKana,
    @JsonKey(name: 'address_kanji')
    required final AddressKanjiParams? addressKanji,
    required final String? email,
    required final String? phone,
  }) = _$RepresentativeParamsImpl;

  factory _RepresentativeParams.fromJson(Map<String, dynamic> json) =
      _$RepresentativeParamsImpl.fromJson;

  @override
  @JsonKey(name: 'first_name_kana')
  String? get firstNameKana;
  @override
  @JsonKey(name: 'first_name_kanji')
  String? get firstNameKanji;
  @override
  @JsonKey(name: 'last_name_kana')
  String? get lastNameKana;
  @override
  @JsonKey(name: 'last_name_kanji')
  String? get lastNameKanji;
  @override
  DobParams? get dob;
  @override
  @JsonKey(name: 'address_kana')
  AddressKanaParams? get addressKana;
  @override
  @JsonKey(name: 'address_kanji')
  AddressKanjiParams? get addressKanji;
  @override
  String? get email;
  @override
  String? get phone;

  /// Create a copy of RepresentativeParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepresentativeParamsImplCopyWith<_$RepresentativeParamsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DobParams _$DobParamsFromJson(Map<String, dynamic> json) {
  return _DobParams.fromJson(json);
}

/// @nodoc
mixin _$DobParams {
  String? get day => throw _privateConstructorUsedError;
  String? get month => throw _privateConstructorUsedError;
  String? get year => throw _privateConstructorUsedError;

  /// Serializes this DobParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DobParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DobParamsCopyWith<DobParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DobParamsCopyWith<$Res> {
  factory $DobParamsCopyWith(DobParams value, $Res Function(DobParams) then) =
      _$DobParamsCopyWithImpl<$Res, DobParams>;
  @useResult
  $Res call({String? day, String? month, String? year});
}

/// @nodoc
class _$DobParamsCopyWithImpl<$Res, $Val extends DobParams>
    implements $DobParamsCopyWith<$Res> {
  _$DobParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DobParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = freezed,
    Object? month = freezed,
    Object? year = freezed,
  }) {
    return _then(
      _value.copyWith(
            day:
                freezed == day
                    ? _value.day
                    : day // ignore: cast_nullable_to_non_nullable
                        as String?,
            month:
                freezed == month
                    ? _value.month
                    : month // ignore: cast_nullable_to_non_nullable
                        as String?,
            year:
                freezed == year
                    ? _value.year
                    : year // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DobParamsImplCopyWith<$Res>
    implements $DobParamsCopyWith<$Res> {
  factory _$$DobParamsImplCopyWith(
    _$DobParamsImpl value,
    $Res Function(_$DobParamsImpl) then,
  ) = __$$DobParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? day, String? month, String? year});
}

/// @nodoc
class __$$DobParamsImplCopyWithImpl<$Res>
    extends _$DobParamsCopyWithImpl<$Res, _$DobParamsImpl>
    implements _$$DobParamsImplCopyWith<$Res> {
  __$$DobParamsImplCopyWithImpl(
    _$DobParamsImpl _value,
    $Res Function(_$DobParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DobParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = freezed,
    Object? month = freezed,
    Object? year = freezed,
  }) {
    return _then(
      _$DobParamsImpl(
        day:
            freezed == day
                ? _value.day
                : day // ignore: cast_nullable_to_non_nullable
                    as String?,
        month:
            freezed == month
                ? _value.month
                : month // ignore: cast_nullable_to_non_nullable
                    as String?,
        year:
            freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DobParamsImpl implements _DobParams {
  const _$DobParamsImpl({
    required this.day,
    required this.month,
    required this.year,
  });

  factory _$DobParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DobParamsImplFromJson(json);

  @override
  final String? day;
  @override
  final String? month;
  @override
  final String? year;

  @override
  String toString() {
    return 'DobParams(day: $day, month: $month, year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DobParamsImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, day, month, year);

  /// Create a copy of DobParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DobParamsImplCopyWith<_$DobParamsImpl> get copyWith =>
      __$$DobParamsImplCopyWithImpl<_$DobParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DobParamsImplToJson(this);
  }
}

abstract class _DobParams implements DobParams {
  const factory _DobParams({
    required final String? day,
    required final String? month,
    required final String? year,
  }) = _$DobParamsImpl;

  factory _DobParams.fromJson(Map<String, dynamic> json) =
      _$DobParamsImpl.fromJson;

  @override
  String? get day;
  @override
  String? get month;
  @override
  String? get year;

  /// Create a copy of DobParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DobParamsImplCopyWith<_$DobParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressKanaParams _$AddressKanaParamsFromJson(Map<String, dynamic> json) {
  return _AddressKanaParams.fromJson(json);
}

/// @nodoc
mixin _$AddressKanaParams {
  String? get line1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'postal_code')
  String? get postalCode => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get town => throw _privateConstructorUsedError;

  /// Serializes this AddressKanaParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressKanaParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressKanaParamsCopyWith<AddressKanaParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressKanaParamsCopyWith<$Res> {
  factory $AddressKanaParamsCopyWith(
    AddressKanaParams value,
    $Res Function(AddressKanaParams) then,
  ) = _$AddressKanaParamsCopyWithImpl<$Res, AddressKanaParams>;
  @useResult
  $Res call({
    String? line1,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? city,
    String? state,
    String? town,
  });
}

/// @nodoc
class _$AddressKanaParamsCopyWithImpl<$Res, $Val extends AddressKanaParams>
    implements $AddressKanaParamsCopyWith<$Res> {
  _$AddressKanaParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressKanaParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line1 = freezed,
    Object? postalCode = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? town = freezed,
  }) {
    return _then(
      _value.copyWith(
            line1:
                freezed == line1
                    ? _value.line1
                    : line1 // ignore: cast_nullable_to_non_nullable
                        as String?,
            postalCode:
                freezed == postalCode
                    ? _value.postalCode
                    : postalCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            city:
                freezed == city
                    ? _value.city
                    : city // ignore: cast_nullable_to_non_nullable
                        as String?,
            state:
                freezed == state
                    ? _value.state
                    : state // ignore: cast_nullable_to_non_nullable
                        as String?,
            town:
                freezed == town
                    ? _value.town
                    : town // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressKanaParamsImplCopyWith<$Res>
    implements $AddressKanaParamsCopyWith<$Res> {
  factory _$$AddressKanaParamsImplCopyWith(
    _$AddressKanaParamsImpl value,
    $Res Function(_$AddressKanaParamsImpl) then,
  ) = __$$AddressKanaParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? line1,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? city,
    String? state,
    String? town,
  });
}

/// @nodoc
class __$$AddressKanaParamsImplCopyWithImpl<$Res>
    extends _$AddressKanaParamsCopyWithImpl<$Res, _$AddressKanaParamsImpl>
    implements _$$AddressKanaParamsImplCopyWith<$Res> {
  __$$AddressKanaParamsImplCopyWithImpl(
    _$AddressKanaParamsImpl _value,
    $Res Function(_$AddressKanaParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressKanaParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line1 = freezed,
    Object? postalCode = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? town = freezed,
  }) {
    return _then(
      _$AddressKanaParamsImpl(
        line1:
            freezed == line1
                ? _value.line1
                : line1 // ignore: cast_nullable_to_non_nullable
                    as String?,
        postalCode:
            freezed == postalCode
                ? _value.postalCode
                : postalCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        city:
            freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                    as String?,
        state:
            freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                    as String?,
        town:
            freezed == town
                ? _value.town
                : town // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressKanaParamsImpl implements _AddressKanaParams {
  const _$AddressKanaParamsImpl({
    required this.line1,
    @JsonKey(name: 'postal_code') required this.postalCode,
    required this.city,
    required this.state,
    required this.town,
  });

  factory _$AddressKanaParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressKanaParamsImplFromJson(json);

  @override
  final String? line1;
  @override
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? town;

  @override
  String toString() {
    return 'AddressKanaParams(line1: $line1, postalCode: $postalCode, city: $city, state: $state, town: $town)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressKanaParamsImpl &&
            (identical(other.line1, line1) || other.line1 == line1) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.town, town) || other.town == town));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, line1, postalCode, city, state, town);

  /// Create a copy of AddressKanaParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressKanaParamsImplCopyWith<_$AddressKanaParamsImpl> get copyWith =>
      __$$AddressKanaParamsImplCopyWithImpl<_$AddressKanaParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressKanaParamsImplToJson(this);
  }
}

abstract class _AddressKanaParams implements AddressKanaParams {
  const factory _AddressKanaParams({
    required final String? line1,
    @JsonKey(name: 'postal_code') required final String? postalCode,
    required final String? city,
    required final String? state,
    required final String? town,
  }) = _$AddressKanaParamsImpl;

  factory _AddressKanaParams.fromJson(Map<String, dynamic> json) =
      _$AddressKanaParamsImpl.fromJson;

  @override
  String? get line1;
  @override
  @JsonKey(name: 'postal_code')
  String? get postalCode;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get town;

  /// Create a copy of AddressKanaParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressKanaParamsImplCopyWith<_$AddressKanaParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressKanjiParams _$AddressKanjiParamsFromJson(Map<String, dynamic> json) {
  return _AddressKanjiParams.fromJson(json);
}

/// @nodoc
mixin _$AddressKanjiParams {
  String? get line1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'postal_code')
  String? get postalCode => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get town => throw _privateConstructorUsedError;

  /// Serializes this AddressKanjiParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressKanjiParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressKanjiParamsCopyWith<AddressKanjiParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressKanjiParamsCopyWith<$Res> {
  factory $AddressKanjiParamsCopyWith(
    AddressKanjiParams value,
    $Res Function(AddressKanjiParams) then,
  ) = _$AddressKanjiParamsCopyWithImpl<$Res, AddressKanjiParams>;
  @useResult
  $Res call({
    String? line1,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? city,
    String? state,
    String? town,
  });
}

/// @nodoc
class _$AddressKanjiParamsCopyWithImpl<$Res, $Val extends AddressKanjiParams>
    implements $AddressKanjiParamsCopyWith<$Res> {
  _$AddressKanjiParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressKanjiParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line1 = freezed,
    Object? postalCode = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? town = freezed,
  }) {
    return _then(
      _value.copyWith(
            line1:
                freezed == line1
                    ? _value.line1
                    : line1 // ignore: cast_nullable_to_non_nullable
                        as String?,
            postalCode:
                freezed == postalCode
                    ? _value.postalCode
                    : postalCode // ignore: cast_nullable_to_non_nullable
                        as String?,
            city:
                freezed == city
                    ? _value.city
                    : city // ignore: cast_nullable_to_non_nullable
                        as String?,
            state:
                freezed == state
                    ? _value.state
                    : state // ignore: cast_nullable_to_non_nullable
                        as String?,
            town:
                freezed == town
                    ? _value.town
                    : town // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressKanjiParamsImplCopyWith<$Res>
    implements $AddressKanjiParamsCopyWith<$Res> {
  factory _$$AddressKanjiParamsImplCopyWith(
    _$AddressKanjiParamsImpl value,
    $Res Function(_$AddressKanjiParamsImpl) then,
  ) = __$$AddressKanjiParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? line1,
    @JsonKey(name: 'postal_code') String? postalCode,
    String? city,
    String? state,
    String? town,
  });
}

/// @nodoc
class __$$AddressKanjiParamsImplCopyWithImpl<$Res>
    extends _$AddressKanjiParamsCopyWithImpl<$Res, _$AddressKanjiParamsImpl>
    implements _$$AddressKanjiParamsImplCopyWith<$Res> {
  __$$AddressKanjiParamsImplCopyWithImpl(
    _$AddressKanjiParamsImpl _value,
    $Res Function(_$AddressKanjiParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressKanjiParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line1 = freezed,
    Object? postalCode = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? town = freezed,
  }) {
    return _then(
      _$AddressKanjiParamsImpl(
        line1:
            freezed == line1
                ? _value.line1
                : line1 // ignore: cast_nullable_to_non_nullable
                    as String?,
        postalCode:
            freezed == postalCode
                ? _value.postalCode
                : postalCode // ignore: cast_nullable_to_non_nullable
                    as String?,
        city:
            freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                    as String?,
        state:
            freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                    as String?,
        town:
            freezed == town
                ? _value.town
                : town // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressKanjiParamsImpl implements _AddressKanjiParams {
  const _$AddressKanjiParamsImpl({
    required this.line1,
    @JsonKey(name: 'postal_code') required this.postalCode,
    required this.city,
    required this.state,
    required this.town,
  });

  factory _$AddressKanjiParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressKanjiParamsImplFromJson(json);

  @override
  final String? line1;
  @override
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? town;

  @override
  String toString() {
    return 'AddressKanjiParams(line1: $line1, postalCode: $postalCode, city: $city, state: $state, town: $town)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressKanjiParamsImpl &&
            (identical(other.line1, line1) || other.line1 == line1) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.town, town) || other.town == town));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, line1, postalCode, city, state, town);

  /// Create a copy of AddressKanjiParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressKanjiParamsImplCopyWith<_$AddressKanjiParamsImpl> get copyWith =>
      __$$AddressKanjiParamsImplCopyWithImpl<_$AddressKanjiParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressKanjiParamsImplToJson(this);
  }
}

abstract class _AddressKanjiParams implements AddressKanjiParams {
  const factory _AddressKanjiParams({
    required final String? line1,
    @JsonKey(name: 'postal_code') required final String? postalCode,
    required final String? city,
    required final String? state,
    required final String? town,
  }) = _$AddressKanjiParamsImpl;

  factory _AddressKanjiParams.fromJson(Map<String, dynamic> json) =
      _$AddressKanjiParamsImpl.fromJson;

  @override
  String? get line1;
  @override
  @JsonKey(name: 'postal_code')
  String? get postalCode;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get town;

  /// Create a copy of AddressKanjiParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressKanjiParamsImplCopyWith<_$AddressKanjiParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
