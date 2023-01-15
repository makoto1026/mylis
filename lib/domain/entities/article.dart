class Article {
  Article({
    required this.siteName,
    required this.url,
    required this.memo,
    required this.createdAt,
  });
  final String siteName;
  final String url;
  final String memo;
  final DateTime createdAt;
}
