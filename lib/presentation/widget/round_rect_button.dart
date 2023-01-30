import 'package:flutter/material.dart';
import 'package:mylis/theme/color.dart';

class RoundRectButton extends StatelessWidget {
  const RoundRectButton({
    required this.onPressed,
    required this.text,
    this.backgroundColor = ThemeColor.orange,
    this.textColor = Colors.white,
    this.disable = false,
    this.fontSize = 16,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool disable;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor.withOpacity(disable ? 0.5 : 1),
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
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
