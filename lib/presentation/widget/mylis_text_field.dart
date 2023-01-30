import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MylisTextField extends HookConsumerWidget {
  const MylisTextField({
    required this.title,
    required this.onChanged,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.maxLines = 1,
    this.minLines = 1,
    this.isAFewLine = false,
    Key? key,
  }) : super(key: key);
  final String title;
  final Function(String)? onChanged;
  final Color textColor;
  final double fontSize;
  final int maxLines;
  final int minLines;
  final bool isAFewLine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 15),
        TextField(
          inputFormatters:
              isAFewLine ? [LengthLimitingTextInputFormatter(2000)] : null,
          maxLines: isAFewLine ? maxLines : 1,
          minLines: isAFewLine ? minLines : 1,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            filled: true,
            fillColor: const Color(0xffF7F6F6),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffEDECEC),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffEDECEC),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffEDECEC),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xffEDECEC),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
