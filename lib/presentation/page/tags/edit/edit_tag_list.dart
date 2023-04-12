import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/router/router.dart';
import 'package:mylis/theme/color.dart';

class EditTagListPage extends HookConsumerWidget {
  const EditTagListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagController);
    final colorState = ref.watch(customizeController);

    final editTagController = useScrollController();

    void _articleScrollListener() async {
      if (editTagController.offset >=
              editTagController.position.maxScrollExtent &&
          !editTagController.position.outOfRange) {
        try {
          // await ref.read(articleController.notifier).getList();
        } catch (e) {
          editTagController.removeListener(_articleScrollListener);
        }
      }
    }

    useEffect(() {
      () async {
        editTagController.addListener(_articleScrollListener);
      }();
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'タグ編集',
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: state.tagList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.editTag.path,
                    arguments: state.tagList[index],
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        state.tagList[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ThemeColor.darkGray,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: ThemeColor.darkGray,
                      size: 16,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
