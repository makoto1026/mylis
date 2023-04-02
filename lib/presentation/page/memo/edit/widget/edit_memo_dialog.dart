import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/snippets/toast.dart';

class EditMemoDialog extends HookConsumerWidget {
  const EditMemoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MylisBaseDialog(
      height: 500,
      title: "メモ編集",
      width: 326,
      widget: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MylisTextField(
              title: "タイトル",
              onChanged: (value) => value,
            ),
            const SizedBox(height: 10),
            MylisTextField(
              title: "メモ",
              onChanged: (value) => value,
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 52,
                width: 160,
                child: RoundRectButton(
                  onPressed: () async => {
                    FocusScope.of(context).unfocus(),
                    // await ref
                    //     .read(registerTagController.notifier)
                    //     .setIsLoading(true),
                    // await ref
                    //     .read(registerTagController.notifier)
                    //     .create(tagName: tagName.value),
                    // await ref.read(tagController.notifier).refresh(),
                    // await ref
                    //     .read(registerTagController.notifier)
                    //     .setIsLoading(false),
                    Navigator.pop(context),
                    await showToast(message: "編集しました"),
                  },
                  text: "編集",
                ),
              ),
            ),
            // const SizedBox(height: 10),
            TextButton(
              onPressed: () async => {
                FocusScope.of(context).unfocus(),
                // await ref
                //     .read(registerTagController.notifier)
                //     .setIsLoading(true),
                // await ref
                //     .read(registerTagController.notifier)
                //     .create(tagName: tagName.value),
                // await ref.read(tagController.notifier).refresh(),
                // await ref
                //     .read(registerTagController.notifier)
                //     .setIsLoading(false),
                Navigator.pop(context),
                await showToast(message: "削除しました"),
              },
              style: TextButton.styleFrom(
                primary: Colors.orange,
              ),
              child: const Text("削除"),
            )
          ],
        ),
      ),
    );
  }
}
