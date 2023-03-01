import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/article/widget/article_box.dart';
import 'package:mylis/presentation/page/tag/register_tag.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';

class ArticleListView extends HookConsumerWidget {
  const ArticleListView({
    required this.isArticles,
    required this.tagUuid,
    Key? key,
  }) : super(key: key);

  final bool isArticles;
  final String tagUuid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    useEffect(() {
      () async {
        await ref.read(articleController.notifier).initialized(tagUuid).then(
              (value) => {
                articlesController.addListener(_articleScrollListener),
              },
            );
      }();
      return () {};
    }, []);

    final state = ref.watch(articleController);

    return isArticles
        ? Container(
            color: Color.fromARGB(255, 236, 236, 236),
            padding: const EdgeInsets.all(10),
            child: state.articleList.isNotEmpty
                ? GridView.count(
                    controller: articlesController,
                    crossAxisCount: 1,
                    physics: const ClampingScrollPhysics(),
                    childAspectRatio: 4.0,
                    children: List.generate(
                      state.articleList.length,
                      (index) => GestureDetector(
                        onTap: () {
                          openUrl(url: state.articleList[index].url);
                        },
                        child: ArticleBox(
                          item: state.articleList[index],
                        ),
                      ),
                    ).toList(),
                  )
                : const SizedBox.shrink(),
          )
        : const RegisterTagView();
  }
}
