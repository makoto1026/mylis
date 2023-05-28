import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';

class ArticleMapper {
  static Article fromJSON(Map<String, dynamic> json, String uuid, Tag? tag) {
    final createdAt = json["created_at"] as Timestamp;

    return Article(
      uuid: uuid,
      title: json["title"] as String,
      url: json["url"] as String,
      memo: json["memo"] as String,
      tag: tag,
      createdAt: createdAt.toDate(),
    );
  }
}
