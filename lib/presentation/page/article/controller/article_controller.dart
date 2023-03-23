import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';
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
          ArticleState(
            articleList: [],
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
  TagRepository tagRepository;
  UserRepository userRepository;

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
      state = state.copyWith(articleList: array);
    }
    await setCount();
  }

  Future<List<Article>> getList(String tagUuid) async {
    return articleRepository.getList("", tagUuid);
  }

  List<Article> setArticlesWithTag(String tagUuid, int length) {
    if (state.articleList.isEmpty || state.articleList.length == length) {
      return [];
    }
    final res = state.articleList.firstWhere(
      (e) => e.uuid == tagUuid,
      orElse: () => ArticlesWithTag(
        uuid: "",
        articles: [],
      ),
    );
    return res.articles;
  }

  void setNewArticle({
    String? title,
    String? url,
    String? memo,
    String? tagUuid,
  }) {
    final tag = Tag(
      uuid: tagUuid ?? state.tag?.uuid,
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

  Future<void> create() async {
    final article = Article(
      title: state.title,
      url: state.url,
      memo: state.memo ?? "",
      tag: state.tag,
      createdAt: DateTime.now(),
    );
    await articleRepository.create(article);
    await setCount();
  }

  Future<Article> getArticle(String tagUuid) async {
    return articleRepository.get("", tagUuid, tagUuid);
  }

  Future<void> refresh() async {
    state = state.copyWith(title: "", url: "", memo: "");
  }

  Future<void> setCount() async {
    final count = state.setCount;
    state = state.copyWith(setCount: count + 1);
  }

  Future<void> setTag(Tag tag) async {
    state = state.copyWith(tag: tag);
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
