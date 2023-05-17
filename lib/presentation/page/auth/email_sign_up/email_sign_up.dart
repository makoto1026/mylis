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

class EmailSignUpPage extends HookConsumerWidget {
  const EmailSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新規登録',
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
