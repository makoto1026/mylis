import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/theme/mixin.dart';

class MylisBaseDialog extends HookConsumerWidget {
  const MylisBaseDialog({
    required this.height,
    required this.width,
    this.title = "",
    required this.widget,
    Key? key,
  }) : super(key: key);

  final double height;
  final double width;
  final String? title;
  final Widget widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding:
            const EdgeInsets.only(top: 21, bottom: 25, left: 28, right: 28),
        child: Center(
          child: title == ""
              ? widget
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title!,
                      style: grayTextStyle,
                    ),
                    const SizedBox(height: 30),
                    widget,
                  ],
                ),
        ),
      ),
    );
  }
}
