import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class BackNoticeDialog extends HookConsumerWidget {
  const BackNoticeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    return MylisBaseDialog(
      widget: Column(
        children: [
          Text(
            "変更が保存されていません",
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
            "保存せずに戻りますか？",
            style: TextStyle(
              fontSize: isTablet
                  ? ThemeFontSize.tabletNormalFontSize
                  : ThemeFontSize.normalFontSize,
              fontWeight: FontWeight.bold,
              color: ThemeColor.darkGray,
            ),
          ),
          SizedBox(height: isTablet ? 40 : 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: isTablet ? 150 : 100,
                child: OutlinedRoundRectButton(
                  onPressed: () => Navigator.pop(context, false),
                  text: "いいえ",
                ),
              ),
              SizedBox(width: isTablet ? 40 : 20),
              SizedBox(
                height: 50,
                width: isTablet ? 150 : 100,
                child: RoundRectButton(
                  onPressed: () => Navigator.pop(context, true),
                  text: "はい",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
