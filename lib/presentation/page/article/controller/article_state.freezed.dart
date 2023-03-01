// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ArticleState {
  List<Article> get articleList => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  Tag? get tag => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArticleStateCopyWith<ArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleStateCopyWith<$Res> {
  factory $ArticleStateCopyWith(
          ArticleState value, $Res Function(ArticleState) then) =
      _$ArticleStateCopyWithImpl<$Res, ArticleState>;
  @useResult
  $Res call(
      {List<Article> articleList,
      String title,
      String url,
      Tag? tag,
      String? memo});
}

/// @nodoc
class _$ArticleStateCopyWithImpl<$Res, $Val extends ArticleState>
    implements $ArticleStateCopyWith<$Res> {
  _$ArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articleList = null,
    Object? title = null,
    Object? url = null,
    Object? tag = freezed,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      articleList: null == articleList
          ? _value.articleList
          : articleList // ignore: cast_nullable_to_non_nullable
              as List<Article>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ArticleStateCopyWith<$Res>
    implements $ArticleStateCopyWith<$Res> {
  factory _$$_ArticleStateCopyWith(
          _$_ArticleState value, $Res Function(_$_ArticleState) then) =
      __$$_ArticleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Article> articleList,
      String title,
      String url,
      Tag? tag,
      String? memo});
}

/// @nodoc
class __$$_ArticleStateCopyWithImpl<$Res>
    extends _$ArticleStateCopyWithImpl<$Res, _$_ArticleState>
    implements _$$_ArticleStateCopyWith<$Res> {
  __$$_ArticleStateCopyWithImpl(
      _$_ArticleState _value, $Res Function(_$_ArticleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articleList = null,
    Object? title = null,
    Object? url = null,
    Object? tag = freezed,
    Object? memo = freezed,
  }) {
    return _then(_$_ArticleState(
      articleList: null == articleList
          ? _value._articleList
          : articleList // ignore: cast_nullable_to_non_nullable
              as List<Article>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ArticleState extends _ArticleState {
  const _$_ArticleState(
      {required final List<Article> articleList,
      required this.title,
      required this.url,
      this.tag,
      this.memo})
      : _articleList = articleList,
        super._();

  final List<Article> _articleList;
  @override
  List<Article> get articleList {
    if (_articleList is EqualUnmodifiableListView) return _articleList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articleList);
  }

  @override
  final String title;
  @override
  final String url;
  @override
  final Tag? tag;
  @override
  final String? memo;

  @override
  String toString() {
    return 'ArticleState(articleList: $articleList, title: $title, url: $url, tag: $tag, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArticleState &&
            const DeepCollectionEquality()
                .equals(other._articleList, _articleList) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_articleList), title, url, tag, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArticleStateCopyWith<_$_ArticleState> get copyWith =>
      __$$_ArticleStateCopyWithImpl<_$_ArticleState>(this, _$identity);
}

abstract class _ArticleState extends ArticleState {
  const factory _ArticleState(
      {required final List<Article> articleList,
      required final String title,
      required final String url,
      final Tag? tag,
      final String? memo}) = _$_ArticleState;
  const _ArticleState._() : super._();

  @override
  List<Article> get articleList;
  @override
  String get title;
  @override
  String get url;
  @override
  Tag? get tag;
  @override
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleStateCopyWith<_$_ArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}
