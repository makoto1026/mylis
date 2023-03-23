// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/domain/entities/tag.dart';

part 'tag_state.freezed.dart';

@freezed
class TagState with _$TagState {
  const factory TagState({
    required List<Tag> tagList,
    String? uuid,
    required Tag tag,
    required bool isLoading,
  }) = _TagState;
  const TagState._();
}
