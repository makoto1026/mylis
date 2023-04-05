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
  Future<String> create(String email, String password) async {
    final postData = {
      "email": email,
      "password": password,
      "created_at": DateTime.now(),
      "updated_at": DateTime.now(),
    };
    var id = "";
    await usersDB
        .add(postData)
        .then(
          (value) => {
            id = value.id,
          },
        )
        .catchError(
          (e) {},
        );
    return id;
  }
}

final memberRepositoryProvider =
    Provider<IMemberRepository>((ref) => IMemberRepository());
