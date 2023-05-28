import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_list_view.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/home/controller/home_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/presentation/widget/news_dialog.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/meta_provider/meta_provider.dart';
import 'package:mylis/provider/news_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/presentation/page/main_page.dart' as main_page;
import 'package:mylis/theme/font_size.dart';

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
    final currentMember = ref.watch(currentMemberProvider);
    final banner = ref.watch(homeBannerAdProvider);
    final isTablet = ref.watch(isTabletProvider);

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
        SchedulerBinding.instance.addPostFrameCallback(
          (_) async => {
            await ref.read(isTabletProvider.notifier).set(context),
          },
        );

        if (currentMemberId != "") {
          await ref.read(newsProvider.notifier).set();
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

          if (await ref.read(metaProvider.notifier).getIsForceUpdate()) {
            showDialog(
              context: context,
              barrierColor: colorState.textColor.withOpacity(0.25),
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomDialog(
                  title: "アップデートが公開されました",
                  message: "アプリストアにて、アップデートをお願いいたします。",
                  isDoubleButton: false,
                  okButtonText: "ストアへ",
                  onPressedWithNo: () => Navigator.pop(context),
                  onPressedWithOk: () => {
                    ref
                        .read(currentMemberProvider.notifier)
                        .updateIsReadedNews(false),
                    openUrl(
                      url: Platform.isAndroid
                          ? "https://play.google.com/store/apps/details?id=com.mylis.app"
                          : "itms-apps://itunes.apple.com/app/6447293191",
                    ),
                    Navigator.pop(context),
                  },
                );
              },
            );
          } else if (currentMember?.isReadedNews == false) {
            showDialog(
              context: context,
              barrierColor: colorState.textColor.withOpacity(0.25),
              builder: (context) => const NewsDialog(),
            );
          }
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
              fontSize: isTablet
                  ? ThemeFontSize.tabletNormalFontSize
                  : ThemeFontSize.normalFontSize,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: ThemeColor.darkGray,
              ),
              onPressed: () => Navigator.pushNamed(
                context,
                RouteNames.search.path,
              ),
            ),
            SizedBox(width: isTablet ? 20 : 0),
          ],
          toolbarHeight: isTablet ? 80 : 40,
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
            tabs: tagList.map(
              (e) {
                if (e.uuid == "") {
                  return Text(
                    e.name,
                    style: TextStyle(
                      fontSize: isTablet
                          ? ThemeFontSize.tabletExtraLargeFontSize
                          : ThemeFontSize.extraLargeFontSize,
                    ),
                  );
                } else {
                  return Text(
                    e.name,
                    style: TextStyle(
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                    ),
                  );
                }
              },
            ).toList(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Consumer(
          builder: (context, ref, _) {
            return ref.watch(homeProvider) != tagList.length - 1
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: currentMember?.isRemovedAds ?? false
                          ? 20
                          : isTablet
                              ? 120
                              : 65,
                    ),
                    child: SizedBox(
                      width: isTablet ? 105 : 70,
                      height: isTablet ? 105 : 70,
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
                        child: Icon(
                          Icons.add,
                          size: isTablet ? 60 : 40,
                          color: ThemeColor.white,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: tagList
                    .map(
                      (e) => ArticleListView(tag: e),
                    )
                    .toList(),
              ),
            ),
            currentMember?.isRemovedAds == true
                ? const SizedBox.shrink()
                : Container(
                    color: ThemeColor.white,
                    height: 50,
                    width: double.infinity,
                    child: AdWidget(ad: banner),
                  ),
          ],
        ),
      ),
    );
  }
}
