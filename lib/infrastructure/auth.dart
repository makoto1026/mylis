import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/auth.dart';
import 'package:mylis/domain/repository/auth.dart';

class IAuthRepository extends AuthRepository {
  IAuthRepository();

  final firebase = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<String> emailSignUp(Auth auth) async {
    final UserCredential userInfo =
        await firebase.createUserWithEmailAndPassword(
      email: auth.email,
      password: auth.password,
    );

    final email = userInfo.user!.email;

    await firestore.collection("users").add({
      "email": email,
      "password": auth.password,
      "createAt": Timestamp.now(),
    });

    return userInfo.user!.uid;
  }

  @override
  Future<String> emailSignIn(Auth auth) async {
    final userInfo = await firebase.signInWithEmailAndPassword(
      email: auth.email,
      password: auth.password,
    );

    return userInfo.user!.uid;
  }
}

final authRepositoryProvider =
    Provider<IAuthRepository>((ref) => IAuthRepository());
