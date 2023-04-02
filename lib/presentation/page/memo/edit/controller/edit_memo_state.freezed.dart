// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_memo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditMemoState {
  String? get uuid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditMemoStateCopyWith<EditMemoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditMemoStateCopyWith<$Res> {
  factory $EditMemoStateCopyWith(
          EditMemoState value, $Res Function(EditMemoState) then) =
      _$EditMemoStateCopyWithImpl<$Res, EditMemoState>;
  @useResult
  $Res call(
      {String? uuid,
      String title,
      String body,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String? memo});
}

/// @nodoc
class _$EditMemoStateCopyWithImpl<$Res, $Val extends EditMemoState>
    implements $EditMemoStateCopyWith<$Res> {
  _$EditMemoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = null,
    Object? body = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? memo = freezed,
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
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditMemoStateCopyWith<$Res>
    implements $EditMemoStateCopyWith<$Res> {
  factory _$$_EditMemoStateCopyWith(
          _$_EditMemoState value, $Res Function(_$_EditMemoState) then) =
      __$$_EditMemoStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uuid,
      String title,
      String body,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String? memo});
}

/// @nodoc
class __$$_EditMemoStateCopyWithImpl<$Res>
    extends _$EditMemoStateCopyWithImpl<$Res, _$_EditMemoState>
    implements _$$_EditMemoStateCopyWith<$Res> {
  __$$_EditMemoStateCopyWithImpl(
      _$_EditMemoState _value, $Res Function(_$_EditMemoState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? title = null,
    Object? body = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? memo = freezed,
  }) {
    return _then(_$_EditMemoState(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_EditMemoState extends _EditMemoState {
  const _$_EditMemoState(
      {this.uuid,
      required this.title,
      required this.body,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      this.memo})
      : super._();

  @override
  final String? uuid;
  @override
  final String title;
  @override
  final String body;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String? memo;

  @override
  String toString() {
    return 'EditMemoState(uuid: $uuid, title: $title, body: $body, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditMemoState &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, uuid, title, body, createdAt, updatedAt, deletedAt, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditMemoStateCopyWith<_$_EditMemoState> get copyWith =>
      __$$_EditMemoStateCopyWithImpl<_$_EditMemoState>(this, _$identity);
}

abstract class _EditMemoState extends EditMemoState {
  const factory _EditMemoState(
      {final String? uuid,
      required final String title,
      required final String body,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? deletedAt,
      final String? memo}) = _$_EditMemoState;
  const _EditMemoState._() : super._();

  @override
  String? get uuid;
  @override
  String get title;
  @override
  String get body;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  String? get memo;
  @override
  @JsonKey(ignore: true)
  _$$_EditMemoStateCopyWith<_$_EditMemoState> get copyWith =>
      throw _privateConstructorUsedError;
}
