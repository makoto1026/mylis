import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';

class CustomDialog extends HookConsumerWidget {
  const CustomDialog({
    required this.title,
    this.message = "",
    this.noButtonText = "いいえ",
    this.okButtonText = "はい",
    required this.onPressedWithNo,
    required this.onPressedWithOk,
    Key? key,
  }) : super(key: key);
  final String title;
  final String message;
  final String noButtonText;
  final String okButtonText;
  final void Function() onPressedWithNo;
  final void Function() onPressedWithOk;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MylisBaseDialog(
      widget: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: message != "" ? 10 : 20),
          if (message != "")
            Column(
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100,
                height: 40,
                child: OutlinedRoundRectButton(
                  onPressed: onPressedWithNo,
                  text: noButtonText,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 100,
                height: 40,
                child: RoundRectButton(
                  onPressed: onPressedWithOk,
                  text: okButtonText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
