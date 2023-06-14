import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/tag.dart';
import 'package:mylis/presentation/page/tags/edit/edit_tag.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/color.dart';
import 'package:mylis/theme/font_size.dart';
import 'package:page_transition/page_transition.dart';

class EditTagListItem extends HookConsumerWidget {
  const EditTagListItem({
    required this.item,
    Key? key,
  }) : super(key: key);
  final Tag item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTablet = ref.watch(isTabletProvider);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 30 : 15,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: EditTagPage(
                tag: item,
              ),
              settings: RouteSettings(arguments: item),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.darkGray,
                  fontSize: isTablet
                      ? ThemeFontSize.tabletNormalFontSize
                      : ThemeFontSize.normalFontSize,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: ThemeColor.darkGray,
              size: isTablet ? 24 : 16,
            ),
          ],
        ),
      ),
    );
  }
}
