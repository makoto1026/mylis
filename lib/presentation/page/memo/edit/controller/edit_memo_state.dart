// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_memo_state.freezed.dart';

@freezed
class EditMemoState with _$EditMemoState {
  const factory EditMemoState({
    required String title,
    required String body,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    String? memo,
  }) = _EditMemoState;
  const EditMemoState._();
}
