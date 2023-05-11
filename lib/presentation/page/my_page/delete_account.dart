import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/my_page/widget/mypage_text_button.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/presentation/page/main_page.dart' as main_page;
import 'package:mylis/theme/font_size.dart';

class DeleteAccountPage extends HookConsumerWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "退会はこちら",
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
        leadingWidth: isTablet ? 80 : 40,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: isTablet ? 36 : 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColor.darkGray,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MypageTextButton(
            onTap: () => {
              showDialog(
                context: context,
                barrierColor: colorState.textColor.withOpacity(0.25),
                builder: (BuildContext context) {
                  return CustomDialog(
                    title: "本当に退会しますか？",
                    message: "退会すると、すべてのデータが削除されます。",
                    onPressedWithNo: () => Navigator.pop(context),
                    onPressedWithOk: () => {
                      ref.read(currentMemberProvider.notifier).delete(),
                      ref.read(sessionProvider.notifier).signOut(),
                      ref.read(currentTabProvider.notifier).changeTab(
                            main_page.Tab.home,
                          ),
                      Navigator.of(context, rootNavigator: false)
                          .pushNamedAndRemoveUntil(
                        RouteNames.auth.path,
                        (_) => false,
                      ),
                      showToast(
                        message: "退会しました",
                        fontSize: isTablet
                            ? ThemeFontSize.tabletMediumFontSize
                            : ThemeFontSize.mediumFontSize,
                      ),
                    },
                  );
                },
              ),
            },
            text: "退会する",
            isLogout: true,
          ),
        ],
      ),
    );
  }
}
