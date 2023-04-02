import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_controller.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
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

    useEffect(() {
      textEditingController.text = memo.body;
      return () {};
    }, []);

    return WillPopScope(
      onWillPop: (() {
        ref.read(editMemoController.notifier).update();
        if (state.title == "" && state.body == "") {
          ref.read(editMemoController.notifier).delete();
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
                child: RoundRectButton(
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
                                // await ref
                                //     .read(editMemoController.notifier)
                                //     .delete(),
                                // await ref
                                //     .read(editMemoController.notifier)
                                //     .refresh(),
                                // await ref
                                //     .read(loadingStateProvider.notifier)
                                //     .stopLoading(),
                                // Navigator.pop(context),
                                // await showToast(message: "削除しました"),

                                Future.delayed(
                                  const Duration(seconds: 3),
                                  () async {
                                    await ref
                                        .read(loadingStateProvider.notifier)
                                        .stopLoading();
                                    await showToast(message: "削除しました");
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                ),
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
                  text: '削除',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
