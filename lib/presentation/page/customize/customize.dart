import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "カスタマイズ",
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
            onPressed: () async => {
              FocusScope.of(context).unfocus(),
              await ref.read(registerTagController.notifier).setIsLoading(true),
              await ref
                  .read(customizeController.notifier)
                  .update(currentMemberId),
              await ref
                  .read(registerTagController.notifier)
                  .setIsLoading(false),
              Navigator.pop(context),
              await showToast(message: "テーマカラーを変更しました"),
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
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              "アプリ内で表示しているテーマカラーを変更できます",
              style: TextStyle(
                color: colorState.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ColorPicker(
              pickerColor: colorState.textColor,
              onColorChanged: (value) =>
                  ref.read(customizeController.notifier).setTextColor(value),
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
