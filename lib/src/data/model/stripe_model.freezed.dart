// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LineItem _$LineItemFromJson(Map<String, dynamic> json) {
  return _LineItem.fromJson(json);
}

/// @nodoc
mixin _$LineItem {
  int get quantity => throw _privateConstructorUsedError;
  PriceData get priceDate => throw _privateConstructorUsedError;

  /// Serializes this LineItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LineItemCopyWith<LineItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LineItemCopyWith<$Res> {
  factory $LineItemCopyWith(LineItem value, $Res Function(LineItem) then) =
      _$LineItemCopyWithImpl<$Res, LineItem>;
  @useResult
  $Res call({int quantity, PriceData priceDate});

  $PriceDataCopyWith<$Res> get priceDate;
}

/// @nodoc
class _$LineItemCopyWithImpl<$Res, $Val extends LineItem>
    implements $LineItemCopyWith<$Res> {
  _$LineItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quantity = null, Object? priceDate = null}) {
    return _then(
      _value.copyWith(
            quantity:
                null == quantity
                    ? _value.quantity
                    : quantity // ignore: cast_nullable_to_non_nullable
                        as int,
            priceDate:
                null == priceDate
                    ? _value.priceDate
                    : priceDate // ignore: cast_nullable_to_non_nullable
                        as PriceData,
          )
          as $Val,
    );
  }

  /// Create a copy of LineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PriceDataCopyWith<$Res> get priceDate {
    return $PriceDataCopyWith<$Res>(_value.priceDate, (value) {
      return _then(_value.copyWith(priceDate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LineItemImplCopyWith<$Res>
    implements $LineItemCopyWith<$Res> {
  factory _$$LineItemImplCopyWith(
    _$LineItemImpl value,
    $Res Function(_$LineItemImpl) then,
  ) = __$$LineItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int quantity, PriceData priceDate});

  @override
  $PriceDataCopyWith<$Res> get priceDate;
}

/// @nodoc
class __$$LineItemImplCopyWithImpl<$Res>
    extends _$LineItemCopyWithImpl<$Res, _$LineItemImpl>
    implements _$$LineItemImplCopyWith<$Res> {
  __$$LineItemImplCopyWithImpl(
    _$LineItemImpl _value,
    $Res Function(_$LineItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LineItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? quantity = null, Object? priceDate = null}) {
    return _then(
      _$LineItemImpl(
        quantity:
            null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                    as int,
        priceDate:
            null == priceDate
                ? _value.priceDate
                : priceDate // ignore: cast_nullable_to_non_nullable
                    as PriceData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LineItemImpl implements _LineItem {
  const _$LineItemImpl({required this.quantity, required this.priceDate});

  factory _$LineItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LineItemImplFromJson(json);

  @override
  final int quantity;
  @override
  final PriceData priceDate;

  @override
  String toString() {
    return 'LineItem(quantity: $quantity, priceDate: $priceDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LineItemImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.priceDate, priceDate) ||
                other.priceDate == priceDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quantity, priceDate);

  /// Create a copy of LineItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LineItemImplCopyWith<_$LineItemImpl> get copyWith =>
      __$$LineItemImplCopyWithImpl<_$LineItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LineItemImplToJson(this);
  }
}

abstract class _LineItem implements LineItem {
  const factory _LineItem({
    required final int quantity,
    required final PriceData priceDate,
  }) = _$LineItemImpl;

  factory _LineItem.fromJson(Map<String, dynamic> json) =
      _$LineItemImpl.fromJson;

  @override
  int get quantity;
  @override
  PriceData get priceDate;

  /// Create a copy of LineItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LineItemImplCopyWith<_$LineItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceData _$PriceDataFromJson(Map<String, dynamic> json) {
  return _PriceData.fromJson(json);
}

/// @nodoc
mixin _$PriceData {
  int get unitAmount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  ProductData get productData => throw _privateConstructorUsedError;

  /// Serializes this PriceData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PriceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PriceDataCopyWith<PriceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceDataCopyWith<$Res> {
  factory $PriceDataCopyWith(PriceData value, $Res Function(PriceData) then) =
      _$PriceDataCopyWithImpl<$Res, PriceData>;
  @useResult
  $Res call({int unitAmount, String currency, ProductData productData});

  $ProductDataCopyWith<$Res> get productData;
}

/// @nodoc
class _$PriceDataCopyWithImpl<$Res, $Val extends PriceData>
    implements $PriceDataCopyWith<$Res> {
  _$PriceDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PriceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unitAmount = null,
    Object? currency = null,
    Object? productData = null,
  }) {
    return _then(
      _value.copyWith(
            unitAmount:
                null == unitAmount
                    ? _value.unitAmount
                    : unitAmount // ignore: cast_nullable_to_non_nullable
                        as int,
            currency:
                null == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String,
            productData:
                null == productData
                    ? _value.productData
                    : productData // ignore: cast_nullable_to_non_nullable
                        as ProductData,
          )
          as $Val,
    );
  }

  /// Create a copy of PriceData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductDataCopyWith<$Res> get productData {
    return $ProductDataCopyWith<$Res>(_value.productData, (value) {
      return _then(_value.copyWith(productData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PriceDataImplCopyWith<$Res>
    implements $PriceDataCopyWith<$Res> {
  factory _$$PriceDataImplCopyWith(
    _$PriceDataImpl value,
    $Res Function(_$PriceDataImpl) then,
  ) = __$$PriceDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int unitAmount, String currency, ProductData productData});

  @override
  $ProductDataCopyWith<$Res> get productData;
}

/// @nodoc
class __$$PriceDataImplCopyWithImpl<$Res>
    extends _$PriceDataCopyWithImpl<$Res, _$PriceDataImpl>
    implements _$$PriceDataImplCopyWith<$Res> {
  __$$PriceDataImplCopyWithImpl(
    _$PriceDataImpl _value,
    $Res Function(_$PriceDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PriceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unitAmount = null,
    Object? currency = null,
    Object? productData = null,
  }) {
    return _then(
      _$PriceDataImpl(
        unitAmount:
            null == unitAmount
                ? _value.unitAmount
                : unitAmount // ignore: cast_nullable_to_non_nullable
                    as int,
        currency:
            null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String,
        productData:
            null == productData
                ? _value.productData
                : productData // ignore: cast_nullable_to_non_nullable
                    as ProductData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceDataImpl implements _PriceData {
  _$PriceDataImpl({
    required this.unitAmount,
    required this.currency,
    required this.productData,
  });

  factory _$PriceDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceDataImplFromJson(json);

  @override
  final int unitAmount;
  @override
  final String currency;
  @override
  final ProductData productData;

  @override
  String toString() {
    return 'PriceData(unitAmount: $unitAmount, currency: $currency, productData: $productData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceDataImpl &&
            (identical(other.unitAmount, unitAmount) ||
                other.unitAmount == unitAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.productData, productData) ||
                other.productData == productData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, unitAmount, currency, productData);

  /// Create a copy of PriceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceDataImplCopyWith<_$PriceDataImpl> get copyWith =>
      __$$PriceDataImplCopyWithImpl<_$PriceDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceDataImplToJson(this);
  }
}

abstract class _PriceData implements PriceData {
  factory _PriceData({
    required final int unitAmount,
    required final String currency,
    required final ProductData productData,
  }) = _$PriceDataImpl;

  factory _PriceData.fromJson(Map<String, dynamic> json) =
      _$PriceDataImpl.fromJson;

  @override
  int get unitAmount;
  @override
  String get currency;
  @override
  ProductData get productData;

  /// Create a copy of PriceData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PriceDataImplCopyWith<_$PriceDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductData _$ProductDataFromJson(Map<String, dynamic> json) {
  return _ProductData.fromJson(json);
}

/// @nodoc
mixin _$ProductData {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  MetaData get metaData => throw _privateConstructorUsedError;

  /// Serializes this ProductData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductDataCopyWith<ProductData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDataCopyWith<$Res> {
  factory $ProductDataCopyWith(
    ProductData value,
    $Res Function(ProductData) then,
  ) = _$ProductDataCopyWithImpl<$Res, ProductData>;
  @useResult
  $Res call({
    String name,
    String description,
    List<String> images,
    MetaData metaData,
  });

  $MetaDataCopyWith<$Res> get metaData;
}

/// @nodoc
class _$ProductDataCopyWithImpl<$Res, $Val extends ProductData>
    implements $ProductDataCopyWith<$Res> {
  _$ProductDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? images = null,
    Object? metaData = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            images:
                null == images
                    ? _value.images
                    : images // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            metaData:
                null == metaData
                    ? _value.metaData
                    : metaData // ignore: cast_nullable_to_non_nullable
                        as MetaData,
          )
          as $Val,
    );
  }

  /// Create a copy of ProductData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaDataCopyWith<$Res> get metaData {
    return $MetaDataCopyWith<$Res>(_value.metaData, (value) {
      return _then(_value.copyWith(metaData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductDataImplCopyWith<$Res>
    implements $ProductDataCopyWith<$Res> {
  factory _$$ProductDataImplCopyWith(
    _$ProductDataImpl value,
    $Res Function(_$ProductDataImpl) then,
  ) = __$$ProductDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String description,
    List<String> images,
    MetaData metaData,
  });

  @override
  $MetaDataCopyWith<$Res> get metaData;
}

/// @nodoc
class __$$ProductDataImplCopyWithImpl<$Res>
    extends _$ProductDataCopyWithImpl<$Res, _$ProductDataImpl>
    implements _$$ProductDataImplCopyWith<$Res> {
  __$$ProductDataImplCopyWithImpl(
    _$ProductDataImpl _value,
    $Res Function(_$ProductDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? images = null,
    Object? metaData = null,
  }) {
    return _then(
      _$ProductDataImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        images:
            null == images
                ? _value._images
                : images // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        metaData:
            null == metaData
                ? _value.metaData
                : metaData // ignore: cast_nullable_to_non_nullable
                    as MetaData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductDataImpl implements _ProductData {
  _$ProductDataImpl({
    required this.name,
    required this.description,
    required final List<String> images,
    required this.metaData,
  }) : _images = images;

  factory _$ProductDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductDataImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final MetaData metaData;

  @override
  String toString() {
    return 'ProductData(name: $name, description: $description, images: $images, metaData: $metaData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.metaData, metaData) ||
                other.metaData == metaData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    const DeepCollectionEquality().hash(_images),
    metaData,
  );

  /// Create a copy of ProductData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductDataImplCopyWith<_$ProductDataImpl> get copyWith =>
      __$$ProductDataImplCopyWithImpl<_$ProductDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductDataImplToJson(this);
  }
}

abstract class _ProductData implements ProductData {
  factory _ProductData({
    required final String name,
    required final String description,
    required final List<String> images,
    required final MetaData metaData,
  }) = _$ProductDataImpl;

  factory _ProductData.fromJson(Map<String, dynamic> json) =
      _$ProductDataImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get images;
  @override
  MetaData get metaData;

  /// Create a copy of ProductData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductDataImplCopyWith<_$ProductDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MetaData _$MetaDataFromJson(Map<String, dynamic> json) {
  return _MetaData.fromJson(json);
}

/// @nodoc
mixin _$MetaData {
  String get productId => throw _privateConstructorUsedError;

  /// Serializes this MetaData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetaDataCopyWith<MetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaDataCopyWith<$Res> {
  factory $MetaDataCopyWith(MetaData value, $Res Function(MetaData) then) =
      _$MetaDataCopyWithImpl<$Res, MetaData>;
  @useResult
  $Res call({String productId});
}

/// @nodoc
class _$MetaDataCopyWithImpl<$Res, $Val extends MetaData>
    implements $MetaDataCopyWith<$Res> {
  _$MetaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? productId = null}) {
    return _then(
      _value.copyWith(
            productId:
                null == productId
                    ? _value.productId
                    : productId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MetaDataImplCopyWith<$Res>
    implements $MetaDataCopyWith<$Res> {
  factory _$$MetaDataImplCopyWith(
    _$MetaDataImpl value,
    $Res Function(_$MetaDataImpl) then,
  ) = __$$MetaDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productId});
}

/// @nodoc
class __$$MetaDataImplCopyWithImpl<$Res>
    extends _$MetaDataCopyWithImpl<$Res, _$MetaDataImpl>
    implements _$$MetaDataImplCopyWith<$Res> {
  __$$MetaDataImplCopyWithImpl(
    _$MetaDataImpl _value,
    $Res Function(_$MetaDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? productId = null}) {
    return _then(
      _$MetaDataImpl(
        productId:
            null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MetaDataImpl implements _MetaData {
  _$MetaDataImpl({required this.productId});

  factory _$MetaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetaDataImplFromJson(json);

  @override
  final String productId;

  @override
  String toString() {
    return 'MetaData(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaDataImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaDataImplCopyWith<_$MetaDataImpl> get copyWith =>
      __$$MetaDataImplCopyWithImpl<_$MetaDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetaDataImplToJson(this);
  }
}

abstract class _MetaData implements MetaData {
  factory _MetaData({required final String productId}) = _$MetaDataImpl;

  factory _MetaData.fromJson(Map<String, dynamic> json) =
      _$MetaDataImpl.fromJson;

  @override
  String get productId;

  /// Create a copy of MetaData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetaDataImplCopyWith<_$MetaDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
