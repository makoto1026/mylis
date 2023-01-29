class Tag {
  Tag({
    required this.name,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });
  final String name;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
}
