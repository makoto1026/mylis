import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';

class RegisterTagView extends HookConsumerWidget {
  const RegisterTagView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MylisTextField(
              title: "タグ名",
              onChanged: (value) =>
                  ref.read(tagController.notifier).setName(value),
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 52,
                width: 160,
                child: RoundRectButton(
                  onPressed: () async => {
                    await ref.read(tagController.notifier).create(),
                    await ref.read(tagController.notifier).refresh(),
                  },
                  text: "登録",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
