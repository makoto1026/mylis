import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/article/widget/article_list_view.dart';
import 'package:mylis/presentation/page/register_article/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/tag/controller/tag_controller.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TabController tabController;

    useEffect(() {
      () async {
        // await ref.read(tagController.notifier).initialized();
        // final tagState = ref.watch(tagController);
        // ref.watch(articleController.notifier).initialized(tagState.tagList);
      }();

      return () {};
    }, []);
    final receiveSharingState = ref.watch(receiveSharingIntentProvider);
    final tagState = ref.watch(tagController);
    // final articles = ref.watch(articleController).articleList;

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

    //TODO: 記事登録時にタグを指定した場合、そのタグのタブに移動する

    // tabController =
    //     useTabController(initialLength: tagState.tagList.length + 1);
    // useValueChanged(
    //   articles,
    //   (a, b) async {
    //     final setTag = ref.watch(tagController).tag;
    //     final filteredTagIndex =
    //         tagState.tagList.indexWhere((e) => e.name == setTag.name);
    //     tabController.animateTo(filteredTagIndex);
    //   },
    // );

    return DefaultTabController(
      initialIndex: 0,
      length: tagState.tagList.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ホーム',
            style: pageHeaderTextStyle,
          ),
          backgroundColor: ThemeColor.white,
          bottom: TabBar(
            // controller: tabController,
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
            tabs: tagState.tagList
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
          // controller: tabController,
          children: tagState.tagList
              .map(
                (e) => ArticleListView(tagUuid: e.uuid ?? ""),
              )
              .toList(),
        ),
      ),
    );
  }
}
