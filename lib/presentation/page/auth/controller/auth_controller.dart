import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/auth.dart';
import 'package:mylis/domain/repository/auth.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/auth.dart';
import 'package:mylis/infrastructure/member.dart';
import 'package:mylis/presentation/page/auth/controller/auth_state.dart';
import 'package:mylis/provider/session_provider.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required this.authRepository,
    required this.memberRepository,
    required Reader read,
  })  : _read = read,
        super(
          const AuthState(
            email: "",
            password: "",
          ),
        );

  AuthRepository authRepository;
  MemberRepository memberRepository;
  final Reader _read;

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  // メールアドレスサインアップ
  Future<void> signUpWithEmail() async {
    var auth = Auth(email: state.email, password: state.password);
    await authRepository
        .signUpWithEmail(auth)
        .then(
          (value) async => {
            await memberRepository.create(state.email, state.password),
            _read(sessionProvider.notifier).signIn(value),
          },
        )
        .catchError(
          (e) {},
        );
  }

  // メールアドレスサインイン
  Future<void> signInWithEmail() async {
    var auth = Auth(email: state.email, password: state.password);
    await authRepository
        .signInWithEmail(auth)
        .then(
          (value) => {
            _read(sessionProvider.notifier).signIn(value),
          },
        )
        .catchError(
          (e) {},
        );
  }

  // Googleサインイン
  Future<void> signInWithGoogle() async {
    await authRepository.signInWithGoogle().then(
          (value) => {
            _read(sessionProvider.notifier).signIn(value),
          },
        );
  }

  // Appleサインイン
  Future<void> signInWithApple() async {
    await authRepository.signInWithApple().then(
          (value) => {
            print("Appleサインイン成功 ${value}"),
            _read(sessionProvider.notifier).signIn(value),
          },
        );
  }
}

final authController = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    memberRepository: ref.watch(memberRepositoryProvider),
    read: ref.read,
  ),
);
