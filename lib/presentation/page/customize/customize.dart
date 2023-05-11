import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/widget/back_notice_dialog.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class CustomizePage extends HookConsumerWidget {
  const CustomizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final currentMember = ref.watch(currentMemberProvider);
    final newColor = useState(colorState.textColor);
    final isTablet = ref.watch(isTabletProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "テーマカラー変更",
          style: TextStyle(
            color: newColor.value,
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
          onPressed: () async => {
            if (newColor.value == colorState.textColor)
              {
                Navigator.pop(context),
              }
            else
              {
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
                ),
              }
          },
          color: ThemeColor.darkGray,
        ),
        actions: [
          TextButton(
            onPressed: () async => {
              FocusScope.of(context).unfocus(),
              await ref.read(registerTagController.notifier).setIsLoading(true),
              await ref
                  .read(customizeController.notifier)
                  .setTextColor(newColor.value),
              await ref
                  .read(customizeController.notifier)
                  .setIconColor(newColor.value),
              await ref
                  .read(customizeController.notifier)
                  .setButtonColor(newColor.value),
              await ref
                  .read(customizeController.notifier)
                  .update(currentMember!),
              await ref
                  .read(registerTagController.notifier)
                  .setIsLoading(false),
              Navigator.pop(context),
              await showToast(
                message: "テーマカラーを変更しました",
                fontSize: isTablet
                    ? ThemeFontSize.tabletMediumFontSize
                    : ThemeFontSize.mediumFontSize,
              ),
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
        padding: EdgeInsets.only(
          top: isTablet ? 60 : 30,
          left: isTablet ? 60 : 0,
          right: isTablet ? 60 : 0,
        ),
        child: Column(
          children: [
            Text(
              "文字色やボタンの色を変更できます",
              style: TextStyle(
                color: newColor.value,
                fontWeight: FontWeight.bold,
                fontSize: isTablet
                    ? ThemeFontSize.tabletNormalFontSize
                    : ThemeFontSize.normalFontSize,
              ),
            ),
            SizedBox(height: isTablet ? 80 : 40),
            ColorPicker(
              pickerColor: newColor.value,
              onColorChanged: (value) async => {
                newColor.value = value,
              },
              colorPickerWidth: isTablet ? 600 : 300,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              labelTypes: const [],
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
