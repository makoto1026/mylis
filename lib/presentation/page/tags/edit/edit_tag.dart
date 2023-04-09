import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/edit/controller/edit_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

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
              RoundRectButton(
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
                                  .read(editTagController.notifier)
                                  .delete(currentMemberId, tag.uuid ?? ""),
                              await ref
                                  .read(editTagController.notifier)
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
                text: '削除',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
