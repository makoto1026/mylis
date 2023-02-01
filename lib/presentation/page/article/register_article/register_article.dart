import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/article/register_article/controller/register_article_controller.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/theme/mixin.dart';

class RegisterArticlePage extends HookConsumerWidget {
  const RegisterArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.refresh(registerArticleController);
      return () {};
    }, []);

    final state = ref.watch(registerArticleController);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '記事登録',
          style: pageHeaderTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 30,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              MylisTextField(
                title: "記事タイトル",
                onChanged: (value) => ref
                    .read(registerArticleController.notifier)
                    .setNewArticle(title: value),
              ),
              const SizedBox(height: 30),
              MylisTextField(
                title: "記事URL",
                onChanged: (value) => ref
                    .read(registerArticleController.notifier)
                    .setNewArticle(url: value),
              ),
              const SizedBox(height: 30),
              MylisTextField(
                title: "メモ",
                maxLines: 5,
                minLines: 5,
                isAFewLine: true,
                onChanged: (value) => ref
                    .read(registerArticleController.notifier)
                    .setNewArticle(memo: value),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: 52,
                      child: OutlinedRoundRectButton(
                        onPressed: () => {
                          Navigator.pop(context),
                          ref.read(articleController.notifier).initialized(),
                        },
                        text: "戻る",
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Center(
                    child: SizedBox(
                      height: 52,
                      width: 160,
                      child: RoundRectButton(
                        disable: state.title == "" || state.url == "",
                        onPressed: () => {
                          ref.read(registerArticleController.notifier).create(),
                          ref.refresh(articleController),
                        },
                        text: "登録",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
