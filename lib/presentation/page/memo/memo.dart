import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/edit/controller/edit_memo_controller.dart';
import 'package:mylis/presentation/page/memo/edit/edit_memo.dart';
import 'package:mylis/presentation/page/memo/register/register_memo.dart';
import 'package:mylis/presentation/page/memo/widget/memo_box.dart';
import 'package:mylis/presentation/widget/custom_dialog.dart';
import 'package:mylis/provider/admob_provider.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';
import 'package:page_transition/page_transition.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final memosController = useScrollController();
    final currentMember = ref.watch(currentMemberProvider);
    final state = ref.watch(memoController);
    final banner = ref.watch(memoBannerAdProvider);
    final isTablet = ref.watch(isTabletProvider);

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
            fontSize: isTablet
                ? ThemeFontSize.tabletNormalFontSize
                : ThemeFontSize.normalFontSize,
          ),
        ),
        backgroundColor: ThemeColor.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: currentMember?.isRemovedAds ?? false
              ? 20
              : isTablet
                  ? 160
                  : 80,
        ),
        child: SizedBox(
          width: isTablet ? 105 : 70,
          height: isTablet ? 105 : 70,
          child: FloatingActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const RegisterMemoPage(),
                ),
              ),
            },
            backgroundColor: colorState.textColor,
            child: Icon(
              Icons.add,
              size: isTablet ? 60 : 40,
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
              padding: EdgeInsets.all(
                isTablet ? 20 : 10,
              ),
              child: state.memoList.isNotEmpty
                  ? ReorderableListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.memoList.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: Key('$index'),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                            right: isTablet ? 40 : 20,
                          ),
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: isTablet ? 36 : 24,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            barrierColor:
                                colorState.textColor.withOpacity(0.25),
                            builder: (BuildContext context) {
                              return CustomDialog(
                                title: "本当に削除しますか？",
                                message: "データは完全に削除されます",
                                onPressedWithNo: () => Navigator.pop(context),
                                onPressedWithOk: () async => {
                                  await ref
                                      .read(loadingStateProvider.notifier)
                                      .startLoading(),
                                  await ref
                                      .read(editMemoController.notifier)
                                      .delete(currentMember?.uuid ?? "",
                                          state.memoList[index].uuid ?? ""),
                                  await ref
                                      .read(editMemoController.notifier)
                                      .refresh(),
                                  await ref
                                      .read(memoController.notifier)
                                      .refresh(currentMember?.uuid ?? ""),
                                  await ref
                                      .read(loadingStateProvider.notifier)
                                      .stopLoading(),
                                  Navigator.pop(context),
                                  await showToast(
                                    message: "削除しました",
                                    fontSize: isTablet
                                        ? ThemeFontSize.tabletMediumFontSize
                                        : ThemeFontSize.mediumFontSize,
                                  ),
                                },
                              );
                            },
                          );
                        },
                        child: GestureDetector(
                          onTap: () => {
                            // 一旦ダイアログではなくページ遷移で実装
                            ref
                                .read(editMemoController.notifier)
                                .setMemo(state.memoList[index]),

                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const EditMemoPage(),
                              ),
                            ),
                          },
                          child: MemoBox(
                            item: state.memoList[index],
                          ),
                        ),
                      ),
                      onReorder: (int oldIndex, int newIndex) {},
                      proxyDecorator: (widget, _, __) {
                        return Opacity(opacity: 0.5, child: widget);
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          currentMember?.isRemovedAds == true
              ? const SizedBox.shrink()
              : Container(
                  color: ThemeColor.white,
                  height: 60,
                  width: double.infinity,
                  child: AdWidget(ad: banner),
                ),
        ],
      ),
    );
  }
}
