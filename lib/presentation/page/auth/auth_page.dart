import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/mixin.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'サインイン・サインアウト',
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
              RoundRectButton(
                onPressed: () => {
                  Navigator.pushNamed(context, RouteNames.emailSignIn.path),
                },
                text: "サインイン",
              ),
              const SizedBox(height: 30),
              RoundRectButton(
                onPressed: () => {
                  Navigator.pushNamed(context, RouteNames.emailSignUp.path),
                },
                text: "サインアップ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
