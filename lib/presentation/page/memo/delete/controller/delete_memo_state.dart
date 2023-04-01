// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_memo_state.freezed.dart';

@freezed
class DeleteMemoState with _$DeleteMemoState {
  const factory DeleteMemoState({
    required String title,
    required String body,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? memo,
  }) = _DeleteMemoState;
  const DeleteMemoState._();
}
