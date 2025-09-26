// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_account_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountParams {

@JsonKey(unknownEnumValue: null) Type? get type;@JsonKey(unknownEnumValue: null) Country? get country; CapabilitiesParams? get capabilities; String? get email;//
@JsonKey(unknownEnumValue: null) BusinessType? get businessType; BusinessProfileParams? get businessProfile; TosAcceptanceParams? get tosAcceptance; String? get externalAccount; IndividualParams? get individual;// // 個人
 CompanyParams? get company;// // 法人＆個人事業主
 RepresentativeParams? get representative;
/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountParamsCopyWith<AccountParams> get copyWith => _$AccountParamsCopyWithImpl<AccountParams>(this as AccountParams, _$identity);

  /// Serializes this AccountParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountParams&&(identical(other.type, type) || other.type == type)&&(identical(other.country, country) || other.country == country)&&(identical(other.capabilities, capabilities) || other.capabilities == capabilities)&&(identical(other.email, email) || other.email == email)&&(identical(other.businessType, businessType) || other.businessType == businessType)&&(identical(other.businessProfile, businessProfile) || other.businessProfile == businessProfile)&&(identical(other.tosAcceptance, tosAcceptance) || other.tosAcceptance == tosAcceptance)&&(identical(other.externalAccount, externalAccount) || other.externalAccount == externalAccount)&&(identical(other.individual, individual) || other.individual == individual)&&(identical(other.company, company) || other.company == company)&&(identical(other.representative, representative) || other.representative == representative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,country,capabilities,email,businessType,businessProfile,tosAcceptance,externalAccount,individual,company,representative);

@override
String toString() {
  return 'AccountParams(type: $type, country: $country, capabilities: $capabilities, email: $email, businessType: $businessType, businessProfile: $businessProfile, tosAcceptance: $tosAcceptance, externalAccount: $externalAccount, individual: $individual, company: $company, representative: $representative)';
}


}

/// @nodoc
abstract mixin class $AccountParamsCopyWith<$Res>  {
  factory $AccountParamsCopyWith(AccountParams value, $Res Function(AccountParams) _then) = _$AccountParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: null) Type? type,@JsonKey(unknownEnumValue: null) Country? country, CapabilitiesParams? capabilities, String? email,@JsonKey(unknownEnumValue: null) BusinessType? businessType, BusinessProfileParams? businessProfile, TosAcceptanceParams? tosAcceptance, String? externalAccount, IndividualParams? individual, CompanyParams? company, RepresentativeParams? representative
});


