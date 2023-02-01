import 'package:mylis/domain/entities/memo.dart';

abstract class MemoRepository {
  Future<Memo> get(String userUuid, String memoUuid);
  Future<List<Memo>> getList(String userUuid);
  Future<void> create(Memo memo);
}
