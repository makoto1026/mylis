import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_box.dart';
import 'package:mylis/presentation/page/articles/edit/controller/edit_article_controller.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/register/register_tag.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';
import 'package:tuple/tuple.dart';

class ArticleListView extends HookConsumerWidget {
  const ArticleListView({
    required this.tag,
    Key? key,
  }) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);

    final articlesController = useScrollController();
    final isBack = useState(false);

    final tagState = ref.watch(tagController);

    return tag.uuid == ""
        ? const RegisterTagView()
        : Scaffold(
            floatingActionButton: SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () async => {
                  await ref
                      .read(secureStorageServiceProvider)
                      .delete(key: "share_url"),
                  await ref.watch(registerArticleController.notifier).refresh(),
                  Navigator.pushNamed(
                    context,
                    RouteNames.registerArticle.path,
                  ),
                },
                backgroundColor: colorState.textColor,
                child: const Icon(
                  Icons.add,
                  size: 40,
                  color: ThemeColor.white,
                ),
              ),
            ),
            body: Container(
              color: const Color.fromARGB(255, 236, 236, 236),
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: ref
                      .watch(articleController.notifier)
                      .setArticlesWithTagUUID(tag.uuid ?? "")
                      .articles
                      .isNotEmpty
                  ? ListView.builder(
                      controller: articlesController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: ref
                          .watch(articleController.notifier)
                          .setArticlesWithTagUUID(tag.uuid ?? "")
                          .articles
                          .length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            openUrl(
                              url: ref
                                  .watch(articleController.notifier)
                                  .setArticlesWithTagUUID(tag.uuid ?? "")
                                  .articles[index]
                                  .url,
                            );
                          },
                          onLongPress: () => showDialog(
                            context: context,
                            barrierColor:
                                colorState.textColor.withOpacity(0.25),
                            builder: (context) => CustomDialog(
                              title:
                                  "「${ref.watch(articleController.notifier).setArticlesWithTagUUID(tag.uuid ?? "").articles[index].title}」の編集、削除",
                              noButtonText: "削除",
                              okButtonText: "編集",
                              onPressedWithNo: () => {
                                showDialog(
                                  context: context,
                                  barrierColor:
                                      colorState.textColor.withOpacity(0),
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      height: 160,
                                      title: "本当に削除しますか？",
                                      message: "データからも完全に削除されます",
                                      onPressedWithNo: () =>
                                          Navigator.pop(context),
                                      onPressedWithOk: () async => {
                                        isBack.value = true,
                                        await ref
                                            .read(
                                              loadingStateProvider.notifier,
                                            )
                                            .startLoading(),
                                        await ref
                                            .read(
                                              editArticleController.notifier,
                                            )
                                            .delete(
                                              currentMemberId,
                                              ref
                                                  .watch(
                                                    articleController.notifier,
                                                  )
                                                  .setArticlesWithTagUUID(
                                                    tag.uuid ?? "",
                                                  )
                                                  .articles[index],
                                              tag.uuid ?? "",
                                            ),
                                        await ref
                                            .read(
                                              editArticleController.notifier,
                                            )
                                            .refresh(),
                                        await ref
                                            .read(
                                              loadingStateProvider.notifier,
                                            )
                                            .stopLoading(),
                                        Navigator.pop(context),
                                        await showToast(message: "削除しました"),
                                        await ref
                                            .read(articleController.notifier)
                                            .initialized(currentMemberId,
                                                tagState.tagList),
                                      },
                                    );
                                  },
                                ).whenComplete(
                                  () => {
                                    isBack.value
                                        ? Navigator.pop(context)
                                        : null,
                                  },
                                ),
                              },
                              onPressedWithOk: () async => {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.editArticle.path,
                                  arguments: Tuple2(
                                    ref
                                        .watch(articleController.notifier)
                                        .setArticlesWithTagUUID(tag.uuid ?? "")
                                        .articles[index],
                                    tag,
                                  ),
                                ).whenComplete(
                                  () => {
                                    Navigator.pop(context),
                                  },
                                ),
                              },
                            ),
                          ),
                          child: ArticleBox(
                            item: ref
                                .watch(articleController.notifier)
                                .setArticlesWithTagUUID(tag.uuid ?? "")
                                .articles[index],
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          );
  }
}
