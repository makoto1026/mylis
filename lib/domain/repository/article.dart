import 'package:mylis/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Article> get(String userUuid, String tagUuid, String articleUuid);
  Future<List<Article>> getList(String userUuid, String tagUuid);
  Future<void> create(Article article);
  Future<void> update(Article article);
  Future<void> delete(Article article);
}
