import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class RoundRectButton extends HookConsumerWidget {
  const RoundRectButton({
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.disable = false,
    this.isAuth = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final bool disable;
  final bool isAuth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: isAuth
            ? ThemeColor.orange
            : colorState.textColor.withOpacity(disable ? 0.5 : 1),
        shape: const StadiumBorder(
          side: BorderSide(
            color: Colors.transparent,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: isTablet
              ? ThemeFontSize.tabletMediumFontSize
              : ThemeFontSize.mediumFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
