import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_box.dart';
import 'package:mylis/presentation/page/tags/register/register_tag.dart';
import 'package:mylis/presentation/widget/select_action_dialog.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';

class ArticleListView extends HookConsumerWidget {
  const ArticleListView({
    required this.tagUuid,
    Key? key,
  }) : super(key: key);

  final String tagUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = useState<List<Article>>([]);
    final articlesController = useScrollController();

    void _articleScrollListener() async {
      if (articlesController.offset >=
              articlesController.position.maxScrollExtent &&
          !articlesController.position.outOfRange) {
        try {
          // await ref.read(articleController.notifier).getList();
        } catch (e) {
          articlesController.removeListener(_articleScrollListener);
        }
      }
    }

    final articlesList = ref.watch(articleController);

    useEffect(() {
      () async {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          state.value = tagUuid == ""
              ? []
              : ref
                  .watch(articleController.notifier)
                  .setArticlesWithTagUUID(tagUuid, state.value.length);
        });

        articlesController.addListener(_articleScrollListener);
      }();
      return () {};
    }, []);

    useValueChanged(
      articlesList.setCount,
      (a, b) async {
        final List<Article> res = tagUuid == ""
            ? []
            : ref
                .watch(articleController.notifier)
                .setArticlesWithTagUUID(tagUuid, state.value.length);
        if (res.isNotEmpty) {
          state.value = res;
        }
      },
    );

    return tagUuid == ""
        ? const RegisterTagView()
        : Container(
            color: const Color.fromARGB(255, 236, 236, 236),
            padding: const EdgeInsets.all(10),
            child: state.value.isNotEmpty
                ? GridView.count(
                    controller: articlesController,
                    crossAxisCount: 1,
                    physics: const ClampingScrollPhysics(),
                    childAspectRatio: 4.0,
                    children: List.generate(
                      state.value.length,
                      (index) => GestureDetector(
                        onTap: () {
                          openUrl(url: state.value[index].url);
                        },
                        onLongPress: () => showDialog(
                          context: context,
                          barrierColor: ThemeColor.orange.withOpacity(0.5),
                          builder: (context) => SelectActionDialog(
                            onPressedWithEdit: () => {
                              Navigator.pushNamed(
                                context,
                                RouteNames.editArticle.path,
                                arguments: state.value[index],
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
                                          await ref
                                              .read(
                                                  loadingStateProvider.notifier)
                                              .startLoading(),
                                          // await ref
                                          //     .read(deleteArticleController
                                          //         .notifier)
                                          //     .delete(),
                                          // await ref
                                          //     .read(deleteArticleController
                                          //         .notifier)
                                          //     .refresh(),
                                          await ref
                                              .read(
                                                  loadingStateProvider.notifier)
                                              .stopLoading(),
                                          Navigator.pop(context),
                                          await showToast(message: "削除しました"),
                                        },
                                        child: const Text("はい"),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            },
                          ),
                        ),
                        child: ArticleBox(
                          item: state.value[index],
                        ),
                      ),
                    ).toList(),
                  )
                : const SizedBox.shrink(),
          );
  }
}
