import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/memo/controller/memo_controller.dart';
import 'package:mylis/presentation/page/memo/widget/memo_box.dart';
import 'package:mylis/presentation/page/memo/widget/memo_detail_dialog.dart';
import 'package:mylis/provider/current_member_provider.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/mixin.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorState = ref.watch(customizeController);
    final memosController = useScrollController();
    final currentMemberId = ref.watch(currentMemberProvider)?.uuid ?? '';

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
            .initialized(currentMemberId)
            .then(
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
        title: Text(
          'メモ',
          style: TextStyle(
            color: colorState.textColor,
            fontWeight: FontWeight.bold,
          ),
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
          backgroundColor: colorState.textColor,
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
                    onTap: () => {
                      showDialog(
                        context: context,
                        barrierColor: colorState.textColor.withOpacity(0.5),
                        builder: (context) => MemoDetailDialog(
                          memo: state.memoList[index],
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
