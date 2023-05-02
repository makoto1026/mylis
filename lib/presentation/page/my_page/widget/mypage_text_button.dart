import 'package:flutter/material.dart';
import 'package:mylis/theme/color.dart';

class MypageTextButton extends StatelessWidget {
  const MypageTextButton({
    required this.onTap,
    required this.text,
    this.isLogout = false,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.darkGray,
                ),
              ),
            ),
            isLogout
                ? const SizedBox.shrink()
                : const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: ThemeColor.darkGray,
                    size: 16,
                  ),
          ],
        ),
      ),
    );
  }
}
