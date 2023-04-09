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
  Future<Tag> get(String memberId, String tagId) async {
    return await userDB.doc("$memberId/tags/$tagId").get().then(
      (event) {
        final doc = event.data();
        return TagMapper.fromJSON(doc!);
      },
    );
  }

  @override
  Future<List<Tag>> getList(String memberId) async {
    final List<Tag> tagList = [];
    await userDB.doc(memberId).collection("tags").get().then(
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
  Future<String> create(String memberId, Tag tag) async {
    final postData = {
      "name": tag.name,
      "position": tag.position,
      "created_at": tag.createdAt,
      "updated_at": tag.updatedAt,
    };

    final docRef = await userDB.doc(memberId).collection("tags").add(postData);

    return docRef.id;
  }

  @override
  Future<void> update(String memberId, Tag tag) async {
    final postData = {
      "name": tag.name,
      "position": tag.position,
      "created_at": tag.createdAt,
      "updated_at": tag.updatedAt,
    };
    final documentReference =
        userDB.doc(memberId).collection("tags").doc(tag.uuid);

    await documentReference.update(postData);
  }

  @override
  Future<void> delete(String memberId, String tagId) async {
    final documentReference =
        userDB.doc(memberId).collection("tags").doc(tagId);

    await documentReference.delete();
  }
}

final tagRepositoryProvider =
    Provider<ITagRepository>((ref) => ITagRepository());
