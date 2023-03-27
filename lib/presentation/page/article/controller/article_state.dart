// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';

part 'article_state.freezed.dart';

@freezed
class ArticleState with _$ArticleState {
  const factory ArticleState({
    required List<ArticlesWithTag> articlesWithTag,
    required int setCount,
  }) = _ArticleState;
  const ArticleState._();
}
