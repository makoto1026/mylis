import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/my_page/widget/mypage_text_button.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/provider/current_member_provider.dart';
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
    final currentMember = ref.watch(currentMemberProvider);
    final banner = ref.watch(mypageBannerAdProvider);

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
        children: [
          Expanded(
            child: Column(
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
                  text: "リスト編集",
                ),
                MypageTextButton(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      RouteNames.customize.path,
                    )
                  },
                  text: "テーマカラー変更",
                ),
                MypageTextButton(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      RouteNames.usage.path,
                    )
                  },
                  text: "使い方",
                ),
                MypageTextButton(
                  onTap: () => {
                    openUrl(url: "https://trsmmkt.editorx.io/mylis/blank-2"),
                  },
                  text: "よくある質問",
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
                      arguments: false,
                    )
                  },
                  text: "利用規約",
                ),
                MypageTextButton(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      RouteNames.privacyPolicy.path,
                      arguments: false,
                    )
                  },
                  text: "プライバシーポリシー",
                ),
                const SizedBox(height: 20),
                MypageTextButton(
                  onTap: () => {
                    showDialog(
                      context: context,
                      barrierColor: colorState.textColor.withOpacity(0.25),
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: "ログアウトしますか？",
                          onPressedWithNo: () => Navigator.pop(context),
                          onPressedWithOk: () => {
                            ref.read(sessionProvider.notifier).signOut(),
                            ref.read(currentTabProvider.notifier).changeTab(
                                  main_page.Tab.home,
                                ),
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.auth.path,
                              (route) => false,
                            ),
                            showToast(message: "ログアウトしました"),
                          },
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
          ),
          currentMember?.isRemovedAds == true
              ? const SizedBox.shrink()
              : Container(
                  color: ThemeColor.white,
                  height: 50,
                  width: double.infinity,
                  child: AdWidget(ad: banner),
                ),
        ],
      ),
    );
  }
}
