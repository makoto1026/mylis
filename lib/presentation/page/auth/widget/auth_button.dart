import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/font_size.dart';

class AuthButton extends HookConsumerWidget {
  const AuthButton({
    required this.onPressed,
    required this.iconPath,
    this.iconColor = Colors.white,
    required this.text,
    required this.backgroundColor,
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String iconPath;
  final Color iconColor;
  final String text;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            vertical: isTablet ? 20 : 10,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        foregroundColor: MaterialStateProperty.all<Color>(textColor),
        splashFactory: NoSplash.splashFactory,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: isTablet ? 52 : 26,
            height: isTablet ? 52 : 26,
            color: iconColor,
          ),
          SizedBox(width: isTablet ? 30 : 15),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet
                  ? ThemeFontSize.tabletNormalFontSize
                  : ThemeFontSize.normalFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
