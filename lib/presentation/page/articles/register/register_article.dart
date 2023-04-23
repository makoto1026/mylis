import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/infrastructure/secure_storage_service.dart';
// import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/domain/service/receive_sharing_intent_service.dart';
import 'package:mylis/presentation/page/articles/article/controller/article_controller.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/widget/back_notice_dialog.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/util/banner.dart';
import 'package:mylis/presentation/widget/drop_down_box.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/page/tags/register/widget/register_tag_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

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
    // final admobState = ref.watch(admobProvider);

    useEffect(() {
      () async {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) async {
            if (tagState.tagList.isNotEmpty) {
              ref.read(tagController.notifier).setTag(tagState.tagList[0]);
              ref.read(registerArticleController.notifier).setNewArticle(
                    tagId: tagState.tagList[0].uuid ?? "",
                  );
            }
          },
        );
      }();

      return () {};
    }, []);

    if (receiveSharingState.url != "") {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          ref
              .read(registerArticleController.notifier)
              .setNewArticle(url: receiveSharingState.url);
        },
      );
    }

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
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.close),
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
                    await ref.read(loadingStateProvider.notifier).stopLoading(),
                    Navigator.pop(context),
                    await showToast(message: "記事を登録しました"),
                    if ((currentMember?.registeredArticleCount ?? 0) % 5 == 0)
                      {
                        AppReview.requestReview,
                      }
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
                  child: const Text(
                    '保存',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MylisTextField(
                            title: "タイトル",
                            initialValue: registerArticleState.title,
                            onChanged: (value) => ref
                                .read(registerArticleController.notifier)
                                .setNewArticle(title: value),
                          ),
                          const SizedBox(height: 20),
                          MylisTextField(
                            title: "URL",
                            maxLines: 20,
                            isAFewLine: true,
                            initialValue: receiveSharingState.url == ""
                                ? registerArticleState.url
                                : receiveSharingState.url,
                            onChanged: (value) => ref
                                .read(registerArticleController.notifier)
                                .setNewArticle(url: value),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "リスト",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const DropDownBox(),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => {
                                  showDialog(
                                    context: context,
                                    barrierColor:
                                        colorState.textColor.withOpacity(0.25),
                                    builder: (context) =>
                                        const RegisterTagDialog(),
                                  ),
                                },
                                child: const Text(
                                  "追加",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          MylisTextField(
                            title: "メモ（任意）",
                            fontSize: 12,
                            maxLines: 20,
                            minLines: 3,
                            isAFewLine: true,
                            initialValue: registerArticleState.memo ?? "",
                            onChanged: (value) => ref
                                .read(registerArticleController.notifier)
                                .setNewArticle(memo: value),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                currentMember?.isRemovedAds == true
                    ? const SizedBox.shrink()
                    : Container(
                        color: ThemeColor.white,
                        height: 50,
                        width: double.infinity,
                        child: AdWidget(ad: setBanner()),
                      )
                // admobState
                //     ? Container(
                //         color: ThemeColor.white,
                //         height: 50,
                //         width: double.infinity,
                //         child: AdWidget(ad: setBanner()),
                //       )
                //     : const SizedBox.shrink(),
              ],
            ),
          );
  }
}
