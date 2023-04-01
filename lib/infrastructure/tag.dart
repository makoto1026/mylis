import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/domain/repository/tag.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/tag_mapper.dart';

class ITagRepository extends TagRepository {
  ITagRepository();

  final firestore = FirebaseFirestore.instance;
  final userDB = Firestore.users;

  @override
  Future<Tag> get(String userUuid, String tagUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    const tagId = "PNdPodf7XX6lsrHfyNHB";
    return await userDB.doc("$userId/tags/$tagId").get().then(
      (event) {
        final doc = event.data();
        return TagMapper.fromJSON(doc!);
      },
    );
  }

  @override
  Future<List<Tag>> getList(String userUuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final List<Tag> tagList = [];
    await userDB.doc(userId).collection("tags").get().then(
      (querySnapshot) {
        for (var doc in querySnapshot.docs) {
          var tag = TagMapper.fromJSON(doc.data());
          tag.uuid = doc.id;
          tagList.add(tag);
        }
      },
    );
    // TODO: 自分の好きな順番に変えられるようにする
    tagList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return tagList;
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

    await userDB.doc(userId).collection("tags").add(postData);
  }

  @override
  Future<void> update(Tag tag) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final postData = {
      "name": tag.name,
      "position": tag.position,
      "created_at": tag.createdAt,
      "updated_at": tag.updatedAt,
    };
    final documentReference =
        userDB.doc(userId).collection("tags").doc(tag.uuid);

    await documentReference.update(postData);
  }

  @override
  Future<void> delete(String tagUUID) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    final documentReference =
        userDB.doc(userId).collection("tags").doc(tagUUID);

    await documentReference.delete();
  }
}

final tagRepositoryProvider =
    Provider<ITagRepository>((ref) => ITagRepository());
