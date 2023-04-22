import 'package:mylis/domain/entities/member.dart';

abstract class MemberRepository {
  Future<Member> get(String uuid);
  Future<Member> update({
    required String currentMemberId,
    required int textColor,
    required int buttonColor,
    required int iconColor,
  });
  Future<void> delete({required String currentMemberId});
}
