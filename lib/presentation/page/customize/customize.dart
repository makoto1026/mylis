import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/util/banner.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class CustomizePage extends HookConsumerWidget {
  const CustomizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final admobState = ref.watch(admobProvider);
    final newColor = useState(colorState.textColor);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "テーマカラー変更",
          style: TextStyle(
            color: newColor.value,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () async => {
            Navigator.pop(context),
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
                  .update(currentMemberId),
              await ref
                  .read(registerTagController.notifier)
                  .setIsLoading(false),
              Navigator.pop(context),
              await showToast(message: "テーマカラーを変更しました"),
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
            child: const Text('保存'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              "文字色やボタンの色を変更できます",
              style: TextStyle(
                color: newColor.value,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ColorPicker(
              pickerColor: newColor.value,
              onColorChanged: (value) async => {
                newColor.value = value,
              },
              colorPickerWidth: 300,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              labelTypes: const [],
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            const Spacer(),
            admobState
                ? Container(
                    color: ThemeColor.white,
                    height: 50,
                    width: double.infinity,
                    child: AdWidget(ad: setBanner()),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
