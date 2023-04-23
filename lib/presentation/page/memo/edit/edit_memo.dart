import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_controller.dart';
import 'package:mylis/presentation/page/memo/widget/back_notice_dialog.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class EditMemoPage extends HookConsumerWidget {
  const EditMemoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final state = ref.watch(editMemoController);
    final isBack = useState(false);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);
    final oldMemo = useState(state.body);

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        textEditingController.text = state.body.replaceAll("\\n", "\n");
      });
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メモ編集',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (oldMemo.value == state.body) {
              Navigator.pop(context);
            } else {
              showDialog<bool>(
                context: context,
                barrierColor: colorState.textColor.withOpacity(0.25),
                builder: (context) => const BackNoticeDialog(),
              ).then(
                (value) => {
                  if (value == true)
                    {
                      Navigator.pop(context),
                    }
                },
              );
            }
          },
          color: ThemeColor.darkGray,
        ),
        actions: [
          TextButton(
            onPressed: () async => {
              await ref
                  .read(editMemoController.notifier)
                  .update(currentMemberId, state.uuid ?? ""),
              await showToast(message: "メモを更新しました"),
              await ref.read(editMemoController.notifier).refresh(),
              await ref.read(memoController.notifier).refresh(currentMemberId),
              Navigator.pop(context),
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return ThemeColor.darkGray.withOpacity(0.25);
                  }
                  return ThemeColor.darkGray;
                },
              ),
              alignment: Alignment.center,
              splashFactory: NoSplash.splashFactory,
            ),
            child: const Text(
              '保存',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
                controller: textEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  ref
                      .read(editMemoController.notifier)
                      .setUpdateValue(body: value.replaceAll('\n', '\\n'));
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () async => {
                    showDialog(
                      context: context,
                      barrierColor: colorState.textColor.withOpacity(0.25),
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: "本当に削除しますか？",
                          message: "データは完全に削除されます",
                          onPressedWithNo: () => Navigator.pop(context),
                          onPressedWithOk: () async => {
                            isBack.value = true,
                            await ref
                                .read(loadingStateProvider.notifier)
                                .startLoading(),
                            await ref
                                .read(editMemoController.notifier)
                                .delete(currentMemberId, state.uuid ?? ""),
                            await ref
                                .read(editMemoController.notifier)
                                .refresh(),
                            await ref
                                .read(memoController.notifier)
                                .refresh(currentMemberId),
                            await ref
                                .read(loadingStateProvider.notifier)
                                .stopLoading(),
                            Navigator.pop(context),
                            await showToast(message: "削除しました"),
                          },
                        );
                      },
                    ).whenComplete(
                      () => {
                        isBack.value ? Navigator.pop(context) : null,
                      },
                    )
                  },
                  style: TextButton.styleFrom(
                    primary: ThemeColor.darkGray,
                    alignment: Alignment.center,
                    textStyle: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: const Text('削除'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
