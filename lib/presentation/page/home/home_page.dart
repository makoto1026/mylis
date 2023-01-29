import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/home/widget/article_list_view.dart';
import 'package:mylis/provider/tag/tag_controller.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesController = useScrollController();

    void _articleScrollListener() async {
      if (articlesController.offset >=
              articlesController.position.maxScrollExtent &&
          !articlesController.position.outOfRange) {
        try {} catch (e) {
          articlesController.removeListener(_articleScrollListener);
        }
      }
    }

    useEffect(() {
      () async {
        articlesController.addListener(_articleScrollListener);
        //   if (await ref.watch(accountController).initializedCount == 0) {
        //     await ref
        //         .read(accountController.notifier)
        //         .initialized()
        //         .then((value) => {
        //               styleFeedController.addListener(_styleFeedScrollListener),
        //               myPostFeedController.addListener(_myPostScrollListener),
        //               newsAndTipsController
        //                   .addListener(_newsAndTipsScrollListener),
        //             });

        //     await ref.read(accountController.notifier).setCount(1);
        //   } else {
        //     isLoadingFinish.value = true;
        //   }
      }();
      return () {};
    }, []);

    final tags = ref.watch(tagController).tagList;

    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: 3, // タブの数
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ホーム',
            style: pageHeaderTextStyle,
          ),
          backgroundColor: ThemeColor.white,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: ThemeColor.orange,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: ThemeColor.orange,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelColor: ThemeColor.gray,
            tabs: <Widget>[
              const Tab(text: 'お気に入り'),
              Tab(text: tags[0].name),
              Tab(text: tags[1].name),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () => {
              Navigator.pushNamed(
                context,
                RouteNames.registerArticle.path,
              ),
            },
            backgroundColor: ThemeColor.orange,
            child: const Icon(
              Icons.add,
              size: 40,
              color: ThemeColor.white,
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ArticleListView(
              items: ref.read(articleController).articleList,
              controller: articlesController,
            ),
            ArticleListView(
              items: ref.read(articleController).articleList,
              controller: articlesController,
            ),
            ArticleListView(
              items: ref.read(articleController).articleList,
              controller: articlesController,
            ),
          ],
        ),
      ),
    );
  }
}
