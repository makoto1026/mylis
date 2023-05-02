// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_tag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditTagState {
  String? get uuid => throw _privateConstructorUsedError;
  Tag get tag => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditTagStateCopyWith<EditTagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditTagStateCopyWith<$Res> {
  factory $EditTagStateCopyWith(
          EditTagState value, $Res Function(EditTagState) then) =
      _$EditTagStateCopyWithImpl<$Res, EditTagState>;
  @useResult
  $Res call({String? uuid, Tag tag, bool isLoading});
}

/// @nodoc
class _$EditTagStateCopyWithImpl<$Res, $Val extends EditTagState>
    implements $EditTagStateCopyWith<$Res> {
  _$EditTagStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? tag = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditTagStateCopyWith<$Res>
    implements $EditTagStateCopyWith<$Res> {
  factory _$$_EditTagStateCopyWith(
          _$_EditTagState value, $Res Function(_$_EditTagState) then) =
      __$$_EditTagStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? uuid, Tag tag, bool isLoading});
}

/// @nodoc
class __$$_EditTagStateCopyWithImpl<$Res>
    extends _$EditTagStateCopyWithImpl<$Res, _$_EditTagState>
    implements _$$_EditTagStateCopyWith<$Res> {
  __$$_EditTagStateCopyWithImpl(
      _$_EditTagState _value, $Res Function(_$_EditTagState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? tag = null,
    Object? isLoading = null,
  }) {
    return _then(_$_EditTagState(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as Tag,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_EditTagState extends _EditTagState {
  const _$_EditTagState({this.uuid, required this.tag, required this.isLoading})
      : super._();

  @override
  final String? uuid;
  @override
  final Tag tag;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'EditTagState(uuid: $uuid, tag: $tag, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditTagState &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, tag, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditTagStateCopyWith<_$_EditTagState> get copyWith =>
      __$$_EditTagStateCopyWithImpl<_$_EditTagState>(this, _$identity);
}

abstract class _EditTagState extends EditTagState {
  const factory _EditTagState(
      {final String? uuid,
      required final Tag tag,
      required final bool isLoading}) = _$_EditTagState;
  const _EditTagState._() : super._();

  @override
  String? get uuid;
  @override
  Tag get tag;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_EditTagStateCopyWith<_$_EditTagState> get copyWith =>
      throw _privateConstructorUsedError;
}
