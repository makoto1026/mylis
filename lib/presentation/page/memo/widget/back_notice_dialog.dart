import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/theme/color.dart';

class BackNoticeDialog extends HookConsumerWidget {
  const BackNoticeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);

    return MylisBaseDialog(
      widget: Column(
        children: [
          Text(
            "変更が保存されていません",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorState.textColor,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "保存せずに戻りますか？",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ThemeColor.darkGray,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 100,
                child: OutlinedRoundRectButton(
                  onPressed: () => Navigator.pop(context, false),
                  text: "いいえ",
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 50,
                width: 100,
                child: RoundRectButton(
                  onPressed: () => Navigator.pop(context, true),
                  text: "はい",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
