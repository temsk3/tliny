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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LineItem _$LineItemFromJson(Map<String, dynamic> json) {
  return _LineItem.fromJson(json);
}

/// @nodoc
mixin _$LineItem {
  int get quantity => throw _privateConstructorUsedError;
  PriceData get priceDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? priceDate = null,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      priceDate: null == priceDate
          ? _value.priceDate
          : priceDate // ignore: cast_nullable_to_non_nullable
              as PriceData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceDataCopyWith<$Res> get priceDate {
    return $PriceDataCopyWith<$Res>(_value.priceDate, (value) {
      return _then(_value.copyWith(priceDate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LineItemCopyWith<$Res> implements $LineItemCopyWith<$Res> {
  factory _$$_LineItemCopyWith(
          _$_LineItem value, $Res Function(_$_LineItem) then) =
      __$$_LineItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int quantity, PriceData priceDate});

  @override
  $PriceDataCopyWith<$Res> get priceDate;
}

/// @nodoc
class __$$_LineItemCopyWithImpl<$Res>
    extends _$LineItemCopyWithImpl<$Res, _$_LineItem>
    implements _$$_LineItemCopyWith<$Res> {
  __$$_LineItemCopyWithImpl(
      _$_LineItem _value, $Res Function(_$_LineItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? priceDate = null,
  }) {
    return _then(_$_LineItem(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      priceDate: null == priceDate
          ? _value.priceDate
          : priceDate // ignore: cast_nullable_to_non_nullable
              as PriceData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_LineItem implements _LineItem {
  const _$_LineItem({required this.quantity, required this.priceDate});

  factory _$_LineItem.fromJson(Map<String, dynamic> json) =>
      _$$_LineItemFromJson(json);

  @override
  final int quantity;
  @override
  final PriceData priceDate;

  @override
  String toString() {
    return 'LineItem(quantity: $quantity, priceDate: $priceDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LineItem &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.priceDate, priceDate) ||
                other.priceDate == priceDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, quantity, priceDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LineItemCopyWith<_$_LineItem> get copyWith =>
      __$$_LineItemCopyWithImpl<_$_LineItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LineItemToJson(
      this,
    );
  }
}

abstract class _LineItem implements LineItem {
  const factory _LineItem(
      {required final int quantity,
      required final PriceData priceDate}) = _$_LineItem;

  factory _LineItem.fromJson(Map<String, dynamic> json) = _$_LineItem.fromJson;

  @override
  int get quantity;
  @override
  PriceData get priceDate;
  @override
  @JsonKey(ignore: true)
  _$$_LineItemCopyWith<_$_LineItem> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unitAmount = null,
    Object? currency = null,
    Object? productData = null,
  }) {
    return _then(_value.copyWith(
      unitAmount: null == unitAmount
          ? _value.unitAmount
          : unitAmount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      productData: null == productData
          ? _value.productData
          : productData // ignore: cast_nullable_to_non_nullable
              as ProductData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductDataCopyWith<$Res> get productData {
    return $ProductDataCopyWith<$Res>(_value.productData, (value) {
      return _then(_value.copyWith(productData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PriceDataCopyWith<$Res> implements $PriceDataCopyWith<$Res> {
  factory _$$_PriceDataCopyWith(
          _$_PriceData value, $Res Function(_$_PriceData) then) =
      __$$_PriceDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int unitAmount, String currency, ProductData productData});

  @override
  $ProductDataCopyWith<$Res> get productData;
}

/// @nodoc
class __$$_PriceDataCopyWithImpl<$Res>
    extends _$PriceDataCopyWithImpl<$Res, _$_PriceData>
    implements _$$_PriceDataCopyWith<$Res> {
  __$$_PriceDataCopyWithImpl(
      _$_PriceData _value, $Res Function(_$_PriceData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unitAmount = null,
    Object? currency = null,
    Object? productData = null,
  }) {
    return _then(_$_PriceData(
      unitAmount: null == unitAmount
          ? _value.unitAmount
          : unitAmount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      productData: null == productData
          ? _value.productData
          : productData // ignore: cast_nullable_to_non_nullable
              as ProductData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_PriceData implements _PriceData {
  _$_PriceData(
      {required this.unitAmount,
      required this.currency,
      required this.productData});

  factory _$_PriceData.fromJson(Map<String, dynamic> json) =>
      _$$_PriceDataFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PriceData &&
            (identical(other.unitAmount, unitAmount) ||
                other.unitAmount == unitAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.productData, productData) ||
                other.productData == productData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, unitAmount, currency, productData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PriceDataCopyWith<_$_PriceData> get copyWith =>
      __$$_PriceDataCopyWithImpl<_$_PriceData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PriceDataToJson(
      this,
    );
  }
}

abstract class _PriceData implements PriceData {
  factory _PriceData(
      {required final int unitAmount,
      required final String currency,
      required final ProductData productData}) = _$_PriceData;

  factory _PriceData.fromJson(Map<String, dynamic> json) =
      _$_PriceData.fromJson;

  @override
  int get unitAmount;
  @override
  String get currency;
  @override
  ProductData get productData;
  @override
  @JsonKey(ignore: true)
  _$$_PriceDataCopyWith<_$_PriceData> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductDataCopyWith<ProductData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductDataCopyWith<$Res> {
  factory $ProductDataCopyWith(
          ProductData value, $Res Function(ProductData) then) =
      _$ProductDataCopyWithImpl<$Res, ProductData>;
  @useResult
  $Res call(
      {String name,
      String description,
      List<String> images,
      MetaData metaData});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? images = null,
    Object? metaData = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metaData: null == metaData
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as MetaData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MetaDataCopyWith<$Res> get metaData {
    return $MetaDataCopyWith<$Res>(_value.metaData, (value) {
      return _then(_value.copyWith(metaData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProductDataCopyWith<$Res>
    implements $ProductDataCopyWith<$Res> {
  factory _$$_ProductDataCopyWith(
          _$_ProductData value, $Res Function(_$_ProductData) then) =
      __$$_ProductDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      List<String> images,
      MetaData metaData});

  @override
  $MetaDataCopyWith<$Res> get metaData;
}

/// @nodoc
class __$$_ProductDataCopyWithImpl<$Res>
    extends _$ProductDataCopyWithImpl<$Res, _$_ProductData>
    implements _$$_ProductDataCopyWith<$Res> {
  __$$_ProductDataCopyWithImpl(
      _$_ProductData _value, $Res Function(_$_ProductData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? images = null,
    Object? metaData = null,
  }) {
    return _then(_$_ProductData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metaData: null == metaData
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as MetaData,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_ProductData implements _ProductData {
  _$_ProductData(
      {required this.name,
      required this.description,
      required final List<String> images,
      required this.metaData})
      : _images = images;

  factory _$_ProductData.fromJson(Map<String, dynamic> json) =>
      _$$_ProductDataFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductData &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.metaData, metaData) ||
                other.metaData == metaData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description,
      const DeepCollectionEquality().hash(_images), metaData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductDataCopyWith<_$_ProductData> get copyWith =>
      __$$_ProductDataCopyWithImpl<_$_ProductData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductDataToJson(
      this,
    );
  }
}

abstract class _ProductData implements ProductData {
  factory _ProductData(
      {required final String name,
      required final String description,
      required final List<String> images,
      required final MetaData metaData}) = _$_ProductData;

  factory _ProductData.fromJson(Map<String, dynamic> json) =
      _$_ProductData.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get images;
  @override
  MetaData get metaData;
  @override
  @JsonKey(ignore: true)
  _$$_ProductDataCopyWith<_$_ProductData> get copyWith =>
      throw _privateConstructorUsedError;
}

MetaData _$MetaDataFromJson(Map<String, dynamic> json) {
  return _MetaData.fromJson(json);
}

/// @nodoc
mixin _$MetaData {
  String get productId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MetaDataCopyWith<$Res> implements $MetaDataCopyWith<$Res> {
  factory _$$_MetaDataCopyWith(
          _$_MetaData value, $Res Function(_$_MetaData) then) =
      __$$_MetaDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String productId});
}

/// @nodoc
class __$$_MetaDataCopyWithImpl<$Res>
    extends _$MetaDataCopyWithImpl<$Res, _$_MetaData>
    implements _$$_MetaDataCopyWith<$Res> {
  __$$_MetaDataCopyWithImpl(
      _$_MetaData _value, $Res Function(_$_MetaData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_$_MetaData(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_MetaData implements _MetaData {
  _$_MetaData({required this.productId});

  factory _$_MetaData.fromJson(Map<String, dynamic> json) =>
      _$$_MetaDataFromJson(json);

  @override
  final String productId;

  @override
  String toString() {
    return 'MetaData(productId: $productId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MetaData &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, productId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MetaDataCopyWith<_$_MetaData> get copyWith =>
      __$$_MetaDataCopyWithImpl<_$_MetaData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MetaDataToJson(
      this,
    );
  }
}

abstract class _MetaData implements MetaData {
  factory _MetaData({required final String productId}) = _$_MetaData;

  factory _MetaData.fromJson(Map<String, dynamic> json) = _$_MetaData.fromJson;

  @override
  String get productId;
  @override
  @JsonKey(ignore: true)
  _$$_MetaDataCopyWith<_$_MetaData> get copyWith =>
      throw _privateConstructorUsedError;
}
