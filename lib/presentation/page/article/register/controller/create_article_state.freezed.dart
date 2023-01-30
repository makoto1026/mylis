// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_article_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateArticleState {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateArticleStateCopyWith<CreateArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateArticleStateCopyWith<$Res> {
  factory $CreateArticleStateCopyWith(
          CreateArticleState value, $Res Function(CreateArticleState) then) =
      _$CreateArticleStateCopyWithImpl<$Res, CreateArticleState>;
  @useResult
  $Res call({String title, String url, String? memo});
}

/// @nodoc
class _$CreateArticleStateCopyWithImpl<$Res, $Val extends CreateArticleState>
    implements $CreateArticleStateCopyWith<$Res> {
  _$CreateArticleStateCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateArticleStateCopyWith<$Res>
    implements $CreateArticleStateCopyWith<$Res> {
  factory _$$_CreateArticleStateCopyWith(_$_CreateArticleState value,
          $Res Function(_$_CreateArticleState) then) =
      __$$_CreateArticleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, String? memo});
}

/// @nodoc
class __$$_CreateArticleStateCopyWithImpl<$Res>
    extends _$CreateArticleStateCopyWithImpl<$Res, _$_CreateArticleState>
    implements _$$_CreateArticleStateCopyWith<$Res> {
  __$$_CreateArticleStateCopyWithImpl(
      _$_CreateArticleState _value, $Res Function(_$_CreateArticleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? memo = freezed,
  }) {
    return _then(_$_CreateArticleState(
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
    ));
  }
}

/// @nodoc

class _$_CreateArticleState extends _CreateArticleState {
  const _$_CreateArticleState(
      {required this.title, required this.url, this.memo})
      : super._();

  @override
  final String title;
  @override
  final String url;
  @override
  final String? memo;

  @override
  String toString() {
    return 'CreateArticleState(title: $title, url: $url, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateArticleState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, url, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateArticleStateCopyWith<_$_CreateArticleState> get copyWith =>
      __$$_CreateArticleStateCopyWithImpl<_$_CreateArticleState>(
          this, _$identity);
}

abstract class _CreateArticleState extends CreateArticleState {
  const factory _CreateArticleState(
      {required final String title,
      required final String url,
      final String? memo}) = _$_CreateArticleState;
  const _CreateArticleState._() : super._();

  @override
  String get title;
  @override
  String get url;
  @override
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$$_CreateArticleStateCopyWith<_$_CreateArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}
