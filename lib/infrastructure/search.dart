import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/search.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/article_mapper.dart';

class ISearchRepository extends SearchRepository {
  ISearchRepository();

  final firestore = FirebaseFirestore.instance;
  final userDB = Firestore.users;

  @override
  Future<List<Article>> search(
      String memberId, List<Tag> tags, String keyword) async {
    final List<Article> articleList = [];
    final List<Article> searchedArticleList = [];

    for (var tag in tags) {
      if (tag.uuid == "") {
        continue;
      }
      await userDB
          .doc("$memberId/tags/${tag.uuid}/")
          .collection("articles")
          .get()
          .then(
        (querySnapshot) {
          for (var doc in querySnapshot.docs) {
            final article = ArticleMapper.fromJSON(doc.data(), doc.id, tag);
            articleList.add(article);
          }
        },
      );
    }

    for (var article in articleList) {
      if (article.title.contains(keyword)) {
        searchedArticleList.add(article);
      }
    }

    searchedArticleList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return searchedArticleList;
  }
}

final searchRepositoryProvider =
    Provider<ISearchRepository>((ref) => ISearchRepository());
