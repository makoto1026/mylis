class Member {
  Member({
    required this.uuid,
    required this.name,
    required this.sex,
    required this.lineUuid,
    required this.email,
    required this.phoneNumber,
    required this.fcmToken,
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
  final DateTime createdAt;
  final DateTime updatedAt;
}
