// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_article_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeleteArticleState {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  Tag? get tag => throw _privateConstructorUsedError;
  int get setCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeleteArticleStateCopyWith<DeleteArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteArticleStateCopyWith<$Res> {
  factory $DeleteArticleStateCopyWith(
          DeleteArticleState value, $Res Function(DeleteArticleState) then) =
      _$DeleteArticleStateCopyWithImpl<$Res, DeleteArticleState>;
  @useResult
  $Res call({String title, String url, String? memo, Tag? tag, int setCount});
}

/// @nodoc
class _$DeleteArticleStateCopyWithImpl<$Res, $Val extends DeleteArticleState>
    implements $DeleteArticleStateCopyWith<$Res> {
  _$DeleteArticleStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_DeleteArticleStateCopyWith<$Res>
    implements $DeleteArticleStateCopyWith<$Res> {
  factory _$$_DeleteArticleStateCopyWith(_$_DeleteArticleState value,
          $Res Function(_$_DeleteArticleState) then) =
      __$$_DeleteArticleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, String? memo, Tag? tag, int setCount});
}

/// @nodoc
class __$$_DeleteArticleStateCopyWithImpl<$Res>
    extends _$DeleteArticleStateCopyWithImpl<$Res, _$_DeleteArticleState>
    implements _$$_DeleteArticleStateCopyWith<$Res> {
  __$$_DeleteArticleStateCopyWithImpl(
      _$_DeleteArticleState _value, $Res Function(_$_DeleteArticleState) _then)
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
    return _then(_$_DeleteArticleState(
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

class _$_DeleteArticleState extends _DeleteArticleState {
  const _$_DeleteArticleState(
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
    return 'DeleteArticleState(title: $title, url: $url, memo: $memo, tag: $tag, setCount: $setCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeleteArticleState &&
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
  _$$_DeleteArticleStateCopyWith<_$_DeleteArticleState> get copyWith =>
      __$$_DeleteArticleStateCopyWithImpl<_$_DeleteArticleState>(
          this, _$identity);
}

abstract class _DeleteArticleState extends DeleteArticleState {
  const factory _DeleteArticleState(
      {required final String title,
      required final String url,
      final String? memo,
      final Tag? tag,
      required final int setCount}) = _$_DeleteArticleState;
  const _DeleteArticleState._() : super._();

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
  _$$_DeleteArticleStateCopyWith<_$_DeleteArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}
