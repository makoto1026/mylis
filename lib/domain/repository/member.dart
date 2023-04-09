import 'package:mylis/domain/entities/member.dart';

abstract class MemberRepository {
  Future<Member> get(String uuid);
  Future<String> create(String email, String password);
  Future<Member> update({
    required String currentMemberId,
    required String textColor,
    required String buttonColor,
    required String iconColor,
  });
}
