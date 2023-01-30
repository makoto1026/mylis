import 'package:flutter/material.dart';
import 'package:mylis/theme/color.dart';

class OutlinedRoundRectButton extends StatelessWidget {
  const OutlinedRoundRectButton({
    required this.onPressed,
    required this.text,
    this.textColor = Colors.orange,
    this.disable = false,
    this.fontSize = 14,
    this.borderColor = ThemeColor.orange,
    this.isIconButton = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final bool disable;
  final double fontSize;
  final Color borderColor;
  final bool isIconButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: disable ? null : onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shape: StadiumBorder(
            side: BorderSide(
              color: borderColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          elevation: 0,
        ),
        child: const Icon(
          Icons.turn_left,
          color: ThemeColor.orange,
        ));
  }
}
