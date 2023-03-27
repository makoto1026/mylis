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
  List<ArticlesWithTag> get articlesWithTag =>
      throw _privateConstructorUsedError;
  int get setCount => throw _privateConstructorUsedError;

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
  $Res call({List<ArticlesWithTag> articlesWithTag, int setCount});
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
    Object? articlesWithTag = null,
    Object? setCount = null,
  }) {
    return _then(_value.copyWith(
      articlesWithTag: null == articlesWithTag
          ? _value.articlesWithTag
          : articlesWithTag // ignore: cast_nullable_to_non_nullable
              as List<ArticlesWithTag>,
      setCount: null == setCount
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({List<ArticlesWithTag> articlesWithTag, int setCount});
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
    Object? articlesWithTag = null,
    Object? setCount = null,
  }) {
    return _then(_$_ArticleState(
      articlesWithTag: null == articlesWithTag
          ? _value._articlesWithTag
          : articlesWithTag // ignore: cast_nullable_to_non_nullable
              as List<ArticlesWithTag>,
      setCount: null == setCount
          ? _value.setCount
          : setCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ArticleState extends _ArticleState {
  const _$_ArticleState(
      {required final List<ArticlesWithTag> articlesWithTag,
      required this.setCount})
      : _articlesWithTag = articlesWithTag,
        super._();

  final List<ArticlesWithTag> _articlesWithTag;
  @override
  List<ArticlesWithTag> get articlesWithTag {
    if (_articlesWithTag is EqualUnmodifiableListView) return _articlesWithTag;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articlesWithTag);
  }

  @override
  final int setCount;

  @override
  String toString() {
    return 'ArticleState(articlesWithTag: $articlesWithTag, setCount: $setCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ArticleState &&
            const DeepCollectionEquality()
                .equals(other._articlesWithTag, _articlesWithTag) &&
            (identical(other.setCount, setCount) ||
                other.setCount == setCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_articlesWithTag), setCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ArticleStateCopyWith<_$_ArticleState> get copyWith =>
      __$$_ArticleStateCopyWithImpl<_$_ArticleState>(this, _$identity);
}

abstract class _ArticleState extends ArticleState {
  const factory _ArticleState(
      {required final List<ArticlesWithTag> articlesWithTag,
      required final int setCount}) = _$_ArticleState;
  const _ArticleState._() : super._();

  @override
  List<ArticlesWithTag> get articlesWithTag;
  @override
  int get setCount;
  @override
  @JsonKey(ignore: true)
  _$$_ArticleStateCopyWith<_$_ArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}
