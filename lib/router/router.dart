import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/articles/edit/edit_article.dart';
import 'package:mylis/presentation/page/articles/register/register_article.dart';
import 'package:mylis/presentation/page/auth/auth_page.dart';
import 'package:mylis/presentation/page/auth/email_sign_in/email_sign_in.dart';
import 'package:mylis/presentation/page/auth/email_sign_up/email_sign_up.dart';
import 'package:mylis/presentation/page/customize/customize.dart';
import 'package:mylis/presentation/page/memo/edit/edit_memo.dart';
import 'package:mylis/presentation/page/memo/register/register_memo.dart';
import 'package:mylis/presentation/page/my_page/delete_account.dart';
import 'package:mylis/presentation/page/my_page/my_page.dart';
import 'package:mylis/presentation/page/memo/memo.dart';
import 'package:mylis/presentation/page/home/home_page.dart';
import 'package:mylis/presentation/page/main_page.dart';
import 'package:mylis/presentation/page/my_page/usage.dart';
import 'package:mylis/presentation/page/privacy_policy/privacy_policy.dart';
import 'package:mylis/presentation/page/splash.dart';
import 'package:mylis/presentation/page/tags/edit/edit_tag.dart';
import 'package:mylis/presentation/page/tags/edit/edit_tag_list.dart';
import 'package:mylis/presentation/page/terms_of_use/terms_of_use.dart';
import 'package:mylis/presentation/page/walk_through.dart';

final routerProvider = Provider((ref) => <String, WidgetBuilder>{
      RouteNames.splash.path: (BuildContext context) => const SplashPage(),
      RouteNames.walkThrough.path: (BuildContext context) =>
          const WalkThroughPage(),
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
      RouteNames.editArticle.path: (BuildContext context) =>
          const EditArticlePage(),
      RouteNames.editMemo.path: (BuildContext context) => const EditMemoPage(),
      RouteNames.editTagList.path: (BuildContext context) =>
          const EditTagListPage(),
      RouteNames.editTag.path: (BuildContext context) => const EditTagPage(),
      RouteNames.customize.path: (BuildContext context) =>
          const CustomizePage(),
      RouteNames.usage.path: (BuildContext context) => const UsagePage(),
      RouteNames.deleteAccount.path: (BuildContext context) =>
          const DeleteAccountPage(),
      RouteNames.privacyPolicy.path: (BuildContext context) =>
          const PrivacyPolicyPage(),
      RouteNames.termsOfUse.path: (BuildContext context) =>
          const TermsOfUsePage(),
    });

enum RouteNames {
  splash,
  walkThrough,
  main,
  auth,
  emailSignUp,
  emailSignIn,
  home,
  memo,
  registerArticle,
  registerMemo,
  myPage,
  editArticle,
  editMemo,
  editTagList,
  editTag,
  customize,
  usage,
  deleteAccount,
  privacyPolicy,
  termsOfUse,
}

extension RouteNamesExtension on RouteNames {
  String get path => "/$name";
}
