// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_tag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegisterTagState {
  String get name => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterTagStateCopyWith<RegisterTagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterTagStateCopyWith<$Res> {
  factory $RegisterTagStateCopyWith(
          RegisterTagState value, $Res Function(RegisterTagState) then) =
      _$RegisterTagStateCopyWithImpl<$Res, RegisterTagState>;
  @useResult
  $Res call(
      {String name,
      int position,
      DateTime createdAt,
      DateTime updatedAt,
      bool isLoading});
}

/// @nodoc
class _$RegisterTagStateCopyWithImpl<$Res, $Val extends RegisterTagState>
    implements $RegisterTagStateCopyWith<$Res> {
  _$RegisterTagStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? position = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
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
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterTagStateCopyWith<$Res>
    implements $RegisterTagStateCopyWith<$Res> {
  factory _$$_RegisterTagStateCopyWith(
          _$_RegisterTagState value, $Res Function(_$_RegisterTagState) then) =
      __$$_RegisterTagStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int position,
      DateTime createdAt,
      DateTime updatedAt,
      bool isLoading});
}

/// @nodoc
class __$$_RegisterTagStateCopyWithImpl<$Res>
    extends _$RegisterTagStateCopyWithImpl<$Res, _$_RegisterTagState>
    implements _$$_RegisterTagStateCopyWith<$Res> {
  __$$_RegisterTagStateCopyWithImpl(
      _$_RegisterTagState _value, $Res Function(_$_RegisterTagState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? position = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isLoading = null,
  }) {
    return _then(_$_RegisterTagState(
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
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_RegisterTagState extends _RegisterTagState {
  const _$_RegisterTagState(
      {required this.name,
      required this.position,
      required this.createdAt,
      required this.updatedAt,
      required this.isLoading})
      : super._();

  @override
  final String name;
  @override
  final int position;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'RegisterTagState(name: $name, position: $position, createdAt: $createdAt, updatedAt: $updatedAt, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterTagState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, position, createdAt, updatedAt, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterTagStateCopyWith<_$_RegisterTagState> get copyWith =>
      __$$_RegisterTagStateCopyWithImpl<_$_RegisterTagState>(this, _$identity);
}

abstract class _RegisterTagState extends RegisterTagState {
  const factory _RegisterTagState(
      {required final String name,
      required final int position,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final bool isLoading}) = _$_RegisterTagState;
  const _RegisterTagState._() : super._();

  @override
  String get name;
  @override
  int get position;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterTagStateCopyWith<_$_RegisterTagState> get copyWith =>
      throw _privateConstructorUsedError;
}
