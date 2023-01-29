import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/user.dart';
import 'package:mylis/domain/repository/user.dart';
import 'package:mylis/infrastructure/user.dart';
import 'package:mylis/presentation/page/my_page/controller/my_page_state.dart';

class UserController extends StateNotifier<MyPageState> {
  UserController({
    required this.userRepository,
  }) : super(
          MyPageState(
            user: User(
              name: '',
              sex: 0,
              lineUuid: '',
              email: '',
              phoneNumber: '',
              fcmToken: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        );

  UserRepository userRepository;

  Future<void> initialized() async {
    await get();
  }

  Future<void> get() async {
    final user = await userRepository.get("");
    state = state.copyWith(user: user);
  }
}

final userController = StateNotifierProvider<UserController, MyPageState>(
  (ref) => UserController(userRepository: ref.watch(userRepositoryProvider)),
);
