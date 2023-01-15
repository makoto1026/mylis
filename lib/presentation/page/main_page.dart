import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/memo/memo.dart';
import 'package:mylis/presentation/page/home/home_page.dart';
import 'package:mylis/presentation/page/my_page/my_page.dart';
import 'package:mylis/provider/current_tab_provider.dart';
import 'package:mylis/provider/tab_nav_key_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final currentTab = ref.watch(currentTabProvider);
    final tabController = useMemoized(() => CupertinoTabController(), []);
    // final isLoggedIn = ref.watch(isLoggedInProvider);

    useEffect(() {
      tabController.addListener(() {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          ref
              .read(currentTabProvider.notifier)
              .changeTab(Tab.values[tabController.index]);
        });
      });
      return () => tabController.dispose();
    }, []);

    // useEffect(() {
    //   SchedulerBinding.instance?.addPostFrameCallback(
    //     (_) async {
    //       if (isLoggedIn) {
    //         // メンバー情報のtokenが空の場合、再取得して保存する
    //         final token =
    //             await ref.watch(currentUserProvider.notifier).getFcmToken();
    //         final currentToken = ref.watch(currentUserProvider)?.deviceToken;

    //         ref
    //             .watch(currentUserProvider.notifier)
    //             .setUserAgent(webViewUserAgent ?? "");

    //         if (currentToken == null ||
    //             currentToken == "" ||
    //             currentToken != token) {
    //           ref
    //               .watch(currentUserProvider.notifier)
    //               .update(deviceToken: token);
    //         }
    //       } else {
    //         ref.read(currentTabProvider.notifier).changeTab(
    //               main_page.Tab.newsAndTips,
    //             );
    //       }
    //       if (ref.watch(appConfigManagerProvider).value == true) {
    //         showDialog(
    //           context: context,
    //           barrierDismissible: false,
    //           builder: (BuildContext context) {
    //             return AlertDialog(
    //               title: Text(
    //                 "update",
    //                 style: const TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               content: Text("you need to update this app ."),
    //               actions: <Widget>[
    //                 TextButton(
    //                   child: Text("Yes"),
    //                   onPressed: () {
    //                     // TODO: アプリURL（IOS,android）に差し替え
    //                     openUrl(url: "");
    //                     Navigator.pop(context);
    //                   },
    //                 ),
    //               ],
    //             );
    //           },
    //         );
    //       }
    //     },
    //   );
    //   return () {};
    // }, [ref.watch(appConfigManagerProvider)]);

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
          activeColor: ThemeColor.orange,
          inactiveColor: ThemeColor.gray,
          backgroundColor: ThemeColor.white,
          items: Tab.values
              .map(
                (e) => BottomNavigationBarItem(
                  label: () {
                    switch (e) {
                      case Tab.home:
                        return "ホーム";
                      case Tab.memo:
                        return "メモ";
                      case Tab.myPage:
                        return "マイページ";
                    }
                  }(),
                  icon: () {
                    switch (e) {
                      case Tab.home:
                        return Icon(
                          Icons.home,
                          size: 28,
                          color: e == currentTab.tab
                              ? ThemeColor.orange
                              : ThemeColor.gray,
                        );
                      case Tab.memo:
                        return Icon(
                          Icons.create,
                          size: 24,
                          color: e == currentTab.tab
                              ? ThemeColor.orange
                              : ThemeColor.gray,
                        );
                      case Tab.myPage:
                        return Icon(
                          Icons.manage_accounts_rounded,
                          size: 28,
                          color: e == currentTab.tab
                              ? ThemeColor.orange
                              : ThemeColor.gray,
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
