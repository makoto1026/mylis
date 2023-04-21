import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/my_page/my_page.dart';
import 'package:mylis/presentation/page/memo/memo.dart';
import 'package:mylis/presentation/page/home/home_page.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/provider/tab/tab_nav_key_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final currentTab = ref.watch(currentTabProvider);
    final tabController = useMemoized(() => CupertinoTabController(), []);
    final colorState = ref.watch(customizeController);

    useEffect(() {
      tabController.addListener(() {
        SchedulerBinding.instance.addPostFrameCallback((_) async => {
              ref.read(currentTabProvider.notifier).changeTab(
                    Tab.values[tabController.index],
                  ),
            });
      });
      return () => tabController.dispose();
    }, []);

    useValueChanged(
        currentTab, (_, __) => tabController.index = currentTab.tab.index);

    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
          onTap: (index) async {
            ref
                .read(tabNavigationStateProvider)[currentTab.tab.index]
                .currentState
                ?.popUntil(
                  (route) => route.isFirst,
                );
          },
          iconSize: 100,
          activeColor: colorState.textColor,
          inactiveColor: ThemeColor.darkGray,
          backgroundColor: ThemeColor.white,
          items: Tab.values
              .map(
                (e) => BottomNavigationBarItem(
                  icon: () {
                    switch (e) {
                      case Tab.home:
                        return Icon(
                          Icons.home,
                          size: 28,
                          color: e == currentTab.tab
                              ? colorState.textColor
                              : ThemeColor.darkGray,
                        );
                      case Tab.memo:
                        return SvgPicture.asset(
                          "assets/icons/memo.svg",
                          width: 26,
                          height: 26,
                          color: e == currentTab.tab
                              ? colorState.textColor
                              : ThemeColor.darkGray,
                        );

                      case Tab.myPage:
                        return Icon(
                          Icons.manage_accounts_rounded,
                          size: 28,
                          color: e == currentTab.tab
                              ? colorState.textColor
                              : ThemeColor.darkGray,
                        );
                    }
                  }(),
                ),
              )
              .toList()),
      tabBuilder: (context, index) {
        final tab = Tab.values[index];
        return CupertinoTabView(
          navigatorKey: ref.watch(tabNavigationStateProvider)[index],
          routes: router,
          builder: (context) {
            return CupertinoPageScaffold(child: () {
              switch (tab) {
                case Tab.home:
                  return const HomePage();
                case Tab.memo:
                  return const MemoPage();
                case Tab.myPage:
                  return const MyPage();
              }
            }());
          },
        );
      },
    );
  }
}

enum Tab { home, memo, myPage }
