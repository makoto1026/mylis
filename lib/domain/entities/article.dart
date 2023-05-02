import 'package:mylis/domain/entities/tag.dart';

class Article {
  Article({
    this.uuid,
    required this.title,
    required this.url,
    required this.memo,
    this.tag,
    required this.createdAt,
    // required this.updatedAt,
  });
  final String? uuid;
  final String title;
  final String url;
  final String memo;
  final Tag? tag;
  final DateTime createdAt;
  // final DateTime updatedAt;
}

class ArticlesWithTagUUID {
  ArticlesWithTagUUID({
    required this.tagId,
    required this.articles,
  });
  final String tagId;
  final List<Article> articles;
}
