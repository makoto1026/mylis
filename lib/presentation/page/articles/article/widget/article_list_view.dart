import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_box.dart';
import 'package:mylis/presentation/page/articles/edit/controller/edit_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/register/register_tag.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/font_size.dart';
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
    final isTablet = ref.watch(isTabletProvider);

    final articlesController = useScrollController();
    final isBack = useState(false);

    final tagState = ref.watch(tagController);

    return tag.uuid == ""
        ? const RegisterTagView()
        : Scaffold(
            body: Container(
              color: const Color.fromARGB(255, 236, 236, 236),
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 20 : 10),
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
                                  "「${ref.watch(articleController.notifier).setArticlesWithTagUUID(tag.uuid ?? "").articles[index].title}」",
                              noButtonText: "削除",
                              okButtonText: "編集",
                              onPressedWithNo: () => {
                                showDialog(
                                  context: context,
                                  barrierColor:
                                      colorState.textColor.withOpacity(0),
                                  builder: (BuildContext context) {
                                    return CustomDialog(
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
                                        await showToast(
                                          message: "削除しました",
                                          fontSize: isTablet
                                              ? ThemeFontSize
                                                  .tabletMediumFontSize
                                              : ThemeFontSize.mediumFontSize,
                                        ),
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
                                Navigator.pop(context),
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
