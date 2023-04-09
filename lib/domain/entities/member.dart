class Member {
  Member({
    required this.uuid,
    required this.name,
    required this.sex,
    required this.lineUuid,
    required this.email,
    required this.phoneNumber,
    required this.fcmToken,
    required this.textColor,
    required this.buttonColor,
    required this.iconColor,
    required this.createdAt,
    required this.updatedAt,
  });
  final String uuid;
  final String name;
  final int sex;
  final String lineUuid;
  final String email;
  final String phoneNumber;
  final String fcmToken;
  final String textColor;
  final String buttonColor;
  final String iconColor;
  final DateTime createdAt;
  final DateTime updatedAt;
}
