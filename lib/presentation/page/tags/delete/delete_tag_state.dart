// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/domain/entities/tag.dart';

part 'delete_tag_state.freezed.dart';

@freezed
class DeleteTagState with _$DeleteTagState {
  const factory DeleteTagState({
    String? uuid,
    required Tag tag,
    required bool isLoading,
  }) = _DeleteTagState;
  const DeleteTagState._();
}
