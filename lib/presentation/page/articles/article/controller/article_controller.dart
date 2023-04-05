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
    await setCount();
  }

  Future<List<Article>> getList(String memberId, String tagId) async {
    if (tagId == "") {
      return [];
    }
    return articleRepository.getList(memberId, tagId);
  }

  Future<ArticlesWithTagUUID> setArticlesWithTagUUID(
      String tagId, int length) async {
    if (state.articlesWithTag.isEmpty ||
        state.articlesWithTag.length == length) {
      return ArticlesWithTagUUID(articles: [], tagId: "");
    }
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
