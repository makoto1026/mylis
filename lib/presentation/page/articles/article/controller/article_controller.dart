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

  Future<void> initialized(String memberId, List<Tag> tags) async {
    final List<ArticlesWithTagUUID> array = [];
    for (Tag i in tags) {
      final res = await getList(memberId, i.uuid ?? "");
      array.add(
        ArticlesWithTagUUID(
          tagId: i.uuid ?? "",
          articles: res,
        ),
      );
      state = state.copyWith(articlesWithTag: array);
    }
  }

  Future<List<Article>> getList(String memberId, String tagId) async {
    if (tagId == "") {
      return [];
    }
    return articleRepository.getList(memberId, tagId);
  }

  Future<void> setArticleListWithTag(String memberId, String tagId) async {
    final List<ArticlesWithTagUUID> array = [];
    final res = await getList(memberId, tagId);
    array.add(
      ArticlesWithTagUUID(
        tagId: tagId,
        articles: res,
      ),
    );
    state = state.copyWith(articlesWithTag: array);
  }

  ArticlesWithTagUUID setArticlesWithTagUUID(String tagId) {
    final res = state.articlesWithTag.firstWhere(
      (e) => e.tagId == tagId,
      orElse: () => ArticlesWithTagUUID(
        tagId: "",
        articles: [],
      ),
    );

    return res;
  }

  Future<Article> getArticle(String memberId, String tagId) async {
    return articleRepository.get(memberId, tagId, tagId);
  }

  ArticlesWithTagUUID setArticles(String tagId) {
    final res = state.articlesWithTag.firstWhere(
      (e) => e.tagId == tagId,
      orElse: () => ArticlesWithTagUUID(
        tagId: "",
        articles: [],
      ),
    );

    return res;
  }
}

final articleController =
    StateNotifierProvider<ArticleController, ArticleState>(
  (ref) => ArticleController(
    articleRepository: ref.watch(articleRepositoryProvider),
    tagRepository: ref.watch(tagRepositoryProvider),
  ),
);
