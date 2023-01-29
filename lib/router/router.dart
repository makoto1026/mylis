import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/my_page/my_page.dart';
import 'package:mylis/presentation/page/memo/memo.dart';
import 'package:mylis/presentation/page/article/register/register_article.dart';
import 'package:mylis/presentation/page/home/home_page.dart';
import 'package:mylis/presentation/page/main_page.dart';

final routerProvider = Provider((ref) => <String, WidgetBuilder>{
      // RouteNames.splash.path: (BuildContext context) => const SplashPage(),
      RouteNames.main.path: (BuildContext context) => const MainPage(),
      RouteNames.home.path: (BuildContext context) => const HomePage(),
      RouteNames.memo.path: (BuildContext context) => const MemoPage(),
      RouteNames.myPage.path: (BuildContext context) => const MyPage(),
      RouteNames.registerArticle.path: (BuildContext context) =>
          const RegisterArticlePage(),
    });

enum RouteNames {
  // splash,
  main,
  home,
  memo,
  myPage,
  registerArticle,
}

extension RouteNamesExtension on RouteNames {
  String get path => "/$name";
}
