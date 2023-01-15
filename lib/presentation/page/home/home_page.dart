import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/presentation/page/home/widget/article_list_view.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articlesController = useScrollController();

    var aItems = [
      Article(
        siteName: "アイメイクはこれで決まり",
        url: "https://google.co.jp",
        memo: "",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイシャドーの心得",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイロンはこう巻け",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイメイクはこれで決まり",
        url: "https://google.co.jp",
        memo: "",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイシャドーの心得",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイロンはこう巻け",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイメイクはこれで決まり",
        url: "https://google.co.jp",
        memo: "",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイシャドーの心得",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイロンはこう巻け",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイメイクはこれで決まり",
        url: "https://google.co.jp",
        memo: "",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイシャドーの心得",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイロンはこう巻け",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
    ];

    var bItems = [
      Article(
        siteName: "アイメイクはこれできまり",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "アイシャドーの心得",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "グロスってどうなの？",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
    ];

    var cItems = [
      Article(
        siteName: "アイロンはこう巻け",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "ブリーチに怯えるな",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
      Article(
        siteName: "そのカラー、自分に合ってる？",
        url: "https://google.co.jp",
        memo: "memomemomemo",
        createdAt: DateTime.now(),
      ),
    ];

    void _articleScrollListener() async {
      if (articlesController.offset >=
              articlesController.position.maxScrollExtent &&
          !articlesController.position.outOfRange) {
        try {
          // await ref.read(accountController.notifier).setFavoriteNewsAndTips();
        } catch (e) {
          articlesController.removeListener(_articleScrollListener);
        }
        ;
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
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: ThemeColor.orange,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: ThemeColor.orange,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelColor: ThemeColor.gray,
            tabs: <Widget>[
              Tab(text: 'お気に入り'),
              Tab(text: 'メイク'),
              Tab(text: '髪型'),
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
              items: aItems,
              controller: articlesController,
            ),
            ArticleListView(
              items: bItems,
              controller: articlesController,
            ),
            ArticleListView(
              items: cItems,
              controller: articlesController,
            ),
          ],
        ),
      ),
    );
  }
}
