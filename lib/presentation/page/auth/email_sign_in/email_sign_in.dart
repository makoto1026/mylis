import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/controller/auth_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/show_auth_error_dialog.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class EmailSignInPage extends HookConsumerWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ログイン',
          style: TextStyle(
            color: ThemeColor.orange,
            fontWeight: FontWeight.bold,
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: isTablet ? 60 : 30,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MylisTextField(
                title: "メールアドレス",
                fontSize: isTablet
                    ? ThemeFontSize.tabletNormalFontSize
                    : ThemeFontSize.normalFontSize,
                onChanged: (value) =>
                    ref.read(authController.notifier).setEmail(value),
              ),
              SizedBox(height: isTablet ? 60 : 30),
              MylisTextField(
                title: "パスワード",
                fontSize: isTablet
                    ? ThemeFontSize.tabletNormalFontSize
                    : ThemeFontSize.normalFontSize,
                onChanged: (value) =>
                    ref.read(authController.notifier).setPassword(value),
              ),
              SizedBox(height: isTablet ? 100 : 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: isTablet ? 78 : 52,
                      child: OutlinedRoundRectButton(
                        onPressed: () => {
                          Navigator.pop(context),
                        },
                        isAuth: true,
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet ? 40 : 20),
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: isTablet ? 240 : 160,
                      child: RoundRectButton(
                        onPressed: () async => {
                          await ref
                              .read(loadingStateProvider.notifier)
                              .startLoading(),
                          await ref
                              .read(authController.notifier)
                              .signInWithEmail()
                              .catchError(
                            (e) async {
                              await ref
                                  .read(loadingStateProvider.notifier)
                                  .stopLoading();
                              String errorMessage = "";
                              if (e is FirebaseAuthException) {
                                switch (e.code) {
                                  case "invalid-email":
                                    errorMessage = "無効なメールアドレスです。";
                                    break;
                                  case "user-not-found":
                                    errorMessage = "ユーザーが見つかりませんでした。";
                                    break;
                                  case "wrong-password":
                                    errorMessage = "パスワードが間違っています。";
                                    break;
                                  default:
                                    errorMessage =
                                        "ログインに失敗しました。メールアドレス、パスワードをご確認ください。";
                                }
                              } else {
                                errorMessage =
                                    "ログインに失敗しましたメールアドレス、パスワードをご確認ください。";
                              }
                              await showAuthErrorDialog(
                                ref.read,
                                errorMessage,
                              );
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
