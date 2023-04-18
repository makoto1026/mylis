import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/edit/controller/edit_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class EditTagPage extends HookConsumerWidget {
  const EditTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tag = ModalRoute.of(context)!.settings.arguments as Tag;
    final isBack = useState(false);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(editTagController.notifier).setTag(tag);
      });
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'タグ編集',
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
              ref.read(editTagController.notifier).update(currentMemberId);
              showToast(message: "タグを更新しました");
              ref.read(tagController.notifier).initialized(currentMemberId);
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  ref.read(editTagController.notifier).setName(value);
                },
                decoration: InputDecoration(
                  labelText: tag.name,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () async => {
                  showDialog(
                    context: context,
                    barrierColor: colorState.textColor.withOpacity(0.25),
                    builder: (BuildContext context) {
                      return CustomDialog(
                        height: 160,
                        title: "本当に削除しますか？",
                        message: "データは完全に削除されます",
                        onPressedWithNo: () => Navigator.pop(context),
                        onPressedWithOk: () async => {
                          isBack.value = true,
                          await ref
                              .read(loadingStateProvider.notifier)
                              .startLoading(),
                          await ref
                              .read(editTagController.notifier)
                              .delete(currentMemberId, tag.uuid ?? ""),
                          await ref.read(editTagController.notifier).refresh(),
                          await ref
                              .read(tagController.notifier)
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
                ),
                child: const Text('削除'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
