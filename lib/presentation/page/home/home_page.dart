import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/home/widget/article_list_view.dart';
import 'package:mylis/provider/tag/tag_controller.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      () async {
        await ref.read(tagController.notifier).initialized();
      }();

      return () {};
    }, []);

    final tabState = ref.watch(tagController);

    final receiveSharingState = ref.watch(receiveSharingIntentProvider);

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

    return DefaultTabController(
      initialIndex: 0,
      length: tabState.tagList.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ホーム',
            style: pageHeaderTextStyle,
          ),
          backgroundColor: ThemeColor.white,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: ThemeColor.orange,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: ThemeColor.orange,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            unselectedLabelColor: ThemeColor.gray,
            tabs: tabState.tagList
                .map(
                  (e) => Tab(
                    text: e.name,
                  ),
                )
                .toList(),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () => {
              Navigator.pushNamed(
                context,
                RouteNames.registerArticle.path,
              ),
            },
            backgroundColor: ThemeColor.orange,
            child: const Icon(
              Icons.add,
              size: 40,
              color: ThemeColor.white,
            ),
          ),
        ),
        body: TabBarView(
          children: tabState.tagList
              .map(
                (e) => const ArticleListView(),
              )
              .toList(),
        ),
      ),
    );
  }
}
