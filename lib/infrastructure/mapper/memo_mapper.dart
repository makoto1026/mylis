import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mylis/domain/entities/memo.dart';

class MemoMapper {
  static Memo fromJSON(Map<String, dynamic> json, String uuid) {
    final createdAt = json["created_at"] as Timestamp;
    final updatedAt = json["created_at"] as Timestamp;

    return Memo(
      uuid: uuid,
      title: json["title"] as String,
      body: json["body"] as String,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
    );
  }
}
