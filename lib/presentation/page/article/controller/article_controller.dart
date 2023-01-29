import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/repository/article.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/domain/repository/user.dart';
import 'package:mylis/infrastructure/article.dart';
import 'package:mylis/infrastructure/tag.dart';
import 'package:mylis/infrastructure/user.dart';
import 'package:mylis/presentation/page/article/controller/article_state.dart';

class ArticleController extends StateNotifier<ArticleState> {
  ArticleController({
    required this.articleRepository,
    required this.tagRepository,
    required this.userRepository,
  }) : super(
          const ArticleState(
            articleList: [],
          ),
        );

  ArticleRepository articleRepository;
  TagRepository tagRepository;
  UserRepository userRepository;

  Future<void> initialized() async {
    await getList();
  }

  Future<void> getList() async {
    final articleList = await articleRepository.getList("", "");
    state = state.copyWith(articleList: articleList);
  }
}

final articleController =
    StateNotifierProvider<ArticleController, ArticleState>(
  (ref) => ArticleController(
    articleRepository: ref.watch(articleRepositoryProvider),
    tagRepository: ref.watch(tagRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
  ),
);
