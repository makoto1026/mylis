import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/article.dart';
import 'package:mylis/provider/is_tablet_provider.dart';
import 'package:mylis/theme/font_size.dart';

class ArticleBox extends HookConsumerWidget {
  const ArticleBox({
    required this.item,
    Key? key,
  }) : super(key: key);
  final Article item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenSize = MediaQuery.of(context).size;
    final isTablet = ref.watch(isTabletProvider);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 10 : 5,
        vertical: isTablet ? 15 : 7.5,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: isTablet ? 30 : 15,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: screenSize.width * 0.02,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: double.infinity),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: isTablet
                              ? ThemeFontSize.tabletNormalFontSize
                              : ThemeFontSize.normalFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.memo != "")
                      Column(
                        children: [
                          SizedBox(height: isTablet ? 10 : 5),
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(maxWidth: double.infinity),
                            child: Text(
                              item.memo,
                              style: TextStyle(
                                fontSize: isTablet
                                    ? ThemeFontSize.tabletSmallFontSize
                                    : ThemeFontSize.smallFontSize,
                              ),
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
