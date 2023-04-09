import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_box.dart';
import 'package:mylis/presentation/page/articles/edit/controller/edit_article_controller.dart';
import 'package:mylis/presentation/page/tags/register/register_tag.dart';
import 'package:mylis/presentation/widget/select_action_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';
import 'package:tuple/tuple.dart';

class ArticleListView extends HookConsumerWidget {
  const ArticleListView({
    required this.tagId,
    Key? key,
  }) : super(key: key);

  final String tagId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';

    final articlesController = useScrollController();
    final isBack = useState(false);

    return tagId == ""
        ? const RegisterTagView()
        : Container(
            color: const Color.fromARGB(255, 236, 236, 236),
            padding: const EdgeInsets.all(10),
            child: ref
                    .watch(articleController.notifier)
                    .setArticlesWithTagUUID(tagId)
                    .articles
                    .isNotEmpty
                ? GridView.count(
                    controller: articlesController,
                    crossAxisCount: 1,
                    physics: const ClampingScrollPhysics(),
                    childAspectRatio: 4.0,
                    children: List.generate(
                      ref
                          .watch(articleController.notifier)
                          .setArticlesWithTagUUID(tagId)
                          .articles
                          .length,
                      (index) => GestureDetector(
                        onTap: () {
                          openUrl(
                            url: ref
                                .watch(articleController.notifier)
                                .setArticlesWithTagUUID(tagId)
                                .articles[index]
                                .url,
                          );
                        },
                        onLongPress: () => showDialog(
                          context: context,
                          barrierColor: ThemeColor.orange.withOpacity(0.5),
                          builder: (context) => SelectActionDialog(
                            onPressedWithEdit: () => {
                              Navigator.pushNamed(
                                context,
                                RouteNames.editArticle.path,
                                arguments: Tuple2(
                                  ref
                                      .watch(articleController.notifier)
                                      .setArticlesWithTagUUID(tagId)
                                      .articles[index],
                                  tagId,
                                ),
                              ),
                            },
                            onPressedWithDelete: () => {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("本当に削除しますか？"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("いいえ"),
                                      ),
                                      TextButton(
                                        onPressed: () async => {
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
                                                      articleController
                                                          .notifier,
                                                    )
                                                    .setArticlesWithTagUUID(
                                                      tagId,
                                                    )
                                                    .articles[index],
                                                tagId,
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
                                        },
                                        child: const Text("はい"),
                                      ),
                                    ],
                                  );
                                },
                              ).whenComplete(
                                () => {
                                  isBack.value ? Navigator.pop(context) : null,
                                },
                              ),
                            },
                          ),
                        ),
                        child: ArticleBox(
                          item: ref
                              .watch(articleController.notifier)
                              .setArticlesWithTagUUID(tagId)
                              .articles[index],
                        ),
                      ),
                    ).toList(),
                  )
                : const SizedBox.shrink(),
          );
  }
}
