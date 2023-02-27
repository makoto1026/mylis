import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/home/widget/article_box.dart';
import 'package:mylis/presentation/page/tag/register_tag.dart';
import 'package:mylis/snippets/url_launcher.dart';

class ArticleListView extends HookConsumerWidget {
  const ArticleListView({
    required this.isArticles,
    Key? key,
  }) : super(key: key);

  final bool isArticles;

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
        await ref.read(articleController.notifier).initialized().then(
              (value) => {
                articlesController.addListener(_articleScrollListener),
              },
            );
      }();
      return () {};
    }, []);

    final state = ref.watch(articleController);

    return isArticles
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: state.articleList.isNotEmpty
                ? GridView.count(
                    controller: articlesController,
                    crossAxisCount: 1,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 3,
                    physics: const ClampingScrollPhysics(),
                    childAspectRatio: 3.75,
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
    // : Scaffold(
    //     appBar: AppBar(
    //       title: const Text(
    //         '記事登録',
    //         style: pageHeaderTextStyle,
    //       ),
    //     ),
    //     body: SingleChildScrollView(
    //       padding: const EdgeInsets.symmetric(
    //         vertical: 50,
    //         horizontal: 30,
    //       ),
    //       child: Center(
    //         child: Column(
    //           children: [
    //             MylisTextField(
    //               title: "タイトル",
    //               onChanged: (value) => ref
    //                   .read(articleController.notifier)
    //                   .setNewArticle(title: value),
    //             ),
    //             const SizedBox(height: 30),
    //             MylisTextField(
    //               title: "URL",
    //               maxLines: 20,
    //               isAFewLine: true,
    //               onChanged: (value) => ref
    //                   .read(articleController.notifier)
    //                   .setNewArticle(url: value),
    //             ),
    //             const SizedBox(height: 30),
    //             MylisTextField(
    //               title: "メモ（任意）",
    //               maxLines: 20,
    //               minLines: 5,
    //               isAFewLine: true,
    //               onChanged: (value) => ref
    //                   .read(articleController.notifier)
    //                   .setNewArticle(memo: value),
    //             ),
    //             const SizedBox(height: 50),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Center(
    //                   child: SizedBox(
    //                     height: 52,
    //                     width: 52,
    //                     child: OutlinedRoundRectButton(
    //                       onPressed: () => {
    //                         Navigator.pop(context),
    //                         ref
    //                             .read(articleController.notifier)
    //                             .initialized(),
    //                         ref
    //                             .read(receiveSharingIntentProvider.notifier)
    //                             .initialized(),
    //                       },
    //                       text: "戻る",
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(width: 20),
    //                 Center(
    //                   child: SizedBox(
    //                     height: 52,
    //                     width: 160,
    //                     child: RoundRectButton(
    //                       onPressed: () => {
    //                         ref
    //                             .read(articleController.notifier)
    //                             .create(),
    //                         ref
    //                             .read(articleController.notifier)
    //                             .initialized(),
    //                         ref
    //                             .read(receiveSharingIntentProvider.notifier)
    //                             .initialized(),
    //                         Navigator.pop(context),
    //                       },
    //                       text: "登録",
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
  }
}
