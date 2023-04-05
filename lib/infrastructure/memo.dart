import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/domain/repository/memo.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/memo_mapper.dart';

class IMemoRepository extends MemoRepository {
  IMemoRepository();

  final userssDB = Firestore.users;

  @override
  Future<Memo> get(String memberId, String memoId) async {
    return await userssDB.doc("$memberId/memos/$memoId").get().then(
      (value) {
        final doc = value.data();
        return MemoMapper.fromJSON(doc!, memoId);
      },
    );
  }

  @override
  Future<List<Memo>> getList(String memberId) async {
    final List<Memo> memoList = [];
    await userssDB.doc(memberId).collection("memos").get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final memo = MemoMapper.fromJSON(doc.data(), doc.id);
          memoList.add(memo);
        }
      },
    );
    return memoList;
  }

  @override
  Future<void> create(String memberId, Memo memo) async {
    final postData = {
      "title": memo.title,
      "body": memo.body,
      "created_at": memo.createdAt,
      "updated_at": memo.updatedAt,
    };
    await userssDB.doc(memberId).collection("memos").add(postData);
  }

  @override
  Future<void> update(String memberId, Memo memo, String memoId) async {
    final postData = {
      "title": memo.title,
      "body": memo.body,
      "created_at": memo.createdAt,
      "updated_at": memo.updatedAt,
    };
    await userssDB
        .doc(memberId)
        .collection("memos")
        .doc(memoId)
        .update(postData);
  }

  @override
  Future<void> delete(String memberId, String memoId) async {
    await userssDB.doc(memberId).collection("memos").doc(memoId).delete();
  }
}

final memoRepositoryProvider =
    Provider<IMemoRepository>((ref) => IMemoRepository());
