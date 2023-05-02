import 'package:mylis/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<String> signUpWithEmail(Auth auth);
  Future<String> signInWithEmail(Auth auth);
  Future<String> signInWithGoogle();
  Future<void> signOutGoogle();
  Future<String> signInWithApple();
}
