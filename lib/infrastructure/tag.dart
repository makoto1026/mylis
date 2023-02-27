import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/tag_mapper.dart';

class ITagRepository extends TagRepository {
  ITagRepository();

  final firestore = FirebaseFirestore.instance;

  @override
  Future<Tag> get(String userUuid, String tagUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    const tagId = "PNdPodf7XX6lsrHfyNHB";
    return await Firestore.users.doc("$userId/tags/$tagId").get().then(
      (event) {
        final doc = event.data();
        return TagMapper.fromJSON(doc!);
      },
    );
  }

  @override
  Future<List<Tag>> getList(String userUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final List<Tag> tagsUuidList = [];
    await Firestore.users.doc(userId).collection("tags").get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          final tag = TagMapper.fromJSON(doc.data());
          tagsUuidList.add(tag);
        }
      },
    );
    return tagsUuidList;
  }

  @override
  Future<void> create(Tag tag) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final postData = {
      "name": tag.name,
      "position": tag.position,
      "created_at": tag.createdAt,
      "updated_at": tag.updatedAt,
    };

    await Firestore.users.doc(userId).collection("tags").add(postData);
  }
}

final tagRepositoryProvider =
    Provider<ITagRepository>((ref) => ITagRepository());
