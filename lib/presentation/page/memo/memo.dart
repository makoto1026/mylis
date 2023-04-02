import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/widget/memo_box.dart';
import 'package:mylis/presentation/widget/select_action_dialog.dart';
import 'package:mylis/provider/loading_state_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/snippets/toast.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memosController = useScrollController();
    final height = useState(70);

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
        await ref.read(memoController.notifier).initialized().then(
              (value) => {
                memosController.addListener(_articleScrollListener),
              },
            );
      }();
      return () {};
    }, []);

    final state = ref.watch(memoController);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'メモ',
          style: orangeTextStyle,
        ),
        backgroundColor: ThemeColor.white,
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () => {
            Navigator.pushNamed(
              context,
              RouteNames.registerMemo.path,
            ),
          },
          backgroundColor: ThemeColor.orange,
          child: const Icon(
            Icons.add,
            size: 40,
            color: ThemeColor.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: state.memoList.isNotEmpty
            ? GridView.count(
                controller: memosController,
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 3,
                physics: const ClampingScrollPhysics(),
                childAspectRatio: 2,
                children: List.generate(
                  state.memoList.length,
                  (index) => GestureDetector(
                    //TODO: メモをタップした時の挙動を考える
                    onTap: () => {},
                    onLongPress: () => {
                      showDialog(
                        context: context,
                        barrierColor: ThemeColor.orange.withOpacity(0.5),
                        builder: (context) => SelectActionDialog(
                          onPressedWithEdit: () => {
                            Navigator.pushNamed(
                              context,
                              RouteNames.editMemo.path,
                              arguments: state.memoList[index],
                            ),
                          },
                          onPressedWithDelete: () => {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("本当に削除しますか？"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("いいえ"),
                                    ),
                                    TextButton(
                                      onPressed: () async => {
                                        await ref
                                            .read(loadingStateProvider.notifier)
                                            .startLoading(),
                                        // await ref
                                        //     .read(deleteArticleController
                                        //         .notifier)
                                        //     .delete(),
                                        // await ref
                                        //     .read(deleteArticleController
                                        //         .notifier)
                                        //     .refresh(),
                                        await ref
                                            .read(loadingStateProvider.notifier)
                                            .stopLoading(),
                                        Navigator.pop(context),
                                        await showToast(message: "削除しました"),
                                      },
                                      child: const Text("はい"),
                                    ),
                                  ],
                                );
                              },
                            ),
                          },
                        ),
                      ),
                    },
                    child: MemoBox(
                      item: state.memoList[index],
                    ),
                  ),
                ).toList(),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
