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

  Future<void> updateIsHiddenSaveMemoNoticeDialog(bool isHidden) async {
    await memberRepository.get(state?.uuid ?? "").then(
          (value) async => {
            state = Member(
              uuid: value.uuid,
              email: value.email,
              password: value.password,
              textColor: value.textColor,
              buttonColor: value.buttonColor,
              iconColor: value.iconColor,
              isRemovedAds: value.isRemovedAds,
              isHiddenSaveMemoNoticeDialog: isHidden,
              isReadedNews: value.isReadedNews,
              registeredArticleCount: value.registeredArticleCount,
              createdAt: value.createdAt,
              updatedAt: value.updatedAt,
              deletedAt: value.deletedAt,
            ),
            await memberRepository.update(state!),
          },
        );
  }

  Future<void> updateRegisteredArticleCount() async {
    final registeredArticleCount = state?.registeredArticleCount ?? 0;
    await memberRepository.get(state?.uuid ?? "").then(
          (value) async => {
            state = Member(
              uuid: value.uuid,
              email: value.email,
              password: value.password,
              textColor: value.textColor,
              buttonColor: value.buttonColor,
              iconColor: value.iconColor,
              isRemovedAds: value.isRemovedAds,
              isHiddenSaveMemoNoticeDialog: value.isHiddenSaveMemoNoticeDialog,
              isReadedNews: value.isReadedNews,
              registeredArticleCount: registeredArticleCount + 1,
              createdAt: value.createdAt,
              updatedAt: value.updatedAt,
              deletedAt: value.deletedAt,
            ),
            await memberRepository.update(state!),
          },
        );
  }

  Future<void> updateIsReadedNews(bool isReaded) async {
    await memberRepository.get(state?.uuid ?? "").then(
          (value) async => {
            state = Member(
              uuid: value.uuid,
              email: value.email,
              password: value.password,
              textColor: value.textColor,
              buttonColor: value.buttonColor,
              iconColor: value.iconColor,
              isRemovedAds: value.isRemovedAds,
              isHiddenSaveMemoNoticeDialog: value.isHiddenSaveMemoNoticeDialog,
              isReadedNews: isReaded,
              registeredArticleCount: value.registeredArticleCount,
              createdAt: value.createdAt,
              updatedAt: value.updatedAt,
              deletedAt: value.deletedAt,
            ),
            await memberRepository.update(state!),
          },
        );
  }
}

final currentMemberProvider =
    StateNotifierProvider.autoDispose<CurrentMemberProvider, Member?>(
  (ref) => CurrentMemberProvider(
      read: ref.read, memberRepository: ref.watch(memberRepositoryProvider)),
);

final isSignedInProvider =
    Provider.autoDispose((ref) => ref.watch(currentMemberProvider) != null);
