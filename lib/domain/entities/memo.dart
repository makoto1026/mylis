class Memo {
  Memo({
    this.uuid,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
  });
  final String? uuid;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
}
