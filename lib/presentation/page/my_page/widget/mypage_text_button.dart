import 'package:flutter/material.dart';

class MypageTextButton extends StatelessWidget {
  const MypageTextButton({
    required this.onTap,
    required this.text,
    this.hasMargin = true,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;
  final bool hasMargin;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(),
        hasMargin ? const SizedBox(height: 30) : const SizedBox.shrink(),
      ],
    );
  }
}
