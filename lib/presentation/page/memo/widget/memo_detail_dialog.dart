import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class MemoDetailDialog extends HookConsumerWidget {
  const MemoDetailDialog({
    required this.memo,
    Key? key,
  }) : super(key: key);
  final Memo memo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final state = ref.watch(editMemoController);
    final isBack = useState(false);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        textEditingController.text = memo.body;
        ref.watch(editMemoController.notifier).setMemo(memo);
      });
      return () {};
    }, []);

    return WillPopScope(
      onWillPop: (() {
        ref
            .read(editMemoController.notifier)
            .update(currentMemberId, memo.uuid ?? "");
        showToast(message: "更新しました");
        if (state.title == "" && state.body == "") {
          ref
              .read(editMemoController.notifier)
              .delete(currentMemberId, memo.uuid ?? "");
          showToast(message: "削除しました");
        }
        Navigator.of(context).pop(true);
        return Future.value(true);
      }),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: const TextStyle(
                  fontSize: 14,
                  color: ThemeColor.darkGray,
                  fontWeight: FontWeight.bold,
                ),
                initialValue: memo.title,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  ref
                      .read(editMemoController.notifier)
                      .setUpdateValue(title: value);
                },
              ),
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
                      .setUpdateValue(body: value);
                },
              ),
              const Spacer(),
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
                                .delete(currentMemberId, memo.uuid ?? ""),
                            await ref
                                .read(editMemoController.notifier)
                                .refresh(),
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