$CapabilitiesParamsCopyWith<$Res>? get capabilities;$BusinessProfileParamsCopyWith<$Res>? get businessProfile;$TosAcceptanceParamsCopyWith<$Res>? get tosAcceptance;$IndividualParamsCopyWith<$Res>? get individual;$CompanyParamsCopyWith<$Res>? get company;$RepresentativeParamsCopyWith<$Res>? get representative;

}
/// @nodoc
class _$AccountParamsCopyWithImpl<$Res>
    implements $AccountParamsCopyWith<$Res> {
  _$AccountParamsCopyWithImpl(this._self, this._then);

  final AccountParams _self;
  final $Res Function(AccountParams) _then;

/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? country = freezed,Object? capabilities = freezed,Object? email = freezed,Object? businessType = freezed,Object? businessProfile = freezed,Object? tosAcceptance = freezed,Object? externalAccount = freezed,Object? individual = freezed,Object? company = freezed,Object? representative = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country?,capabilities: freezed == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as CapabilitiesParams?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,businessType: freezed == businessType ? _self.businessType : businessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,businessProfile: freezed == businessProfile ? _self.businessProfile : businessProfile // ignore: cast_nullable_to_non_nullable
as BusinessProfileParams?,tosAcceptance: freezed == tosAcceptance ? _self.tosAcceptance : tosAcceptance // ignore: cast_nullable_to_non_nullable
as TosAcceptanceParams?,externalAccount: freezed == externalAccount ? _self.externalAccount : externalAccount // ignore: cast_nullable_to_non_nullable
as String?,individual: freezed == individual ? _self.individual : individual // ignore: cast_nullable_to_non_nullable
as IndividualParams?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as CompanyParams?,representative: freezed == representative ? _self.representative : representative // ignore: cast_nullable_to_non_nullable
as RepresentativeParams?,
  ));
}
/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapabilitiesParamsCopyWith<$Res>? get capabilities {
    if (_self.capabilities == null) {
    return null;
  }

  return $CapabilitiesParamsCopyWith<$Res>(_self.capabilities!, (value) {
    return _then(_self.copyWith(capabilities: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessProfileParamsCopyWith<$Res>? get businessProfile {
    if (_self.businessProfile == null) {
    return null;
  }

  return $BusinessProfileParamsCopyWith<$Res>(_self.businessProfile!, (value) {
    return _then(_self.copyWith(businessProfile: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TosAcceptanceParamsCopyWith<$Res>? get tosAcceptance {
    if (_self.tosAcceptance == null) {
    return null;
  }

  return $TosAcceptanceParamsCopyWith<$Res>(_self.tosAcceptance!, (value) {
    return _then(_self.copyWith(tosAcceptance: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndividualParamsCopyWith<$Res>? get individual {
    if (_self.individual == null) {
    return null;
  }

  return $IndividualParamsCopyWith<$Res>(_self.individual!, (value) {
    return _then(_self.copyWith(individual: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyParamsCopyWith<$Res>? get company {
    if (_self.company == null) {
    return null;
  }

  return $CompanyParamsCopyWith<$Res>(_self.company!, (value) {
    return _then(_self.copyWith(company: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RepresentativeParamsCopyWith<$Res>? get representative {
    if (_self.representative == null) {
    return null;
  }

  return $RepresentativeParamsCopyWith<$Res>(_self.representative!, (value) {
    return _then(_self.copyWith(representative: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountParams].
extension AccountParamsPatterns on AccountParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountParams value)  $default,){
final _that = this;
switch (_that) {
case _AccountParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountParams value)?  $default,){
final _that = this;
switch (_that) {
case _AccountParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: null)  Type? type, @JsonKey(unknownEnumValue: null)  Country? country,  CapabilitiesParams? capabilities,  String? email, @JsonKey(unknownEnumValue: null)  BusinessType? businessType,  BusinessProfileParams? businessProfile,  TosAcceptanceParams? tosAcceptance,  String? externalAccount,  IndividualParams? individual,  CompanyParams? company,  RepresentativeParams? representative)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountParams() when $default != null:
return $default(_that.type,_that.country,_that.capabilities,_that.email,_that.businessType,_that.businessProfile,_that.tosAcceptance,_that.externalAccount,_that.individual,_that.company,_that.representative);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: null)  Type? type, @JsonKey(unknownEnumValue: null)  Country? country,  CapabilitiesParams? capabilities,  String? email, @JsonKey(unknownEnumValue: null)  BusinessType? businessType,  BusinessProfileParams? businessProfile,  TosAcceptanceParams? tosAcceptance,  String? externalAccount,  IndividualParams? individual,  CompanyParams? company,  RepresentativeParams? representative)  $default,) {final _that = this;
switch (_that) {
case _AccountParams():
return $default(_that.type,_that.country,_that.capabilities,_that.email,_that.businessType,_that.businessProfile,_that.tosAcceptance,_that.externalAccount,_that.individual,_that.company,_that.representative);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: null)  Type? type, @JsonKey(unknownEnumValue: null)  Country? country,  CapabilitiesParams? capabilities,  String? email, @JsonKey(unknownEnumValue: null)  BusinessType? businessType,  BusinessProfileParams? businessProfile,  TosAcceptanceParams? tosAcceptance,  String? externalAccount,  IndividualParams? individual,  CompanyParams? company,  RepresentativeParams? representative)?  $default,) {final _that = this;
switch (_that) {
case _AccountParams() when $default != null:
return $default(_that.type,_that.country,_that.capabilities,_that.email,_that.businessType,_that.businessProfile,_that.tosAcceptance,_that.externalAccount,_that.individual,_that.company,_that.representative);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountParams implements AccountParams {
  const _AccountParams({@JsonKey(unknownEnumValue: null) required this.type, @JsonKey(unknownEnumValue: null) required this.country, required this.capabilities, required this.email, @JsonKey(unknownEnumValue: null) required this.businessType, required this.businessProfile, required this.tosAcceptance, required this.externalAccount, required this.individual, required this.company, required this.representative});
  factory _AccountParams.fromJson(Map<String, dynamic> json) => _$AccountParamsFromJson(json);

@override@JsonKey(unknownEnumValue: null) final  Type? type;
@override@JsonKey(unknownEnumValue: null) final  Country? country;
@override final  CapabilitiesParams? capabilities;
@override final  String? email;
//
@override@JsonKey(unknownEnumValue: null) final  BusinessType? businessType;
@override final  BusinessProfileParams? businessProfile;
@override final  TosAcceptanceParams? tosAcceptance;
@override final  String? externalAccount;
@override final  IndividualParams? individual;
// // 個人
@override final  CompanyParams? company;
// // 法人＆個人事業主
@override final  RepresentativeParams? representative;

/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountParamsCopyWith<_AccountParams> get copyWith => __$AccountParamsCopyWithImpl<_AccountParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountParams&&(identical(other.type, type) || other.type == type)&&(identical(other.country, country) || other.country == country)&&(identical(other.capabilities, capabilities) || other.capabilities == capabilities)&&(identical(other.email, email) || other.email == email)&&(identical(other.businessType, businessType) || other.businessType == businessType)&&(identical(other.businessProfile, businessProfile) || other.businessProfile == businessProfile)&&(identical(other.tosAcceptance, tosAcceptance) || other.tosAcceptance == tosAcceptance)&&(identical(other.externalAccount, externalAccount) || other.externalAccount == externalAccount)&&(identical(other.individual, individual) || other.individual == individual)&&(identical(other.company, company) || other.company == company)&&(identical(other.representative, representative) || other.representative == representative));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,country,capabilities,email,businessType,businessProfile,tosAcceptance,externalAccount,individual,company,representative);

@override
String toString() {
  return 'AccountParams(type: $type, country: $country, capabilities: $capabilities, email: $email, businessType: $businessType, businessProfile: $businessProfile, tosAcceptance: $tosAcceptance, externalAccount: $externalAccount, individual: $individual, company: $company, representative: $representative)';
}


}

/// @nodoc
abstract mixin class _$AccountParamsCopyWith<$Res> implements $AccountParamsCopyWith<$Res> {
  factory _$AccountParamsCopyWith(_AccountParams value, $Res Function(_AccountParams) _then) = __$AccountParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: null) Type? type,@JsonKey(unknownEnumValue: null) Country? country, CapabilitiesParams? capabilities, String? email,@JsonKey(unknownEnumValue: null) BusinessType? businessType, BusinessProfileParams? businessProfile, TosAcceptanceParams? tosAcceptance, String? externalAccount, IndividualParams? individual, CompanyParams? company, RepresentativeParams? representative
});


@override $CapabilitiesParamsCopyWith<$Res>? get capabilities;@override $BusinessProfileParamsCopyWith<$Res>? get businessProfile;@override $TosAcceptanceParamsCopyWith<$Res>? get tosAcceptance;@override $IndividualParamsCopyWith<$Res>? get individual;@override $CompanyParamsCopyWith<$Res>? get company;@override $RepresentativeParamsCopyWith<$Res>? get representative;

}
/// @nodoc
class __$AccountParamsCopyWithImpl<$Res>
    implements _$AccountParamsCopyWith<$Res> {
  __$AccountParamsCopyWithImpl(this._self, this._then);

  final _AccountParams _self;
  final $Res Function(_AccountParams) _then;

/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? country = freezed,Object? capabilities = freezed,Object? email = freezed,Object? businessType = freezed,Object? businessProfile = freezed,Object? tosAcceptance = freezed,Object? externalAccount = freezed,Object? individual = freezed,Object? company = freezed,Object? representative = freezed,}) {
  return _then(_AccountParams(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as Type?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country?,capabilities: freezed == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as CapabilitiesParams?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,businessType: freezed == businessType ? _self.businessType : businessType // ignore: cast_nullable_to_non_nullable
as BusinessType?,businessProfile: freezed == businessProfile ? _self.businessProfile : businessProfile // ignore: cast_nullable_to_non_nullable
as BusinessProfileParams?,tosAcceptance: freezed == tosAcceptance ? _self.tosAcceptance : tosAcceptance // ignore: cast_nullable_to_non_nullable
as TosAcceptanceParams?,externalAccount: freezed == externalAccount ? _self.externalAccount : externalAccount // ignore: cast_nullable_to_non_nullable
as String?,individual: freezed == individual ? _self.individual : individual // ignore: cast_nullable_to_non_nullable
as IndividualParams?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as CompanyParams?,representative: freezed == representative ? _self.representative : representative // ignore: cast_nullable_to_non_nullable
as RepresentativeParams?,
  ));
}

/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CapabilitiesParamsCopyWith<$Res>? get capabilities {
    if (_self.capabilities == null) {
    return null;
  }

  return $CapabilitiesParamsCopyWith<$Res>(_self.capabilities!, (value) {
    return _then(_self.copyWith(capabilities: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessProfileParamsCopyWith<$Res>? get businessProfile {
    if (_self.businessProfile == null) {
    return null;
  }

  return $BusinessProfileParamsCopyWith<$Res>(_self.businessProfile!, (value) {
    return _then(_self.copyWith(businessProfile: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TosAcceptanceParamsCopyWith<$Res>? get tosAcceptance {
    if (_self.tosAcceptance == null) {
    return null;
  }

  return $TosAcceptanceParamsCopyWith<$Res>(_self.tosAcceptance!, (value) {
    return _then(_self.copyWith(tosAcceptance: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndividualParamsCopyWith<$Res>? get individual {
    if (_self.individual == null) {
    return null;
  }

  return $IndividualParamsCopyWith<$Res>(_self.individual!, (value) {
    return _then(_self.copyWith(individual: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompanyParamsCopyWith<$Res>? get company {
    if (_self.company == null) {
    return null;
  }

  return $CompanyParamsCopyWith<$Res>(_self.company!, (value) {
    return _then(_self.copyWith(company: value));
  });
}/// Create a copy of AccountParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RepresentativeParamsCopyWith<$Res>? get representative {
    if (_self.representative == null) {
    return null;
  }

  return $RepresentativeParamsCopyWith<$Res>(_self.representative!, (value) {
    return _then(_self.copyWith(representative: value));
  });
}
}


/// @nodoc
mixin _$CapabilitiesParams {

@JsonKey(name: 'bank_transfer_payments') RequestedParams? get bankTransferPayments;@JsonKey(name: 'card_payments') RequestedParams? get cardPayments;@JsonKey(name: 'jcb_payments') RequestedParams? get jcbPayments;@JsonKey(name: 'konbini_payments') RequestedParams? get konbiniPayments; RequestedParams? get transfers;
/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapabilitiesParamsCopyWith<CapabilitiesParams> get copyWith => _$CapabilitiesParamsCopyWithImpl<CapabilitiesParams>(this as CapabilitiesParams, _$identity);

  /// Serializes this CapabilitiesParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CapabilitiesParams&&(identical(other.bankTransferPayments, bankTransferPayments) || other.bankTransferPayments == bankTransferPayments)&&(identical(other.cardPayments, cardPayments) || other.cardPayments == cardPayments)&&(identical(other.jcbPayments, jcbPayments) || other.jcbPayments == jcbPayments)&&(identical(other.konbiniPayments, konbiniPayments) || other.konbiniPayments == konbiniPayments)&&(identical(other.transfers, transfers) || other.transfers == transfers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankTransferPayments,cardPayments,jcbPayments,konbiniPayments,transfers);

@override
String toString() {
  return 'CapabilitiesParams(bankTransferPayments: $bankTransferPayments, cardPayments: $cardPayments, jcbPayments: $jcbPayments, konbiniPayments: $konbiniPayments, transfers: $transfers)';
}


}

/// @nodoc
abstract mixin class $CapabilitiesParamsCopyWith<$Res>  {
  factory $CapabilitiesParamsCopyWith(CapabilitiesParams value, $Res Function(CapabilitiesParams) _then) = _$CapabilitiesParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'bank_transfer_payments') RequestedParams? bankTransferPayments,@JsonKey(name: 'card_payments') RequestedParams? cardPayments,@JsonKey(name: 'jcb_payments') RequestedParams? jcbPayments,@JsonKey(name: 'konbini_payments') RequestedParams? konbiniPayments, RequestedParams? transfers
});


$RequestedParamsCopyWith<$Res>? get bankTransferPayments;$RequestedParamsCopyWith<$Res>? get cardPayments;$RequestedParamsCopyWith<$Res>? get jcbPayments;$RequestedParamsCopyWith<$Res>? get konbiniPayments;$RequestedParamsCopyWith<$Res>? get transfers;

}
/// @nodoc
class _$CapabilitiesParamsCopyWithImpl<$Res>
    implements $CapabilitiesParamsCopyWith<$Res> {
  _$CapabilitiesParamsCopyWithImpl(this._self, this._then);

  final CapabilitiesParams _self;
  final $Res Function(CapabilitiesParams) _then;

/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bankTransferPayments = freezed,Object? cardPayments = freezed,Object? jcbPayments = freezed,Object? konbiniPayments = freezed,Object? transfers = freezed,}) {
  return _then(_self.copyWith(
bankTransferPayments: freezed == bankTransferPayments ? _self.bankTransferPayments : bankTransferPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,cardPayments: freezed == cardPayments ? _self.cardPayments : cardPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,jcbPayments: freezed == jcbPayments ? _self.jcbPayments : jcbPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,konbiniPayments: freezed == konbiniPayments ? _self.konbiniPayments : konbiniPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,transfers: freezed == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as RequestedParams?,
  ));
}
/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get bankTransferPayments {
    if (_self.bankTransferPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.bankTransferPayments!, (value) {
    return _then(_self.copyWith(bankTransferPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get cardPayments {
    if (_self.cardPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.cardPayments!, (value) {
    return _then(_self.copyWith(cardPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get jcbPayments {
    if (_self.jcbPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.jcbPayments!, (value) {
    return _then(_self.copyWith(jcbPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get konbiniPayments {
    if (_self.konbiniPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.konbiniPayments!, (value) {
    return _then(_self.copyWith(konbiniPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get transfers {
    if (_self.transfers == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.transfers!, (value) {
    return _then(_self.copyWith(transfers: value));
  });
}
}


/// Adds pattern-matching-related methods to [CapabilitiesParams].
extension CapabilitiesParamsPatterns on CapabilitiesParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CapabilitiesParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CapabilitiesParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CapabilitiesParams value)  $default,){
final _that = this;
switch (_that) {
case _CapabilitiesParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CapabilitiesParams value)?  $default,){
final _that = this;
switch (_that) {
case _CapabilitiesParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'bank_transfer_payments')  RequestedParams? bankTransferPayments, @JsonKey(name: 'card_payments')  RequestedParams? cardPayments, @JsonKey(name: 'jcb_payments')  RequestedParams? jcbPayments, @JsonKey(name: 'konbini_payments')  RequestedParams? konbiniPayments,  RequestedParams? transfers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CapabilitiesParams() when $default != null:
return $default(_that.bankTransferPayments,_that.cardPayments,_that.jcbPayments,_that.konbiniPayments,_that.transfers);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'bank_transfer_payments')  RequestedParams? bankTransferPayments, @JsonKey(name: 'card_payments')  RequestedParams? cardPayments, @JsonKey(name: 'jcb_payments')  RequestedParams? jcbPayments, @JsonKey(name: 'konbini_payments')  RequestedParams? konbiniPayments,  RequestedParams? transfers)  $default,) {final _that = this;
switch (_that) {
case _CapabilitiesParams():
return $default(_that.bankTransferPayments,_that.cardPayments,_that.jcbPayments,_that.konbiniPayments,_that.transfers);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'bank_transfer_payments')  RequestedParams? bankTransferPayments, @JsonKey(name: 'card_payments')  RequestedParams? cardPayments, @JsonKey(name: 'jcb_payments')  RequestedParams? jcbPayments, @JsonKey(name: 'konbini_payments')  RequestedParams? konbiniPayments,  RequestedParams? transfers)?  $default,) {final _that = this;
switch (_that) {
case _CapabilitiesParams() when $default != null:
return $default(_that.bankTransferPayments,_that.cardPayments,_that.jcbPayments,_that.konbiniPayments,_that.transfers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CapabilitiesParams implements CapabilitiesParams {
  const _CapabilitiesParams({@JsonKey(name: 'bank_transfer_payments') this.bankTransferPayments, @JsonKey(name: 'card_payments') this.cardPayments, @JsonKey(name: 'jcb_payments') this.jcbPayments, @JsonKey(name: 'konbini_payments') this.konbiniPayments, this.transfers});
  factory _CapabilitiesParams.fromJson(Map<String, dynamic> json) => _$CapabilitiesParamsFromJson(json);

@override@JsonKey(name: 'bank_transfer_payments') final  RequestedParams? bankTransferPayments;
@override@JsonKey(name: 'card_payments') final  RequestedParams? cardPayments;
@override@JsonKey(name: 'jcb_payments') final  RequestedParams? jcbPayments;
@override@JsonKey(name: 'konbini_payments') final  RequestedParams? konbiniPayments;
@override final  RequestedParams? transfers;

/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapabilitiesParamsCopyWith<_CapabilitiesParams> get copyWith => __$CapabilitiesParamsCopyWithImpl<_CapabilitiesParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CapabilitiesParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CapabilitiesParams&&(identical(other.bankTransferPayments, bankTransferPayments) || other.bankTransferPayments == bankTransferPayments)&&(identical(other.cardPayments, cardPayments) || other.cardPayments == cardPayments)&&(identical(other.jcbPayments, jcbPayments) || other.jcbPayments == jcbPayments)&&(identical(other.konbiniPayments, konbiniPayments) || other.konbiniPayments == konbiniPayments)&&(identical(other.transfers, transfers) || other.transfers == transfers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,bankTransferPayments,cardPayments,jcbPayments,konbiniPayments,transfers);

@override
String toString() {
  return 'CapabilitiesParams(bankTransferPayments: $bankTransferPayments, cardPayments: $cardPayments, jcbPayments: $jcbPayments, konbiniPayments: $konbiniPayments, transfers: $transfers)';
}


}

/// @nodoc
abstract mixin class _$CapabilitiesParamsCopyWith<$Res> implements $CapabilitiesParamsCopyWith<$Res> {
  factory _$CapabilitiesParamsCopyWith(_CapabilitiesParams value, $Res Function(_CapabilitiesParams) _then) = __$CapabilitiesParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'bank_transfer_payments') RequestedParams? bankTransferPayments,@JsonKey(name: 'card_payments') RequestedParams? cardPayments,@JsonKey(name: 'jcb_payments') RequestedParams? jcbPayments,@JsonKey(name: 'konbini_payments') RequestedParams? konbiniPayments, RequestedParams? transfers
});


@override $RequestedParamsCopyWith<$Res>? get bankTransferPayments;@override $RequestedParamsCopyWith<$Res>? get cardPayments;@override $RequestedParamsCopyWith<$Res>? get jcbPayments;@override $RequestedParamsCopyWith<$Res>? get konbiniPayments;@override $RequestedParamsCopyWith<$Res>? get transfers;

}
/// @nodoc
class __$CapabilitiesParamsCopyWithImpl<$Res>
    implements _$CapabilitiesParamsCopyWith<$Res> {
  __$CapabilitiesParamsCopyWithImpl(this._self, this._then);

  final _CapabilitiesParams _self;
  final $Res Function(_CapabilitiesParams) _then;

/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bankTransferPayments = freezed,Object? cardPayments = freezed,Object? jcbPayments = freezed,Object? konbiniPayments = freezed,Object? transfers = freezed,}) {
  return _then(_CapabilitiesParams(
bankTransferPayments: freezed == bankTransferPayments ? _self.bankTransferPayments : bankTransferPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,cardPayments: freezed == cardPayments ? _self.cardPayments : cardPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,jcbPayments: freezed == jcbPayments ? _self.jcbPayments : jcbPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,konbiniPayments: freezed == konbiniPayments ? _self.konbiniPayments : konbiniPayments // ignore: cast_nullable_to_non_nullable
as RequestedParams?,transfers: freezed == transfers ? _self.transfers : transfers // ignore: cast_nullable_to_non_nullable
as RequestedParams?,
  ));
}

/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get bankTransferPayments {
    if (_self.bankTransferPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.bankTransferPayments!, (value) {
    return _then(_self.copyWith(bankTransferPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get cardPayments {
    if (_self.cardPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.cardPayments!, (value) {
    return _then(_self.copyWith(cardPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get jcbPayments {
    if (_self.jcbPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.jcbPayments!, (value) {
    return _then(_self.copyWith(jcbPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get konbiniPayments {
    if (_self.konbiniPayments == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.konbiniPayments!, (value) {
    return _then(_self.copyWith(konbiniPayments: value));
  });
}/// Create a copy of CapabilitiesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<$Res>? get transfers {
    if (_self.transfers == null) {
    return null;
  }

  return $RequestedParamsCopyWith<$Res>(_self.transfers!, (value) {
    return _then(_self.copyWith(transfers: value));
  });
}
}


/// @nodoc
mixin _$RequestedParams {

 bool? get required;
/// Create a copy of RequestedParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestedParamsCopyWith<RequestedParams> get copyWith => _$RequestedParamsCopyWithImpl<RequestedParams>(this as RequestedParams, _$identity);

  /// Serializes this RequestedParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestedParams&&(identical(other.required, required) || other.required == required));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,required);

@override
String toString() {
  return 'RequestedParams(required: $required)';
}


}

/// @nodoc
abstract mixin class $RequestedParamsCopyWith<$Res>  {
  factory $RequestedParamsCopyWith(RequestedParams value, $Res Function(RequestedParams) _then) = _$RequestedParamsCopyWithImpl;
@useResult
$Res call({
 bool? required
});




}
/// @nodoc
class _$RequestedParamsCopyWithImpl<$Res>
    implements $RequestedParamsCopyWith<$Res> {
  _$RequestedParamsCopyWithImpl(this._self, this._then);

  final RequestedParams _self;
  final $Res Function(RequestedParams) _then;

/// Create a copy of RequestedParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? required = freezed,}) {
  return _then(_self.copyWith(
required: freezed == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestedParams].
extension RequestedParamsPatterns on RequestedParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestedParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestedParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestedParams value)  $default,){
final _that = this;
switch (_that) {
case _RequestedParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestedParams value)?  $default,){
final _that = this;
switch (_that) {
case _RequestedParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? required)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestedParams() when $default != null:
return $default(_that.required);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? required)  $default,) {final _that = this;
switch (_that) {
case _RequestedParams():
return $default(_that.required);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? required)?  $default,) {final _that = this;
switch (_that) {
case _RequestedParams() when $default != null:
return $default(_that.required);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestedParams implements RequestedParams {
  const _RequestedParams({this.required});
  factory _RequestedParams.fromJson(Map<String, dynamic> json) => _$RequestedParamsFromJson(json);

@override final  bool? required;

/// Create a copy of RequestedParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestedParamsCopyWith<_RequestedParams> get copyWith => __$RequestedParamsCopyWithImpl<_RequestedParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestedParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestedParams&&(identical(other.required, required) || other.required == required));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,required);

@override
String toString() {
  return 'RequestedParams(required: $required)';
}


}

/// @nodoc
abstract mixin class _$RequestedParamsCopyWith<$Res> implements $RequestedParamsCopyWith<$Res> {
  factory _$RequestedParamsCopyWith(_RequestedParams value, $Res Function(_RequestedParams) _then) = __$RequestedParamsCopyWithImpl;
@override @useResult
$Res call({
 bool? required
});




}
/// @nodoc
class __$RequestedParamsCopyWithImpl<$Res>
    implements _$RequestedParamsCopyWith<$Res> {
  __$RequestedParamsCopyWithImpl(this._self, this._then);

  final _RequestedParams _self;
  final $Res Function(_RequestedParams) _then;

/// Create a copy of RequestedParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? required = freezed,}) {
  return _then(_RequestedParams(
required: freezed == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$BusinessProfileParams {

 String? get mcc; String? get url;@JsonKey(name: 'product_description') String? get productDescription;
/// Create a copy of BusinessProfileParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessProfileParamsCopyWith<BusinessProfileParams> get copyWith => _$BusinessProfileParamsCopyWithImpl<BusinessProfileParams>(this as BusinessProfileParams, _$identity);

  /// Serializes this BusinessProfileParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessProfileParams&&(identical(other.mcc, mcc) || other.mcc == mcc)&&(identical(other.url, url) || other.url == url)&&(identical(other.productDescription, productDescription) || other.productDescription == productDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mcc,url,productDescription);

@override
String toString() {
  return 'BusinessProfileParams(mcc: $mcc, url: $url, productDescription: $productDescription)';
}


}

/// @nodoc
abstract mixin class $BusinessProfileParamsCopyWith<$Res>  {
  factory $BusinessProfileParamsCopyWith(BusinessProfileParams value, $Res Function(BusinessProfileParams) _then) = _$BusinessProfileParamsCopyWithImpl;
@useResult
$Res call({
 String? mcc, String? url,@JsonKey(name: 'product_description') String? productDescription
});




}
/// @nodoc
class _$BusinessProfileParamsCopyWithImpl<$Res>
    implements $BusinessProfileParamsCopyWith<$Res> {
  _$BusinessProfileParamsCopyWithImpl(this._self, this._then);

  final BusinessProfileParams _self;
  final $Res Function(BusinessProfileParams) _then;

/// Create a copy of BusinessProfileParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mcc = freezed,Object? url = freezed,Object? productDescription = freezed,}) {
  return _then(_self.copyWith(
mcc: freezed == mcc ? _self.mcc : mcc // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,productDescription: freezed == productDescription ? _self.productDescription : productDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessProfileParams].
extension BusinessProfileParamsPatterns on BusinessProfileParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessProfileParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessProfileParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessProfileParams value)  $default,){
final _that = this;
switch (_that) {
case _BusinessProfileParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessProfileParams value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessProfileParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? mcc,  String? url, @JsonKey(name: 'product_description')  String? productDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessProfileParams() when $default != null:
return $default(_that.mcc,_that.url,_that.productDescription);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? mcc,  String? url, @JsonKey(name: 'product_description')  String? productDescription)  $default,) {final _that = this;
switch (_that) {
case _BusinessProfileParams():
return $default(_that.mcc,_that.url,_that.productDescription);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? mcc,  String? url, @JsonKey(name: 'product_description')  String? productDescription)?  $default,) {final _that = this;
switch (_that) {
case _BusinessProfileParams() when $default != null:
return $default(_that.mcc,_that.url,_that.productDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessProfileParams implements BusinessProfileParams {
  const _BusinessProfileParams({this.mcc, this.url, @JsonKey(name: 'product_description') this.productDescription});
  factory _BusinessProfileParams.fromJson(Map<String, dynamic> json) => _$BusinessProfileParamsFromJson(json);

@override final  String? mcc;
@override final  String? url;
@override@JsonKey(name: 'product_description') final  String? productDescription;

/// Create a copy of BusinessProfileParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessProfileParamsCopyWith<_BusinessProfileParams> get copyWith => __$BusinessProfileParamsCopyWithImpl<_BusinessProfileParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessProfileParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessProfileParams&&(identical(other.mcc, mcc) || other.mcc == mcc)&&(identical(other.url, url) || other.url == url)&&(identical(other.productDescription, productDescription) || other.productDescription == productDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mcc,url,productDescription);

@override
String toString() {
  return 'BusinessProfileParams(mcc: $mcc, url: $url, productDescription: $productDescription)';
}


}

/// @nodoc
abstract mixin class _$BusinessProfileParamsCopyWith<$Res> implements $BusinessProfileParamsCopyWith<$Res> {
  factory _$BusinessProfileParamsCopyWith(_BusinessProfileParams value, $Res Function(_BusinessProfileParams) _then) = __$BusinessProfileParamsCopyWithImpl;
@override @useResult
$Res call({
 String? mcc, String? url,@JsonKey(name: 'product_description') String? productDescription
});




}
/// @nodoc
class __$BusinessProfileParamsCopyWithImpl<$Res>
    implements _$BusinessProfileParamsCopyWith<$Res> {
  __$BusinessProfileParamsCopyWithImpl(this._self, this._then);

  final _BusinessProfileParams _self;
  final $Res Function(_BusinessProfileParams) _then;

/// Create a copy of BusinessProfileParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mcc = freezed,Object? url = freezed,Object? productDescription = freezed,}) {
  return _then(_BusinessProfileParams(
mcc: freezed == mcc ? _self.mcc : mcc // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,productDescription: freezed == productDescription ? _self.productDescription : productDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TosAcceptanceParams {

 String? get ip; String? get data;
/// Create a copy of TosAcceptanceParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TosAcceptanceParamsCopyWith<TosAcceptanceParams> get copyWith => _$TosAcceptanceParamsCopyWithImpl<TosAcceptanceParams>(this as TosAcceptanceParams, _$identity);

  /// Serializes this TosAcceptanceParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TosAcceptanceParams&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ip,data);

@override
String toString() {
  return 'TosAcceptanceParams(ip: $ip, data: $data)';
}


}

/// @nodoc
abstract mixin class $TosAcceptanceParamsCopyWith<$Res>  {
  factory $TosAcceptanceParamsCopyWith(TosAcceptanceParams value, $Res Function(TosAcceptanceParams) _then) = _$TosAcceptanceParamsCopyWithImpl;
@useResult
$Res call({
 String? ip, String? data
});




}
/// @nodoc
class _$TosAcceptanceParamsCopyWithImpl<$Res>
    implements $TosAcceptanceParamsCopyWith<$Res> {
  _$TosAcceptanceParamsCopyWithImpl(this._self, this._then);

  final TosAcceptanceParams _self;
  final $Res Function(TosAcceptanceParams) _then;

/// Create a copy of TosAcceptanceParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ip = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TosAcceptanceParams].
extension TosAcceptanceParamsPatterns on TosAcceptanceParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TosAcceptanceParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TosAcceptanceParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TosAcceptanceParams value)  $default,){
final _that = this;
switch (_that) {
case _TosAcceptanceParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TosAcceptanceParams value)?  $default,){
final _that = this;
switch (_that) {
case _TosAcceptanceParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? ip,  String? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TosAcceptanceParams() when $default != null:
return $default(_that.ip,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? ip,  String? data)  $default,) {final _that = this;
switch (_that) {
case _TosAcceptanceParams():
return $default(_that.ip,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? ip,  String? data)?  $default,) {final _that = this;
switch (_that) {
case _TosAcceptanceParams() when $default != null:
return $default(_that.ip,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TosAcceptanceParams implements TosAcceptanceParams {
  const _TosAcceptanceParams({this.ip, this.data});
  factory _TosAcceptanceParams.fromJson(Map<String, dynamic> json) => _$TosAcceptanceParamsFromJson(json);

@override final  String? ip;
@override final  String? data;

/// Create a copy of TosAcceptanceParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TosAcceptanceParamsCopyWith<_TosAcceptanceParams> get copyWith => __$TosAcceptanceParamsCopyWithImpl<_TosAcceptanceParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TosAcceptanceParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TosAcceptanceParams&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ip,data);

@override
String toString() {
  return 'TosAcceptanceParams(ip: $ip, data: $data)';
}


}

/// @nodoc
abstract mixin class _$TosAcceptanceParamsCopyWith<$Res> implements $TosAcceptanceParamsCopyWith<$Res> {
  factory _$TosAcceptanceParamsCopyWith(_TosAcceptanceParams value, $Res Function(_TosAcceptanceParams) _then) = __$TosAcceptanceParamsCopyWithImpl;
@override @useResult
$Res call({
 String? ip, String? data
});




}
/// @nodoc
class __$TosAcceptanceParamsCopyWithImpl<$Res>
    implements _$TosAcceptanceParamsCopyWith<$Res> {
  __$TosAcceptanceParamsCopyWithImpl(this._self, this._then);

  final _TosAcceptanceParams _self;
  final $Res Function(_TosAcceptanceParams) _then;

/// Create a copy of TosAcceptanceParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ip = freezed,Object? data = freezed,}) {
  return _then(_TosAcceptanceParams(
ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IndividualParams {

@JsonKey(name: 'first_name_kana') String? get firstNameKana;@JsonKey(name: 'first_name_kanji') String? get firstNameKanji;@JsonKey(name: 'last_name_kana') String? get lastNameKana;@JsonKey(name: 'last_name_kanji') String? get lastNameKanji; DobParams? get dob;@JsonKey(name: 'address_kana') AddressKanaParams? get addressKana;@JsonKey(name: 'address_kanji') AddressKanjiParams? get addressKanji; String? get email; String? get phone;
/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndividualParamsCopyWith<IndividualParams> get copyWith => _$IndividualParamsCopyWithImpl<IndividualParams>(this as IndividualParams, _$identity);

  /// Serializes this IndividualParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndividualParams&&(identical(other.firstNameKana, firstNameKana) || other.firstNameKana == firstNameKana)&&(identical(other.firstNameKanji, firstNameKanji) || other.firstNameKanji == firstNameKanji)&&(identical(other.lastNameKana, lastNameKana) || other.lastNameKana == lastNameKana)&&(identical(other.lastNameKanji, lastNameKanji) || other.lastNameKanji == lastNameKanji)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.addressKana, addressKana) || other.addressKana == addressKana)&&(identical(other.addressKanji, addressKanji) || other.addressKanji == addressKanji)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstNameKana,firstNameKanji,lastNameKana,lastNameKanji,dob,addressKana,addressKanji,email,phone);

@override
String toString() {
  return 'IndividualParams(firstNameKana: $firstNameKana, firstNameKanji: $firstNameKanji, lastNameKana: $lastNameKana, lastNameKanji: $lastNameKanji, dob: $dob, addressKana: $addressKana, addressKanji: $addressKanji, email: $email, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $IndividualParamsCopyWith<$Res>  {
  factory $IndividualParamsCopyWith(IndividualParams value, $Res Function(IndividualParams) _then) = _$IndividualParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'first_name_kana') String? firstNameKana,@JsonKey(name: 'first_name_kanji') String? firstNameKanji,@JsonKey(name: 'last_name_kana') String? lastNameKana,@JsonKey(name: 'last_name_kanji') String? lastNameKanji, DobParams? dob,@JsonKey(name: 'address_kana') AddressKanaParams? addressKana,@JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji, String? email, String? phone
});


$DobParamsCopyWith<$Res>? get dob;$AddressKanaParamsCopyWith<$Res>? get addressKana;$AddressKanjiParamsCopyWith<$Res>? get addressKanji;

}
/// @nodoc
class _$IndividualParamsCopyWithImpl<$Res>
    implements $IndividualParamsCopyWith<$Res> {
  _$IndividualParamsCopyWithImpl(this._self, this._then);

  final IndividualParams _self;
  final $Res Function(IndividualParams) _then;

/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstNameKana = freezed,Object? firstNameKanji = freezed,Object? lastNameKana = freezed,Object? lastNameKanji = freezed,Object? dob = freezed,Object? addressKana = freezed,Object? addressKanji = freezed,Object? email = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
firstNameKana: freezed == firstNameKana ? _self.firstNameKana : firstNameKana // ignore: cast_nullable_to_non_nullable
as String?,firstNameKanji: freezed == firstNameKanji ? _self.firstNameKanji : firstNameKanji // ignore: cast_nullable_to_non_nullable
as String?,lastNameKana: freezed == lastNameKana ? _self.lastNameKana : lastNameKana // ignore: cast_nullable_to_non_nullable
as String?,lastNameKanji: freezed == lastNameKanji ? _self.lastNameKanji : lastNameKanji // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DobParams?,addressKana: freezed == addressKana ? _self.addressKana : addressKana // ignore: cast_nullable_to_non_nullable
as AddressKanaParams?,addressKanji: freezed == addressKanji ? _self.addressKanji : addressKanji // ignore: cast_nullable_to_non_nullable
as AddressKanjiParams?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DobParamsCopyWith<$Res>? get dob {
    if (_self.dob == null) {
    return null;
  }

  return $DobParamsCopyWith<$Res>(_self.dob!, (value) {
    return _then(_self.copyWith(dob: value));
  });
}/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_self.addressKana == null) {
    return null;
  }

  return $AddressKanaParamsCopyWith<$Res>(_self.addressKana!, (value) {
    return _then(_self.copyWith(addressKana: value));
  });
}/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_self.addressKanji == null) {
    return null;
  }

  return $AddressKanjiParamsCopyWith<$Res>(_self.addressKanji!, (value) {
    return _then(_self.copyWith(addressKanji: value));
  });
}
}


/// Adds pattern-matching-related methods to [IndividualParams].
extension IndividualParamsPatterns on IndividualParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IndividualParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IndividualParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IndividualParams value)  $default,){
final _that = this;
switch (_that) {
case _IndividualParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IndividualParams value)?  $default,){
final _that = this;
switch (_that) {
case _IndividualParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name_kana')  String? firstNameKana, @JsonKey(name: 'first_name_kanji')  String? firstNameKanji, @JsonKey(name: 'last_name_kana')  String? lastNameKana, @JsonKey(name: 'last_name_kanji')  String? lastNameKanji,  DobParams? dob, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? email,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IndividualParams() when $default != null:
return $default(_that.firstNameKana,_that.firstNameKanji,_that.lastNameKana,_that.lastNameKanji,_that.dob,_that.addressKana,_that.addressKanji,_that.email,_that.phone);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name_kana')  String? firstNameKana, @JsonKey(name: 'first_name_kanji')  String? firstNameKanji, @JsonKey(name: 'last_name_kana')  String? lastNameKana, @JsonKey(name: 'last_name_kanji')  String? lastNameKanji,  DobParams? dob, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? email,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _IndividualParams():
return $default(_that.firstNameKana,_that.firstNameKanji,_that.lastNameKana,_that.lastNameKanji,_that.dob,_that.addressKana,_that.addressKanji,_that.email,_that.phone);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'first_name_kana')  String? firstNameKana, @JsonKey(name: 'first_name_kanji')  String? firstNameKanji, @JsonKey(name: 'last_name_kana')  String? lastNameKana, @JsonKey(name: 'last_name_kanji')  String? lastNameKanji,  DobParams? dob, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? email,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _IndividualParams() when $default != null:
return $default(_that.firstNameKana,_that.firstNameKanji,_that.lastNameKana,_that.lastNameKanji,_that.dob,_that.addressKana,_that.addressKanji,_that.email,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IndividualParams implements IndividualParams {
  const _IndividualParams({@JsonKey(name: 'first_name_kana') this.firstNameKana, @JsonKey(name: 'first_name_kanji') this.firstNameKanji, @JsonKey(name: 'last_name_kana') this.lastNameKana, @JsonKey(name: 'last_name_kanji') this.lastNameKanji, this.dob, @JsonKey(name: 'address_kana') this.addressKana, @JsonKey(name: 'address_kanji') this.addressKanji, this.email, this.phone});
  factory _IndividualParams.fromJson(Map<String, dynamic> json) => _$IndividualParamsFromJson(json);

@override@JsonKey(name: 'first_name_kana') final  String? firstNameKana;
@override@JsonKey(name: 'first_name_kanji') final  String? firstNameKanji;
@override@JsonKey(name: 'last_name_kana') final  String? lastNameKana;
@override@JsonKey(name: 'last_name_kanji') final  String? lastNameKanji;
@override final  DobParams? dob;
@override@JsonKey(name: 'address_kana') final  AddressKanaParams? addressKana;
@override@JsonKey(name: 'address_kanji') final  AddressKanjiParams? addressKanji;
@override final  String? email;
@override final  String? phone;

/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndividualParamsCopyWith<_IndividualParams> get copyWith => __$IndividualParamsCopyWithImpl<_IndividualParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IndividualParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndividualParams&&(identical(other.firstNameKana, firstNameKana) || other.firstNameKana == firstNameKana)&&(identical(other.firstNameKanji, firstNameKanji) || other.firstNameKanji == firstNameKanji)&&(identical(other.lastNameKana, lastNameKana) || other.lastNameKana == lastNameKana)&&(identical(other.lastNameKanji, lastNameKanji) || other.lastNameKanji == lastNameKanji)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.addressKana, addressKana) || other.addressKana == addressKana)&&(identical(other.addressKanji, addressKanji) || other.addressKanji == addressKanji)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstNameKana,firstNameKanji,lastNameKana,lastNameKanji,dob,addressKana,addressKanji,email,phone);

@override
String toString() {
  return 'IndividualParams(firstNameKana: $firstNameKana, firstNameKanji: $firstNameKanji, lastNameKana: $lastNameKana, lastNameKanji: $lastNameKanji, dob: $dob, addressKana: $addressKana, addressKanji: $addressKanji, email: $email, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$IndividualParamsCopyWith<$Res> implements $IndividualParamsCopyWith<$Res> {
  factory _$IndividualParamsCopyWith(_IndividualParams value, $Res Function(_IndividualParams) _then) = __$IndividualParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'first_name_kana') String? firstNameKana,@JsonKey(name: 'first_name_kanji') String? firstNameKanji,@JsonKey(name: 'last_name_kana') String? lastNameKana,@JsonKey(name: 'last_name_kanji') String? lastNameKanji, DobParams? dob,@JsonKey(name: 'address_kana') AddressKanaParams? addressKana,@JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji, String? email, String? phone
});


@override $DobParamsCopyWith<$Res>? get dob;@override $AddressKanaParamsCopyWith<$Res>? get addressKana;@override $AddressKanjiParamsCopyWith<$Res>? get addressKanji;

}
/// @nodoc
class __$IndividualParamsCopyWithImpl<$Res>
    implements _$IndividualParamsCopyWith<$Res> {
  __$IndividualParamsCopyWithImpl(this._self, this._then);

  final _IndividualParams _self;
  final $Res Function(_IndividualParams) _then;

/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstNameKana = freezed,Object? firstNameKanji = freezed,Object? lastNameKana = freezed,Object? lastNameKanji = freezed,Object? dob = freezed,Object? addressKana = freezed,Object? addressKanji = freezed,Object? email = freezed,Object? phone = freezed,}) {
  return _then(_IndividualParams(
firstNameKana: freezed == firstNameKana ? _self.firstNameKana : firstNameKana // ignore: cast_nullable_to_non_nullable
as String?,firstNameKanji: freezed == firstNameKanji ? _self.firstNameKanji : firstNameKanji // ignore: cast_nullable_to_non_nullable
as String?,lastNameKana: freezed == lastNameKana ? _self.lastNameKana : lastNameKana // ignore: cast_nullable_to_non_nullable
as String?,lastNameKanji: freezed == lastNameKanji ? _self.lastNameKanji : lastNameKanji // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DobParams?,addressKana: freezed == addressKana ? _self.addressKana : addressKana // ignore: cast_nullable_to_non_nullable
as AddressKanaParams?,addressKanji: freezed == addressKanji ? _self.addressKanji : addressKanji // ignore: cast_nullable_to_non_nullable
as AddressKanjiParams?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DobParamsCopyWith<$Res>? get dob {
    if (_self.dob == null) {
    return null;
  }

  return $DobParamsCopyWith<$Res>(_self.dob!, (value) {
    return _then(_self.copyWith(dob: value));
  });
}/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_self.addressKana == null) {
    return null;
  }

  return $AddressKanaParamsCopyWith<$Res>(_self.addressKana!, (value) {
    return _then(_self.copyWith(addressKana: value));
  });
}/// Create a copy of IndividualParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_self.addressKanji == null) {
    return null;
  }

  return $AddressKanjiParamsCopyWith<$Res>(_self.addressKanji!, (value) {
    return _then(_self.copyWith(addressKanji: value));
  });
}
}


/// @nodoc
mixin _$CompanyParams {

 String? get name;// 法人の場合必須 //ローマ字または英語表記
@JsonKey(name: 'name_kana') String? get nameKana;// 法人の場合必須
@JsonKey(name: 'name_kanji') String? get nameKanji;// 法人の場合必須
@JsonKey(name: 'address_kana') AddressKanaParams? get addressKana;@JsonKey(name: 'address_kanji') AddressKanjiParams? get addressKanji; String? get phone; String? get taxId;
/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyParamsCopyWith<CompanyParams> get copyWith => _$CompanyParamsCopyWithImpl<CompanyParams>(this as CompanyParams, _$identity);

  /// Serializes this CompanyParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyParams&&(identical(other.name, name) || other.name == name)&&(identical(other.nameKana, nameKana) || other.nameKana == nameKana)&&(identical(other.nameKanji, nameKanji) || other.nameKanji == nameKanji)&&(identical(other.addressKana, addressKana) || other.addressKana == addressKana)&&(identical(other.addressKanji, addressKanji) || other.addressKanji == addressKanji)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,nameKana,nameKanji,addressKana,addressKanji,phone,taxId);

@override
String toString() {
  return 'CompanyParams(name: $name, nameKana: $nameKana, nameKanji: $nameKanji, addressKana: $addressKana, addressKanji: $addressKanji, phone: $phone, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class $CompanyParamsCopyWith<$Res>  {
  factory $CompanyParamsCopyWith(CompanyParams value, $Res Function(CompanyParams) _then) = _$CompanyParamsCopyWithImpl;
@useResult
$Res call({
 String? name,@JsonKey(name: 'name_kana') String? nameKana,@JsonKey(name: 'name_kanji') String? nameKanji,@JsonKey(name: 'address_kana') AddressKanaParams? addressKana,@JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji, String? phone, String? taxId
});


$AddressKanaParamsCopyWith<$Res>? get addressKana;$AddressKanjiParamsCopyWith<$Res>? get addressKanji;

}
/// @nodoc
class _$CompanyParamsCopyWithImpl<$Res>
    implements $CompanyParamsCopyWith<$Res> {
  _$CompanyParamsCopyWithImpl(this._self, this._then);

  final CompanyParams _self;
  final $Res Function(CompanyParams) _then;

/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? nameKana = freezed,Object? nameKanji = freezed,Object? addressKana = freezed,Object? addressKanji = freezed,Object? phone = freezed,Object? taxId = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameKana: freezed == nameKana ? _self.nameKana : nameKana // ignore: cast_nullable_to_non_nullable
as String?,nameKanji: freezed == nameKanji ? _self.nameKanji : nameKanji // ignore: cast_nullable_to_non_nullable
as String?,addressKana: freezed == addressKana ? _self.addressKana : addressKana // ignore: cast_nullable_to_non_nullable
as AddressKanaParams?,addressKanji: freezed == addressKanji ? _self.addressKanji : addressKanji // ignore: cast_nullable_to_non_nullable
as AddressKanjiParams?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_self.addressKana == null) {
    return null;
  }

  return $AddressKanaParamsCopyWith<$Res>(_self.addressKana!, (value) {
    return _then(_self.copyWith(addressKana: value));
  });
}/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_self.addressKanji == null) {
    return null;
  }

  return $AddressKanjiParamsCopyWith<$Res>(_self.addressKanji!, (value) {
    return _then(_self.copyWith(addressKanji: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompanyParams].
extension CompanyParamsPatterns on CompanyParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyParams value)  $default,){
final _that = this;
switch (_that) {
case _CompanyParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyParams value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name, @JsonKey(name: 'name_kana')  String? nameKana, @JsonKey(name: 'name_kanji')  String? nameKanji, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? phone,  String? taxId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyParams() when $default != null:
return $default(_that.name,_that.nameKana,_that.nameKanji,_that.addressKana,_that.addressKanji,_that.phone,_that.taxId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name, @JsonKey(name: 'name_kana')  String? nameKana, @JsonKey(name: 'name_kanji')  String? nameKanji, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? phone,  String? taxId)  $default,) {final _that = this;
switch (_that) {
case _CompanyParams():
return $default(_that.name,_that.nameKana,_that.nameKanji,_that.addressKana,_that.addressKanji,_that.phone,_that.taxId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name, @JsonKey(name: 'name_kana')  String? nameKana, @JsonKey(name: 'name_kanji')  String? nameKanji, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? phone,  String? taxId)?  $default,) {final _that = this;
switch (_that) {
case _CompanyParams() when $default != null:
return $default(_that.name,_that.nameKana,_that.nameKanji,_that.addressKana,_that.addressKanji,_that.phone,_that.taxId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyParams implements CompanyParams {
  const _CompanyParams({this.name, @JsonKey(name: 'name_kana') this.nameKana, @JsonKey(name: 'name_kanji') this.nameKanji, @JsonKey(name: 'address_kana') this.addressKana, @JsonKey(name: 'address_kanji') this.addressKanji, this.phone, this.taxId});
  factory _CompanyParams.fromJson(Map<String, dynamic> json) => _$CompanyParamsFromJson(json);

@override final  String? name;
// 法人の場合必須 //ローマ字または英語表記
@override@JsonKey(name: 'name_kana') final  String? nameKana;
// 法人の場合必須
@override@JsonKey(name: 'name_kanji') final  String? nameKanji;
// 法人の場合必須
@override@JsonKey(name: 'address_kana') final  AddressKanaParams? addressKana;
@override@JsonKey(name: 'address_kanji') final  AddressKanjiParams? addressKanji;
@override final  String? phone;
@override final  String? taxId;

/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyParamsCopyWith<_CompanyParams> get copyWith => __$CompanyParamsCopyWithImpl<_CompanyParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyParams&&(identical(other.name, name) || other.name == name)&&(identical(other.nameKana, nameKana) || other.nameKana == nameKana)&&(identical(other.nameKanji, nameKanji) || other.nameKanji == nameKanji)&&(identical(other.addressKana, addressKana) || other.addressKana == addressKana)&&(identical(other.addressKanji, addressKanji) || other.addressKanji == addressKanji)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.taxId, taxId) || other.taxId == taxId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,nameKana,nameKanji,addressKana,addressKanji,phone,taxId);

@override
String toString() {
  return 'CompanyParams(name: $name, nameKana: $nameKana, nameKanji: $nameKanji, addressKana: $addressKana, addressKanji: $addressKanji, phone: $phone, taxId: $taxId)';
}


}

/// @nodoc
abstract mixin class _$CompanyParamsCopyWith<$Res> implements $CompanyParamsCopyWith<$Res> {
  factory _$CompanyParamsCopyWith(_CompanyParams value, $Res Function(_CompanyParams) _then) = __$CompanyParamsCopyWithImpl;
@override @useResult
$Res call({
 String? name,@JsonKey(name: 'name_kana') String? nameKana,@JsonKey(name: 'name_kanji') String? nameKanji,@JsonKey(name: 'address_kana') AddressKanaParams? addressKana,@JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji, String? phone, String? taxId
});


@override $AddressKanaParamsCopyWith<$Res>? get addressKana;@override $AddressKanjiParamsCopyWith<$Res>? get addressKanji;

}
/// @nodoc
class __$CompanyParamsCopyWithImpl<$Res>
    implements _$CompanyParamsCopyWith<$Res> {
  __$CompanyParamsCopyWithImpl(this._self, this._then);

  final _CompanyParams _self;
  final $Res Function(_CompanyParams) _then;

/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? nameKana = freezed,Object? nameKanji = freezed,Object? addressKana = freezed,Object? addressKanji = freezed,Object? phone = freezed,Object? taxId = freezed,}) {
  return _then(_CompanyParams(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nameKana: freezed == nameKana ? _self.nameKana : nameKana // ignore: cast_nullable_to_non_nullable
as String?,nameKanji: freezed == nameKanji ? _self.nameKanji : nameKanji // ignore: cast_nullable_to_non_nullable
as String?,addressKana: freezed == addressKana ? _self.addressKana : addressKana // ignore: cast_nullable_to_non_nullable
as AddressKanaParams?,addressKanji: freezed == addressKanji ? _self.addressKanji : addressKanji // ignore: cast_nullable_to_non_nullable
as AddressKanjiParams?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,taxId: freezed == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_self.addressKana == null) {
    return null;
  }

  return $AddressKanaParamsCopyWith<$Res>(_self.addressKana!, (value) {
    return _then(_self.copyWith(addressKana: value));
  });
}/// Create a copy of CompanyParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_self.addressKanji == null) {
    return null;
  }

  return $AddressKanjiParamsCopyWith<$Res>(_self.addressKanji!, (value) {
    return _then(_self.copyWith(addressKanji: value));
  });
}
}


/// @nodoc
mixin _$RepresentativeParams {

@JsonKey(name: 'first_name_kana') String? get firstNameKana;@JsonKey(name: 'first_name_kanji') String? get firstNameKanji;@JsonKey(name: 'last_name_kana') String? get lastNameKana;@JsonKey(name: 'last_name_kanji') String? get lastNameKanji; DobParams? get dob;@JsonKey(name: 'address_kana') AddressKanaParams? get addressKana;@JsonKey(name: 'address_kanji') AddressKanjiParams? get addressKanji; String? get email; String? get phone;
/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RepresentativeParamsCopyWith<RepresentativeParams> get copyWith => _$RepresentativeParamsCopyWithImpl<RepresentativeParams>(this as RepresentativeParams, _$identity);

  /// Serializes this RepresentativeParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RepresentativeParams&&(identical(other.firstNameKana, firstNameKana) || other.firstNameKana == firstNameKana)&&(identical(other.firstNameKanji, firstNameKanji) || other.firstNameKanji == firstNameKanji)&&(identical(other.lastNameKana, lastNameKana) || other.lastNameKana == lastNameKana)&&(identical(other.lastNameKanji, lastNameKanji) || other.lastNameKanji == lastNameKanji)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.addressKana, addressKana) || other.addressKana == addressKana)&&(identical(other.addressKanji, addressKanji) || other.addressKanji == addressKanji)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstNameKana,firstNameKanji,lastNameKana,lastNameKanji,dob,addressKana,addressKanji,email,phone);

@override
String toString() {
  return 'RepresentativeParams(firstNameKana: $firstNameKana, firstNameKanji: $firstNameKanji, lastNameKana: $lastNameKana, lastNameKanji: $lastNameKanji, dob: $dob, addressKana: $addressKana, addressKanji: $addressKanji, email: $email, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $RepresentativeParamsCopyWith<$Res>  {
  factory $RepresentativeParamsCopyWith(RepresentativeParams value, $Res Function(RepresentativeParams) _then) = _$RepresentativeParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'first_name_kana') String? firstNameKana,@JsonKey(name: 'first_name_kanji') String? firstNameKanji,@JsonKey(name: 'last_name_kana') String? lastNameKana,@JsonKey(name: 'last_name_kanji') String? lastNameKanji, DobParams? dob,@JsonKey(name: 'address_kana') AddressKanaParams? addressKana,@JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji, String? email, String? phone
});


$DobParamsCopyWith<$Res>? get dob;$AddressKanaParamsCopyWith<$Res>? get addressKana;$AddressKanjiParamsCopyWith<$Res>? get addressKanji;

}
/// @nodoc
class _$RepresentativeParamsCopyWithImpl<$Res>
    implements $RepresentativeParamsCopyWith<$Res> {
  _$RepresentativeParamsCopyWithImpl(this._self, this._then);

  final RepresentativeParams _self;
  final $Res Function(RepresentativeParams) _then;

/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstNameKana = freezed,Object? firstNameKanji = freezed,Object? lastNameKana = freezed,Object? lastNameKanji = freezed,Object? dob = freezed,Object? addressKana = freezed,Object? addressKanji = freezed,Object? email = freezed,Object? phone = freezed,}) {
  return _then(_self.copyWith(
firstNameKana: freezed == firstNameKana ? _self.firstNameKana : firstNameKana // ignore: cast_nullable_to_non_nullable
as String?,firstNameKanji: freezed == firstNameKanji ? _self.firstNameKanji : firstNameKanji // ignore: cast_nullable_to_non_nullable
as String?,lastNameKana: freezed == lastNameKana ? _self.lastNameKana : lastNameKana // ignore: cast_nullable_to_non_nullable
as String?,lastNameKanji: freezed == lastNameKanji ? _self.lastNameKanji : lastNameKanji // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DobParams?,addressKana: freezed == addressKana ? _self.addressKana : addressKana // ignore: cast_nullable_to_non_nullable
as AddressKanaParams?,addressKanji: freezed == addressKanji ? _self.addressKanji : addressKanji // ignore: cast_nullable_to_non_nullable
as AddressKanjiParams?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DobParamsCopyWith<$Res>? get dob {
    if (_self.dob == null) {
    return null;
  }

  return $DobParamsCopyWith<$Res>(_self.dob!, (value) {
    return _then(_self.copyWith(dob: value));
  });
}/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_self.addressKana == null) {
    return null;
  }

  return $AddressKanaParamsCopyWith<$Res>(_self.addressKana!, (value) {
    return _then(_self.copyWith(addressKana: value));
  });
}/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_self.addressKanji == null) {
    return null;
  }

  return $AddressKanjiParamsCopyWith<$Res>(_self.addressKanji!, (value) {
    return _then(_self.copyWith(addressKanji: value));
  });
}
}


/// Adds pattern-matching-related methods to [RepresentativeParams].
extension RepresentativeParamsPatterns on RepresentativeParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RepresentativeParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RepresentativeParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RepresentativeParams value)  $default,){
final _that = this;
switch (_that) {
case _RepresentativeParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RepresentativeParams value)?  $default,){
final _that = this;
switch (_that) {
case _RepresentativeParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name_kana')  String? firstNameKana, @JsonKey(name: 'first_name_kanji')  String? firstNameKanji, @JsonKey(name: 'last_name_kana')  String? lastNameKana, @JsonKey(name: 'last_name_kanji')  String? lastNameKanji,  DobParams? dob, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? email,  String? phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RepresentativeParams() when $default != null:
return $default(_that.firstNameKana,_that.firstNameKanji,_that.lastNameKana,_that.lastNameKanji,_that.dob,_that.addressKana,_that.addressKanji,_that.email,_that.phone);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'first_name_kana')  String? firstNameKana, @JsonKey(name: 'first_name_kanji')  String? firstNameKanji, @JsonKey(name: 'last_name_kana')  String? lastNameKana, @JsonKey(name: 'last_name_kanji')  String? lastNameKanji,  DobParams? dob, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? email,  String? phone)  $default,) {final _that = this;
switch (_that) {
case _RepresentativeParams():
return $default(_that.firstNameKana,_that.firstNameKanji,_that.lastNameKana,_that.lastNameKanji,_that.dob,_that.addressKana,_that.addressKanji,_that.email,_that.phone);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'first_name_kana')  String? firstNameKana, @JsonKey(name: 'first_name_kanji')  String? firstNameKanji, @JsonKey(name: 'last_name_kana')  String? lastNameKana, @JsonKey(name: 'last_name_kanji')  String? lastNameKanji,  DobParams? dob, @JsonKey(name: 'address_kana')  AddressKanaParams? addressKana, @JsonKey(name: 'address_kanji')  AddressKanjiParams? addressKanji,  String? email,  String? phone)?  $default,) {final _that = this;
switch (_that) {
case _RepresentativeParams() when $default != null:
return $default(_that.firstNameKana,_that.firstNameKanji,_that.lastNameKana,_that.lastNameKanji,_that.dob,_that.addressKana,_that.addressKanji,_that.email,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RepresentativeParams implements RepresentativeParams {
  const _RepresentativeParams({@JsonKey(name: 'first_name_kana') this.firstNameKana, @JsonKey(name: 'first_name_kanji') this.firstNameKanji, @JsonKey(name: 'last_name_kana') this.lastNameKana, @JsonKey(name: 'last_name_kanji') this.lastNameKanji, this.dob, @JsonKey(name: 'address_kana') this.addressKana, @JsonKey(name: 'address_kanji') this.addressKanji, this.email, this.phone});
  factory _RepresentativeParams.fromJson(Map<String, dynamic> json) => _$RepresentativeParamsFromJson(json);

@override@JsonKey(name: 'first_name_kana') final  String? firstNameKana;
@override@JsonKey(name: 'first_name_kanji') final  String? firstNameKanji;
@override@JsonKey(name: 'last_name_kana') final  String? lastNameKana;
@override@JsonKey(name: 'last_name_kanji') final  String? lastNameKanji;
@override final  DobParams? dob;
@override@JsonKey(name: 'address_kana') final  AddressKanaParams? addressKana;
@override@JsonKey(name: 'address_kanji') final  AddressKanjiParams? addressKanji;
@override final  String? email;
@override final  String? phone;

/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RepresentativeParamsCopyWith<_RepresentativeParams> get copyWith => __$RepresentativeParamsCopyWithImpl<_RepresentativeParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RepresentativeParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RepresentativeParams&&(identical(other.firstNameKana, firstNameKana) || other.firstNameKana == firstNameKana)&&(identical(other.firstNameKanji, firstNameKanji) || other.firstNameKanji == firstNameKanji)&&(identical(other.lastNameKana, lastNameKana) || other.lastNameKana == lastNameKana)&&(identical(other.lastNameKanji, lastNameKanji) || other.lastNameKanji == lastNameKanji)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.addressKana, addressKana) || other.addressKana == addressKana)&&(identical(other.addressKanji, addressKanji) || other.addressKanji == addressKanji)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstNameKana,firstNameKanji,lastNameKana,lastNameKanji,dob,addressKana,addressKanji,email,phone);

@override
String toString() {
  return 'RepresentativeParams(firstNameKana: $firstNameKana, firstNameKanji: $firstNameKanji, lastNameKana: $lastNameKana, lastNameKanji: $lastNameKanji, dob: $dob, addressKana: $addressKana, addressKanji: $addressKanji, email: $email, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$RepresentativeParamsCopyWith<$Res> implements $RepresentativeParamsCopyWith<$Res> {
  factory _$RepresentativeParamsCopyWith(_RepresentativeParams value, $Res Function(_RepresentativeParams) _then) = __$RepresentativeParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'first_name_kana') String? firstNameKana,@JsonKey(name: 'first_name_kanji') String? firstNameKanji,@JsonKey(name: 'last_name_kana') String? lastNameKana,@JsonKey(name: 'last_name_kanji') String? lastNameKanji, DobParams? dob,@JsonKey(name: 'address_kana') AddressKanaParams? addressKana,@JsonKey(name: 'address_kanji') AddressKanjiParams? addressKanji, String? email, String? phone
});


@override $DobParamsCopyWith<$Res>? get dob;@override $AddressKanaParamsCopyWith<$Res>? get addressKana;@override $AddressKanjiParamsCopyWith<$Res>? get addressKanji;

}
/// @nodoc
class __$RepresentativeParamsCopyWithImpl<$Res>
    implements _$RepresentativeParamsCopyWith<$Res> {
  __$RepresentativeParamsCopyWithImpl(this._self, this._then);

  final _RepresentativeParams _self;
  final $Res Function(_RepresentativeParams) _then;

/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstNameKana = freezed,Object? firstNameKanji = freezed,Object? lastNameKana = freezed,Object? lastNameKanji = freezed,Object? dob = freezed,Object? addressKana = freezed,Object? addressKanji = freezed,Object? email = freezed,Object? phone = freezed,}) {
  return _then(_RepresentativeParams(
firstNameKana: freezed == firstNameKana ? _self.firstNameKana : firstNameKana // ignore: cast_nullable_to_non_nullable
as String?,firstNameKanji: freezed == firstNameKanji ? _self.firstNameKanji : firstNameKanji // ignore: cast_nullable_to_non_nullable
as String?,lastNameKana: freezed == lastNameKana ? _self.lastNameKana : lastNameKana // ignore: cast_nullable_to_non_nullable
as String?,lastNameKanji: freezed == lastNameKanji ? _self.lastNameKanji : lastNameKanji // ignore: cast_nullable_to_non_nullable
as String?,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as DobParams?,addressKana: freezed == addressKana ? _self.addressKana : addressKana // ignore: cast_nullable_to_non_nullable
as AddressKanaParams?,addressKanji: freezed == addressKanji ? _self.addressKanji : addressKanji // ignore: cast_nullable_to_non_nullable
as AddressKanjiParams?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DobParamsCopyWith<$Res>? get dob {
    if (_self.dob == null) {
    return null;
  }

  return $DobParamsCopyWith<$Res>(_self.dob!, (value) {
    return _then(_self.copyWith(dob: value));
  });
}/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanaParamsCopyWith<$Res>? get addressKana {
    if (_self.addressKana == null) {
    return null;
  }

  return $AddressKanaParamsCopyWith<$Res>(_self.addressKana!, (value) {
    return _then(_self.copyWith(addressKana: value));
  });
}/// Create a copy of RepresentativeParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressKanjiParamsCopyWith<$Res>? get addressKanji {
    if (_self.addressKanji == null) {
    return null;
  }

  return $AddressKanjiParamsCopyWith<$Res>(_self.addressKanji!, (value) {
    return _then(_self.copyWith(addressKanji: value));
  });
}
}


/// @nodoc
mixin _$DobParams {

 String? get day; String? get month; String? get year;
/// Create a copy of DobParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DobParamsCopyWith<DobParams> get copyWith => _$DobParamsCopyWithImpl<DobParams>(this as DobParams, _$identity);

  /// Serializes this DobParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DobParams&&(identical(other.day, day) || other.day == day)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,month,year);

@override
String toString() {
  return 'DobParams(day: $day, month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class $DobParamsCopyWith<$Res>  {
  factory $DobParamsCopyWith(DobParams value, $Res Function(DobParams) _then) = _$DobParamsCopyWithImpl;
@useResult
$Res call({
 String? day, String? month, String? year
});




}
/// @nodoc
class _$DobParamsCopyWithImpl<$Res>
    implements $DobParamsCopyWith<$Res> {
  _$DobParamsCopyWithImpl(this._self, this._then);

  final DobParams _self;
  final $Res Function(DobParams) _then;

/// Create a copy of DobParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = freezed,Object? month = freezed,Object? year = freezed,}) {
  return _then(_self.copyWith(
day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DobParams].
extension DobParamsPatterns on DobParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DobParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DobParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DobParams value)  $default,){
final _that = this;
switch (_that) {
case _DobParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DobParams value)?  $default,){
final _that = this;
switch (_that) {
case _DobParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? day,  String? month,  String? year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DobParams() when $default != null:
return $default(_that.day,_that.month,_that.year);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? day,  String? month,  String? year)  $default,) {final _that = this;
switch (_that) {
case _DobParams():
return $default(_that.day,_that.month,_that.year);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? day,  String? month,  String? year)?  $default,) {final _that = this;
switch (_that) {
case _DobParams() when $default != null:
return $default(_that.day,_that.month,_that.year);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DobParams implements DobParams {
  const _DobParams({this.day, this.month, this.year});
  factory _DobParams.fromJson(Map<String, dynamic> json) => _$DobParamsFromJson(json);

@override final  String? day;
@override final  String? month;
@override final  String? year;

/// Create a copy of DobParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DobParamsCopyWith<_DobParams> get copyWith => __$DobParamsCopyWithImpl<_DobParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DobParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DobParams&&(identical(other.day, day) || other.day == day)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,month,year);

@override
String toString() {
  return 'DobParams(day: $day, month: $month, year: $year)';
}


}

/// @nodoc
abstract mixin class _$DobParamsCopyWith<$Res> implements $DobParamsCopyWith<$Res> {
  factory _$DobParamsCopyWith(_DobParams value, $Res Function(_DobParams) _then) = __$DobParamsCopyWithImpl;
@override @useResult
$Res call({
 String? day, String? month, String? year
});




}
/// @nodoc
class __$DobParamsCopyWithImpl<$Res>
    implements _$DobParamsCopyWith<$Res> {
  __$DobParamsCopyWithImpl(this._self, this._then);

  final _DobParams _self;
  final $Res Function(_DobParams) _then;

/// Create a copy of DobParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = freezed,Object? month = freezed,Object? year = freezed,}) {
  return _then(_DobParams(
day: freezed == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String?,month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AddressKanaParams {

 String? get line1;@JsonKey(name: 'postal_code') String? get postalCode; String? get city; String? get state; String? get town;
/// Create a copy of AddressKanaParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressKanaParamsCopyWith<AddressKanaParams> get copyWith => _$AddressKanaParamsCopyWithImpl<AddressKanaParams>(this as AddressKanaParams, _$identity);

  /// Serializes this AddressKanaParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressKanaParams&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.town, town) || other.town == town));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,postalCode,city,state,town);

@override
String toString() {
  return 'AddressKanaParams(line1: $line1, postalCode: $postalCode, city: $city, state: $state, town: $town)';
}


}

/// @nodoc
abstract mixin class $AddressKanaParamsCopyWith<$Res>  {
  factory $AddressKanaParamsCopyWith(AddressKanaParams value, $Res Function(AddressKanaParams) _then) = _$AddressKanaParamsCopyWithImpl;
@useResult
$Res call({
 String? line1,@JsonKey(name: 'postal_code') String? postalCode, String? city, String? state, String? town
});




}
/// @nodoc
class _$AddressKanaParamsCopyWithImpl<$Res>
    implements $AddressKanaParamsCopyWith<$Res> {
  _$AddressKanaParamsCopyWithImpl(this._self, this._then);

  final AddressKanaParams _self;
  final $Res Function(AddressKanaParams) _then;

/// Create a copy of AddressKanaParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line1 = freezed,Object? postalCode = freezed,Object? city = freezed,Object? state = freezed,Object? town = freezed,}) {
  return _then(_self.copyWith(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,town: freezed == town ? _self.town : town // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressKanaParams].
extension AddressKanaParamsPatterns on AddressKanaParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressKanaParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressKanaParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressKanaParams value)  $default,){
final _that = this;
switch (_that) {
case _AddressKanaParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressKanaParams value)?  $default,){
final _that = this;
switch (_that) {
case _AddressKanaParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? line1, @JsonKey(name: 'postal_code')  String? postalCode,  String? city,  String? state,  String? town)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressKanaParams() when $default != null:
return $default(_that.line1,_that.postalCode,_that.city,_that.state,_that.town);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? line1, @JsonKey(name: 'postal_code')  String? postalCode,  String? city,  String? state,  String? town)  $default,) {final _that = this;
switch (_that) {
case _AddressKanaParams():
return $default(_that.line1,_that.postalCode,_that.city,_that.state,_that.town);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? line1, @JsonKey(name: 'postal_code')  String? postalCode,  String? city,  String? state,  String? town)?  $default,) {final _that = this;
switch (_that) {
case _AddressKanaParams() when $default != null:
return $default(_that.line1,_that.postalCode,_that.city,_that.state,_that.town);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressKanaParams implements AddressKanaParams {
  const _AddressKanaParams({this.line1, @JsonKey(name: 'postal_code') this.postalCode, this.city, this.state, this.town});
  factory _AddressKanaParams.fromJson(Map<String, dynamic> json) => _$AddressKanaParamsFromJson(json);

@override final  String? line1;
@override@JsonKey(name: 'postal_code') final  String? postalCode;
@override final  String? city;
@override final  String? state;
@override final  String? town;

/// Create a copy of AddressKanaParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressKanaParamsCopyWith<_AddressKanaParams> get copyWith => __$AddressKanaParamsCopyWithImpl<_AddressKanaParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressKanaParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressKanaParams&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.town, town) || other.town == town));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,postalCode,city,state,town);

@override
String toString() {
  return 'AddressKanaParams(line1: $line1, postalCode: $postalCode, city: $city, state: $state, town: $town)';
}


}

/// @nodoc
abstract mixin class _$AddressKanaParamsCopyWith<$Res> implements $AddressKanaParamsCopyWith<$Res> {
  factory _$AddressKanaParamsCopyWith(_AddressKanaParams value, $Res Function(_AddressKanaParams) _then) = __$AddressKanaParamsCopyWithImpl;
@override @useResult
$Res call({
 String? line1,@JsonKey(name: 'postal_code') String? postalCode, String? city, String? state, String? town
});




}
/// @nodoc
class __$AddressKanaParamsCopyWithImpl<$Res>
    implements _$AddressKanaParamsCopyWith<$Res> {
  __$AddressKanaParamsCopyWithImpl(this._self, this._then);

  final _AddressKanaParams _self;
  final $Res Function(_AddressKanaParams) _then;

/// Create a copy of AddressKanaParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line1 = freezed,Object? postalCode = freezed,Object? city = freezed,Object? state = freezed,Object? town = freezed,}) {
  return _then(_AddressKanaParams(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,town: freezed == town ? _self.town : town // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AddressKanjiParams {

 String? get line1;@JsonKey(name: 'postal_code') String? get postalCode; String? get city; String? get state; String? get town;
/// Create a copy of AddressKanjiParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressKanjiParamsCopyWith<AddressKanjiParams> get copyWith => _$AddressKanjiParamsCopyWithImpl<AddressKanjiParams>(this as AddressKanjiParams, _$identity);

  /// Serializes this AddressKanjiParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressKanjiParams&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.town, town) || other.town == town));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,postalCode,city,state,town);

@override
String toString() {
  return 'AddressKanjiParams(line1: $line1, postalCode: $postalCode, city: $city, state: $state, town: $town)';
}


}

/// @nodoc
abstract mixin class $AddressKanjiParamsCopyWith<$Res>  {
  factory $AddressKanjiParamsCopyWith(AddressKanjiParams value, $Res Function(AddressKanjiParams) _then) = _$AddressKanjiParamsCopyWithImpl;
@useResult
$Res call({
 String? line1,@JsonKey(name: 'postal_code') String? postalCode, String? city, String? state, String? town
});




}
/// @nodoc
class _$AddressKanjiParamsCopyWithImpl<$Res>
    implements $AddressKanjiParamsCopyWith<$Res> {
  _$AddressKanjiParamsCopyWithImpl(this._self, this._then);

  final AddressKanjiParams _self;
  final $Res Function(AddressKanjiParams) _then;

/// Create a copy of AddressKanjiParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? line1 = freezed,Object? postalCode = freezed,Object? city = freezed,Object? state = freezed,Object? town = freezed,}) {
  return _then(_self.copyWith(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,town: freezed == town ? _self.town : town // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressKanjiParams].
extension AddressKanjiParamsPatterns on AddressKanjiParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressKanjiParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressKanjiParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressKanjiParams value)  $default,){
final _that = this;
switch (_that) {
case _AddressKanjiParams():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressKanjiParams value)?  $default,){
final _that = this;
switch (_that) {
case _AddressKanjiParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? line1, @JsonKey(name: 'postal_code')  String? postalCode,  String? city,  String? state,  String? town)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressKanjiParams() when $default != null:
return $default(_that.line1,_that.postalCode,_that.city,_that.state,_that.town);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? line1, @JsonKey(name: 'postal_code')  String? postalCode,  String? city,  String? state,  String? town)  $default,) {final _that = this;
switch (_that) {
case _AddressKanjiParams():
return $default(_that.line1,_that.postalCode,_that.city,_that.state,_that.town);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? line1, @JsonKey(name: 'postal_code')  String? postalCode,  String? city,  String? state,  String? town)?  $default,) {final _that = this;
switch (_that) {
case _AddressKanjiParams() when $default != null:
return $default(_that.line1,_that.postalCode,_that.city,_that.state,_that.town);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressKanjiParams implements AddressKanjiParams {
  const _AddressKanjiParams({this.line1, @JsonKey(name: 'postal_code') this.postalCode, this.city, this.state, this.town});
  factory _AddressKanjiParams.fromJson(Map<String, dynamic> json) => _$AddressKanjiParamsFromJson(json);

@override final  String? line1;
@override@JsonKey(name: 'postal_code') final  String? postalCode;
@override final  String? city;
@override final  String? state;
@override final  String? town;

/// Create a copy of AddressKanjiParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressKanjiParamsCopyWith<_AddressKanjiParams> get copyWith => __$AddressKanjiParamsCopyWithImpl<_AddressKanjiParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressKanjiParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressKanjiParams&&(identical(other.line1, line1) || other.line1 == line1)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.town, town) || other.town == town));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,line1,postalCode,city,state,town);

@override
String toString() {
  return 'AddressKanjiParams(line1: $line1, postalCode: $postalCode, city: $city, state: $state, town: $town)';
}


}

/// @nodoc
abstract mixin class _$AddressKanjiParamsCopyWith<$Res> implements $AddressKanjiParamsCopyWith<$Res> {
  factory _$AddressKanjiParamsCopyWith(_AddressKanjiParams value, $Res Function(_AddressKanjiParams) _then) = __$AddressKanjiParamsCopyWithImpl;
@override @useResult
$Res call({
 String? line1,@JsonKey(name: 'postal_code') String? postalCode, String? city, String? state, String? town
});




}
/// @nodoc
class __$AddressKanjiParamsCopyWithImpl<$Res>
    implements _$AddressKanjiParamsCopyWith<$Res> {
  __$AddressKanjiParamsCopyWithImpl(this._self, this._then);

  final _AddressKanjiParams _self;
  final $Res Function(_AddressKanjiParams) _then;

/// Create a copy of AddressKanjiParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? line1 = freezed,Object? postalCode = freezed,Object? city = freezed,Object? state = freezed,Object? town = freezed,}) {
  return _then(_AddressKanjiParams(
line1: freezed == line1 ? _self.line1 : line1 // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,town: freezed == town ? _self.town : town // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
