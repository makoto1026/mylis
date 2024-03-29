import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/font_size.dart';

class RegisterTagView extends HookConsumerWidget {
  const RegisterTagView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(currentMemberProvider);
    final state = ref.watch(registerTagController);
    final tagList = ref.watch(tagController).tagList;
    final isTablet = ref.watch(isTabletProvider);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 60 : 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MylisTextField(
            title: "新規リスト",
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
            onChanged: (value) async =>
                await ref.read(registerTagController.notifier).setName(value),
          ),
          SizedBox(height: isTablet ? 100 : 50),
          Center(
            child: SizedBox(
              height: 52,
              width: isTablet ? 240 : 160,
              child: RoundRectButton(
                disable: state.name == "",
                onPressed: () async => {
                  await ref.read(loadingStateProvider.notifier).startLoading(),
                  await ref
                      .read(registerTagController.notifier)
                      .create(currentMember?.uuid ?? "", tagList.length - 1),
                  await ref.read(registerTagController.notifier).refresh(),
                  await ref
                      .read(tagController.notifier)
                      .refresh(currentMember?.uuid ?? "", true, false),
                  await ref.read(tagController.notifier).setCount(),
                  await ref.read(loadingStateProvider.notifier).stopLoading(),
                  await showToast(
                    message: "リストを追加しました",
                    fontSize: isTablet
                        ? ThemeFontSize.tabletMediumFontSize
                        : ThemeFontSize.mediumFontSize,
                  ),
                },
                text: "登録",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
