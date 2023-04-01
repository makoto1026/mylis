// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/domain/entities/tag.dart';

part 'delete_article_state.freezed.dart';

@freezed
class DeleteArticleState with _$DeleteArticleState {
  const factory DeleteArticleState({
    required String title,
    required String url,
    String? memo,
    Tag? tag,
    required int setCount,
  }) = _DeleteArticleState;
  const DeleteArticleState._();
}
