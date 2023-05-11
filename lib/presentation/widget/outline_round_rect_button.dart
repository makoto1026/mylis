import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class OutlinedRoundRectButton extends HookConsumerWidget {
  const OutlinedRoundRectButton({
    required this.onPressed,
    this.text = "",
    this.disable = false,
    this.isIconButton = false,
    this.isAuth = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final bool disable;
  final bool isIconButton;
  final bool isAuth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: isAuth ? ThemeColor.orange : colorState.textColor,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
      ),
      child: text == ""
          ? Icon(
              Icons.turn_left,
              color: isAuth ? ThemeColor.orange : colorState.textColor,
              size: isTablet ? 36 : 24,
            )
          : Text(
              text,
              style: TextStyle(
                color: isAuth ? ThemeColor.orange : colorState.textColor,
                fontSize: isTablet
                    ? ThemeFontSize.tabletMediumFontSize
                    : ThemeFontSize.mediumFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
