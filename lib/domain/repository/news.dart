import 'package:mylis/domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<News>> getList();
}
