import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/customize/widget/customize_color_component.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class CustomizeTextColorDialog extends HookConsumerWidget {
  const CustomizeTextColorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = useState(ThemeColor.darkGray);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';

    return MylisBaseDialog(
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "アプリ内で表示しているテーマカラーを変更できます",
            style: TextStyle(
              color: textColor.value,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CostomizeColorComponent(
                    color: Colors.black,
                    onTap: () => {
                      textColor.value = Colors.black,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: Colors.black == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.red,
                    onTap: () => {
                      textColor.value = ThemeColor.red,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.red == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.pink,
                    onTap: () => {
                      textColor.value = ThemeColor.pink,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.pink == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.pastelPink,
                    onTap: () => {
                      textColor.value = ThemeColor.pastelPink,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.pastelPink == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.orange,
                    onTap: () => {
                      textColor.value = ThemeColor.orange,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.orange == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.pastelOrange,
                    onTap: () => {
                      textColor.value = ThemeColor.pastelOrange,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.pastelOrange == textColor.value,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CostomizeColorComponent(
                    color: ThemeColor.blue,
                    onTap: () => {
                      textColor.value = ThemeColor.blue,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.blue == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.pastelBlue,
                    onTap: () => {
                      textColor.value = ThemeColor.pastelBlue,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.pastelBlue == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.green,
                    onTap: () => {
                      textColor.value = ThemeColor.green,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.green == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.pastelGreen,
                    onTap: () => {
                      textColor.value = ThemeColor.pastelGreen,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.pastelGreen == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.yellow,
                    onTap: () => {
                      textColor.value = ThemeColor.yellow,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.yellow == textColor.value,
                  ),
                  CostomizeColorComponent(
                    color: ThemeColor.pastelPurple,
                    onTap: () => {
                      textColor.value = ThemeColor.pastelPurple,
                      ref
                          .read(customizeController.notifier)
                          .setTextColor(textColor.value),
                    },
                    isSelected: ThemeColor.pastelPurple == textColor.value,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 60),
          Center(
            child: SizedBox(
              height: 52,
              width: 160,
              child: RoundRectButton(
                onPressed: () async => {
                  FocusScope.of(context).unfocus(),
                  await ref
                      .read(registerTagController.notifier)
                      .setIsLoading(true),
                  await ref
                      .read(customizeController.notifier)
                      .update(currentMemberId),
                  await ref
                      .read(registerTagController.notifier)
                      .setIsLoading(false),
                  Navigator.pop(context),
                  await showToast(message: "テーマカラーを変更しました"),
                },
                text: "変更",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
