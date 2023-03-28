import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/register_memo/controller/register_memo_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/theme/mixin.dart';

class RegisterMemoPage extends HookConsumerWidget {
  const RegisterMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.refresh(registerMemoController);
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'メモ登録',
          style: orangeTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 30,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              MylisTextField(
                title: "タイトル",
                onChanged: (value) => ref
                    .read(registerMemoController.notifier)
                    .setNewMemo(title: value),
              ),
              const SizedBox(height: 30),
              MylisTextField(
                title: "内容",
                maxLines: 5,
                minLines: 5,
                isAFewLine: true,
                onChanged: (value) => ref
                    .read(registerMemoController.notifier)
                    .setNewMemo(body: value),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: 52,
                      child: OutlinedRoundRectButton(
                        onPressed: () => {
                          Navigator.pop(context),
                          ref.read(memoController.notifier).initialized(),
                        },
                        text: "戻る",
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: 160,
                      child: RoundRectButton(
                        onPressed: () => {
                          ref.read(registerMemoController.notifier).create(),
                          ref.refresh(memoController),
                        },
                        text: "登録",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
