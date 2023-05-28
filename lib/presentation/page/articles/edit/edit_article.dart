import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/edit/controller/edit_article_controller.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/widget/back_notice_dialog.dart';
import 'package:mylis/presentation/page/search/controller/search_controller.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/page/tags/register/widget/register_tag_dialog.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/drop_down_box.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';
import 'package:tuple/tuple.dart';

class EditArticlePage extends HookConsumerWidget {
  const EditArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Tuple2<Article, Tag>;
    final article = arguments.item1;
    final tag = arguments.item2;
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);
    final tagState = ref.watch(tagController);
    final isLoading = ref.watch(registerTagController).isLoading;
    final editArticleState = ref.watch(editArticleController);
    final isTablet = ref.watch(isTabletProvider);

    final oldTag = useState(tag);

    useEffect(() {
      () async {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          ref.read(tagController.notifier).setTag(tag);
          ref.read(editArticleController.notifier).setArticle(article);
          ref.read(registerArticleController.notifier).setNewArticle(
                title: article.title,
                url: article.url,
                memo: article.memo,
              );
          ref.read(registerArticleController.notifier).setTag(tag);
        });
      }();
      return () {};
    }, []);

    return isLoading
        ? Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                '記事編集',
                style: TextStyle(
                  color: colorState.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet
                      ? ThemeFontSize.tabletNormalFontSize
                      : ThemeFontSize.normalFontSize,
                ),
              ),
              leadingWidth: isTablet ? 80 : 40,
              leading: IconButton(
                icon: Icon(
                  Icons.close,
                  size: isTablet ? 36 : 24,
                ),
                onPressed: () {
                  final isSameTitle = article.title == editArticleState.title;
                  final isSameUrl = article.url == editArticleState.url;
                  final isSameMemo = article.memo == editArticleState.memo;
                  final isSameTag = oldTag.value.uuid == tagState.tag.uuid;
                  if (isSameTitle && isSameUrl && isSameMemo && isSameTag) {
                    Navigator.pop(context);
                  } else {
                    showDialog<bool>(
                      context: context,
                      barrierColor: colorState.textColor.withOpacity(0.25),
                      builder: (context) => const BackNoticeDialog(),
                    ).then(
                      (value) => {
                        if (value == true)
                          {
                            Navigator.pop(context),
                          }
                      },
                    );
                  }
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
                    if (oldTag.value.uuid == tagState.tag.uuid)
                      {
                        await ref
                            .read(editArticleController.notifier)
                            .update(currentMemberId, tag.uuid ?? ""),
                      }
                    else
                      {
                        await ref.read(editArticleController.notifier).delete(
                            currentMemberId, article, oldTag.value.uuid ?? ""),
                        await ref
                            .read(registerArticleController.notifier)
                            .create(currentMemberId),
                      },
                    await ref.read(editArticleController.notifier).refresh(),
                    await ref
                        .read(registerArticleController.notifier)
                        .refresh(),
                    await ref
                        .read(
                          loadingStateProvider.notifier,
                        )
                        .stopLoading(),
                    Navigator.pop(context, true),
                    await showToast(
                      message: "記事を更新しました",
                      fontSize: isTablet
                          ? ThemeFontSize.tabletMediumFontSize
                          : ThemeFontSize.mediumFontSize,
                    ),
                    await ref
                        .read(articleController.notifier)
                        .initialized(currentMemberId, tagState.tagList),
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return ThemeColor.darkGray.withOpacity(0.25);
                        }
                        return ThemeColor.darkGray;
                      },
                    ),
                    alignment: Alignment.center,
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    '保存',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                    ),
                  ),
                ),
                SizedBox(width: isTablet ? 20 : 0),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 60 : 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MylisTextField(
                      title: "タイトル",
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                      initialValue: article.title,
                      onChanged: (value) async => await ref
                          .read(editArticleController.notifier)
                          .setUpdateValue(title: value),
                    ),
                    SizedBox(height: isTablet ? 40 : 20),
                    MylisTextField(
                      title: "URL",
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                      initialValue: article.url,
                      onChanged: (value) async => await ref
                          .read(editArticleController.notifier)
                          .setUpdateValue(url: value),
                    ),
                    SizedBox(height: isTablet ? 40 : 20),
                    Text(
                      "リスト",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet
                            ? ThemeFontSize.tabletNormalFontSize
                            : ThemeFontSize.normalFontSize,
                      ),
                    ),
                    SizedBox(height: isTablet ? 10 : 5),
                    Row(
                      children: [
                        const DropDownBox(),
                        SizedBox(width: isTablet ? 40 : 20),
                        GestureDetector(
                          onTap: () => {
                            showDialog(
                              context: context,
                              barrierColor:
                                  colorState.textColor.withOpacity(0.25),
                              builder: (context) => const RegisterTagDialog(),
                            ),
                          },
                          child: Text(
                            "追加",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: isTablet
                                  ? ThemeFontSize.tabletNormalFontSize
                                  : ThemeFontSize.normalFontSize,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: isTablet ? 40 : 20),
                    MylisTextField(
                      title: "メモ",
                      minLines: 5,
                      maxLines: 10,
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                      isAFewLine: true,
                      initialValue: article.memo,
                      onChanged: (value) async => await ref
                          .read(editArticleController.notifier)
                          .setUpdateValue(memo: value),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
