// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MemoState {
  List<Memo> get memoList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemoStateCopyWith<MemoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoStateCopyWith<$Res> {
  factory $MemoStateCopyWith(MemoState value, $Res Function(MemoState) then) =
      _$MemoStateCopyWithImpl<$Res, MemoState>;
  @useResult
  $Res call({List<Memo> memoList});
}

/// @nodoc
class _$MemoStateCopyWithImpl<$Res, $Val extends MemoState>
    implements $MemoStateCopyWith<$Res> {
  _$MemoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoList = null,
  }) {
    return _then(_value.copyWith(
      memoList: null == memoList
          ? _value.memoList
          : memoList // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MemoStateCopyWith<$Res> implements $MemoStateCopyWith<$Res> {
  factory _$$_MemoStateCopyWith(
          _$_MemoState value, $Res Function(_$_MemoState) then) =
      __$$_MemoStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Memo> memoList});
}

/// @nodoc
class __$$_MemoStateCopyWithImpl<$Res>
    extends _$MemoStateCopyWithImpl<$Res, _$_MemoState>
    implements _$$_MemoStateCopyWith<$Res> {
  __$$_MemoStateCopyWithImpl(
      _$_MemoState _value, $Res Function(_$_MemoState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoList = null,
  }) {
    return _then(_$_MemoState(
      memoList: null == memoList
          ? _value._memoList
          : memoList // ignore: cast_nullable_to_non_nullable
              as List<Memo>,
    ));
  }
}

/// @nodoc

class _$_MemoState extends _MemoState {
  const _$_MemoState({required final List<Memo> memoList})
      : _memoList = memoList,
        super._();

  final List<Memo> _memoList;
  @override
  List<Memo> get memoList {
    if (_memoList is EqualUnmodifiableListView) return _memoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memoList);
  }

  @override
  String toString() {
    return 'MemoState(memoList: $memoList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MemoState &&
            const DeepCollectionEquality().equals(other._memoList, _memoList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_memoList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MemoStateCopyWith<_$_MemoState> get copyWith =>
      __$$_MemoStateCopyWithImpl<_$_MemoState>(this, _$identity);
}

abstract class _MemoState extends MemoState {
  const factory _MemoState({required final List<Memo> memoList}) = _$_MemoState;
  const _MemoState._() : super._();

  @override
  List<Memo> get memoList;
  @override
  @JsonKey(ignore: true)
  _$$_MemoStateCopyWith<_$_MemoState> get copyWith =>
      throw _privateConstructorUsedError;
}
