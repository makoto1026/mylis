import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/theme/color.dart';

class OutlinedRoundRectButton extends HookConsumerWidget {
  const OutlinedRoundRectButton({
    required this.onPressed,
    this.text = "",
    this.disable = false,
    this.fontSize = 16,
    this.isIconButton = false,
    this.isAuth = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final bool disable;
  final double fontSize;
  final bool isIconButton;
  final bool isAuth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
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
        elevation: 0,
      ),
      child: text == ""
          ? Icon(
              Icons.turn_left,
              color: isAuth ? ThemeColor.orange : colorState.textColor,
            )
          : Text(
              text,
              style: TextStyle(
                color: isAuth ? ThemeColor.orange : colorState.textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
