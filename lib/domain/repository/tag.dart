import 'package:mylis/domain/entities/tag.dart';

abstract class TagRepository {
  Future<Tag> get(String memberId, String tagId);
  Future<List<Tag>> getList(String memberId);
  Future<String> create(String memberId, Tag tag);
  Future<void> update(String memberId, Tag tag);
  Future<void> delete(String memberId, String tagId);
}
