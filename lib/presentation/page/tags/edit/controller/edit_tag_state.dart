// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/domain/entities/tag.dart';

part 'edit_tag_state.freezed.dart';

@freezed
class EditTagState with _$EditTagState {
  const factory EditTagState({
    String? uuid,
    required Tag tag,
    required bool isLoading,
  }) = _EditTagState;
  const EditTagState._();
}
