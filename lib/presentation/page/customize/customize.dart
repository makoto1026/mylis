import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/customize/widget/customize_text_color_dialog.dart';
import 'package:mylis/presentation/page/my_page/widget/mypage_text_button.dart';
import 'package:mylis/theme/color.dart';

class CustomizePage extends HookConsumerWidget {
  const CustomizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);

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
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MypageTextButton(
            onTap: () => {
              showDialog(
                context: context,
                barrierColor: ThemeColor.orange.withOpacity(0.5),
                builder: (conetxt) => const CustomizeTextColorDialog(),
              )
            },
            text: "テーマカラー",
            isLogout: true,
          ),
        ],
      ),
    );
  }
}
