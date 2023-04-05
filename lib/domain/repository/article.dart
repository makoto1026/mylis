import 'package:mylis/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<Article> get(String memberId, String tagId, String articleUuid);
  Future<List<Article>> getList(String memberId, String tagId);
  Future<void> create(String memberId, Article article);
  Future<void> update(String memberId, Article article, String tagId);
  Future<void> delete(String memberId, Article article, String tagId);
}
