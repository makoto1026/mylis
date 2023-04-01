import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/domain/repository/memo.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/memo_mapper.dart';

class IMemoRepository extends MemoRepository {
  IMemoRepository();

  final userssDB = Firestore.users;

  @override
  Future<Memo> get(String userUuid, String memoUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    const memoId = "ooQMDpswehs8ILe4FrnX";

    return await userssDB.doc("$userId/memos/$memoId").get().then(
      (value) {
        final doc = value.data();
        return MemoMapper.fromJSON(doc!);
      },
    );
  }

  @override
  Future<List<Memo>> getList(String userUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final List<Memo> memoList = [];
    await userssDB.doc(userId).collection("memos").get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final memo = MemoMapper.fromJSON(doc.data());
          memoList.add(memo);
        }
      },
    );
    return memoList;
  }

  @override
  Future<void> create(Memo memo) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final postData = {
      "title": memo.title,
      "body": memo.body,
      "created_at": memo.createdAt,
      "updated_at": memo.updatedAt,
      "deleted_at": memo.deletedAt,
    };
    await userssDB.doc(userId).collection("memos").add(postData);
  }

  @override
  Future<void> update(Memo memo) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final postData = {
      "title": memo.title,
      "body": memo.body,
      "created_at": memo.createdAt,
      "updated_at": memo.updatedAt,
      "deleted_at": memo.deletedAt,
    };
    await userssDB
        .doc(userId)
        .collection("memos")
        .doc(memo.uuid)
        .update(postData);
  }

  @override
  Future<void> delete(Memo memo) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    await userssDB.doc(userId).collection("memos").doc(memo.uuid).delete();
  }
}

final memoRepositoryProvider =
    Provider<IMemoRepository>((ref) => IMemoRepository());
