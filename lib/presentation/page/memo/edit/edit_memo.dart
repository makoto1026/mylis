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
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

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
    final isTablet = ref.watch(isTabletProvider);

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
              await showToast(
                message: "メモを更新しました",
                fontSize: isTablet
                    ? ThemeFontSize.tabletMediumFontSize
                    : ThemeFontSize.mediumFontSize,
              ),
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
            child: Text(
              '保存',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isTablet
                    ? ThemeFontSize.tabletNormalFontSize
                    : ThemeFontSize.normalFontSize,
              ),
            ),
          ),
          SizedBox(width: isTablet ? 20 : 0),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: isTablet ? 10 : 0,
          horizontal: isTablet ? 40 : 20,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                style: TextStyle(
                  fontSize: isTablet
                      ? ThemeFontSize.tabletNormalFontSize
                      : ThemeFontSize.normalFontSize,
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
              SizedBox(height: isTablet ? 40 : 20),
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
                            await showToast(
                              message: "削除しました",
                              fontSize: isTablet
                                  ? ThemeFontSize.tabletMediumFontSize
                                  : ThemeFontSize.mediumFontSize,
                            ),
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
                    textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: isTablet
                          ? ThemeFontSize.tabletMediumFontSize
                          : ThemeFontSize.mediumFontSize,
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    '削除',
                    style: TextStyle(
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
