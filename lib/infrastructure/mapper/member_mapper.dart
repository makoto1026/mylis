import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mylis/domain/entities/member.dart';

class MemberMapper {
  static Member fromJSON(Map<String, dynamic> json, String uuid) {
    final createdAt = json["created_at"] as Timestamp;
    final updatedAt = json["updated_at"] as Timestamp;
    final deletedAt =
        json["deleted_at"] == null ? null : json["deleted_at"] as Timestamp;

    return Member(
      uuid: uuid,
      email: json["email"] as String,
      password: json["password"] as String,
      textColor: json["text_color"] as int,
      buttonColor: json["button_color"] as int,
      iconColor: json["icon_color"] as int,
      isRemovedAds: json["is_removed_ads"] as bool,
      isHiddenSaveMemoNoticeDialog:
          json["is_hidden_save_memo_notice_dialog"] as bool,
      registeredArticleCount: json["registered_article_count"] as int,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      deletedAt: deletedAt?.toDate(),
    );
  }
}
