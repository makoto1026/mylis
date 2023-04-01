// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_tag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeleteTagState {
  String? get uuid => throw _privateConstructorUsedError;
  Tag get tag => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeleteTagStateCopyWith<DeleteTagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteTagStateCopyWith<$Res> {
  factory $DeleteTagStateCopyWith(
          DeleteTagState value, $Res Function(DeleteTagState) then) =
      _$DeleteTagStateCopyWithImpl<$Res, DeleteTagState>;
  @useResult
  $Res call({String? uuid, Tag tag, bool isLoading});
}

/// @nodoc
class _$DeleteTagStateCopyWithImpl<$Res, $Val extends DeleteTagState>
    implements $DeleteTagStateCopyWith<$Res> {
  _$DeleteTagStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_DeleteTagStateCopyWith<$Res>
    implements $DeleteTagStateCopyWith<$Res> {
  factory _$$_DeleteTagStateCopyWith(
          _$_DeleteTagState value, $Res Function(_$_DeleteTagState) then) =
      __$$_DeleteTagStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? uuid, Tag tag, bool isLoading});
}

/// @nodoc
class __$$_DeleteTagStateCopyWithImpl<$Res>
    extends _$DeleteTagStateCopyWithImpl<$Res, _$_DeleteTagState>
    implements _$$_DeleteTagStateCopyWith<$Res> {
  __$$_DeleteTagStateCopyWithImpl(
      _$_DeleteTagState _value, $Res Function(_$_DeleteTagState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? tag = null,
    Object? isLoading = null,
  }) {
    return _then(_$_DeleteTagState(
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

class _$_DeleteTagState extends _DeleteTagState {
  const _$_DeleteTagState(
      {this.uuid, required this.tag, required this.isLoading})
      : super._();

  @override
  final String? uuid;
  @override
  final Tag tag;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'DeleteTagState(uuid: $uuid, tag: $tag, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeleteTagState &&
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
  _$$_DeleteTagStateCopyWith<_$_DeleteTagState> get copyWith =>
      __$$_DeleteTagStateCopyWithImpl<_$_DeleteTagState>(this, _$identity);
}

abstract class _DeleteTagState extends DeleteTagState {
  const factory _DeleteTagState(
      {final String? uuid,
      required final Tag tag,
      required final bool isLoading}) = _$_DeleteTagState;
  const _DeleteTagState._() : super._();

  @override
  String? get uuid;
  @override
  Tag get tag;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_DeleteTagStateCopyWith<_$_DeleteTagState> get copyWith =>
      throw _privateConstructorUsedError;
}
