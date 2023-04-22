import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/presentation/page/tags/register/controller/register_tag_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/presentation/util/banner.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class RegisterTagView extends HookConsumerWidget {
  const RegisterTagView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMember = ref.watch(currentMemberProvider);
    final state = ref.watch(registerTagController);
    final tagList = ref.watch(tagController).tagList;
    // final admobState = ref.watch(admobProvider);

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MylisTextField(
                  title: "新規リスト",
                  onChanged: (value) =>
                      ref.read(registerTagController.notifier).setName(value),
                ),
                const SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    height: 52,
                    width: 160,
                    child: RoundRectButton(
                      disable: state.name == "",
                      onPressed: () async => {
                        await ref
                            .read(loadingStateProvider.notifier)
                            .startLoading(),
                        await ref.read(registerTagController.notifier).create(
                            currentMember?.uuid ?? "", tagList.length - 1),
                        await ref
                            .read(registerTagController.notifier)
                            .refresh(),
                        await ref
                            .read(tagController.notifier)
                            .refresh(currentMember?.uuid ?? "", true, false),
                        await ref
                            .read(loadingStateProvider.notifier)
                            .stopLoading(),
                        await showToast(message: "リストを追加しました"),
                      },
                      text: "登録",
                    ),
                  ),
                ),
              ],
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
    );
  }
}
