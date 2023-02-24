import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/auth/controller/auth_controller.dart';
import 'package:mylis/provider/session_provider.dart';
import 'package:mylis/provider/tab/current_tab_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/mixin.dart';
import 'package:mylis/presentation/page/main_page.dart' as main_page;

class MyPage extends HookConsumerWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = ref.read(currentTabProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'マイページ',
          style: pageHeaderTextStyle,
        ),
      ),
      body: Center(
        child: Container(
          width: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("サブスクリプション"),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 30),
              Text("カスタマイズ"),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  ref.read(sessionProvider.notifier).signOut().whenComplete(
                        () => {
                          tabController.changeTab(
                            main_page.Tab.home,
                          ),
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.auth.path,
                            (route) => false,
                          )
                        },
                      );
                },
                child: Text("ログアウト"),
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 30),
              Text("使い方"),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 30),
              Text("お問い合わせ"),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 30),
              Text("利用規約"),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 30),
              Text("プライバシーポリシー"),
              SizedBox(height: 10),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
