import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/my_page/widget/mypage_text_button.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/mixin.dart';
import 'package:mylis/presentation/page/main_page.dart' as main_page;

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = ref.read(currentTabProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'マイページ',
          style: pageHeaderTextStyle,
        ),
      ),
      body: Center(
        child: Container(
          width: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TODO: リリースキャンペーン終了後に解放
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
              // MypageTextButton(
              //   onTap: () => {},
              //   text: "カスタマイズ",
              // ),
              MypageTextButton(
                onTap: () => {
                  ref.read(sessionProvider.notifier).signOut().whenComplete(
                        () => {
                          tabController.changeTab(
                            main_page.Tab.home,
                          ),
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.auth.path,
                            (route) => false,
                          )
                        },
                      ),
                },
                text: "ログアウト",
              ),
              MypageTextButton(
                onTap: () => {},
                text: "使い方",
              ),
              MypageTextButton(
                onTap: () => {},
                text: "お問い合わせ",
              ),
              MypageTextButton(
                onTap: () => {},
                text: "利用規約",
              ),
              MypageTextButton(
                onTap: () => {},
                text: "プライバシーポリシー",
                hasMargin: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
