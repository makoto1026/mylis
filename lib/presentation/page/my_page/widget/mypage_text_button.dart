import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class MypageTextButton extends HookConsumerWidget {
  const MypageTextButton({
    required this.onTap,
    required this.text,
    this.isLogout = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;
  final bool isLogout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 30 : 15,
        horizontal: isTablet ? 40 : 20,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.darkGray,
                  fontSize: isTablet
                      ? ThemeFontSize.tabletNormalFontSize
                      : ThemeFontSize.normalFontSize,
                ),
              ),
            ),
            isLogout
                ? const SizedBox.shrink()
                : Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: ThemeColor.darkGray,
                    size: isTablet ? 24 : 16,
                  ),
          ],
        ),
      ),
    );
  }
}
