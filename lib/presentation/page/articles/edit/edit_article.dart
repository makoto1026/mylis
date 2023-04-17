import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/edit/controller/edit_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:tuple/tuple.dart';

class EditArticlePage extends HookConsumerWidget {
  const EditArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Tuple2<Article, String>;
    final article = arguments.item1;
    final tagId = arguments.item2;
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);
    final tagState = ref.watch(tagController);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(editArticleController.notifier).setArticle(article);
      });
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '記事編集',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColor.darkGray,
        ),
        actions: [
          TextButton(
            onPressed: () async => {
              await ref
                  .read(
                    loadingStateProvider.notifier,
                  )
                  .startLoading(),
              await ref
                  .read(editArticleController.notifier)
                  .update(currentMemberId, tagId),
              await ref.read(editArticleController.notifier).refresh(),
              await ref
                  .read(articleController.notifier)
                  .initialized(currentMemberId, tagState.tagList),
              await ref.read(articleController.notifier).setCount(),
              await ref
                  .read(
                    loadingStateProvider.notifier,
                  )
                  .stopLoading(),
              Navigator.pop(context),
              await showToast(message: "記事を更新しました"),
            },
            style: TextButton.styleFrom(
              primary: ThemeColor.darkGray,
              alignment: Alignment.center,
            ),
            child: const Text('保存'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MylisTextField(
              title: "タイトル",
              initialValue: article.title,
              onChanged: (value) => ref
                  .read(editArticleController.notifier)
                  .setUpdateValue(title: value),
            ),
            const SizedBox(height: 10),
            MylisTextField(
              title: "URL",
              initialValue: article.url,
              onChanged: (value) => ref
                  .read(editArticleController.notifier)
                  .setUpdateValue(url: value),
            ),
            const SizedBox(height: 10),
            MylisTextField(
              title: "メモ",
              initialValue: article.memo,
              onChanged: (value) => ref
                  .read(editArticleController.notifier)
                  .setUpdateValue(memo: value),
            ),
          ],
        ),
      ),
    );
  }
}
