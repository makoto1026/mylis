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
    required this.deletedAt,
    required this.isRemovedAds,
  });
  final String uuid;
  final String name;
  final int sex;
  final String lineUuid;
  final String email;
  final String phoneNumber;
  final String fcmToken;
  final int textColor;
  final int buttonColor;
  final int iconColor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isRemovedAds;
}
