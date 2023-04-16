import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/my_page/widget/mypage_text_button.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/presentation/page/main_page.dart' as main_page;

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'マイページ',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // サブスクは一旦保留
          // MypageTextButton(
          //   onTap: () => {},
          //   text: "サブスクリプション",
          // ),
          MypageTextButton(
            onTap: () => {
              Navigator.pushNamed(
                context,
                RouteNames.editTagList.path,
              )
            },
            text: "タグ編集",
          ),
          MypageTextButton(
            onTap: () => {
              Navigator.pushNamed(
                context,
                RouteNames.customize.path,
              )
            },
            text: "カスタマイズ",
          ),
          MypageTextButton(
            onTap: () => {
              openMailApp(),
            },
            text: "お問い合わせ",
          ),
          MypageTextButton(
            onTap: () => {
              Navigator.pushNamed(
                context,
                RouteNames.termsOfUse.path,
              )
            },
            text: "利用規約",
          ),
          MypageTextButton(
            onTap: () => {
              Navigator.pushNamed(
                context,
                RouteNames.privacyPolicy.path,
              )
            },
            text: "プライバシーポリシー",
          ),
          const SizedBox(height: 20),
          MypageTextButton(
            onTap: () => {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("ログアウトしますか？"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("いいえ"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text("はい"),
                        onPressed: () async {
                          ref.read(sessionProvider.notifier).signOut();
                          ref.read(currentTabProvider.notifier).changeTab(
                                main_page.Tab.home,
                              );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.auth.path,
                            (route) => false,
                          );
                          showToast(message: "ログアウトしました");
                        },
                      ),
                    ],
                  );
                },
              ),
            },
            text: "ログアウト",
            isLogout: true,
          ),
          const SizedBox(height: 40),
          Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextButton(
                onPressed: () => {
                  Navigator.pushNamed(
                    context,
                    RouteNames.deleteAccount.path,
                  )
                },
                child: const Text(
                  "退会はこちら",
                  style: TextStyle(
                    color: ThemeColor.darkGray,
                    fontSize: 12,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
