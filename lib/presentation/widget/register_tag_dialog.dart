import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/loading_state_provider.dart';

class RegisterTagDialog extends HookConsumerWidget {
  const RegisterTagDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagName = useState("");
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 326, maxWidth: 326),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding:
            const EdgeInsets.only(top: 21, bottom: 25, left: 28, right: 28),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MylisTextField(
                title: "タグ名",
                onChanged: (value) => tagName.value = value,
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  height: 52,
                  width: 160,
                  child: RoundRectButton(
                    onPressed: () async => {
                      await ref
                          .read(loadingStateProvider.notifier)
                          .startLoading(),
                      // await ref
                      //     .read(tagController.notifier)
                      //     .create(tagName: tagName.value),
                      // await ref.read(tagController.notifier).refresh(),
                      await Future.delayed(const Duration(seconds: 3)),

                      await ref
                          .read(loadingStateProvider.notifier)
                          .stopLoading(),

                      Navigator.pop(context),
                    },
                    text: "登録",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
