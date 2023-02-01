// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_memo_state.freezed.dart';

@freezed
class RegisterMemoState with _$RegisterMemoState {
  const factory RegisterMemoState({
    required String title,
    required String body,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? memo,
  }) = _RegisterMemoState;
  const RegisterMemoState._();
}
