// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customize_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomizeState {
  Color get textColor => throw _privateConstructorUsedError;
  Color get buttonColor => throw _privateConstructorUsedError;
  Color get iconColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomizeStateCopyWith<CustomizeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomizeStateCopyWith<$Res> {
  factory $CustomizeStateCopyWith(
          CustomizeState value, $Res Function(CustomizeState) then) =
      _$CustomizeStateCopyWithImpl<$Res, CustomizeState>;
  @useResult
  $Res call({Color textColor, Color buttonColor, Color iconColor});
}

/// @nodoc
class _$CustomizeStateCopyWithImpl<$Res, $Val extends CustomizeState>
    implements $CustomizeStateCopyWith<$Res> {
  _$CustomizeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textColor = freezed,
    Object? buttonColor = freezed,
    Object? iconColor = freezed,
  }) {
    return _then(_value.copyWith(
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color,
      buttonColor: freezed == buttonColor
          ? _value.buttonColor
          : buttonColor // ignore: cast_nullable_to_non_nullable
              as Color,
      iconColor: freezed == iconColor
          ? _value.iconColor
          : iconColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CustomizeStateCopyWith<$Res>
    implements $CustomizeStateCopyWith<$Res> {
  factory _$$_CustomizeStateCopyWith(
          _$_CustomizeState value, $Res Function(_$_CustomizeState) then) =
      __$$_CustomizeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Color textColor, Color buttonColor, Color iconColor});
}

/// @nodoc
class __$$_CustomizeStateCopyWithImpl<$Res>
    extends _$CustomizeStateCopyWithImpl<$Res, _$_CustomizeState>
    implements _$$_CustomizeStateCopyWith<$Res> {
  __$$_CustomizeStateCopyWithImpl(
      _$_CustomizeState _value, $Res Function(_$_CustomizeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textColor = freezed,
    Object? buttonColor = freezed,
    Object? iconColor = freezed,
  }) {
    return _then(_$_CustomizeState(
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color,
      buttonColor: freezed == buttonColor
          ? _value.buttonColor
          : buttonColor // ignore: cast_nullable_to_non_nullable
              as Color,
      iconColor: freezed == iconColor
          ? _value.iconColor
          : iconColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$_CustomizeState extends _CustomizeState {
  const _$_CustomizeState(
      {required this.textColor,
      required this.buttonColor,
      required this.iconColor})
      : super._();

  @override
  final Color textColor;
  @override
  final Color buttonColor;
  @override
  final Color iconColor;

  @override
  String toString() {
    return 'CustomizeState(textColor: $textColor, buttonColor: $buttonColor, iconColor: $iconColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomizeState &&
            const DeepCollectionEquality().equals(other.textColor, textColor) &&
            const DeepCollectionEquality()
                .equals(other.buttonColor, buttonColor) &&
            const DeepCollectionEquality().equals(other.iconColor, iconColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(textColor),
      const DeepCollectionEquality().hash(buttonColor),
      const DeepCollectionEquality().hash(iconColor));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomizeStateCopyWith<_$_CustomizeState> get copyWith =>
      __$$_CustomizeStateCopyWithImpl<_$_CustomizeState>(this, _$identity);
}

abstract class _CustomizeState extends CustomizeState {
  const factory _CustomizeState(
      {required final Color textColor,
      required final Color buttonColor,
      required final Color iconColor}) = _$_CustomizeState;
  const _CustomizeState._() : super._();

  @override
  Color get textColor;
  @override
  Color get buttonColor;
  @override
  Color get iconColor;
  @override
  @JsonKey(ignore: true)
  _$$_CustomizeStateCopyWith<_$_CustomizeState> get copyWith =>
      throw _privateConstructorUsedError;
}
