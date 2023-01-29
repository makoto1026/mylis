import 'package:mylis/domain/entities/user.dart';

class UserMapper {
  static User fromJSON(Map<String, dynamic> json) {
    return User(
      name: json["name"] as String,
      sex: json["sex"] as int,
      lineUuid: json["line_uuid"] as String,
      email: json["email"] as String,
      phoneNumber: json["phone_number"] as String,
      fcmToken: json["fcm_token"] as String,
      createdAt: json["created_at"].toDate(),
      updatedAt: json["updated_at"].toDate(),
    );
  }
}
