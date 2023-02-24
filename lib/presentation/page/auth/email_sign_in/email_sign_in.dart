import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/controller/auth_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/mixin.dart';

class EmailSignInPage extends HookConsumerWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'メールアドレスサインイン',
          style: pageHeaderTextStyle,
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
                        text: "戻る",
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
                              .emailSignIn()
                              .then(
                                (value) => {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteNames.main.path,
                                    (route) => false,
                                  )
                                },
                              )
                              .catchError(
                                (e) => {
                                  print(e),
                                },
                              )
                        },
                        text: "サインイン",
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
