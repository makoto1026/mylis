import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';

abstract class SearchRepository {
  Future<List<Article>> search(String memberId, List<Tag> tags, String keyword);
}
