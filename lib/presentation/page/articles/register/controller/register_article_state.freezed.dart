// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_article_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegisterArticleState {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  Tag? get tag => throw _privateConstructorUsedError;
  int get setCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterArticleStateCopyWith<RegisterArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterArticleStateCopyWith<$Res> {
  factory $RegisterArticleStateCopyWith(RegisterArticleState value,
          $Res Function(RegisterArticleState) then) =
      _$RegisterArticleStateCopyWithImpl<$Res, RegisterArticleState>;
  @useResult
  $Res call({String title, String url, String? memo, Tag? tag, int setCount});
}

/// @nodoc
class _$RegisterArticleStateCopyWithImpl<$Res,
        $Val extends RegisterArticleState>
    implements $RegisterArticleStateCopyWith<$Res> {
  _$RegisterArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? memo = freezed,
    Object? tag = freezed,
    Object? setCount = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      setCount: null == setCount
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterArticleStateCopyWith<$Res>
    implements $RegisterArticleStateCopyWith<$Res> {
  factory _$$_RegisterArticleStateCopyWith(_$_RegisterArticleState value,
          $Res Function(_$_RegisterArticleState) then) =
      __$$_RegisterArticleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, String? memo, Tag? tag, int setCount});
}

/// @nodoc
class __$$_RegisterArticleStateCopyWithImpl<$Res>
    extends _$RegisterArticleStateCopyWithImpl<$Res, _$_RegisterArticleState>
    implements _$$_RegisterArticleStateCopyWith<$Res> {
  __$$_RegisterArticleStateCopyWithImpl(_$_RegisterArticleState _value,
      $Res Function(_$_RegisterArticleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? memo = freezed,
    Object? tag = freezed,
    Object? setCount = null,
  }) {
    return _then(_$_RegisterArticleState(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      setCount: null == setCount
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RegisterArticleState extends _RegisterArticleState {
  const _$_RegisterArticleState(
      {required this.title,
      required this.url,
      this.memo,
      this.tag,
      required this.setCount})
      : super._();

  @override
  final String title;
  @override
  final String url;
  @override
  final String? memo;
  @override
  final Tag? tag;
  @override
  final int setCount;

  @override
  String toString() {
    return 'RegisterArticleState(title: $title, url: $url, memo: $memo, tag: $tag, setCount: $setCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterArticleState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.setCount, setCount) ||
                other.setCount == setCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, url, memo, tag, setCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterArticleStateCopyWith<_$_RegisterArticleState> get copyWith =>
      __$$_RegisterArticleStateCopyWithImpl<_$_RegisterArticleState>(
          this, _$identity);
}

abstract class _RegisterArticleState extends RegisterArticleState {
  const factory _RegisterArticleState(
      {required final String title,
      required final String url,
      final String? memo,
      final Tag? tag,
      required final int setCount}) = _$_RegisterArticleState;
  const _RegisterArticleState._() : super._();

  @override
  String get title;
  @override
  String get url;
  @override
  String? get memo;
  @override
  Tag? get tag;
  @override
  int get setCount;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterArticleStateCopyWith<_$_RegisterArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}
