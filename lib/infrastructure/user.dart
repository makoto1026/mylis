import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/user.dart';
import 'package:mylis/domain/repository/user.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:mylis/infrastructure/mapper/user_mapper.dart';

class IUserRepository extends UserRepository {
  IUserRepository();

  final firestore = FirebaseFirestore.instance;

  @override
  Future<User> get(String uuid) async {
    const userId = "94Jrw17JegeWKqDkW2S5";
    return await Firestore.users.doc(userId).get().then(
      (value) {
        final doc = value.data();
        return UserMapper.fromJSON(doc!);
      },
    );
  }

  @override
  Future<String> create(String email, String password) async {
    final postData = {
      "email": email,
      "password": password,
    };
    var id = "";
    await Firestore.users
        .add(postData)
        .then(
          (value) => {
            id = value.id,
          },
        )
        .catchError(
      (e) {
        print(e);
      },
    );
    return id;
  }
}

final userRepositoryProvider =
    Provider<IUserRepository>((ref) => IUserRepository());
