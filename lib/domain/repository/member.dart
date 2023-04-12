import 'package:mylis/domain/entities/member.dart';

abstract class MemberRepository {
  Future<Member> get(String uuid);
  Future<Member> update({
    required String currentMemberId,
    required String textColor,
    required String buttonColor,
    required String iconColor,
  });
  Future<void> delete({required String currentMemberId});
}
