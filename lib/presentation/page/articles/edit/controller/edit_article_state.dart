// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/domain/entities/tag.dart';

part 'edit_article_state.freezed.dart';

@freezed
class EditArticleState with _$EditArticleState {
  const factory EditArticleState({
    String? uuid,
    required String title,
    required String url,
    String? memo,
    Tag? tag,
    required int setCount,
  }) = _EditArticleState;
  const EditArticleState._();
}
