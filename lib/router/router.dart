import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/register_article/register_article.dart';
import 'package:mylis/presentation/page/auth/auth_page.dart';
import 'package:mylis/presentation/page/auth/email_sign_in/email_sign_in.dart';
import 'package:mylis/presentation/page/auth/email_sign_up/email_sign_up.dart';
import 'package:mylis/presentation/page/memo/register_memo/register_memo.dart';
import 'package:mylis/presentation/page/my_page/my_page.dart';
import 'package:mylis/presentation/page/memo/memo.dart';
import 'package:mylis/presentation/page/home/home_page.dart';
import 'package:mylis/presentation/page/main_page.dart';
import 'package:mylis/presentation/page/tag/edit_tag.dart';
import 'package:mylis/presentation/page/tag/edit_tag_list.dart';

final routerProvider = Provider((ref) => <String, WidgetBuilder>{
      RouteNames.main.path: (BuildContext context) => const MainPage(),
      RouteNames.auth.path: (BuildContext context) => const AuthPage(),
      RouteNames.emailSignUp.path: (BuildContext context) =>
          const EmailSignUpPage(),
      RouteNames.emailSignIn.path: (BuildContext context) =>
          const EmailSignInPage(),
      RouteNames.home.path: (BuildContext context) => const HomePage(),
      RouteNames.memo.path: (BuildContext context) => const MemoPage(),
      RouteNames.registerArticle.path: (BuildContext context) =>
          const RegisterArticlePage(),
      RouteNames.registerMemo.path: (BuildContext context) =>
          const RegisterMemoPage(),
      RouteNames.myPage.path: (BuildContext context) => const MyPage(),
      RouteNames.editTagList.path: (BuildContext context) =>
          const EditTagListPage(),
      RouteNames.editTag.path: (BuildContext context) => const EditTagPage(),
    });

enum RouteNames {
  main,
  auth,
  emailSignUp,
  emailSignIn,
  home,
  memo,
  registerArticle,
  registerMemo,
  myPage,
  editTagList,
  editTag,
}

extension RouteNamesExtension on RouteNames {
  String get path => "/$name";
}
