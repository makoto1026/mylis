import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/base_dialog.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/snippets/toast.dart';

class RegisterTagDialog extends HookConsumerWidget {
  const RegisterTagDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagController);
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';

    return MylisBaseDialog(
      height: 326,
      width: 326,
      widget: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MylisTextField(
              title: "タグ名",
              onChanged: (value) => {
                ref.read(registerTagController.notifier).setName(value),
              },
            ),
            const SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 52,
                width: 160,
                child: RoundRectButton(
                  disable: ref.watch(registerTagController).name.isEmpty,
                  onPressed: () async => {
                    FocusScope.of(context).unfocus(),
                    await ref
                        .read(registerTagController.notifier)
                        .setIsLoading(true),
                    await ref
                        .read(registerTagController.notifier)
                        .create(currentMemberId)
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
                        .refresh(currentMemberId),
                    await ref
                        .read(registerTagController.notifier)
                        .setIsLoading(false),

                    Navigator.pop(context),
                    await showToast(message: "タグを追加しました"),
                    // TODO: 登録後に記事タイトルなどが消えてしまう事象の解消
                  },
                  text: "登録",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
