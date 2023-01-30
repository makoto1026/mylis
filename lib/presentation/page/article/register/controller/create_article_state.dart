// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_article_state.freezed.dart';

@freezed
class CreateArticleState with _$CreateArticleState {
  const factory CreateArticleState({
    required String title,
    required String url,
    String? memo,
  }) = _CreateArticleState;
  const CreateArticleState._();
}
