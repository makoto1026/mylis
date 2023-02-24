import 'package:mylis/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<String> emailSignUp(Auth auth);
  Future<String> emailSignIn(Auth auth);
}
