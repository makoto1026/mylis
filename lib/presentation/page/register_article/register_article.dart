import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/register_article/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/drop_down_box.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/register_tag_dialog.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class RegisterArticlePage extends HookConsumerWidget {
  const RegisterArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerArticleState = ref.watch(registerArticleController);

    final receiveSharingState = ref.watch(receiveSharingIntentProvider);

    final tagState = ref.watch(tagController);

    useEffect(() {
      () async {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            if (tagState.tagList.isNotEmpty) {
              ref.read(tagController.notifier).setTag(tagState.tagList[0]);
              ref.read(registerArticleController.notifier).setNewArticle(
                    tagUuid: tagState.tagList[0].uuid ?? "",
                  );
            }
          },
        );
      }();

      return () {};
    }, []);

    if (receiveSharingState.url != "") {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          ref
              .read(registerArticleController.notifier)
              .setNewArticle(url: receiveSharingState.url);
        },
      );
    }

    return tagState.isLoading
        ? Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                '記事登録',
                style: pageHeaderTextStyle,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MylisTextField(
                      title: "タイトル",
                      onChanged: (value) => ref
                          .read(registerArticleController.notifier)
                          .setNewArticle(title: value),
                    ),
                    const SizedBox(height: 25),
                    MylisTextField(
                      title: "URL",
                      maxLines: 20,
                      isAFewLine: true,
                      initialValue: receiveSharingState.url == ""
                          ? ""
                          : receiveSharingState.url,
                      onChanged: (value) => ref
                          .read(registerArticleController.notifier)
                          .setNewArticle(url: value),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "タグ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const DropDownBox(),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => {
                            showDialog(
                              context: context,
                              barrierColor: ThemeColor.orange.withOpacity(0.5),
                              builder: (context) => const RegisterTagDialog(),
                            ),
                          },
                          child: const Text(
                            "追加",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    MylisTextField(
                      title: "メモ（任意）",
                      maxLines: 20,
                      minLines: 5,
                      isAFewLine: true,
                      onChanged: (value) => ref
                          .read(registerArticleController.notifier)
                          .setNewArticle(memo: value),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 52,
                            width: 52,
                            child: OutlinedRoundRectButton(
                              onPressed: () => {
                                Navigator.pop(context),
                                ref
                                    .read(receiveSharingIntentProvider.notifier)
                                    .initialized(),
                              },
                              text: "戻る",
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Center(
                          child: SizedBox(
                            height: 52,
                            width: 160,
                            child: RoundRectButton(
                              disable: registerArticleState.title == "" ||
                                  registerArticleState.url == "",
                              onPressed: () async => {
                                await ref
                                    .read(loadingStateProvider.notifier)
                                    .startLoading(),
                                ref
                                    .read(registerArticleController.notifier)
                                    .create(),
                                ref
                                    .read(receiveSharingIntentProvider.notifier)
                                    .initialized(),
                                ref
                                    .read(articleController.notifier)
                                    .initialized(tagState.tagList),
                                ref.read(articleController.notifier).setCount(),
                                await Future.delayed(
                                  const Duration(seconds: 3),
                                ),
                                await ref
                                    .read(loadingStateProvider.notifier)
                                    .stopLoading(),
                                Navigator.pop(context),
                                await showToast(message: "記事を登録しました"),
                              },
                              text: "登録",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
