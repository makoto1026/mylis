import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/auth_page.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/customize/customize.dart';
import 'package:mylis/presentation/page/my_page/delete_account.dart';
import 'package:mylis/presentation/page/my_page/usage.dart';
import 'package:mylis/presentation/page/my_page/widget/mypage_text_button.dart';
import 'package:mylis/presentation/page/privacy_policy/privacy_policy.dart';
import 'package:mylis/presentation/page/tags/edit/edit_tag_list.dart';
import 'package:mylis/presentation/page/terms_of_use/terms_of_use.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/presentation/page/main_page.dart' as main_page;
import 'package:mylis/theme/font_size.dart';
import 'package:page_transition/page_transition.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final currentMember = ref.watch(currentMemberProvider);
    final banner = ref.watch(mypageBannerAdProvider);
    final isTablet = ref.watch(isTabletProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'マイページ',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const EditTagListPage(),
                        ),
                      ),
                    },
                    text: "リスト編集",
                  ),
                  MypageTextButton(
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const CustomizePage(),
                        ),
                      ),
                    },
                    text: "テーマカラー変更",
                  ),
                  MypageTextButton(
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const UsagePage(),
                        ),
                      ),
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
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const TermsOfUsePage(isFromAuthPage: false),
                        ),
                      ),
                    },
                    text: "利用規約",
                  ),
                  MypageTextButton(
                    onTap: () => {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const PrivacyPolicyPage(isFromAuthPage: false),
                        ),
                      ),
                    },
                    text: "プライバシーポリシー",
                  ),
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
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const AuthPage(),
                                ),
                                (route) => false,
                              ),
                              showToast(
                                message: "ログアウトしました",
                                fontSize: isTablet
                                    ? ThemeFontSize.tabletMediumFontSize
                                    : ThemeFontSize.mediumFontSize,
                              ),
                            },
                          );
                        },
                      ),
                    },
                    text: "ログアウト",
                    isLogout: true,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: isTablet ? 30 : 15,
                      ),
                      child: TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const DeleteAccountPage(),
                            ),
                          ),
                        },
                        child: Text(
                          "退会はこちら",
                          style: TextStyle(
                            color: ThemeColor.darkGray,
                            fontSize: isTablet
                                ? ThemeFontSize.tabletSmallFontSize
                                : ThemeFontSize.smallFontSize,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          currentMember?.isRemovedAds == true
              ? const SizedBox.shrink()
              : Container(
                  color: ThemeColor.white,
                  height: 60,
                  width: double.infinity,
                  child: AdWidget(ad: banner),
                ),
        ],
      ),
    );
  }
}
