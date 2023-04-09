import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';

class OutlinedRoundRectButton extends HookConsumerWidget {
  const OutlinedRoundRectButton({
    required this.onPressed,
    this.text = "",
    this.disable = false,
    this.fontSize = 16,
    this.isIconButton = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final bool disable;
  final double fontSize;
  final bool isIconButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(
            color: colorState.textColor,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        elevation: 0,
      ),
      child: text == ""
          ? Icon(
              Icons.turn_left,
              color: colorState.textColor,
            )
          : Text(
              text,
              style: TextStyle(
                color: colorState.textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
