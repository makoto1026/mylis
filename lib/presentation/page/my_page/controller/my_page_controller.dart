import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/member.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/member.dart';
import 'package:mylis/presentation/page/my_page/controller/my_page_state.dart';

class UserController extends StateNotifier<MyPageState> {
  UserController({
    required this.memberRepository,
  }) : super(
          MyPageState(
            member: Member(
              uuid: '',
              password: '',
              email: '',
              textColor: 0,
              buttonColor: 0,
              iconColor: 0,
              isRemovedAds: false,
              isHiddenSaveMemoNoticeDialog: false,
              isReadedNews: null,
              registeredArticleCount: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              deletedAt: null,
            ),
          ),
        );

  MemberRepository memberRepository;

  Future<void> get(String uuid) async {
    final member = await memberRepository.get(uuid);
    state = state.copyWith(member: member);
  }
}

final userController = StateNotifierProvider<UserController, MyPageState>(
  (ref) =>
      UserController(memberRepository: ref.watch(memberRepositoryProvider)),
);
