import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/theme/color.dart';

class RoundRectButton extends HookConsumerWidget {
  const RoundRectButton({
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.disable = false,
    this.fontSize = 16,
    this.isAuth = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final bool disable;
  final double fontSize;
  final bool isAuth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
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
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
