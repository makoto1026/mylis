import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/auth.dart';
import 'package:mylis/domain/repository/auth.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';

class IAuthRepository extends AuthRepository {
  IAuthRepository();

  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final userDB = Firestore.users;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<String> signUpWithEmail(Auth auth) async {
    final UserCredential userInfo =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: auth.email,
      password: auth.password,
    );

    final email = userInfo.user!.email;

    await firestore.collection("users").add({
      "email": email,
      "password": auth.password,
      "create_at": Timestamp.now(),
    });

    return userInfo.user!.uid;
  }

  @override
  Future<String> signInWithEmail(Auth auth) async {
    final userInfo = await firebaseAuth.signInWithEmailAndPassword(
      email: auth.email,
      password: auth.password,
    );

    return userInfo.user!.uid;
  }

  @override
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);
    final User? user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != "");

      final User currentUser = firebaseAuth.currentUser!;
      assert(user.uid == currentUser.uid);
      final docRef = userDB.doc(user.uid);
      docRef.get().then(
            (value) => {
              if (!value.exists)
                docRef.set(
                  {
                    "email": user.email,
                    "password": "",
                    "created_at": DateTime.now(),
                    "updated_at": DateTime.now(),
                  },
                )
            },
          );
      return user.uid;
    }
    return '';
  }

  @override
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}

final authRepositoryProvider =
    Provider<IAuthRepository>((ref) => IAuthRepository());
