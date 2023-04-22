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
      name: json["name"] as String? ?? "",
      sex: json["sex"] as int? ?? 0,
      lineUuid: json["line_uuid"] as String? ?? "",
      email: json["email"] as String,
      phoneNumber: json["phone_number"] as String? ?? "",
      fcmToken: json["fcm_token"] as String? ?? "",
      textColor: json["text_color"] as int? ?? 0,
      buttonColor: json["button_color"] as int? ?? 0,
      iconColor: json["icon_color"] as int? ?? 0,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      deletedAt: deletedAt?.toDate(),
      isRemovedAds: json["is_removed_ads"] as bool? ?? false,
    );
  }
}
