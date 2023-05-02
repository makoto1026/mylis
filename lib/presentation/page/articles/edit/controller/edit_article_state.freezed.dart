// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_article_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditArticleState {
  String? get uuid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;
  Tag? get tag => throw _privateConstructorUsedError;
  int get setCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditArticleStateCopyWith<EditArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditArticleStateCopyWith<$Res> {
  factory $EditArticleStateCopyWith(
          EditArticleState value, $Res Function(EditArticleState) then) =
      _$EditArticleStateCopyWithImpl<$Res, EditArticleState>;
  @useResult
  $Res call(
      {String? uuid,
      String title,
      String url,
      String? memo,
      Tag? tag,
      int setCount});
}

/// @nodoc
class _$EditArticleStateCopyWithImpl<$Res, $Val extends EditArticleState>
    implements $EditArticleStateCopyWith<$Res> {
  _$EditArticleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = null,
    Object? url = null,
    Object? memo = freezed,
    Object? tag = freezed,
    Object? setCount = null,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$_EditArticleStateCopyWith<$Res>
    implements $EditArticleStateCopyWith<$Res> {
  factory _$$_EditArticleStateCopyWith(
          _$_EditArticleState value, $Res Function(_$_EditArticleState) then) =
      __$$_EditArticleStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uuid,
      String title,
      String url,
      String? memo,
      Tag? tag,
      int setCount});
}

/// @nodoc
class __$$_EditArticleStateCopyWithImpl<$Res>
    extends _$EditArticleStateCopyWithImpl<$Res, _$_EditArticleState>
    implements _$$_EditArticleStateCopyWith<$Res> {
  __$$_EditArticleStateCopyWithImpl(
      _$_EditArticleState _value, $Res Function(_$_EditArticleState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = null,
    Object? url = null,
    Object? memo = freezed,
    Object? tag = freezed,
    Object? setCount = null,
  }) {
    return _then(_$_EditArticleState(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
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

class _$_EditArticleState extends _EditArticleState {
  const _$_EditArticleState(
      {this.uuid,
      required this.title,
      required this.url,
      this.memo,
      this.tag,
      required this.setCount})
      : super._();

  @override
  final String? uuid;
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
    return 'EditArticleState(uuid: $uuid, title: $title, url: $url, memo: $memo, tag: $tag, setCount: $setCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditArticleState &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.setCount, setCount) ||
                other.setCount == setCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, title, url, memo, tag, setCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditArticleStateCopyWith<_$_EditArticleState> get copyWith =>
      __$$_EditArticleStateCopyWithImpl<_$_EditArticleState>(this, _$identity);
}

abstract class _EditArticleState extends EditArticleState {
  const factory _EditArticleState(
      {final String? uuid,
      required final String title,
      required final String url,
      final String? memo,
      final Tag? tag,
      required final int setCount}) = _$_EditArticleState;
  const _EditArticleState._() : super._();

  @override
  String? get uuid;
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
  _$$_EditArticleStateCopyWith<_$_EditArticleState> get copyWith =>
      throw _privateConstructorUsedError;
}
