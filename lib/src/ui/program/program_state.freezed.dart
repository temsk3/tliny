// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProgramState {
  List<Program> get programList => throw _privateConstructorUsedError;
  bool get addProgramButton => throw _privateConstructorUsedError;
  bool get addStaffButton => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgramStateCopyWith<ProgramState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramStateCopyWith<$Res> {
  factory $ProgramStateCopyWith(
          ProgramState value, $Res Function(ProgramState) then) =
      _$ProgramStateCopyWithImpl<$Res, ProgramState>;
  @useResult
  $Res call(
      {List<Program> programList, bool addProgramButton, bool addStaffButton});
}

/// @nodoc
class _$ProgramStateCopyWithImpl<$Res, $Val extends ProgramState>
    implements $ProgramStateCopyWith<$Res> {
  _$ProgramStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programList = null,
    Object? addProgramButton = null,
    Object? addStaffButton = null,
  }) {
    return _then(_value.copyWith(
      programList: null == programList
          ? _value.programList
          : programList // ignore: cast_nullable_to_non_nullable
              as List<Program>,
      addProgramButton: null == addProgramButton
          ? _value.addProgramButton
          : addProgramButton // ignore: cast_nullable_to_non_nullable
              as bool,
      addStaffButton: null == addStaffButton
          ? _value.addStaffButton
          : addStaffButton // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgramStateCopyWith<$Res>
    implements $ProgramStateCopyWith<$Res> {
  factory _$$_ProgramStateCopyWith(
          _$_ProgramState value, $Res Function(_$_ProgramState) then) =
      __$$_ProgramStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Program> programList, bool addProgramButton, bool addStaffButton});
}

/// @nodoc
class __$$_ProgramStateCopyWithImpl<$Res>
    extends _$ProgramStateCopyWithImpl<$Res, _$_ProgramState>
    implements _$$_ProgramStateCopyWith<$Res> {
  __$$_ProgramStateCopyWithImpl(
      _$_ProgramState _value, $Res Function(_$_ProgramState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programList = null,
    Object? addProgramButton = null,
    Object? addStaffButton = null,
  }) {
    return _then(_$_ProgramState(
      programList: null == programList
          ? _value._programList
          : programList // ignore: cast_nullable_to_non_nullable
              as List<Program>,
      addProgramButton: null == addProgramButton
          ? _value.addProgramButton
          : addProgramButton // ignore: cast_nullable_to_non_nullable
              as bool,
      addStaffButton: null == addStaffButton
          ? _value.addStaffButton
          : addStaffButton // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ProgramState implements _ProgramState {
  const _$_ProgramState(
      {final List<Program> programList = const <Program>[],
      this.addProgramButton = false,
      this.addStaffButton = false})
      : _programList = programList;

  final List<Program> _programList;
  @override
  @JsonKey()
  List<Program> get programList {
    if (_programList is EqualUnmodifiableListView) return _programList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programList);
  }

  @override
  @JsonKey()
  final bool addProgramButton;
  @override
  @JsonKey()
  final bool addStaffButton;

  @override
  String toString() {
    return 'ProgramState(programList: $programList, addProgramButton: $addProgramButton, addStaffButton: $addStaffButton)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgramState &&
            const DeepCollectionEquality()
                .equals(other._programList, _programList) &&
            (identical(other.addProgramButton, addProgramButton) ||
                other.addProgramButton == addProgramButton) &&
            (identical(other.addStaffButton, addStaffButton) ||
                other.addStaffButton == addStaffButton));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_programList),
      addProgramButton,
      addStaffButton);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgramStateCopyWith<_$_ProgramState> get copyWith =>
      __$$_ProgramStateCopyWithImpl<_$_ProgramState>(this, _$identity);
}

abstract class _ProgramState implements ProgramState {
  const factory _ProgramState(
      {final List<Program> programList,
      final bool addProgramButton,
      final bool addStaffButton}) = _$_ProgramState;

  @override
  List<Program> get programList;
  @override
  bool get addProgramButton;
  @override
  bool get addStaffButton;
  @override
  @JsonKey(ignore: true)
  _$$_ProgramStateCopyWith<_$_ProgramState> get copyWith =>
      throw _privateConstructorUsedError;
}
