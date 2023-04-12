import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/auth.dart';
import 'package:mylis/domain/repository/auth.dart';
import 'package:mylis/infrastructure/firestore/firestore.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

    final userDoc = userDB.doc(userInfo.user!.uid);

    await userDoc.set({
      "email": email,
      "password": auth.password,
      "text_color": "orange",
      "button_color": "orange",
      "icon_color": "orange",
      "created_at": Timestamp.now(),
      "updated_at": Timestamp.now(),
    });

    return userDoc.id;
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
                    "text_color": "orange",
                    "button_color": "orange",
                    "icon_color": "orange",
                    "created_at": DateTime.now(),
                    "updated_at": DateTime.now(),
                  },
                )
            },
          );
      return user.uid;
    }
    return "";
  }

  @override
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  @override
  Future<String> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oAuthCredential = OAuthProvider('apple.com').credential(
      accessToken: appleCredential.authorizationCode,
      idToken: appleCredential.identityToken,
    );

    final res =
        await FirebaseAuth.instance.signInWithCredential(oAuthCredential);

    final User? user = res.user;
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
                    "text_color": "orange",
                    "button_color": "orange",
                    "icon_color": "orange",
                    "created_at": DateTime.now(),
                    "updated_at": DateTime.now(),
                  },
                )
            },
          );
      return user.uid;
    }

    return "";
  }
}

final authRepositoryProvider =
    Provider<IAuthRepository>((ref) => IAuthRepository());
