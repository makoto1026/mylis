import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/news.dart';
import 'package:mylis/domain/repository/news.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/news_mapper.dart';

class INewsRepository extends NewsRepository {
  INewsRepository();

  final newsDB = Firestore.news;

  @override
  Future<List<News>> getList() async {
    final List<News> newsList = [];
    await newsDB.get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final news = NewsMapper.fromJSON(doc.data());
          newsList.add(news);
        }
      },
    );
    return newsList;
  }
}

final newsRepositoryProvider =
    Provider<INewsRepository>((ref) => INewsRepository());
