import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_controller.dart';
import 'package:mylis/presentation/page/memo/widget/memo_box.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final memosController = useScrollController();
    final currentMember = ref.watch(currentMemberProvider);
    final state = ref.watch(memoController);
    final banner = ref.watch(memoBannerAdProvider);

    void _articleScrollListener() async {
      if (memosController.offset >= memosController.position.maxScrollExtent &&
          !memosController.position.outOfRange) {
        try {
          // await ref.read(memoController.notifier).getList();
        } catch (e) {
          memosController.removeListener(_articleScrollListener);
        }
      }
    }

    useEffect(() {
      () async {
        await ref
            .read(memoController.notifier)
            .initialized(currentMember?.uuid ?? "")
            .then(
              (value) => {
                memosController.addListener(_articleScrollListener),
              },
            );
      }();
      return () {
        memosController.removeListener(_articleScrollListener);
      };
    }, [state.memoList.length]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メモ',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ThemeColor.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () => {
              Navigator.pushNamed(
                context,
                RouteNames.registerMemo.path,
              ),
            },
            backgroundColor: colorState.textColor,
            child: const Icon(
              Icons.add,
              size: 40,
              color: ThemeColor.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color.fromARGB(255, 236, 236, 236),
              padding: const EdgeInsets.all(10),
              child: state.memoList.isNotEmpty
                  ? ListView.builder(
                      controller: memosController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.memoList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => {
                            // 一旦ダイアログではなくページ遷移で実装
                            ref
                                .read(editMemoController.notifier)
                                .setMemo(state.memoList[index]),
                            Navigator.pushNamed(
                              context,
                              RouteNames.editMemo.path,
                            )
                          },
                          child: MemoBox(
                            item: state.memoList[index],
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          currentMember?.isRemovedAds == true
              ? const SizedBox.shrink()
              : Container(
                  color: ThemeColor.white,
                  height: 50,
                  width: double.infinity,
                  child: AdWidget(ad: banner),
                ),
        ],
      ),
    );
  }
}
