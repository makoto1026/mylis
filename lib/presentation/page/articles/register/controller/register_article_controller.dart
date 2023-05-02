import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/article.dart';
import 'package:mylis/infrastructure/article.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_state.dart';

class RegisterArticleController extends StateNotifier<RegisterArticleState> {
  RegisterArticleController({
    required this.articleRepository,
  }) : super(
          RegisterArticleState(
            title: '',
            url: '',
            memo: '',
            tag: Tag(
              uuid: "",
              name: "",
              position: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            setCount: 0,
          ),
        );

  ArticleRepository articleRepository;

  Future<void> initialized(List<Tag> tags) async {}

  Future<void> setNewArticle({
    String? title,
    String? url,
    String? memo,
    String? tagId,
  }) async {
    final tag = Tag(
      uuid: tagId ?? state.tag?.uuid,
      name: state.tag?.name ?? "",
      position: state.tag?.position ?? 0,
      createdAt: state.tag?.createdAt ?? DateTime.now(),
      updatedAt: state.tag?.updatedAt ?? DateTime.now(),
    );
    state = state.copyWith(
      title: title ?? state.title,
      url: url ?? state.url,
      memo: memo ?? state.memo,
      tag: tag,
    );
  }

  Future<void> setTag(Tag tag) async {
    state = state.copyWith(tag: tag);
  }

  Future<void> create(String memberId) async {
    final article = Article(
      title: state.title,
      url: state.url,
      memo: state.memo ?? "",
      tag: state.tag,
      createdAt: DateTime.now(),
    );
    await articleRepository.create(memberId, article);
  }

  Future<void> refresh() async {
    final tag = Tag(
      name: "",
      position: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    state = state.copyWith(title: "", url: "", memo: "", tag: tag);
  }
}

final registerArticleController =
    StateNotifierProvider<RegisterArticleController, RegisterArticleState>(
  (ref) => RegisterArticleController(
    articleRepository: ref.watch(articleRepositoryProvider),
  ),
);
