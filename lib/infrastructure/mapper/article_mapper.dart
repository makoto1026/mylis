import 'package:mylis/domain/entities/article.dart';

class ArticleMapper {
  static Article fromJSON(Map<String, dynamic> json) {
    return Article(
      title: json["title"] as String,
      url: json["url"] as String,
      memo: json["memo"] as String,
      createdAt: json["created_at"].toDate(),
    );
  }
}
