import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/auth_page.dart';
import 'package:mylis/presentation/page/my_page/my_page.dart';
import 'package:mylis/presentation/page/memo/memo.dart';
import 'package:mylis/presentation/page/home/home_page.dart';
import 'package:mylis/presentation/page/main_page.dart';
import 'package:mylis/presentation/page/walk_through.dart';

final routerProvider = Provider(
  (ref) => <String, WidgetBuilder>{
    RouteNames.walkThrough.path: (BuildContext context) =>
        const WalkThroughPage(),
    RouteNames.main.path: (BuildContext context) => const MainPage(),
    RouteNames.auth.path: (BuildContext context) => const AuthPage(),
    RouteNames.home.path: (BuildContext context) => const HomePage(),
    RouteNames.memo.path: (BuildContext context) => const MemoPage(),
    RouteNames.myPage.path: (BuildContext context) => const MyPage(),
  },
);

enum RouteNames {
  walkThrough,
  main,
  auth,
  home,
  memo,
  myPage,
}

extension RouteNamesExtension on RouteNames {
  String get path => "/$name";
}
