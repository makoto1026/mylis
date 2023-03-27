import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/article.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/article.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_state.dart';

class ArticleController extends StateNotifier<ArticleState> {
  ArticleController({
    required this.articleRepository,
    required this.tagRepository,
  }) : super(
          const ArticleState(
            articlesWithTag: [],
            setCount: 0,
          ),
        );

  ArticleRepository articleRepository;
  TagRepository tagRepository;

  Future<void> initialized(List<Tag> tags) async {
    final List<ArticlesWithTag> array = [];
    for (Tag i in tags) {
      final res = await getList(i.uuid ?? "");
      array.add(
        ArticlesWithTag(
          uuid: i.uuid ?? "",
          articles: res,
        ),
      );
      state = state.copyWith(articlesWithTag: array);
    }
    await setCount();
  }

  Future<List<Article>> getList(String tagUuid) async {
    if (tagUuid == "") {
      return [];
    }
    return articleRepository.getList("", tagUuid);
  }

  List<Article> setArticlesWithTag(String tagUuid, int length) {
    if (state.articlesWithTag.isEmpty ||
        state.articlesWithTag.length == length) {
      return [];
    }
    final res = state.articlesWithTag.firstWhere(
      (e) => e.uuid == tagUuid,
      orElse: () => ArticlesWithTag(
        uuid: "",
        articles: [],
      ),
    );
    return res.articles;
  }

  Future<Article> getArticle(String tagUuid) async {
    return articleRepository.get("", tagUuid, tagUuid);
  }

  Future<void> setCount() async {
    final count = state.setCount;
    state = state.copyWith(setCount: count + 1);
  }
}

final articleController =
    StateNotifierProvider<ArticleController, ArticleState>(
  (ref) => ArticleController(
    articleRepository: ref.watch(articleRepositoryProvider),
    tagRepository: ref.watch(tagRepositoryProvider),
  ),
);
