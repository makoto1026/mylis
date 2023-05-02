import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/controller/auth_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/show_auth_error_dialog.dart';
import 'package:mylis/theme/color.dart';

class EmailSignUpPage extends HookConsumerWidget {
  const EmailSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '新規登録',
          style: TextStyle(
            color: ThemeColor.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 30,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MylisTextField(
                title: "メールアドレス",
                onChanged: (value) =>
                    ref.read(authController.notifier).setEmail(value),
              ),
              const SizedBox(height: 30),
              MylisTextField(
                title: "パスワード",
                onChanged: (value) =>
                    ref.read(authController.notifier).setPassword(value),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: 52,
                      child: OutlinedRoundRectButton(
                        onPressed: () => {
                          Navigator.pop(context),
                        },
                        isAuth: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: 160,
                      child: RoundRectButton(
                        onPressed: () async => {
                          await ref
                              .read(loadingStateProvider.notifier)
                              .startLoading(),
                          await ref
                              .read(authController.notifier)
                              .signUpWithEmail()
                              .catchError(
                            (e) async {
                              await ref
                                  .read(loadingStateProvider.notifier)
                                  .stopLoading();
                              String errorMessage =
                                  "登録に失敗しました。\n再度お試しいただくか、別のメールアドレスを使用してください。";

                              if (e is FirebaseException) {
                                switch (e.code) {
                                  case 'email-already-in-use':
                                    errorMessage = 'このメールアドレスは既に使用されています。';
                                    break;
                                  case 'invalid-email':
                                    errorMessage = 'メールアドレスの形式が正しくありません。';
                                    break;
                                  case 'weak-password':
                                    errorMessage = 'パスワードは6文字以上で入力してください。';
                                    break;
                                }
                              }
                              await showAuthErrorDialog(ref.read, errorMessage);
                            },
                          ),
                        },
                        text: "登録",
                        isAuth: true,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
