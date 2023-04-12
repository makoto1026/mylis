import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/member.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/member_mapper.dart';

class IMemberRepository extends MemberRepository {
  IMemberRepository();

  final firestore = FirebaseFirestore.instance;
  final usersDB = Firestore.users;

  @override
  Future<Member> get(String uuid) async {
    return await usersDB.doc(uuid).get().then(
      (value) {
        final doc = value.data();
        return MemberMapper.fromJSON(doc!, uuid);
      },
    );
  }

  @override
  Future<Member> update({
    required String currentMemberId,
    required String textColor,
    required String buttonColor,
    required String iconColor,
  }) async {
    final postData = {
      "text_color": textColor,
      "button_color": buttonColor,
      "icon_color": iconColor,
      "updated_at": DateTime.now(),
    };

    await usersDB.doc(currentMemberId).update(postData);

    return await get(currentMemberId);
  }

  @override
  Future<void> delete({required String currentMemberId}) async {
    final postData = {
      "deleted_at": DateTime.now(),
    };

    await usersDB.doc(currentMemberId).update(postData);

    await get(currentMemberId);
  }
}

final memberRepositoryProvider =
    Provider<IMemberRepository>((ref) => IMemberRepository());
