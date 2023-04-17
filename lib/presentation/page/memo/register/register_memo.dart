import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/register/controller/register_memo_controller.dart';
import 'package:mylis/presentation/util/banner.dart';
import 'package:mylis/presentation/widget/mylis_text_field.dart';
import 'package:mylis/presentation/widget/outline_round_rect_button.dart';
import 'package:mylis/presentation/widget/round_rect_button.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';

class RegisterMemoPage extends HookConsumerWidget {
  const RegisterMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';
    final colorState = ref.watch(customizeController);

    useEffect(() {
      ref.refresh(registerMemoController);
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メモ登録',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 30,
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      MylisTextField(
                        title: "タイトル",
                        onChanged: (value) => ref
                            .read(registerMemoController.notifier)
                            .setNewMemo(title: value),
                      ),
                      const SizedBox(height: 30),
                      MylisTextField(
                        title: "内容",
                        maxLines: 5,
                        minLines: 5,
                        isAFewLine: true,
                        onChanged: (value) => ref
                            .read(registerMemoController.notifier)
                            .setNewMemo(body: value),
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
                                  ref
                                      .read(memoController.notifier)
                                      .initialized(currentMemberId),
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Center(
                            child: SizedBox(
                              height: 52,
                              width: 160,
                              child: RoundRectButton(
                                onPressed: () async => {
                                  await ref
                                      .read(loadingStateProvider.notifier)
                                      .startLoading(),
                                  await ref
                                      .read(registerMemoController.notifier)
                                      .create(currentMemberId),
                                  await ref
                                      .read(memoController.notifier)
                                      .refresh(currentMemberId),
                                  await ref
                                      .read(loadingStateProvider.notifier)
                                      .stopLoading(),
                                  await showToast(message: "メモを追加しました"),
                                  Navigator.pop(context),
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
            ),
          ),
          Container(
            color: ThemeColor.white,
            height: 50,
            width: double.infinity,
            child: AdWidget(ad: setBanner()),
          ),
        ],
      ),
    );
  }
}
