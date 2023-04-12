import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/member.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/member.dart';

class CurrentMemberProvider extends StateNotifier<Member?> {
  CurrentMemberProvider({
    required Reader read,
    required this.memberRepository,
  }) : super(null);

  MemberRepository memberRepository;

  Future<void> set(String? uuid) async {
    try {
      state = await memberRepository.get(uuid ?? '');
    } catch (e) {
      return;
    }
  }

  void signOut() {
    state = null;
  }

  Future<void> delete() async {
    try {
      await memberRepository.delete(currentMemberId: state?.uuid ?? "");
      state = null;
    } catch (e) {
      return;
    }
  }
}

final currentMemberProvider =
    StateNotifierProvider.autoDispose<CurrentMemberProvider, Member?>(
  (ref) => CurrentMemberProvider(
      read: ref.read, memberRepository: ref.watch(memberRepositoryProvider)),
);

final isSignedInProvider =
    Provider.autoDispose((ref) => ref.watch(currentMemberProvider) != null);
