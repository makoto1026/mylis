import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/article/widget/article_box.dart';
import 'package:mylis/presentation/page/articles/edit/controller/edit_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/search/controller/search_controller.dart';
import 'package:mylis/presentation/page/tags/register/register_tag.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/snippets/url_launcher.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';
import 'package:tuple/tuple.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(currentMemberProvider);
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);
    final state = ref.watch(searchController);
    final tagState = ref.watch(tagController);
    final banner = ref.watch(searchPageBannerAdProvider);
    final tags = ref.watch(tagController);
    final isLoading = ref.watch(loadingStateProvider);

    final articlesController = useScrollController();
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final isFocused = useState(false);
    final isFirstSearch = useState(true);
    final isBack = useState(false);

    useEffect(() {
      focusNode.addListener(() {
        isFocused.value = focusNode.hasFocus;
      });

      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: isTablet ? 80 : 40,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: isTablet ? 36 : 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ThemeColor.darkGray,
        ),
        titleSpacing: 0,
        title: isFocused.value
            ? Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'キーワードを入力',
                        prefixIcon: Icon(
                          Icons.search,
                          color: ThemeColor.darkGray,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) async {
                        await ref
                            .read(loadingStateProvider.notifier)
                            .startLoading();
                        await ref.read(searchController.notifier).search(
                              currentMember?.uuid ?? "",
                              tags.tagList,
                              value,
                            );
                        await ref
                            .read(loadingStateProvider.notifier)
                            .stopLoading();
                        isFirstSearch.value = false;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.clear(),
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text(
                      "キャンセル",
                      style: TextStyle(
                        color: ThemeColor.darkGray,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'キーワードを入力',
                        prefixIcon: Icon(
                          Icons.search,
                          color: ThemeColor.darkGray,
                        ),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        ref.read(searchController.notifier).search(
                              currentMember?.uuid ?? "",
                              tags.tagList,
                              value,
                            );
                        isFirstSearch.value = false;
                      },
                    ),
                  ),
                  SizedBox(width: isTablet ? 40 : 20),
                ],
              ),
        toolbarHeight: isTablet ? 100 : 50,
        backgroundColor: ThemeColor.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 236, 236, 236),
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 20 : 10),
              child: state.articles.isNotEmpty
                  ? ListView.builder(
                      controller: articlesController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.articles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            openUrl(
                              url: state.articles[index].url,
                            );
                          },
                          onLongPress: () => showDialog(
                            context: context,
                            barrierColor:
                                colorState.textColor.withOpacity(0.25),
                            builder: (context) => CustomDialog(
                              title: "「${state.articles[index].title}」",
                              noButtonText: "削除",
                              okButtonText: "編集",
                              onPressedWithNo: () async {
                                await showDialog(
                                  context: context,
                                  barrierColor:
                                      colorState.textColor.withOpacity(0),
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: "本当に削除しますか？",
                                      message: "データからも完全に削除されます",
                                      onPressedWithNo: () =>
                                          Navigator.pop(context),
                                      onPressedWithOk: () async => {
                                        isBack.value = true,
                                        await ref
                                            .read(searchController.notifier)
                                            .delete(
                                              state.articles[index].uuid ?? "",
                                            ),
                                        await ref
                                            .read(
                                              loadingStateProvider.notifier,
                                            )
                                            .startLoading(),
                                        await ref
                                            .read(
                                              editArticleController.notifier,
                                            )
                                            .delete(
                                              currentMember?.uuid ?? "",
                                              state.articles[index],
                                              state.articles[index].tag?.uuid ??
                                                  "",
                                            ),
                                        await ref
                                            .read(
                                              editArticleController.notifier,
                                            )
                                            .refresh(),
                                        await ref
                                            .read(
                                              loadingStateProvider.notifier,
                                            )
                                            .stopLoading(),
                                        Navigator.pop(context),
                                        await showToast(
                                          message: "削除しました",
                                          fontSize: isTablet
                                              ? ThemeFontSize
                                                  .tabletMediumFontSize
                                              : ThemeFontSize.mediumFontSize,
                                        ),
                                        await ref
                                            .read(articleController.notifier)
                                            .initialized(
                                              currentMember?.uuid ?? "",
                                              tagState.tagList,
                                            ),
                                      },
                                    );
                                  },
                                ).whenComplete(
                                  () => {
                                    isBack.value
                                        ? Navigator.pop(context)
                                        : null,
                                  },
                                );
                              },
                              onPressedWithOk: () async {
                                Navigator.pop(context);
                                var isEdit = await Navigator.pushNamed(
                                  context,
                                  RouteNames.editArticle.path,
                                  arguments: Tuple2(
                                    state.articles[index],
                                    state.articles[index].tag!,
                                  ),
                                );
                                if (isEdit == true) {
                                  await ref
                                      .read(searchController.notifier)
                                      .refresh(
                                        currentMember?.uuid ?? "",
                                        tagState.tagList,
                                      );
                                }
                              },
                            ),
                          ),
                          child: ArticleBox(
                            item: state.articles[index],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        isFirstSearch.value ? "" : "検索結果はありません",
                        style: TextStyle(
                          color: ThemeColor.darkGray,
                          fontSize: isTablet
                              ? ThemeFontSize.tabletMediumFontSize
                              : ThemeFontSize.mediumFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          ),
          // currentMember?.isRemovedAds == true
          //     ? const SizedBox.shrink()
          //     : Container(
          //         color: ThemeColor.white,
          //         height: 50,
          //         width: double.infinity,
          //         child: AdWidget(ad: banner),
          //       ),
        ],
      ),
    );
  }
}
