class Member {
  Member({
    required this.uuid,
    required this.email,
    required this.password,
    required this.textColor,
    required this.buttonColor,
    required this.iconColor,
    required this.isRemovedAds,
    required this.isHiddenSaveMemoNoticeDialog,
    required this.registeredArticleCount,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
  final String uuid;
  final String email;
  final String password;
  final int textColor;
  final int buttonColor;
  final int iconColor;
  final bool isRemovedAds;
  final bool isHiddenSaveMemoNoticeDialog;
  final int registeredArticleCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
}
