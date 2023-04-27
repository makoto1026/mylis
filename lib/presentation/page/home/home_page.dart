import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_list_view.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/home/controller/home_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/presentation/page/main_page.dart' as main_page;

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
    final registerTagCount = ref.watch(tagController).count;
    final registerArticleCount = ref.watch(articleController).setCount;
    var tabController = TabController(
      vsync: _MyTickerProvider(),
      length: tagList.length,
      initialIndex: 0,
    );
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? "";
    final shareUrl = useState("");

    tabController.addListener(() async {
      await ref.read(homeProvider.notifier).set(tabController.index);
    });

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
                  shareUrl.value = await ref
                          .read(secureStorageServiceProvider)
                          .read(key: "share_url") ??
                      "",
                  if (shareUrl.value != "")
                    {
                      shareUrl.value = "",
                      Navigator.pushNamed(
                        context,
                        RouteNames.registerArticle.path,
                      ),
                    }
                },
              );
          await ref.read(homeProvider.notifier).set(tabController.index);
        }
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
            ref.read(currentTabProvider.notifier).changeTab(main_page.Tab.home);
            await Navigator.pushNamed(context, RouteNames.registerArticle.path);
          },
        );
      },
    );

    useValueChanged(
      registerArticleCount,
      (a, b) async {
        final filteredTagIndex = tagList.indexWhere(
          (e) => e.uuid == ref.watch(tagController).tag.uuid,
        );

        Future.microtask(() async {
          // filteredTagIndexが０の場合、一度アニメーションしてから動かさないと０まで戻れないため
          if (filteredTagIndex == 0) {
            tabController.animateTo(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            tabController.animateTo(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            tabController.animateTo(
              filteredTagIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      },
    );

    useValueChanged(
      registerTagCount,
      (a, b) async {
        Future.microtask(
          () async {
            tabController.animateTo(
                tagList.length <= 1 ? 0 : tagList.length - 2,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          },
        );
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
            splashFactory: NoSplash.splashFactory,
            tabs: tagList
                .map(
                  (e) => Tab(
                    text: e.name,
                  ),
                )
                .toList(),
          ),
        ),
        floatingActionButton: Consumer(
          builder: (context, ref, _) {
            return ref.watch(homeProvider) != tagList.length - 1
                ? SizedBox(
                    width: 70,
                    height: 70,
                    child: FloatingActionButton(
                      onPressed: () async => {
                        await ref
                            .read(secureStorageServiceProvider)
                            .delete(key: "share_url"),
                        await ref
                            .watch(registerArticleController.notifier)
                            .refresh(),
                        Navigator.pushNamed(
                          context,
                          RouteNames.registerArticle.path,
                        ),
                      },
                      backgroundColor: colorState.textColor,
                      child: const Icon(
                        Icons.add,
                        size: 40,
                        color: ThemeColor.white,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        body: TabBarView(
          controller: tabController,
          children: tagList
              .map(
                (e) => ArticleListView(tag: e),
              )
              .toList(),
        ),
      ),
    );
  }
}
