// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_reference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DocRefModel _$DocRefModelFromJson(Map<String, dynamic> json) {
  return _DocRefModel.fromJson(json);
}

/// @nodoc
mixin _$DocRefModel {
  @DocumentReferenceNullStringConverter()
  String? get docRef => throw _privateConstructorUsedError;

  /// Serializes this DocRefModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocRefModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocRefModelCopyWith<DocRefModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocRefModelCopyWith<$Res> {
  factory $DocRefModelCopyWith(
    DocRefModel value,
    $Res Function(DocRefModel) then,
  ) = _$DocRefModelCopyWithImpl<$Res, DocRefModel>;
  @useResult
  $Res call({@DocumentReferenceNullStringConverter() String? docRef});
}

/// @nodoc
class _$DocRefModelCopyWithImpl<$Res, $Val extends DocRefModel>
    implements $DocRefModelCopyWith<$Res> {
  _$DocRefModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocRefModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? docRef = freezed}) {
    return _then(
      _value.copyWith(
            docRef:
                freezed == docRef
                    ? _value.docRef
                    : docRef // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocRefModelImplCopyWith<$Res>
    implements $DocRefModelCopyWith<$Res> {
  factory _$$DocRefModelImplCopyWith(
    _$DocRefModelImpl value,
    $Res Function(_$DocRefModelImpl) then,
  ) = __$$DocRefModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@DocumentReferenceNullStringConverter() String? docRef});
}

/// @nodoc
class __$$DocRefModelImplCopyWithImpl<$Res>
    extends _$DocRefModelCopyWithImpl<$Res, _$DocRefModelImpl>
    implements _$$DocRefModelImplCopyWith<$Res> {
  __$$DocRefModelImplCopyWithImpl(
    _$DocRefModelImpl _value,
    $Res Function(_$DocRefModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocRefModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? docRef = freezed}) {
    return _then(
      _$DocRefModelImpl(
        freezed == docRef
            ? _value.docRef
            : docRef // ignore: cast_nullable_to_non_nullable
                as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DocRefModelImpl implements _DocRefModel {
  _$DocRefModelImpl(@DocumentReferenceNullStringConverter() this.docRef);

  factory _$DocRefModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocRefModelImplFromJson(json);

  @override
  @DocumentReferenceNullStringConverter()
  final String? docRef;

  @override
  String toString() {
    return 'DocRefModel(docRef: $docRef)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocRefModelImpl &&
            (identical(other.docRef, docRef) || other.docRef == docRef));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, docRef);

  /// Create a copy of DocRefModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocRefModelImplCopyWith<_$DocRefModelImpl> get copyWith =>
      __$$DocRefModelImplCopyWithImpl<_$DocRefModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocRefModelImplToJson(this);
  }
}

abstract class _DocRefModel implements DocRefModel {
  factory _DocRefModel(
    @DocumentReferenceNullStringConverter() final String? docRef,
  ) = _$DocRefModelImpl;

  factory _DocRefModel.fromJson(Map<String, dynamic> json) =
      _$DocRefModelImpl.fromJson;

  @override
  @DocumentReferenceNullStringConverter()
  String? get docRef;

  /// Create a copy of DocRefModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocRefModelImplCopyWith<_$DocRefModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
