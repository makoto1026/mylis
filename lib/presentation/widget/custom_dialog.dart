import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/font_size.dart';

class CustomDialog extends HookConsumerWidget {
  const CustomDialog({
    required this.title,
    this.message = "",
    this.noButtonText = "いいえ",
    this.okButtonText = "はい",
    required this.onPressedWithNo,
    required this.onPressedWithOk,
    this.isDoubleButton = true,
    Key? key,
  }) : super(key: key);
  final String title;
  final String message;
  final String noButtonText;
  final String okButtonText;
  final void Function() onPressedWithNo;
  final void Function() onPressedWithOk;
  final bool isDoubleButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    return MylisBaseDialog(
      widget: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTablet
                  ? ThemeFontSize.tabletMediumFontSize
                  : ThemeFontSize.mediumFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: message != "" ? 10 : 20),
          if (message != "")
            Column(
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: isTablet
                        ? ThemeFontSize.tabletNormalFontSize
                        : ThemeFontSize.normalFontSize,
                  ),
                ),
                SizedBox(height: isTablet ? 40 : 20),
              ],
            ),
          isDoubleButton
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: isTablet ? 150 : 100,
                      height: 50,
                      child: OutlinedRoundRectButton(
                        onPressed: onPressedWithNo,
                        text: noButtonText,
                      ),
                    ),
                    SizedBox(width: isTablet ? 40 : 20),
                    SizedBox(
                      width: isTablet ? 150 : 100,
                      height: 50,
                      child: RoundRectButton(
                        onPressed: onPressedWithOk,
                        text: okButtonText,
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  width: isTablet ? 150 : 100,
                  height: 50,
                  child: RoundRectButton(
                    onPressed: onPressedWithOk,
                    text: okButtonText,
                  ),
                ),
        ],
      ),
    );
  }
}
