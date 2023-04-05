import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/theme/color.dart';

class DropDownBox extends HookConsumerWidget {
  const DropDownBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagController);

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 50,
        width: 227,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xffF7F6F6),
                border: Border.all(
                  color: const Color(0xffEDECEC),
                  width: 0.5,
                ),
              ),
            ),
            DropdownButton<Tag>(
              value: state.tagList.isNotEmpty ? state.tag : null,
              items: state.tagList
                  .map(
                    (e) => DropdownMenuItem<Tag>(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          e.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ThemeColor.orange,
              ),
              hint: const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "選択してください",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              underline: const SizedBox.shrink(),
              onChanged: (value) => {
                ref.read(tagController.notifier).setTag(value!),
                ref.read(registerArticleController.notifier).setNewArticle(
                      tagId: value.uuid ?? "",
                    ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
