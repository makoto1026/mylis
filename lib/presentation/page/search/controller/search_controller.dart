import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/search.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/search.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/search/controller/search_state.dart';

class SearchController extends StateNotifier<SearchState> {
  SearchController({
    required this.searchRepository,
    required this.tagRepository,
  }) : super(
          const SearchState(
            articles: [],
            keyword: "",
          ),
        );

  SearchRepository searchRepository;
  TagRepository tagRepository;

  Future<void> search(String memberId, List<Tag> tags, String keyword) async {
    if (keyword == "") {
      state = state.copyWith(articles: [], keyword: keyword);
      return;
    }
    final res = await searchRepository.search(memberId, tags, keyword);
    state = state.copyWith(articles: res, keyword: keyword);
  }

  Future<void> delete(String articleId) async {
    final articles = List<Article>.from(state.articles);
    articles.removeWhere((e) => e.uuid == articleId);
    state = state.copyWith(articles: articles);
  }

  Future<void> refresh(String memberId, List<Tag> tags) async {
    final res = await searchRepository.search(memberId, tags, state.keyword);
    state = state.copyWith(articles: res, keyword: "");
  }
}

final searchController =
    StateNotifierProvider.autoDispose<SearchController, SearchState>(
  (ref) => SearchController(
    searchRepository: ref.watch(searchRepositoryProvider),
    tagRepository: ref.watch(tagRepositoryProvider),
  ),
);
