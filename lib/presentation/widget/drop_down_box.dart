import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/articles/register/controller/register_article_controller.dart';
import 'package:mylis/presentation/page/customize/controller/customize_controller.dart';
import 'package:mylis/presentation/page/tags/tag/controller/tag_controller.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/font_size.dart';

class DropDownBox extends HookConsumerWidget {
  const DropDownBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tagController);
    final colorState = ref.watch(customizeController);
    final isTablet = ref.watch(isTabletProvider);

    List<Tag> tagList = List.from(state.tagList);
    tagList.removeLast();

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 50,
        width: isTablet ? 340 : 227,
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
              value: tagList.isNotEmpty ? state.tag : null,
              items: tagList
                  .map(
                    (e) => DropdownMenuItem<Tag>(
                      value: e,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: isTablet ? 30 : 15,
                        ),
                        child: Text(
                          e.name,
                          style: TextStyle(
                            fontSize: isTablet
                                ? ThemeFontSize.tabletNormalFontSize
                                : ThemeFontSize.normalFontSize,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: colorState.textColor,
                size: isTablet ? 36 : 24,
              ),
              hint: Padding(
                padding: EdgeInsets.only(
                  left: isTablet ? 30 : 15,
                ),
                child: Text(
                  "選択してください",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: isTablet
                        ? ThemeFontSize.tabletNormalFontSize
                        : ThemeFontSize.normalFontSize,
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
