import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/edit/controller/edit_tag_controller.dart';
import 'package:mylis/presentation/page/tags/edit/edit_tag_list_item.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class EditTagListPage extends HookConsumerWidget {
  const EditTagListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagController);
    final colorState = ref.watch(customizeController);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? "";
    final isTablet = ref.watch(isTabletProvider);

    final editTagViewController = useScrollController();

    void _articleScrollListener() async {
      if (editTagViewController.offset >=
              editTagViewController.position.maxScrollExtent &&
          !editTagViewController.position.outOfRange) {
        try {
          // await ref.read(articleController.notifier).getList();
        } catch (e) {
          editTagViewController.removeListener(_articleScrollListener);
        }
      }
    }

    useEffect(() {
      () async {
        editTagViewController.addListener(_articleScrollListener);
      }();
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'リスト編集',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
        leadingWidth: isTablet ? 80 : 40,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: isTablet ? 36 : 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColor.darkGray,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? 20 : 10,
          horizontal: isTablet ? 40 : 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView.builder(
                itemCount: state.tagList.length - 1,
                itemBuilder: (context, index) => Dismissible(
                  key: Key('$index'),
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(
                      right: isTablet ? 40 : 20,
                    ),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: isTablet ? 36 : 24,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      barrierColor: colorState.textColor.withOpacity(0.25),
                      builder: (BuildContext context) {
                        return CustomDialog(
                          title: "本当に削除しますか？",
                          message: "データは完全に削除されます",
                          onPressedWithNo: () => Navigator.pop(context),
                          onPressedWithOk: () async => {
                            await ref
                                .read(loadingStateProvider.notifier)
                                .startLoading(),
                            await ref.read(editTagController.notifier).delete(
                                currentMemberId,
                                state.tagList[index].uuid ?? ""),
                            await ref
                                .read(editTagController.notifier)
                                .refresh(),
                            await ref
                                .read(tagController.notifier)
                                .refresh(currentMemberId, false, true),
                            await ref
                                .read(loadingStateProvider.notifier)
                                .stopLoading(),
                            Navigator.pop(context),
                            await showToast(
                              message: "削除しました",
                              fontSize: isTablet
                                  ? ThemeFontSize.tabletMediumFontSize
                                  : ThemeFontSize.mediumFontSize,
                            ),
                          },
                        );
                      },
                    );
                  },
                  child: EditTagListItem(
                    item: state.tagList[index],
                    key: Key('$index'),
                  ),
                ),
                onReorder: (int oldIndex, int newIndex) {
                  ref.read(tagController.notifier).reorderTagListWithEdit(
                        oldIndex,
                        newIndex,
                        currentMemberId,
                      );
                },
                proxyDecorator: (widget, _, __) {
                  return Opacity(opacity: 0.5, child: widget);
                },
              ),
            ),
            Text(
              "リストの並び替えは長押し&スライドで行えます",
              style: TextStyle(
                fontSize: isTablet
                    ? ThemeFontSize.tabletSmallFontSize
                    : ThemeFontSize.smallFontSize,
              ),
            ),
            SizedBox(height: isTablet ? 20 : 10),
          ],
        ),
      ),
    );
  }
}
