// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TagState {
  List<Tag> get tagList => throw _privateConstructorUsedError;
  String? get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagStateCopyWith<TagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagStateCopyWith<$Res> {
  factory $TagStateCopyWith(TagState value, $Res Function(TagState) then) =
      _$TagStateCopyWithImpl<$Res, TagState>;
  @useResult
  $Res call(
      {List<Tag> tagList,
      String? uuid,
      String name,
      int position,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$TagStateCopyWithImpl<$Res, $Val extends TagState>
    implements $TagStateCopyWith<$Res> {
  _$TagStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagList = null,
    Object? uuid = freezed,
    Object? name = null,
    Object? position = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      tagList: null == tagList
          ? _value.tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TagStateCopyWith<$Res> implements $TagStateCopyWith<$Res> {
  factory _$$_TagStateCopyWith(
          _$_TagState value, $Res Function(_$_TagState) then) =
      __$$_TagStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Tag> tagList,
      String? uuid,
      String name,
      int position,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$_TagStateCopyWithImpl<$Res>
    extends _$TagStateCopyWithImpl<$Res, _$_TagState>
    implements _$$_TagStateCopyWith<$Res> {
  __$$_TagStateCopyWithImpl(
      _$_TagState _value, $Res Function(_$_TagState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagList = null,
    Object? uuid = freezed,
    Object? name = null,
    Object? position = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_TagState(
      tagList: null == tagList
          ? _value._tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<Tag>,
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_TagState extends _TagState {
  const _$_TagState(
      {required final List<Tag> tagList,
      this.uuid,
      required this.name,
      required this.position,
      required this.createdAt,
      required this.updatedAt})
      : _tagList = tagList,
        super._();

  final List<Tag> _tagList;
  @override
  List<Tag> get tagList {
    if (_tagList is EqualUnmodifiableListView) return _tagList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagList);
  }

  @override
  final String? uuid;
  @override
  final String name;
  @override
  final int position;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TagState(tagList: $tagList, uuid: $uuid, name: $name, position: $position, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TagState &&
            const DeepCollectionEquality().equals(other._tagList, _tagList) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tagList),
      uuid,
      name,
      position,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagStateCopyWith<_$_TagState> get copyWith =>
      __$$_TagStateCopyWithImpl<_$_TagState>(this, _$identity);
}

abstract class _TagState extends TagState {
  const factory _TagState(
      {required final List<Tag> tagList,
      final String? uuid,
      required final String name,
      required final int position,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$_TagState;
  const _TagState._() : super._();

  @override
  List<Tag> get tagList;
  @override
  String? get uuid;
  @override
  String get name;
  @override
  int get position;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_TagStateCopyWith<_$_TagState> get copyWith =>
      throw _privateConstructorUsedError;
}
