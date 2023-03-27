import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/auth.dart';
import 'package:mylis/domain/repository/auth.dart';
import 'package:mylis/domain/repository/user.dart';
import 'package:mylis/infrastructure/auth.dart';
import 'package:mylis/infrastructure/user.dart';
import 'package:mylis/presentation/page/auth/controller/auth_state.dart';
import 'package:mylis/provider/session_provider.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required this.authRepository,
    required this.userRepository,
    required Reader read,
  })  : _read = read,
        super(
          const AuthState(
            email: "",
            password: "",
          ),
        );

  AuthRepository authRepository;
  UserRepository userRepository;
  final Reader _read;

  Future<void> emailSignUp() async {
    var auth = Auth(email: state.email, password: state.password);
    await authRepository
        .emailSignUp(auth)
        .then(
          (value) async => {
            await userRepository.create(state.email, state.password),
            _read(sessionProvider.notifier).signIn(),
          },
        )
        .catchError(
          (e) {},
        );
  }

  Future<void> emailSignIn() async {
    var auth = Auth(email: state.email, password: state.password);
    await authRepository
        .emailSignIn(auth)
        .then(
          (value) => {
            _read(sessionProvider.notifier).signIn(),
          },
        )
        .catchError(
          (e) {},
        );
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }
}

final authController = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
    read: ref.read,
  ),
);
