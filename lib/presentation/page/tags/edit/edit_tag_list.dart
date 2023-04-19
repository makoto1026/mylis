import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/edit/edit_tag_list_item.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/theme/color.dart';

class EditTagListPage extends HookConsumerWidget {
  const EditTagListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagController);
    final colorState = ref.watch(customizeController);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid;

    final editTagController = useScrollController();

    void _articleScrollListener() async {
      if (editTagController.offset >=
              editTagController.position.maxScrollExtent &&
          !editTagController.position.outOfRange) {
        try {
          // await ref.read(articleController.notifier).getList();
        } catch (e) {
          editTagController.removeListener(_articleScrollListener);
        }
      }
    }

    useEffect(() {
      () async {
        editTagController.addListener(_articleScrollListener);
      }();
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView.builder(
                itemCount: state.tagList.length - 1,
                itemBuilder: (context, index) => EditTagListItem(
                  item: state.tagList[index],
                  key: Key('$index'),
                ),
                onReorder: (int oldIndex, int newIndex) {
                  ref.read(tagController.notifier).reorderTagListWithEdit(
                      oldIndex, newIndex, currentMemberId ?? "");
                },
                proxyDecorator: (widget, _, __) {
                  return Opacity(opacity: 0.5, child: widget);
                },
              ),
            ),
            const Text(
              "タグの並び替えは長押し&スライドで行えます",
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
