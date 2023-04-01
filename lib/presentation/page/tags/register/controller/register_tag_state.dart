// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_tag_state.freezed.dart';

@freezed
class RegisterTagState with _$RegisterTagState {
  const factory RegisterTagState({
    required String name,
    required int position,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isLoading,
  }) = _RegisterTagState;
  const RegisterTagState._();
}
