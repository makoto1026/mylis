class Article {
  Article({
    required this.title,
    required this.url,
    required this.memo,
    required this.createdAt,
    // required this.updatedAt,
  });
  final String title;
  final String url;
  final String memo;
  final DateTime createdAt;
  // final DateTime updatedAt;
}
