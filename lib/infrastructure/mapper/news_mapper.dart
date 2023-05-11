import 'package:mylis/domain/entities/news.dart';

class NewsMapper {
  static News fromJSON(Map<String, dynamic> json) {
    return News(
      title: json["title"] as String,
      content: json["content"] as String,
      imageUri: json["image_uri"] as String,
    );
  }
}
