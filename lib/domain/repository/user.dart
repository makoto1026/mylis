import 'package:mylis/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> get(String uuid);
}
