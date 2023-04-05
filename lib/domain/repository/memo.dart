import 'package:mylis/domain/entities/memo.dart';

abstract class MemoRepository {
  Future<Memo> get(String memberId, String memoId);
  Future<List<Memo>> getList(String memberId);
  Future<void> create(String memberId, Memo memo);
  Future<void> update(String memberId, Memo memo, String memoId);
  Future<void> delete(String memberId, String memoId);
}
