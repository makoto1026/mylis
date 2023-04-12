import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/controller/auth_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/snippets/show_auth_error_dialog.dart';
import 'package:mylis/theme/color.dart';

class EmailSignInPage extends HookConsumerWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'メールアドレスログイン',
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
                        onPressed: () => {
                          ref
                              .read(authController.notifier)
                              .signInWithEmail()
                              .catchError(
                                (e) async => {
                                  await showAuthErrorDialog(
                                    ref.read,
                                    "ログイン情報が正しくありません。メールアドレス、パスワードをご確認ください。",
                                  ),
                                },
                              ),
                        },
                        text: "ログイン",
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
