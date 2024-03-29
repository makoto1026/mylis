import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/controller/auth_controller.dart';
import 'package:mylis/presentation/page/auth/email_sign_in/email_sign_in.dart';
import 'package:mylis/presentation/page/auth/email_sign_up/email_sign_up.dart';
import 'package:mylis/presentation/page/auth/widget/auth_button.dart';
import 'package:mylis/presentation/page/privacy_policy/privacy_policy.dart';
import 'package:mylis/presentation/page/terms_of_use/terms_of_use.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';
import 'package:page_transition/page_transition.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    bool isIOS = Platform.isIOS;

    final isShowEmailAuthButtons = useState(false);

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) async => {
          await ref.read(isTabletProvider.notifier).set(context),
        },
      );
      return () {};
    }, []);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(isTablet ? 60 : 30),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'mylis',
                style: TextStyle(
                  color: ThemeColor.orange,
                  fontSize: isTablet
                      ? ThemeFontSize.tabletHugeFontSize
                      : ThemeFontSize.hugeFontSize,
                ),
              ),
              SizedBox(height: isTablet ? 20 : 10),
              Text(
                '最適なブックマーク体験を',
                style: TextStyle(
                  color: ThemeColor.darkGray,
                  fontSize: isTablet
                      ? ThemeFontSize.tabletSmallFontSize
                      : ThemeFontSize.smallFontSize,
                ),
              ),
              SizedBox(height: isTablet ? 120 : 60),
              // Twitterログインは一旦保留
              // AuthButton(
              //   onPressed: () => {
              //     Navigator.pushNamed(context, RouteNames.emailSignIn.path),
              //   },
              //   iconPath: "assets/icons/twitter.svg",
              //   text: "Twitterログイン・新規登録",
              //   backgroundColor: ThemeColor.blue,
              // ),
              // SizedBox(height: isTablet ? 40 : 20),
              isIOS
                  ? AuthButton(
                      onPressed: () async => {
                        await ref
                            .read(loadingStateProvider.notifier)
                            .startLoading(),
                        await ref
                            .read(authController.notifier)
                            .signInWithApple()
                            .catchError(
                          (e) async {
                            await ref
                                .read(loadingStateProvider.notifier)
                                .stopLoading();
                            await showToast(
                              message: "Apple認証に失敗しました",
                              fontSize: isTablet
                                  ? ThemeFontSize.tabletMediumFontSize
                                  : ThemeFontSize.mediumFontSize,
                            );
                          },
                        ),
                      },
                      iconPath: "assets/icons/apple.svg",
                      text: "Appleログイン・新規登録",
                      backgroundColor: ThemeColor.black,
                    )
                  : const SizedBox.shrink(),
              SizedBox(height: isTablet ? 40 : 20),
              AuthButton(
                onPressed: () async => {
                  await ref.read(loadingStateProvider.notifier).startLoading(),
                  await ref
                      .read(authController.notifier)
                      .signInWithGoogle()
                      .catchError(
                    (e) async {
                      await ref
                          .read(loadingStateProvider.notifier)
                          .stopLoading();
                      await showToast(
                        message: "Google認証に失敗しました",
                        fontSize: isTablet
                            ? ThemeFontSize.tabletMediumFontSize
                            : ThemeFontSize.mediumFontSize,
                      );
                    },
                  ),
                },
                iconPath: "assets/icons/google.svg",
                text: "Googleログイン・新規登録",
                backgroundColor: isIOS ? ThemeColor.white : ThemeColor.darkGray,
                textColor: isIOS ? ThemeColor.darkGray : ThemeColor.white,
                iconColor: isIOS ? ThemeColor.darkGray : ThemeColor.white,
              ),
              SizedBox(height: isTablet ? 40 : 20),
              isShowEmailAuthButtons.value
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        AuthButton(
                          onPressed: () => {
                            isShowEmailAuthButtons.value =
                                !isShowEmailAuthButtons.value,
                          },
                          iconPath: "assets/icons/mail.svg",
                          text: "メールログイン・新規登録",
                          backgroundColor: ThemeColor.orange,
                        ),
                        SizedBox(height: isTablet ? 40 : 20),
                      ],
                    ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.5),
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: isShowEmailAuthButtons.value
                    ? Column(
                        children: [
                          AuthButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const EmailSignInPage(),
                                ),
                              ),
                            },
                            iconPath: "assets/icons/mail.svg",
                            text: "メールログイン",
                            backgroundColor: ThemeColor.white,
                            textColor: ThemeColor.orange,
                            iconColor: ThemeColor.orange,
                          ),
                          SizedBox(height: isTablet ? 40 : 20),
                          AuthButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const EmailSignUpPage(),
                                ),
                              ),
                            },
                            iconPath: "assets/icons/mail.svg",
                            text: "メール新規登録",
                            backgroundColor: ThemeColor.white,
                            textColor: ThemeColor.orange,
                            iconColor: ThemeColor.orange,
                          ),
                          SizedBox(height: isTablet ? 40 : 20),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "ログインにより  ",
                      style: TextStyle(
                        color: ThemeColor.darkGray,
                        fontSize: isTablet
                            ? ThemeFontSize.tabletTinyFontSize
                            : ThemeFontSize.tinyFontSize,
                      ),
                    ),
                    TextSpan(
                      text: "利用規約",
                      style: TextStyle(
                        color: ThemeColor.orange,
                        fontSize: isTablet
                            ? ThemeFontSize.tabletTinyFontSize
                            : ThemeFontSize.tinyFontSize,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const TermsOfUsePage(isFromAuthPage: true),
                            ),
                          );
                        },
                    ),
                    TextSpan(
                      text: "  と  ",
                      style: TextStyle(
                        color: ThemeColor.darkGray,
                        fontSize: isTablet
                            ? ThemeFontSize.tabletTinyFontSize
                            : ThemeFontSize.tinyFontSize,
                      ),
                    ),
                    TextSpan(
                      text: "プライバシーポリシー",
                      style: TextStyle(
                        color: ThemeColor.orange,
                        fontSize: isTablet
                            ? ThemeFontSize.tabletTinyFontSize
                            : ThemeFontSize.tinyFontSize,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child:
                                  const PrivacyPolicyPage(isFromAuthPage: true),
                            ),
                          );
                        },
                    ),
                    TextSpan(
                      text: "  に同意したものとみなします。",
                      style: TextStyle(
                        color: ThemeColor.darkGray,
                        fontSize: isTablet
                            ? ThemeFontSize.tabletTinyFontSize
                            : ThemeFontSize.tinyFontSize,
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
