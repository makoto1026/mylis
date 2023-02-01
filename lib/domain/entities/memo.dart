class Memo {
  Memo({
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
}
