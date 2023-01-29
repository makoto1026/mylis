// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TabState {
  Tab get tab => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TabStateCopyWith<TabState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabStateCopyWith<$Res> {
  factory $TabStateCopyWith(TabState value, $Res Function(TabState) then) =
      _$TabStateCopyWithImpl<$Res, TabState>;
  @useResult
  $Res call({Tab tab});
}

/// @nodoc
class _$TabStateCopyWithImpl<$Res, $Val extends TabState>
    implements $TabStateCopyWith<$Res> {
  _$TabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tab = null,
  }) {
    return _then(_value.copyWith(
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as Tab,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TabStateCopyWith<$Res> implements $TabStateCopyWith<$Res> {
  factory _$$_TabStateCopyWith(
          _$_TabState value, $Res Function(_$_TabState) then) =
      __$$_TabStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Tab tab});
}

/// @nodoc
class __$$_TabStateCopyWithImpl<$Res>
    extends _$TabStateCopyWithImpl<$Res, _$_TabState>
    implements _$$_TabStateCopyWith<$Res> {
  __$$_TabStateCopyWithImpl(
      _$_TabState _value, $Res Function(_$_TabState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tab = null,
  }) {
    return _then(_$_TabState(
      tab: null == tab
          ? _value.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as Tab,
    ));
  }
}

/// @nodoc

class _$_TabState extends _TabState {
  const _$_TabState({required this.tab}) : super._();

  @override
  final Tab tab;

  @override
  String toString() {
    return 'TabState(tab: $tab)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TabState &&
            (identical(other.tab, tab) || other.tab == tab));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tab);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TabStateCopyWith<_$_TabState> get copyWith =>
      __$$_TabStateCopyWithImpl<_$_TabState>(this, _$identity);
}

abstract class _TabState extends TabState {
  const factory _TabState({required final Tab tab}) = _$_TabState;
  const _TabState._() : super._();

  @override
  Tab get tab;
  @override
  @JsonKey(ignore: true)
  _$$_TabStateCopyWith<_$_TabState> get copyWith =>
      throw _privateConstructorUsedError;
}
