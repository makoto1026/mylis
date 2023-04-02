import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/article.dart';
import 'package:mylis/infrastructure/article.dart';
import 'package:mylis/presentation/page/articles/edit/controller/edit_article_state.dart';

class EditArticleController extends StateNotifier<EditArticleState> {
  EditArticleController({
    required this.articleRepository,
  }) : super(
          EditArticleState(
            uuid: '',
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

  Future<void> setArticle(Article article) async {
    final tag = Tag(
      uuid: article.tag?.uuid,
      name: article.tag?.name ?? "",
      position: article.tag?.position ?? 0,
      createdAt: article.tag?.createdAt ?? DateTime.now(),
      updatedAt: article.tag?.updatedAt ?? DateTime.now(),
    );
    state = state.copyWith(
      uuid: article.uuid,
      title: article.title,
      url: article.url,
      memo: article.memo,
      tag: tag,
    );
  }

  Future<void> setUpdateValue({
    String? title,
    String? url,
    String? memo,
    String? tagUuid,
  }) async {
    state = state.copyWith(
      title: title ?? state.title,
      url: url ?? state.url,
      memo: memo ?? state.memo,
      tag: state.tag,
    );
  }

  Future<void> update() async {
    final article = Article(
      uuid: state.uuid,
      title: state.title,
      url: state.url,
      memo: state.memo ?? "",
      tag: state.tag,
      createdAt: DateTime.now(),
    );
    await articleRepository.update(article);
  }

  Future<void> delete() async {
    final article = Article(
      uuid: state.uuid,
      title: state.title,
      url: state.url,
      memo: state.memo ?? "",
      tag: state.tag,
      createdAt: DateTime.now(),
    );
    await articleRepository.delete(article);
  }

  //TODO: refreshは必要なのか？ref.refresh()でいける？
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

final editArticleController =
    StateNotifierProvider<EditArticleController, EditArticleState>(
  (ref) => EditArticleController(
    articleRepository: ref.watch(articleRepositoryProvider),
  ),
);
