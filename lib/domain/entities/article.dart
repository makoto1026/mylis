import 'package:mylis/domain/entities/tag.dart';

class Article {
  Article({
    required this.title,
    required this.url,
    required this.memo,
    this.tag,
    required this.createdAt,
    // required this.updatedAt,
  });
  final String title;
  final String url;
  final String memo;
  final Tag? tag;
  final DateTime createdAt;
  // final DateTime updatedAt;
}
