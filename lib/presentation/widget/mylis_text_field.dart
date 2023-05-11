import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/font_size.dart';

class MylisTextField extends HookConsumerWidget {
  const MylisTextField({
    required this.title,
    required this.onChanged,
    required this.fontSize,
    this.textColor = Colors.white,
    this.maxLines = 1,
    this.minLines = 1,
    this.isAFewLine = false,
    this.initialValue = "",
    this.height = 1.5,
    Key? key,
  }) : super(key: key);
  final String title;
  final Function(String)? onChanged;
  final Color textColor;
  final double fontSize;
  final int maxLines;
  final int minLines;
  final bool isAFewLine;
  final String initialValue;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isTablet = ref.watch(isTabletProvider);
    useEffect(() {
      controller.text = initialValue;
      return () {};
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
        SizedBox(height: isTablet ? 10 : 5),
        TextFormField(
          style: TextStyle(
            fontSize: fontSize,
            height: height,
          ),
          controller: controller,
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
