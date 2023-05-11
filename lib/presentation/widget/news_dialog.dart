import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class NewsDialog extends HookConsumerWidget {
  const NewsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    return MylisBaseDialog(
      widget: Column(
        children: [
          Text(
            "iPad版正式リリース！",
            style: TextStyle(
              fontSize: isTablet
                  ? ThemeFontSize.tabletMediumFontSize
                  : ThemeFontSize.mediumFontSize,
              fontWeight: FontWeight.bold,
              color: colorState.textColor,
            ),
          ),
          SizedBox(height: isTablet ? 40 : 20),
          Text(
            "β版にて公開していたiPad版が正式リリースされました！\n\n現在iPhoneでご利用中のデータはそのままに、iPadでもご利用いただけます！\n\niPadで「mylis」を検索！",
            style: TextStyle(
              fontSize: isTablet
                  ? ThemeFontSize.tabletNormalFontSize
                  : ThemeFontSize.normalFontSize,
              fontWeight: FontWeight.bold,
              color: ThemeColor.darkGray,
            ),
          ),
          SizedBox(height: isTablet ? 40 : 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ThemeColor.gray,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/save_memo.jpg",
                width: isTablet ? 600 : 300,
                height: isTablet ? 200 : 100,
              ),
            ),
          ),
          SizedBox(height: isTablet ? 40 : 20),
          const Divider(),
          SizedBox(height: isTablet ? 60 : 30),
          SizedBox(
            height: 50,
            width: isTablet ? 260 : 160,
            child: RoundRectButton(
              onPressed: () => {
                ref
                    .read(currentMemberProvider.notifier)
                    .updateIsReadedNews(true),
                Navigator.pop(context),
              },
              text: "今後は表示しない",
            ),
          ),
        ],
      ),
    );
  }
}
