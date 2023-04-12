import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/controller/auth_controller.dart';
import 'package:mylis/presentation/page/auth/widget/auth_button.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isIOS = Platform.isIOS;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 30,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'myLis',
                style: TextStyle(
                  color: ThemeColor.orange,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '自分だけのブックマークを作ろう！',
                style: TextStyle(
                  color: ThemeColor.darkGray,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 60),
              // Twitterログインは一旦保留
              // AuthButton(
              //   onPressed: () => {
              //     Navigator.pushNamed(context, RouteNames.emailSignIn.path),
              //   },
              //   iconPath: "assets/icons/twitter.svg",
              //   text: "Twitterログイン・新規登録",
              //   backgroundColor: ThemeColor.blue,
              // ),
              // const SizedBox(height: 20),
              isIOS
                  ? AuthButton(
                      onPressed: () => {
                        ref
                            .read(authController.notifier)
                            .signInWithApple()
                            .catchError(
                          (e) async {
                            await showToast(message: "Apple認証に失敗しました");
                          },
                        ),
                      },
                      iconPath: "assets/icons/apple.svg",
                      text: "Appleログイン・新規登録",
                      backgroundColor: ThemeColor.black,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              AuthButton(
                onPressed: () async => {
                  await ref
                      .read(authController.notifier)
                      .signInWithGoogle()
                      .catchError(
                    (e) async {
                      await showToast(message: "Google認証に失敗しました");
                    },
                  ),
                },
                iconPath: "assets/icons/google.svg",
                text: "Googleログイン・新規登録",
                backgroundColor: isIOS ? ThemeColor.white : ThemeColor.darkGray,
                textColor: isIOS ? ThemeColor.darkGray : ThemeColor.white,
                iconColor: isIOS ? ThemeColor.darkGray : ThemeColor.white,
              ),
              const SizedBox(height: 20),
              AuthButton(
                onPressed: () => {
                  Navigator.pushNamed(context, RouteNames.emailSignIn.path),
                },
                iconPath: "assets/icons/mail.svg",
                text: "メールアドレスログイン",
                backgroundColor: ThemeColor.orange,
              ),
              const SizedBox(height: 20),
              AuthButton(
                onPressed: () => {
                  Navigator.pushNamed(context, RouteNames.emailSignUp.path),
                },
                iconPath: "assets/icons/mail.svg",
                text: "メールアドレス新規登録",
                backgroundColor: ThemeColor.white,
                textColor: ThemeColor.orange,
                iconColor: ThemeColor.orange,
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "ログインにより  ",
                      style: TextStyle(
                        color: ThemeColor.darkGray,
                        fontSize: 10,
                      ),
                    ),
                    TextSpan(
                      text: "利用規約",
                      style: const TextStyle(
                        color: ThemeColor.orange,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.termsOfUse.path,
                          );
                        },
                    ),
                    const TextSpan(
                      text: "  と  ",
                      style: TextStyle(
                        color: ThemeColor.darkGray,
                        fontSize: 10,
                      ),
                    ),
                    TextSpan(
                      text: "プライバシーポリシー",
                      style: const TextStyle(
                        color: ThemeColor.orange,
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.privacyPolicy.path,
                          );
                        },
                    ),
                    const TextSpan(
                      text: "  に同意したものとみなします。",
                      style: TextStyle(
                        color: ThemeColor.darkGray,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
