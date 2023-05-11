import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/register/controller/register_memo_controller.dart';
import 'package:mylis/presentation/page/memo/widget/back_notice_dialog.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/presentation/widget/save_memo_notice_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class RegisterMemoPage extends HookConsumerWidget {
  const RegisterMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(currentMemberProvider);
    final colorState = ref.watch(customizeController);
    final controller = useTextEditingController();
    final focusNode = FocusNode();
    final setMemo = ref.watch(registerMemoController).body;
    final isTablet = ref.watch(isTabletProvider);

    useEffect(() {
      ref.refresh(registerMemoController);
      if (currentMember?.isHiddenSaveMemoNoticeDialog == true) {
        focusNode.requestFocus();
      }
      SchedulerBinding.instance.addPostFrameCallback(
        (_) async => {
          if (currentMember?.isHiddenSaveMemoNoticeDialog == false)
            {
              showDialog(
                context: context,
                barrierColor: colorState.textColor.withOpacity(0.25),
                builder: (context) => const SaveMemoNoticeDialog(),
              ),
            }
        },
      );

      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メモ登録',
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
            if (setMemo == "") {
              focusNode.unfocus();
              FocusScope.of(context).unfocus();
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
              if (ref.read(registerMemoController).body == "")
                {
                  showDialog(
                    context: context,
                    barrierColor: colorState.textColor.withOpacity(0.25),
                    builder: (BuildContext context) {
                      return CustomDialog(
                        title: "本文が入力されていません",
                        onPressedWithNo: () => Navigator.pop(context),
                        onPressedWithOk: () => Navigator.pop(context),
                        okButtonText: "戻る",
                        isDoubleButton: false,
                      );
                    },
                  ),
                }
              else
                {
                  await ref.read(loadingStateProvider.notifier).startLoading(),
                  await ref
                      .read(registerMemoController.notifier)
                      .create(currentMember?.uuid ?? ""),
                  await ref
                      .read(memoController.notifier)
                      .refresh(currentMember?.uuid ?? ""),
                  await ref.read(loadingStateProvider.notifier).stopLoading(),
                  await showToast(
                    message: "メモを追加しました",
                    fontSize: isTablet
                        ? ThemeFontSize.tabletMediumFontSize
                        : ThemeFontSize.mediumFontSize,
                  ),
                  Navigator.pop(context),
                },
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
          vertical: isTablet ? 20 : 10,
          horizontal: isTablet ? 10 : 0,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  initialValue: null,
                  style: TextStyle(
                    fontSize: isTablet
                        ? ThemeFontSize.tabletNormalFontSize
                        : ThemeFontSize.normalFontSize,
                    height: 1.5,
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(2000)],
                  maxLines: 15,
                  minLines: 15,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeColor.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeColor.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeColor.white),
                    ),
                  ),
                  onChanged: (value) =>
                      ref.read(registerMemoController.notifier).setNewMemo(
                            body: value.replaceAll('\n', '\\n'),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
