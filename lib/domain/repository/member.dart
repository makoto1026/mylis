import 'package:mylis/domain/entities/member.dart';

abstract class MemberRepository {
  Future<Member> get(String uuid);
  Future<Member> update(Member member);
  Future<void> delete({required String currentMemberId});
}
