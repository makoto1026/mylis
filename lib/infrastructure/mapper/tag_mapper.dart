import 'package:mylis/domain/entities/tag.dart';

class TagMapper {
  static Tag fromJSON(Map<String, dynamic> json) {
    return Tag(
      name: json["name"] as String,
      position: json["position"] as int,
      createdAt: json["created_at"].toDate(),
      updatedAt: json["updated_at"].toDate(),
    );
  }
}
