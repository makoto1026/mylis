// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receive_sharing_intent_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReceiveSharingIntentState {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  List<SharedMediaFile> get images => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReceiveSharingIntentStateCopyWith<ReceiveSharingIntentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiveSharingIntentStateCopyWith<$Res> {
  factory $ReceiveSharingIntentStateCopyWith(ReceiveSharingIntentState value,
          $Res Function(ReceiveSharingIntentState) then) =
      _$ReceiveSharingIntentStateCopyWithImpl<$Res, ReceiveSharingIntentState>;
  @useResult
  $Res call({String title, String url, List<SharedMediaFile> images});
}

/// @nodoc
class _$ReceiveSharingIntentStateCopyWithImpl<$Res,
        $Val extends ReceiveSharingIntentState>
    implements $ReceiveSharingIntentStateCopyWith<$Res> {
  _$ReceiveSharingIntentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? images = null,
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
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<SharedMediaFile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReceiveSharingIntentStateCopyWith<$Res>
    implements $ReceiveSharingIntentStateCopyWith<$Res> {
  factory _$$_ReceiveSharingIntentStateCopyWith(
          _$_ReceiveSharingIntentState value,
          $Res Function(_$_ReceiveSharingIntentState) then) =
      __$$_ReceiveSharingIntentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String url, List<SharedMediaFile> images});
}

/// @nodoc
class __$$_ReceiveSharingIntentStateCopyWithImpl<$Res>
    extends _$ReceiveSharingIntentStateCopyWithImpl<$Res,
        _$_ReceiveSharingIntentState>
    implements _$$_ReceiveSharingIntentStateCopyWith<$Res> {
  __$$_ReceiveSharingIntentStateCopyWithImpl(
      _$_ReceiveSharingIntentState _value,
      $Res Function(_$_ReceiveSharingIntentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? url = null,
    Object? images = null,
  }) {
    return _then(_$_ReceiveSharingIntentState(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<SharedMediaFile>,
    ));
  }
}

/// @nodoc

class _$_ReceiveSharingIntentState extends _ReceiveSharingIntentState {
  const _$_ReceiveSharingIntentState(
      {required this.title,
      required this.url,
      required final List<SharedMediaFile> images})
      : _images = images,
        super._();

  @override
  final String title;
  @override
  final String url;
  final List<SharedMediaFile> _images;
  @override
  List<SharedMediaFile> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'ReceiveSharingIntentState(title: $title, url: $url, images: $images)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReceiveSharingIntentState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, url, const DeepCollectionEquality().hash(_images));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReceiveSharingIntentStateCopyWith<_$_ReceiveSharingIntentState>
      get copyWith => __$$_ReceiveSharingIntentStateCopyWithImpl<
          _$_ReceiveSharingIntentState>(this, _$identity);
}

abstract class _ReceiveSharingIntentState extends ReceiveSharingIntentState {
  const factory _ReceiveSharingIntentState(
          {required final String title,
          required final String url,
          required final List<SharedMediaFile> images}) =
      _$_ReceiveSharingIntentState;
  const _ReceiveSharingIntentState._() : super._();

  @override
  String get title;
  @override
  String get url;
  @override
  List<SharedMediaFile> get images;
  @override
  @JsonKey(ignore: true)
  _$$_ReceiveSharingIntentStateCopyWith<_$_ReceiveSharingIntentState>
      get copyWith => throw _privateConstructorUsedError;
}
