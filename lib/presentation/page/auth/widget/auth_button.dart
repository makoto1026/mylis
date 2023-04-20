import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 10),
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
            width: 26,
            height: 26,
            color: iconColor,
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
