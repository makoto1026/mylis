import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/repository/article.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/article_mapper.dart';

// TODO: 各APIのエラーハンドリング
// TODO: 各メソッドに渡しているidが必要かどうか
// TODO: articleにtagを含ませるかどうか
// TODO: 各stateにuuidを含められないのか？articleやtag、memoのuuidが空になっているので、今は個別で渡さないといけない

class IArticleRepository extends ArticleRepository {
  IArticleRepository();

  final firestore = FirebaseFirestore.instance;
  final userDB = Firestore.users;

  @override
  Future<Article> get(String memberId, String tagId, String articleUuid) async {
    return await userDB
        .doc("$memberId/tags/$tagId/articles/$articleUuid")
        .get()
        .then(
      (value) {
        final doc = value.data();
        return ArticleMapper.fromJSON(doc!, articleUuid, null);
      },
    );
  }

  @override
  Future<List<Article>> getList(String memberId, String tagId) async {
    final List<Article> articleList = [];
    await userDB
        .doc("$memberId/tags/$tagId/")
        .collection("articles")
        .get()
        .then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final article = ArticleMapper.fromJSON(doc.data(), doc.id, null);
          articleList.add(article);
        }
      },
    );

    articleList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return articleList;
  }

  @override
  Future<String> create(String memberId, Article article) async {
    final tagId = article.tag?.uuid;
    final postData = {
      "title": article.title,
      "url": article.url,
      "memo": article.memo,
      "created_at": article.createdAt,
    };

    final docRef = await userDB
        .doc("$memberId/tags/$tagId")
        .collection("articles")
        .add(postData);

    return docRef.id;
  }

  @override
  Future<void> update(String memberId, Article article, String tagId) async {
    final postData = {
      "title": article.title,
      "url": article.url,
      "memo": article.memo,
      "created_at": article.createdAt,
    };

    await userDB
        .doc("$memberId/tags/$tagId/articles/${article.uuid}")
        .update(postData);
  }

  @override
  Future<void> delete(String memberId, Article article, String tagId) async {
    await userDB.doc("$memberId/tags/$tagId/articles/${article.uuid}").delete();
  }
}

final articleRepositoryProvider =
    Provider<IArticleRepository>((ref) => IArticleRepository());
