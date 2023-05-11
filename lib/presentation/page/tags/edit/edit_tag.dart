import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/edit/controller/edit_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class EditTagPage extends HookConsumerWidget {
  const EditTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tag = ModalRoute.of(context)!.settings.arguments as Tag;
    final isBack = useState(false);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(editTagController.notifier).setTag(tag);
      });
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
        actions: [
          TextButton(
            onPressed: () async {
              ref.read(editTagController.notifier).update(currentMemberId);
              showToast(
                message: "リストを更新しました",
                fontSize: isTablet
                    ? ThemeFontSize.tabletMediumFontSize
                    : ThemeFontSize.mediumFontSize,
              );
              ref.read(tagController.notifier).initialized(currentMemberId);
              Navigator.pop(context);
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 60 : 30,
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
              SizedBox(height: isTablet ? 60 : 30),
              TextButton(
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
                              .read(editTagController.notifier)
                              .delete(currentMemberId, tag.uuid ?? ""),
                          await ref.read(editTagController.notifier).refresh(),
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
            ],
          ),
        ),
      ),
    );
  }
}
