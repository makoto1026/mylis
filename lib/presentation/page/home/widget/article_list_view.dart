import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/presentation/page/home/widget/article_box.dart';
import 'package:mylis/snippets/url_launcher.dart';

class ArticleListView extends HookConsumerWidget {
  const ArticleListView({
    required this.items,
    required this.controller,
    Key? key,
  }) : super(key: key);
  final List<Article> items;
  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.count(
        controller: controller,
        crossAxisCount: 1,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        physics: const ClampingScrollPhysics(),
        childAspectRatio: 3.95,
        children: List.generate(
          items.length,
          (index) => GestureDetector(
            onTap: () {
              openUrl(url: items[index].url);
            },
            child: ArticleBox(
              item: items[index],
            ),
          ),
        ).toList(),
      ),
    );
  }
}
