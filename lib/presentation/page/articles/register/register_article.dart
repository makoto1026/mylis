import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/widget/back_notice_dialog.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/presentation/widget/drop_down_box.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/page/tags/register/widget/register_tag_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';

class RegisterArticlePage extends HookConsumerWidget {
  const RegisterArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final registerArticleState = ref.watch(registerArticleController);
    final receiveSharingState = ref.watch(receiveSharingIntentProvider);
    final tagState = ref.watch(tagController);
    final isLoading = ref.watch(registerTagController).isLoading;
    final currentMember = ref.watch(currentMemberProvider);
    final isTablet = ref.watch(isTabletProvider);

    useEffect(() {
      () async {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            if (tagState.tagList.isNotEmpty) {
              ref.read(tagController.notifier).setTag(tagState.tagList[0]);
              ref.read(registerArticleController.notifier).setNewArticle(
                    tagId: tagState.tagList[0].uuid ?? "",
                  );
              if (receiveSharingState.url != "") {
                ref
                    .read(registerArticleController.notifier)
                    .setNewArticle(url: receiveSharingState.url);
              }
            }
          },
        );
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
                '記事登録',
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
                  if (registerArticleState.title == "" &&
                      registerArticleState.url == "" &&
                      registerArticleState.memo == "") {
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
                    if (ref.read(registerArticleController).title == "" ||
                        ref.read(registerArticleController).url == "")
                      {
                        showDialog(
                          context: context,
                          barrierColor: colorState.textColor.withOpacity(0.25),
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "タイトルまたはURLが入力されていません",
                              onPressedWithNo: () => Navigator.pop(context),
                              onPressedWithOk: () => Navigator.pop(context),
                              okButtonText: "戻る",
                              isDoubleButton: false,
                            );
                          },
                        ),
                      }
                    else
                      {
                        await ref
                            .read(loadingStateProvider.notifier)
                            .startLoading(),
                        await ref
                            .read(registerArticleController.notifier)
                            .create(currentMember?.uuid ?? ""),
                        await ref
                            .read(receiveSharingIntentProvider.notifier)
                            .refresh(),
                        await ref.read(articleController.notifier).initialized(
                            currentMember?.uuid ?? "", tagState.tagList),
                        await ref
                            .read(registerArticleController.notifier)
                            .refresh(),
                        await ref
                            .read(secureStorageServiceProvider)
                            .write(key: "share_url", value: ""),
                        await ref
                            .read(currentMemberProvider.notifier)
                            .updateRegisteredArticleCount(),
                        await ref
                            .read(currentMemberProvider.notifier)
                            .set(currentMember?.uuid ?? ""),
                        await ref.read(articleController.notifier).setCount(),
                        await ref
                            .read(loadingStateProvider.notifier)
                            .stopLoading(),
                        Navigator.pop(context),
                        await showToast(
                          message: "記事を登録しました",
                          fontSize: isTablet
                              ? ThemeFontSize.tabletMediumFontSize
                              : ThemeFontSize.mediumFontSize,
                        ),
                        if ((currentMember?.registeredArticleCount ?? 0) % 5 ==
                            0)
                          {
                            AppReview.requestReview,
                          }
                      },
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
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 60 : 30,
                vertical: isTablet ? 40 : 20,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MylisTextField(
                      title: "タイトル",
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                      initialValue: registerArticleState.title,
                      onChanged: (value) async => await ref
                          .read(registerArticleController.notifier)
                          .setNewArticle(title: value),
                    ),
                    SizedBox(height: isTablet ? 40 : 20),
                    MylisTextField(
                      title: "URL",
                      fontSize: isTablet
                          ? ThemeFontSize.tabletNormalFontSize
                          : ThemeFontSize.normalFontSize,
                      maxLines: 20,
                      isAFewLine: true,
                      initialValue: receiveSharingState.url == ""
                          ? registerArticleState.url
                          : receiveSharingState.url,
                      onChanged: (value) async => await ref
                          .read(registerArticleController.notifier)
                          .setNewArticle(url: value),
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
                      title: "メモ（任意）",
                      fontSize: isTablet
                          ? ThemeFontSize.tabletSmallFontSize
                          : ThemeFontSize.smallFontSize,
                      maxLines: 20,
                      minLines: 3,
                      isAFewLine: true,
                      initialValue: registerArticleState.memo ?? "",
                      onChanged: (value) async => await ref
                          .read(registerArticleController.notifier)
                          .setNewArticle(memo: value),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
