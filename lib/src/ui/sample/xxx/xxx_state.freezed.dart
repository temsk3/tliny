// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'xxx_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$XxxState {
  List<Xxx> get xxxList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $XxxStateCopyWith<XxxState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XxxStateCopyWith<$Res> {
  factory $XxxStateCopyWith(XxxState value, $Res Function(XxxState) then) =
      _$XxxStateCopyWithImpl<$Res, XxxState>;
  @useResult
  $Res call({List<Xxx> xxxList});
}

/// @nodoc
class _$XxxStateCopyWithImpl<$Res, $Val extends XxxState>
    implements $XxxStateCopyWith<$Res> {
  _$XxxStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xxxList = null,
  }) {
    return _then(_value.copyWith(
      xxxList: null == xxxList
          ? _value.xxxList
          : xxxList // ignore: cast_nullable_to_non_nullable
              as List<Xxx>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_XxxStateCopyWith<$Res> implements $XxxStateCopyWith<$Res> {
  factory _$$_XxxStateCopyWith(
          _$_XxxState value, $Res Function(_$_XxxState) then) =
      __$$_XxxStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Xxx> xxxList});
}

/// @nodoc
class __$$_XxxStateCopyWithImpl<$Res>
    extends _$XxxStateCopyWithImpl<$Res, _$_XxxState>
    implements _$$_XxxStateCopyWith<$Res> {
  __$$_XxxStateCopyWithImpl(
      _$_XxxState _value, $Res Function(_$_XxxState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? xxxList = null,
  }) {
    return _then(_$_XxxState(
      xxxList: null == xxxList
          ? _value._xxxList
          : xxxList // ignore: cast_nullable_to_non_nullable
              as List<Xxx>,
    ));
  }
}

/// @nodoc

class _$_XxxState implements _XxxState {
  const _$_XxxState({final List<Xxx> xxxList = const <Xxx>[]})
      : _xxxList = xxxList;

  final List<Xxx> _xxxList;
  @override
  @JsonKey()
  List<Xxx> get xxxList {
    if (_xxxList is EqualUnmodifiableListView) return _xxxList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_xxxList);
  }

  @override
  String toString() {
    return 'XxxState(xxxList: $xxxList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_XxxState &&
            const DeepCollectionEquality().equals(other._xxxList, _xxxList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_xxxList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_XxxStateCopyWith<_$_XxxState> get copyWith =>
      __$$_XxxStateCopyWithImpl<_$_XxxState>(this, _$identity);
}

abstract class _XxxState implements XxxState {
  const factory _XxxState({final List<Xxx> xxxList}) = _$_XxxState;

  @override
  List<Xxx> get xxxList;
  @override
  @JsonKey(ignore: true)
  _$$_XxxStateCopyWith<_$_XxxState> get copyWith =>
      throw _privateConstructorUsedError;
}
