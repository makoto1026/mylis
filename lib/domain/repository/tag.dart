import 'package:mylis/domain/entities/tag.dart';

abstract class TagRepository {
  Future<Tag> get(String userUuid, String tagUuid);
  Future<List<Tag>> getList(String userUuid);
  Future<void> create(Tag tag);
}
