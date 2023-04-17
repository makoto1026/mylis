import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_controller.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

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
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 326),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding:
              const EdgeInsets.only(top: 21, bottom: 25, left: 28, right: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: memo.title,
                style: grayTextStyle,
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
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("本当に削除しますか？"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("いいえ"),
                            ),
                            TextButton(
                              onPressed: () async => {
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
                              child: const Text("はい"),
                            ),
                          ],
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
                      fontSize: 18,
                    ),
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
