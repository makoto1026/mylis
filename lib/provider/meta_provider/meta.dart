// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta.freezed.dart';

@freezed
class Meta with _$Meta {
  factory Meta({
    required String appVersion,
    required bool isForceUpdate,
    required String appUrl,
  }) = _Meta;
}
