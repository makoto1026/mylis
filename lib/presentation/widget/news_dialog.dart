import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/theme/color.dart';

class NewsDialog extends HookConsumerWidget {
  const NewsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final isReaded = ref.watch(currentMemberProvider)?.isReadedNews ?? false;
    return MylisBaseDialog(
      widget: Column(
        children: [
          Text(
            "iPad版正式リリース！",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorState.textColor,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "β版にて公開していたiPad版が正式リリースされました！\n\n現在iPhoneでご利用中のデータはそのままに、iPadでもご利用いただけます！\n\niPadで「mylis」を検索！",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ThemeColor.darkGray,
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: ThemeColor.gray,
          //       width: 1,
          //     ),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(10),
          //     child: Image.asset(
          //       "assets/images/save_memo.jpg",
          //       width: 300,
          //       height: 100,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),

          CheckboxListTile(
            title: const Text(
              "今後は表示しない",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ThemeColor.darkGray,
                fontSize: 14,
              ),
            ),
            value: isReaded,
            onChanged: (bool? value) {
              ref
                  .read(currentMemberProvider.notifier)
                  .updateIsReadedNews(value ?? false);
            },
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 130,
            child: RoundRectButton(
              onPressed: () => {
                Navigator.pop(context),
              },
              text: "閉じる",
            ),
          ),
        ],
      ),
    );
  }
}
