import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/news.dart';
import 'package:mylis/domain/repository/news.dart';
import 'package:mylis/infrastructure/news.dart';

class NewsProvider extends StateNotifier<News?> {
  NewsProvider({
    required this.newsRepository,
  }) : super(null);

  NewsRepository newsRepository;

  Future<void> set() async {
    final newsList = await newsRepository.getList();
    state = newsList[0];
  }
}

final newsProvider = StateNotifierProvider<NewsProvider, News?>(
  (ref) => NewsProvider(
    newsRepository: ref.watch(newsRepositoryProvider),
  ),
);
