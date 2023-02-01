import 'package:mylis/domain/entities/memo.dart';

class MemoMapper {
  static Memo fromJSON(Map<String, dynamic> json) {
    return Memo(
      title: json["title"] as String,
      body: json["body"] as String,
      createdAt: json["created_at"].toDate(),
      updatedAt: json["updated_at"].toDate(),
      deletedAt: json["deleted_at"].toDate(),
    );
  }
}
