import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';

class SelectActionDialog extends HookConsumerWidget {
  const SelectActionDialog({
    required this.onPressedWithEdit,
    required this.onPressedWithDelete,
    Key? key,
  }) : super(key: key);
  final void Function() onPressedWithEdit;
  final void Function() onPressedWithDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MylisBaseDialog(
      height: 140,
      width: 326,
      widget: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100,
              height: 60,
              child: RoundRectButton(
                onPressed: onPressedWithEdit,
                text: "編集",
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 100,
              height: 60,
              child: OutlinedRoundRectButton(
                onPressed: onPressedWithDelete,
                text: "削除",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
