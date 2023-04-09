import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/memo.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class EditMemoPage extends HookConsumerWidget {
  const EditMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memo = ModalRoute.of(context)!.settings.arguments as Memo;
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(editMemoController.notifier).setMemo(memo);
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
            Navigator.pop(context);
          },
          color: ThemeColor.darkGray,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              ref
                  .read(editMemoController.notifier)
                  .update(currentMemberId, memo.uuid ?? "");
              showToast(message: "メモを更新しました");
              ref.read(editMemoController.notifier).refresh();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              primary: ThemeColor.darkGray,
              alignment: Alignment.center,
            ),
            child: const Text('保存'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MylisTextField(
              title: "タイトル",
              initialValue: memo.title,
              onChanged: (value) => ref
                  .read(editMemoController.notifier)
                  .setUpdateValue(title: value),
            ),
            const SizedBox(height: 10),
            MylisTextField(
              title: "内容",
              initialValue: memo.body,
              onChanged: (value) => ref
                  .read(editMemoController.notifier)
                  .setUpdateValue(body: value),
            ),
          ],
        ),
      ),
    );
  }
}
