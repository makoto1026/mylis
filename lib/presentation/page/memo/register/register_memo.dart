import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/register/controller/register_memo_controller.dart';
import 'package:mylis/presentation/util/banner.dart';
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
    final admobState = ref.watch(admobProvider);
    final controller = useTextEditingController();
    final focusNode = FocusNode();

    useEffect(() {
      ref.refresh(registerMemoController);
      focusNode.requestFocus();
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
              await ref.read(loadingStateProvider.notifier).startLoading(),
              await ref
                  .read(registerMemoController.notifier)
                  .create(currentMemberId),
              await ref.read(memoController.notifier).refresh(currentMemberId),
              await ref.read(loadingStateProvider.notifier).stopLoading(),
              await showToast(message: "メモを追加しました"),
              Navigator.pop(context),
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
            child: const Text('保存'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: focusNode,
                      controller: controller,
                      initialValue: null,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                      inputFormatters: [LengthLimitingTextInputFormatter(2000)],
                      maxLines: 15,
                      minLines: 15,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColor.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColor.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColor.white),
                        ),
                      ),
                      onChanged: (value) =>
                          ref.read(registerMemoController.notifier).setNewMemo(
                                body: value.replaceAll('\n', '\\n'),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          admobState
              ? Container(
                  color: ThemeColor.white,
                  height: 50,
                  width: double.infinity,
                  child: AdWidget(ad: setBanner()),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
