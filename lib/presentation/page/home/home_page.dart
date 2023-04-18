import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_list_view.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';

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
    final colorState = ref.watch(customizeController);
    final member = ref.watch(currentMemberProvider);
    final receiveSharingState = ref.watch(receiveSharingIntentProvider);
    final tagList = ref.watch(tagController).tagList;
    final articleState = ref.watch(articleController);
    var tabController = TabController(
      vsync: _MyTickerProvider(),
      length: tagList.length,
      initialIndex: 0,
    );
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? "";

    TabController _createNewTabController() => TabController(
          vsync: _MyTickerProvider(),
          length: tagList.length,
        );

    useEffect(() {
      () async {
        if (currentMemberId != "") {
          await ref
              .read(tagController.notifier)
              .initialized(ref.watch(currentMemberProvider)?.uuid)
              .then(
                (value) async => {
                  await ref.watch(articleController.notifier).initialized(
                        ref.watch(currentMemberProvider)?.uuid ?? "",
                        ref.watch(tagController).tagList,
                      ),
                  await ref
                      .watch(customizeController.notifier)
                      .initialized(member!),
                },
              );
        }
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
        tabController.index = tagList.length == 1 ? 0 : tagList.length - 2;
      },
    );

    return DefaultTabController(
      initialIndex: 0,
      length: tagList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ホーム',
            style: TextStyle(
              color: colorState.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ThemeColor.white,
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorColor: colorState.textColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: colorState.textColor,
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
        body: TabBarView(
          controller: tabController,
          children: tagList
              .map(
                (e) => ArticleListView(tagId: e.uuid ?? ""),
              )
              .toList(),
        ),
      ),
    );
  }
}
