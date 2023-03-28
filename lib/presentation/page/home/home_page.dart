import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_list_view.dart';
import 'package:mylis/presentation/page/articles/register_article/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class _MyTickerProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiveSharingState = ref.watch(receiveSharingIntentProvider);
    final tagList = ref.watch(tagController).tagList;
    final articleState = ref.watch(articleController);
    var tabController = TabController(
      vsync: _MyTickerProvider(),
      length: tagList.length,
      initialIndex: 0,
    );

    TabController _createNewTabController() => TabController(
          vsync: _MyTickerProvider(),
          length: tagList.length,
        );

    useEffect(() {
      () async {
        // await ref.read(tagController.notifier).initialized();
        // final tagState = ref.watch(tagController);
        // ref.watch(articleController.notifier).initialized(tagState.tagList);
        tabController = _createNewTabController();
      }();
      return () {};
    }, []);

    useValueChanged(
      receiveSharingState,
      (a, b) async {
        if (receiveSharingState.url == "") {
          return;
        }
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            await Navigator.pushNamed(context, RouteNames.registerArticle.path);
          },
        );
      },
    );

    useValueChanged(
      articleState,
      (a, b) async {
        final setTag = ref.watch(tagController).tag;
        final filteredTagIndex =
            tagList.indexWhere((e) => e.uuid == setTag.uuid);
        tabController.index = filteredTagIndex;
      },
    );

    useValueChanged(
      tagList,
      (a, b) async {
        tabController = _createNewTabController();
        tabController.index = tagList.length - 2;
      },
    );

    return DefaultTabController(
      initialIndex: 0,
      length: tagList.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ホーム',
            style: orangeTextStyle,
          ),
          backgroundColor: ThemeColor.white,
          bottom: TabBar(
            controller: tabController,
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
            unselectedLabelColor: ThemeColor.darkGray,
            tabs: tagList
                .map(
                  (e) => Tab(
                    text: e.name,
                  ),
                )
                .toList(),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () async => {
              await ref.watch(registerArticleController.notifier).refresh(),
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
          controller: tabController,
          children: tagList
              .map(
                (e) => ArticleListView(tagUuid: e.uuid ?? ""),
              )
              .toList(),
        ),
      ),
    );
  }
}
