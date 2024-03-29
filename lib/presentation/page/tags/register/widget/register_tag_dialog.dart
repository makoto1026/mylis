import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/font_size.dart';

class RegisterTagDialog extends HookConsumerWidget {
  const RegisterTagDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final tagList = ref.watch(tagController).tagList;
    final isTablet = ref.watch(isTabletProvider);

    return MylisBaseDialog(
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MylisTextField(
            title: "リスト",
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
            onChanged: (value) async =>
                await ref.read(registerTagController.notifier).setName(value),
          ),
          SizedBox(height: isTablet ? 60 : 30),
          Center(
            child: SizedBox(
              height: 52,
              width: isTablet ? 240 : 160,
              child: RoundRectButton(
                disable: ref.watch(registerTagController).name.isEmpty,
                onPressed: () async => {
                  FocusScope.of(context).unfocus(),
                  await ref
                      .read(registerTagController.notifier)
                      .setIsLoading(true),
                  await ref
                      .read(registerTagController.notifier)
                      .create(currentMemberId, tagList.length - 1)
                      .then(
                        (value) async => {
                          await ref
                              .read(registerArticleController.notifier)
                              .setNewArticle(
                                tagId: value,
                              ),
                        },
                      ),
                  await ref.read(registerTagController.notifier).refresh(),
                  await ref
                      .read(tagController.notifier)
                      .refresh(currentMemberId, true, false),
                  await ref
                      .read(registerTagController.notifier)
                      .setIsLoading(false),
                  Navigator.pop(context),
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
