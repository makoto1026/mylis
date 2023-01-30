import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/repository/article.dart';
import 'package:mylis/infrastructure/article.dart';
import 'package:mylis/presentation/page/article/register/controller/create_article_state.dart';

class CreateArticleController extends StateNotifier<CreateArticleState> {
  CreateArticleController({
    required this.articleRepository,
  }) : super(
          const CreateArticleState(
            title: '',
            url: '',
            memo: '',
          ),
        );

  ArticleRepository articleRepository;

  void setNewArticle({
    String? title,
    String? url,
    String? memo,
  }) {
    state = state.copyWith(
      title: title ?? state.title,
      url: url ?? state.url,
      memo: memo ?? state.memo,
    );
  }

  Future<void> create() async {
    final article = Article(
      title: state.title,
      url: state.url,
      memo: state.memo ?? "",
      createdAt: DateTime.now(),
    );
    await articleRepository.create(article);
  }
}

final createArticleController =
    StateNotifierProvider<CreateArticleController, CreateArticleState>(
  (ref) => CreateArticleController(
    articleRepository: ref.watch(articleRepositoryProvider),
  ),
);
