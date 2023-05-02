class Tag {
  Tag({
    this.uuid,
    required this.name,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });
  String? uuid;
  final String name;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
}
