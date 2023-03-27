import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/repository/article.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/article_mapper.dart';

// TODO: 各APIのエラーハンドリング

class IArticleRepository extends ArticleRepository {
  IArticleRepository();

  final firestore = FirebaseFirestore.instance;

  @override
  Future<Article> get(
      String userUuid, String tagUuid, String articleUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    const tagId = "PNdPodf7XX6lsrHfyNHB";
    const articleId = "ooQMDpswehs8ILe4FrnX";

    return await Firestore.users
        .doc("$userId/tags/$tagId/articles/$articleId")
        .get()
        .then(
      (value) {
        final doc = value.data();
        return ArticleMapper.fromJSON(doc!);
      },
    );
  }

  @override
  Future<List<Article>> getList(String userUuid, String tagUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final List<Article> articleList = [];
    await Firestore.users
        .doc("$userId/tags/$tagUuid/")
        .collection("articles")
        .get()
        .then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final article = ArticleMapper.fromJSON(doc.data());
          articleList.add(article);
        }
      },
    );
    return articleList;
  }

  @override
  Future<void> create(Article article) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final tagId = article.tag?.uuid;
    final postData = {
      "title": article.title,
      "url": article.url,
      "memo": article.memo,
      "created_at": article.createdAt,
    };

    await Firestore.users
        .doc("$userId/tags/$tagId")
        .collection("articles")
        .add(postData);
  }
}

final articleRepositoryProvider =
    Provider<IArticleRepository>((ref) => IArticleRepository());
