import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/tags/edit_tag/controller/edit_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class EditTagPage extends HookConsumerWidget {
  const EditTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tag = ModalRoute.of(context)!.settings.arguments as Tag;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(editTagController.notifier).setTag(tag);
      });
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'タグ編集',
          style: pageHeaderTextStyle,
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
              ref.read(editTagController.notifier).update();
              showToast(message: "タグを更新しました");
              ref.read(tagController.notifier).initialized();
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
            child: TextField(
          onChanged: (value) {
            ref.read(editTagController.notifier).setName(value);
          },
          decoration: InputDecoration(
            labelText: tag.name,
            border: const OutlineInputBorder(),
          ),
        )),
      ),
    );
  }
}
